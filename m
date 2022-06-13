Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B7549C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbiFMSrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiFMSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:46:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9219357127;
        Mon, 13 Jun 2022 08:11:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DDYMPP013212;
        Mon, 13 Jun 2022 15:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=k2cGdegRka22JgRYEruPY16EG/kHNxE8wyXSk7ocZRg=;
 b=VH2UckBgU2SUUVjdtYpEAE0w0ZfqOTQsmb6fLYQTsjr0PjJ1xdX3QE+re6g3GXVR80Um
 F2Yp9CqeLjofie27isbzHka/bLz6wNndzFInF59uOrqV1daMdgbH4FS2LQeA6py+ElPu
 K3QWIX4lUSgKemO2t7n58gnVXO/C5Dq6F4CC5VefHsJNpkaD8aM61m2hfmEw6quRx4HQ
 r+12bS0Zjdjwv2eR31kRjfTsOzwoCYP0BIPlkW8It72P0d7GY8WHc/psPanmBwzOPNGd
 JsMWU6tygc2nL45SP1aTPCD44qmPW6O7PNzPNPZR9l3qruToxrCYuJaa/YJlhrT3F7+i gQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2kdxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 15:11:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DF7s0I001868;
        Mon, 13 Jun 2022 15:11:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gp7bts28q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 15:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ff7Nbh7gPyGiVi3v8MUJxfSuYXY0da7zaActah/+8WXV9fqCX3LTDMB79KtUqG0CgjIL5NAimj45WGqiwIBDOKPk8J7iLKwSo8g168RULoQ5xsUvmXURz1QrYjLrgNpQTTCgxznF32vwOYgfwyiSqCUsNDjNJZhJ/JZzFfWs9VdeAX+Moa9NO5TpDIHdoEbtkcdAW7/oE75Q9011Hpin6Srs6wETh5lQrY+vjuZ/EWdncAxgQ2VL8pXowmVpR0FPJz/Cgw/fQEpPkeqQGpps9r5VRwGLjNPgYtgTofujYXm6kV70cp0AxM1qyscK27zSlvqlSq9U+HjfJbPyE3hDBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2cGdegRka22JgRYEruPY16EG/kHNxE8wyXSk7ocZRg=;
 b=C/vKljbPEUXF5sIsNxFpTDQ/WJuVjCO3Tey+AdZW3/EeOdvZ8V6shBKj2955lz4kiqwmzwuuwCttZX342pEJP7sqse/Jcrn5zLl1JsRcGeHVqJ5VeaRfNO3xInFp4glxWdECQoXTdiD+6KuuaOl7HtCEBs7+yU+Mh4B5mINq9If4GzM4pWMS4syeLf8nFDNlJmt72PttfmI8VtNkzjiloiHk8d/l3cr4R5cB2pV/rvc9+MHwcwyvc87n8LTv5ltqyQJckxHtn13Q39wKIPEanvTpU4JPl+HXiOxc/ZR7aw6VEPihPQBTs7xEH02uoWGyuRo7MCNUVE1PD0O5ePulTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2cGdegRka22JgRYEruPY16EG/kHNxE8wyXSk7ocZRg=;
 b=RjhCBzZ/XXXlwjoPVMM+daidEkuNMAkLzRcKHBfPBbkrT/y5l7dSJIFfm/4jafK6LzcVqgZvUSCaMiCOHntOq5sBmCEkgfd968wyY9W8hlpabSPdgPUXrK577VgRJCBGbdnB78X82guvyiXGCfIyP4+KuIhMnZwaJdxQhJ4o+fA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY4PR1001MB2293.namprd10.prod.outlook.com (2603:10b6:910:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 13 Jun
 2022 15:11:20 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5332.016; Mon, 13 Jun 2022
 15:11:20 +0000
Message-ID: <390b38f7-462a-bfad-5e46-21b4e72f8a39@oracle.com>
Date:   Mon, 13 Jun 2022 10:11:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH -next] scsi: target: iscsi: Fix NULL pointer dereference
 in iscsi_conn_auth_required()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, martin.petersen@oracle.com,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220613014321.107045-1-yang.lee@linux.alibaba.com>
