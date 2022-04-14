Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B44501AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbiDNSCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbiDNSCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:02:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783BD18E3A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:59:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EHg64l003034;
        Thu, 14 Apr 2022 17:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bDhLi/bqy51qbNMkAE9MZxd9Uo7dgAiS8NdcWJvRGvE=;
 b=JSbhByAXL83afT1u/CJ9IyTBx0wEu/VfnAmucR0uQpU181EaDw9DAzAZGOR7kRcHRS2w
 xtgaLOYvEtYYfPVe/XbZHyueOT0292Dp6BeGq3XGAcp30e9CB3N2Qvf5sIpLcPBQ/LiY
 gYVMPVuVPpbnZmjXCmuedwuB3Un61ycM5k9CZn2ur94e7ByNtAe3QT6QwzVm/tju6z35
 XSipM2EN9t3PiGAD0IPxfW0dD8GwOIwNgA9xoODloVw3sku6JWBXfs67CT57H7ccpyFT
 j8NNfOvernzLb5MxA7L5jb0/vIAxzYJmpPiOW2FAiRHKfx78BaP/vrRqGIGW99acpVTT Og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2njgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:59:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EHuUo8011956;
        Thu, 14 Apr 2022 17:59:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck1570ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/kR388PgCTxu56lI/3kI+pa3XSUVT4Ov4mjsIHBRryPgJt/5Xrr1wOja3Mkh74a/MeGGKe8Q/IwPiiuUFZmhkrj8KD4P5gbIv6lN1+CwAavJI9y4wTNzgxjOwfJBXPd22dKmgdRwB4BTumOREkpbFmlJmcz3lH34OU9c7+4sVjRfTxGmKEYu55dSoRO993hWfkc9ZiK/bcNoRkeThXN5RW5iGmBQfcFTB62Yx7jPMmdIWbusv4zxIfvyTVmtPveR7dIRnfSbE9SDqFT+/lJhMW4AuCjZmsQpp4HCbwAdf1cBA03I+BzqDxa7gKm5A1I7RBrn694FXa0Y0wTzt7GdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDhLi/bqy51qbNMkAE9MZxd9Uo7dgAiS8NdcWJvRGvE=;
 b=TeO12oBhNZ20f4ILovjhHclYKdYa15J9FhxgO5JRtg1Xv2YroePmlzan7p/Yy/1s1owFz8E0GsMXQt4U7I4JDHop8UKKlKdbZxsraqQ86z0oTRcEobxlZmfVOF98iAdnvjcaa+Tn4yOKfjXTAMVnEvAHs29WiqTaGg/a7FEwrk5N3Z6yXXXm+iVK9oRcZu6KeOSE1Y0z3ue8Jm9W/mHiYb1aK8esAsQyQ8v/OMLlf1NldFp9Ls0GpYlkz3NnwAotv2/hKwLClDv4ThhQCqr0b2Hegla0ckEP9ACRZlf5nCu0CYfNBgxti91/BDJtuuqVwsp9WFCnggMm3vXPzwsFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDhLi/bqy51qbNMkAE9MZxd9Uo7dgAiS8NdcWJvRGvE=;
 b=OK3BvX594x5Pb/99/cwuAlYmWoHQmDy+TNMOmDsXQt2slU2htcW2bBgERjqxKV4R/l4Uac2bs+9BnGO/G+wl6PPc5q+XXo9Ha1rMrKDDT8NohEZ5w0/3WxBxpCqd8hFI1j0ywCLwyCuj+eurFwaxN6p9t8B7CPJaPq6N9H6q6Is=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27; Thu, 14 Apr
 2022 17:59:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b1bb:21c2:580e:922c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b1bb:21c2:580e:922c%4]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 17:59:35 +0000