From:   michael.christie@oracle.com
In-Reply-To: <20220613014321.107045-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24)
 To DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0855a896-fd3c-4f58-e09c-08da4d4ef8ac
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2293:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB22935F5F49A68D0CA31D2B5EF1AB9@CY4PR1001MB2293.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5j4mNOwFOKO5zetdXtSFe5GuU/gLyT9ov8LXXmExjjbxPTpLMMPe82srgYfhiLRmCgpWrAAcBgteq4y9nBPjk6iJpxx0MAKYCIgeeK27uSsfynUSBs61RP8ndkrnnMGYGlsS587q0ieWL6Yh2E+YcU8TfvXcQP9hnMIj25KYOr8q74hTMybG7a/574TGPv6YHNFJSIcFH8yg+iTpZtLyGtNXpeJysPM5u/UAMhXIyLFgL8rTwtBbGCYB3+sM0m3NzBwtXGPJdvFWCuNv3nMNpFR9xv61NTHJ4Yq+lTXH3j1f4JdxklJOEWMADtkliRdgJxYxO9O7UdoVli+kgP8R4+bBNhTUdipLuXgXxXgIUUl6DP8MyCwsD4bWSWKFnhVRasrEEgQ0ch2LgPqYM0zp+vX3q8eTTwBrWNzBs2UOYAV9XRhiHYWOKCAjom0bJ2OSgm5ixSd5hgSlDXCpoCvnk6HRJBe2QBkWxs72G6HiiHwVrGavNjg3J/nJ3BTEyDqIPVzdf+xpO2D1++hsDPcKsZCsLWF8/F9Bt+XkWBTWzauU17iQWCBakeTBMlW9u80dewivKn2zYLfh/jNWBUC/7ccAj9x/d4lkT2yuBjRfkt335Bw0TWnBU/5EX79pc0XgJOA528b9kxIvX6X5/SEDZgJkFnIR3zYc+O2TUjALrTarPAa1Vx9ynAA+lziCNW+M0SfNdZBG3AUums7PWQ/N9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(508600001)(8936002)(316002)(110136005)(53546011)(83380400001)(6666004)(5660300002)(86362001)(6512007)(31696002)(186003)(9686003)(4326008)(6506007)(66556008)(8676002)(66476007)(31686004)(36756003)(2616005)(66946007)(26005)(2906002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHAzQnFSYkVSaTZ6STJzR1A2T3c5d0hiMFBRYXZRS20rZzl1OVN5SGRCaWc4?=
 =?utf-8?B?Z1RiamVrZXVCTEhQbWVaemttL2VLMzZFZWk3V0xFekNmaXZ1M1ZFemVtR0hS?=
 =?utf-8?B?Nzh3MWJocE1WejM4aVZybEdYQXZTbDhxSGFucHJJQm0rclZuRlRwNmpCTFox?=
 =?utf-8?B?Q3hOb1pPOUZMd0oxS2hnSXdMSjArMDlsOW1QaHdxN0gzSmlzTWhiRHk0WFV5?=
 =?utf-8?B?dDVaRE15T2ZycEFNUVcvNmRETXdiVXhnRG5DSWNXdnlhVzRuMjFJVzVLcEN3?=
 =?utf-8?B?Sm5WenljdVFDOVhFUEgyS1RCZlNaalJrSnFtaklzSE1OT3p0aVk1Q1AvZktx?=
 =?utf-8?B?aWM1RythVW9yS1hYSkJhRDhOZTRmR3Y0K29oMmE2UHZnZFYrbnlwTjkzRUdv?=
 =?utf-8?B?S1g5dWNZcDFqK0VCbTZGRHlYRldHc1FLYnhBcnI0KythOFlURnVXazY2QzF6?=
 =?utf-8?B?VldjMDQxUElNSWQvTFhtdC9QZ1dwdis5TU56VG1Qd2hjSW5lZWxxZUY1Nzlh?=
 =?utf-8?B?UEdvU1lZdU53MDFId0pBL0U1K0Y1dEllWTRHb1oyc1YwMmR2a2tqYVZvVVhs?=
 =?utf-8?B?MEFFd2x6M0xSR1p0ZGZ4bjlmbjI2Zm1vT05WRldOdFdCekhjNEIxK0FEM3Q0?=
 =?utf-8?B?NU4zZGtxZGQ0b1YvTnFHa0c0eWhvYXROUGpEckZ0U1BOZkJ6bFJ2a0Y3SHZ0?=
 =?utf-8?B?NEJ1UmNSTEtyZGQvQi9RZDFuVmtrcFI2Qlp2NVRZbFpjbVovSXpNdmFjUXgw?=
 =?utf-8?B?Yk44bktJVmk1UldPaUVadXF5MUV3UVNNQ0dOMFJRdTNFbTQ1NkhuaHFOMVZw?=
 =?utf-8?B?RWtDakphWmVidzBJaFBjRXlBQXFFbjR1aC9GbHlZZ1kwSVhucjhIZWZsZjhs?=
 =?utf-8?B?b2FRNk5JcXRqWCtFbWhscDBxZTJVb0p1Vk1yR3l2TkxjRFRHSlpVaWowcHR0?=
 =?utf-8?B?WlhDTXcyS21pOFFidUdybGtpeVpTVm5aVXlUZ2RXaENveGpOMWVRVmNVMWN0?=
 =?utf-8?B?ODExMWZMeXRSYW1tOSswdHlMbXY5YndOU2ZDdzd6YnZnanJBWi9Gd2tJRm9o?=
 =?utf-8?B?d2JFSzVNUnJjc1JoWTFYRDJCMVBKRUJTaUx4WmRvMkRnUm5neDJ6YzBCaGZL?=
 =?utf-8?B?TzNRQmlHZ2dxT1pmZDNyd0ZlYUlrWUlzTytncmdXa1dRTzBrekpuWW9udFdU?=
 =?utf-8?B?QjVqSGgrY0xVaUZPanRjcmJ1Z0c2dy9mRjQyRXg2b0xwNmxveFRoQUxFYnBI?=
 =?utf-8?B?WlhKd2xuZU9sRXRlZ2NSSkZJVVU5aHVaNWxnT2p4MFJYZkFFNEhSR3B6RGVh?=
 =?utf-8?B?UmtFRUZLWnZLc2VEbzVKZmVNTkg5S1hwM09obEcraC9FRXhoeW90RmxQbDln?=
 =?utf-8?B?dEQzS3BCMXhjajRGcFc0aE1Zdktmck1acFgydUxDY3hLWTBRSVZnakFpNm5N?=
 =?utf-8?B?YzNPVlYzczJDZWNHRHdnNTF6Z2lQanYvanoxSUZTd0RBZCtNV2xXUGMzV3c5?=
 =?utf-8?B?Q3gyNGkwZFNCVG5YQ1NnWmRPRHZjWnprY3I4dkZwYUdBaDlKR0FndXNBZndw?=
 =?utf-8?B?WGIrcjF4Y3puL1hTODRCK1JLSnh0bExScUFITm11RytZODhXMDdnbDdSL3p2?=
 =?utf-8?B?bTA3WWhVTFR5UjdiZlZaaWNjVlMxVWZreXFqcVJXaTUvT1JDcDJFOUF1NVZz?=
 =?utf-8?B?STBKOGJZU216dDlVa2xabUxOcEs3ZURiNmRXdUVQTFRvemtmRTdLL1FZRmlP?=
 =?utf-8?B?aWsvR2hSWHBtN2NCODhIbXNlWEJJWHBDZ2hEVEJpUVlLZUxQVTJLWVFFUzVT?=
 =?utf-8?B?UjlRaHVhckt2dnBDbVhzK1p0VysrWkhaVUlQNTFFWnd6OUlBQ1hsMHNwYTdy?=
 =?utf-8?B?Tno3c3NUdkRPa2VsbmorUk51MjF4Z2ZlK25iV1pBWVpmaVpZb0JoVDM3KzZE?=
 =?utf-8?B?N08yVHY1Ui9NNFZlUnFZbUxnd0lDVzNyZ2dKR1BSalhxdC9SMW52VHFFTmJm?=
 =?utf-8?B?Wm0yelZnbXJVZGlXN0JkNWFjSFlMUFAzKzVLNWlmZlFIOEVEVXp2SGRvWDln?=
 =?utf-8?B?cDhHUGRyV2tDTVB3WFdkdEFxZStEUDY2ZWJvOWYzZjZscXlsV3JtcUxUVHhw?=
 =?utf-8?B?d2RGYkthZHhiWkVBcnNFY3pqQ0g1dDZHVXhQZXJFZXU4RWh0NUxsY3hhYjlD?=
 =?utf-8?B?SUVxdGlyeW1nZyt4cWVKN04yaEd5MFlmeUFJemI2UlNrU0VVMWxnK251eDJB?=
 =?utf-8?B?bEFkY2Zkc3Q3ZGJJcVRzV01PbVEvWCtzckJOWWUxM2Rqay9HMm1xZWtmWUsy?=
 =?utf-8?B?WU43VHV2eGtjRjF3YVhvNW92Y3dyeXBmemhPMU90STkxQmlsajh2NmJ2VGYz?=
 =?utf-8?Q?oEj6LUCG9ihmhib4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0855a896-fd3c-4f58-e09c-08da4d4ef8ac
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 15:11:20.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiWjusdd/i/tanyswqNMdwZUkEnSFKu30K9x7vAlo46f/ZXB7EbnaaSJbKoJHLL+BMwp7auvY3I0KfPPHIuO79pfMy50gNMzmjdU1Oda284=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2293
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_06:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130068
X-Proofpoint-GUID: MTu0k6tcsZzTkOKKr-65RSWk7cIpWZpd
X-Proofpoint-ORIG-GUID: MTu0k6tcsZzTkOKKr-65RSWk7cIpWZpd
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TRACKER_ID,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/22 8:43 PM, Yang Li wrote:
> Fix following coccicheck error:
> ./drivers/target/iscsi/iscsi_target_nego.c:831:13-26: ERROR: se_nacl is
> NULL but dereferenced.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

This was just added in Martin's 5.20 tree in:

a75fcb0912a549c6c1da8395f33271ce06e84acd

scsi: target: iscsi: Extract auth functions

Do we need a Fixes or should the original patch be fixed?

Patch looks ok to me, so if we just add it:

Reviewed-by: Mike Christie <michael.christie@oracle.com>

> ---
>  drivers/target/iscsi/iscsi_target_nego.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
> index 9ce35a59962b..fb93a1173954 100644
> --- a/drivers/target/iscsi/iscsi_target_nego.c
> +++ b/drivers/target/iscsi/iscsi_target_nego.c
> @@ -827,8 +827,7 @@ static bool iscsi_conn_auth_required(struct iscsit_conn *conn)
>  	 */
>  	se_nacl = conn->sess->se_sess->se_node_acl;
>  	if (!se_nacl) {
> -		pr_debug("Unknown ACL %s is trying to connect\n",
> -			 se_nacl->initiatorname);
> +		pr_debug("Unknown ACL is trying to connect\n");
>  		return true;
>  	}
>  