Message-ID: <79bb1d5b-1518-f6ca-e375-2666eee19e90@oracle.com>
Date:   Thu, 14 Apr 2022 10:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 3/3] Revert "mm/memory-failure.c: fix race with
 changing page compound again"
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-4-naoya.horiguchi@linux.dev>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220408135323.1559401-4-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b1c59e1-5d2a-4395-c541-08da1e4088d9
X-MS-TrafficTypeDiagnostic: SA1PR10MB5823:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB582329C5CD8CAB95F01A4F82E2EF9@SA1PR10MB5823.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xhtop0fFfDeQKG7EQc6Lqo/f6eI4KcsvV5vy3G8ZdG1CxDv4gMkJkyft/g8r61nW61EjCQxeBux6SLtFpLBWic0XiLbvi1o/jmpzT3F2pX+a/DDUuZrctYsDN6ljiml1VGXDBMr1HJ2wDesnkyHwa72dGBtB//lhV3TPQA5XKIvw8ri/G7bEt3wOC1hX1wRta3K8bc7oKrTipCT+Arq6qFpuQSxaUdyvKKjUTp3kW90dzG9v4hEBB3oQ9FskXI25fZnUKRMDS65zScfZ52CSpgi7/G0wRxZgJxrXx9l5oOwfbtkDX66dCmLXU65vpCe5ciZUTPmKUPlFwi7wQzOEW4lbzpjhHSJ5Uf3H5aBb0FjOQNwezRN3j/wpmik+B8AtKzufBIA/a+trsh1qiji/5Fgn8u/DRbENnOQTpzck5iaV4/UUwUV2dS7XZW3jbPUhYZPSZ750ZbOceQy06jUjkiVY0bKyFwGcROySqKxvfPkGGt7a5Xm0eeLZBB6sgNL2RXr2sJjOPgvRoVLBFI6JnnGOTCDWkkg7r0ZDUW1Lpamc6jP+UYOzgNdSLZ9hy6Zuco+mYbA76Nhlb2/mkCNaQiH48PP2ZmGf+7/LaHAkx5XuYvZP+MMKuRp6NgLl7nqCGRoH6Ibn8NMj0jMN5z7wGLt9PDDi5/ZeGETDPZCktD/UOXOoVf7ga0MnIIxS1cXSLCAXsjiJYmB+kQwvevWpMUAYVa2HElld3pt4HhfmhLhOkGSch7q8vNGBzjYownh2p3H2J6Ct7Reycwwe2lcdpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(36756003)(186003)(5660300002)(2616005)(26005)(38350700002)(66946007)(31686004)(4326008)(31696002)(86362001)(8676002)(316002)(83380400001)(508600001)(53546011)(52116002)(6486002)(6506007)(66476007)(6512007)(66556008)(2906002)(38100700002)(54906003)(4744005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FpcWFRR0trZ0NUdTFIZ3RIenVBVytFYjRTUU1wZ3g2SUlxbmdGbG9IN09R?=
 =?utf-8?B?M1ZaYVRHZzBpeGxkY2tQVlBJOGpDZXVySE5pNzFja3o3NjhWQTJWZkN4TTZa?=
 =?utf-8?B?RmVYeEp2MjBCbnJDU1FCUDJWRVdOdEJuMW9uYndpWEVobjEyOXJkeVRsd2cy?=
 =?utf-8?B?ZytOalVlY0d4R1I2MlhMMlZScjFkMXNTaXJGOEZtdnJ1NC90VHJwRXJWK1dZ?=
 =?utf-8?B?Q2U1bVh5K2ZXSUpPV1MvZkx5SnY5Mjg1WDl5UmVBQ0hkN1owdkxOZmJTeERF?=
 =?utf-8?B?TVBVcGNiaWhUZzNndFdhc0srRjJKY0VIK3A2RDlmT1paREd1Y2NBUEV0VmFL?=
 =?utf-8?B?OWMzaVdlc1o2bGMza1kzSjhTbnRrV1N3Z1FNOTRnQ0VPVGs1YmJmK2pOT3Iw?=
 =?utf-8?B?QnBiMUdEVHJZWFE1NjkwMC9RWHBYSERwczh6cnhGMnM5ZHhCUEp0d254bUl2?=
 =?utf-8?B?V3Z3ZnMrMk5sSElueXdGUTJHWFJNdUE4UVlhZ0hkaDcwSFgvQkcvajFLeGFN?=
 =?utf-8?B?eVN6NXBlcXlrWXA3UjVHMmhUS0FQeWU4a29oSUtLUWR3Y0VLZ1k5RUY1eEdV?=
 =?utf-8?B?bS8yUjRXNWtEQ0J1RE1wWEdmbEVhS284eWtETWJiVWgrVlU4MzYxTG0wdS9k?=
 =?utf-8?B?U1BLUzcvRDVIZi9TMWhGaEwwRE0xb3dzSGQzQWo5SGxkbEtqMm9wTFVibnFv?=
 =?utf-8?B?cW1peGdNTDhLSXdnZFUwZGwzN2IxRVpOSFFlSFJLRnZFYk5XR0RtelB4ZGVW?=
 =?utf-8?B?UjF5R0dsUGU2UzZDeEw2NSthQUx5cks5QmZyM21iSWVMTHBlT0RlUnJuRkVk?=
 =?utf-8?B?ZDVKd3h5enRobDVBbXFObmhsMFhWbkl0dkFtck5PK1VBVTVyS0xpNzdCa1pB?=
 =?utf-8?B?ZFVlL3NmQ0RjYTR6cEpOTUZKSmtTRWRMV1lvUC9BWFllZjJvZ0JLUmxqVi85?=
 =?utf-8?B?NldMSzI4THdJcW1HeERBSE1LallIelhLUHBXdElYV3hxc2dKR2lzc29yNWFU?=
 =?utf-8?B?bFFrZXVhUkVLaUpscXN6d1hpdnFOY1UydzI0UklsV2dJUFc0aVg4V0pUYWk1?=
 =?utf-8?B?ZnRkVXF4VmVvY2taUE9PUk9WQ29QUGdTcndjeHJrSkVRZXVWNUpuYzFWSU95?=
 =?utf-8?B?bjhNRFNsMkZuSnNwR3FVanpLQ1NyM3JJWkJYMGtTUXl3YVUxSXFDdTNKYlZa?=
 =?utf-8?B?K1FUMnk2WXUyMWtNQkxMQ3dFdmNzVnpYYUJFKzZINVMweGxacGlURmJ0aHoy?=
 =?utf-8?B?LzI3RUZZV29BWk1GMzhERTcrNlpjYzg3NDd6SWl6SnZ0VGNRK1JKTHJ5bVZU?=
 =?utf-8?B?aFM2VHhVY0ZVallrQWc0ODFUTXdweVEzUi95YzhadVhydG5DMlhxQURPbnhr?=
 =?utf-8?B?SC94R2lINi82aXNGK2JYRW9CZTU1SHJWdjJobzNvbzBYRGloZ3BHMkJOako2?=
 =?utf-8?B?SkNhM3ZIeENER2J4a0VkVlA2ajRBS1Z2dzFVWVg3d2NqUVk4eFdPcUR5S0RF?=
 =?utf-8?B?WHFyZzNsb0hHQ1NCSTdzcEhmeHpCSmtBLzE1QXNXcVI2aFNUc1hWZDM0a2dr?=
 =?utf-8?B?TGR4bVk2aVpuZHRJRnIzbjJUQlluZDBDN09WK1pLMWpXenJPb0hpc3U2ekV1?=
 =?utf-8?B?TXQ3bzlUd09WYUY4SzhZYVc0SVM4WnZQblA2Uzl5VmhSVGpwZDJDVmFWVC9Z?=
 =?utf-8?B?SGV3eGFISEtBUitZbXVmelhKcm56VlBuL3dpMEo5a0pPM3A5amlYemU3UEZa?=
 =?utf-8?B?WHEraCtybGRLOXhia2tlTmlqQzdhdENPa3lnY29YdXBKYWJPV1cxT2FYRWJB?=
 =?utf-8?B?bG9RWWc1WFBYMzVXdmowV1NFOEplbjB4bWlSbEJ0OTVML0I2VkFXbjVWZHpE?=
 =?utf-8?B?NWk5RkJPTGl3U3EvakJMZG9jMHZQbUhzdWZtRnZCZjA0ajl6QnZzTWphNFJy?=
 =?utf-8?B?TURXeWtBUlozMzQveWdNb00zcyt5ZVErSjJrbU1yTGlHZ0JaaGYzOEx5RVlu?=
 =?utf-8?B?SEFlYVB4SXZ3dUlHTXAyRkRYUmNyNUhwcE4rTGYyeDYvcHBpR1BOc3k5dVk2?=
 =?utf-8?B?QlBkNDJyZVFOOHRsYVRncjA0SURIdWhsR2ZGbStBcWZZS2dqeW5HditZUCtk?=
 =?utf-8?B?SFFqdEl5NkRNWmJtQktQMFlJNEVlVHBpRktQakorUkVkeFlwWG9XdllGU1JQ?=
 =?utf-8?B?V3F5cURKb0dEQVlRQ3V3WE95enpybldpSTN1dzh1bjlBQVFEdURnbTNLSkZH?=
 =?utf-8?B?WUd0eTdFYjVWckx4NlBuTThkUGJCb2xUazBXa0ZQMGxVcyt4L2xxYytUQi9T?=
 =?utf-8?B?SWhGK2s1TkRPNkR6aG93QXY2aTF1Nng0OG83Tzl0L2s0VkxlUXhVM0pVc0Zn?=
 =?utf-8?Q?iAlHc3H8dXU5OyUU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1c59e1-5d2a-4395-c541-08da1e4088d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:59:35.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrfCVPySuD7CUR/JargXKUyeGdrJ+3kJ9wAh/53n9HSa0BSwCy+AfNg/Vis/KuGnG1gXlDGXzZMdwvPfzFcnww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_05:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140095
X-Proofpoint-ORIG-GUID: jKsFrnkcctcOaFTEa6WfDXP2sJ_ZYa0k
X-Proofpoint-GUID: jKsFrnkcctcOaFTEa6WfDXP2sJ_ZYa0k
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 06:53, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Reverts commit 888af2701db7 ("mm/memory-failure.c: fix race with
> changing page compound again") because now we fetch the page refcount
> under hugetlb_lock in try_memory_failure_hugetlb() so that the race
> check is no longer necessary.
> 
> Suggested-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  include/linux/mm.h      |  1 -
>  include/ras/ras_event.h |  1 -
>  mm/memory-failure.c     | 11 -----------
>  3 files changed, 13 deletions(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
