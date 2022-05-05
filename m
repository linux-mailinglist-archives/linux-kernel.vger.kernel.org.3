Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E02851B6A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiEEDkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241538AbiEEDkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:40:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9714A3CA;
        Wed,  4 May 2022 20:36:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244Nl8PD030007;
        Thu, 5 May 2022 03:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4imIRbOUcq6sxIkvtRiWtTHNxuvtIQN1giBALvpfGOQ=;
 b=Fm1yc+jdCUaxWL3AESNGw24ouFBVQfYY7FDrguAHcB9WNv/R1lH2tFqo8vmoLe0Dus/d
 9pUkDRSv6ZhmnxWHZJDAjS4rlQpsppPbEbLivK6UQDAXNXM16a2cfrfLxPko8id/AIZi
 ZRFboxHU1QQEhAr6nHjlPpfa3pDGLmve7eqet8aaieseIwebC8dxQOhDRRZkeCr5eOUB
 YFANI1LsEDDgYozbVx5HynfbJI/uJG+M7P+q9kA4k8xs4aFpBZmJ6NxNQyeGteNzfNfH
 bVsiqPQbc6UPPnt954sV21eILsqf5THASu9UMyXqid9dDReYuRetzCO8p+SqjtxVv92e gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0j7wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 03:36:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2453ZTPT010710;
        Thu, 5 May 2022 03:36:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a6e82n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 03:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCRYe74qn2E/3eZuQ/iGslu1BekwgjmXIpYiK/KRNOeywIzgHHxjB5oZYWoZaO9vPLHvRJDGm6fCBNL1uxyzrtjv5Pb3l5SS1E6l75IY+wxoY6JQMxmltPnNB2tciKibuYF+0xul+CIcCdEnAYO7y+dONUewncdMAGjSJp4IOwrht/lobtnTugNdsPLIEiv8GEFRpr4VX6H9s/pvBRw5ekMHBhOfr+Z9FMbsC/J8dhvWGKKD6JR9vS9u4Usvnx22YbKitJpuDJkqBJBdRCN0Rea2Ig0p5f2KfqJla3eTkHHj2Zjtx74JuTE9qlrsPjxQSqpWjD2RNevJoMIkonojog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4imIRbOUcq6sxIkvtRiWtTHNxuvtIQN1giBALvpfGOQ=;
 b=YWms58TajKQ2LstrFBqEVTCWUJiIitCHqDbbsadQL9jnSOgKiseouBOXooqTcOFjfKBU5PRTSt7G23PUcJcQ2+BbdTIn1aG/BdDhLdqVzNHPEfgMbninc1HxKXn3YtWCEwB0bB5rBbM4flz15cUPq4y/E65N3pvWgIK9lo3V5SqVFBdA/Ux5NkX7vpu/RcJJcMulN56+ytKhZ2zPbjf+TbfJePjHrbZCx2MUCbuxESVjWPmIsjGWrnpp6g38Yx042hzII/+WPJ9ju0EN+U612oo3MnoYU7voepRgwd+sTN+NAKX/YDl2hOh04pHK+hduivOvVI6SAcIyqKZfMzn4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4imIRbOUcq6sxIkvtRiWtTHNxuvtIQN1giBALvpfGOQ=;
 b=y1nyBOODtEzfCjG6uBMgy92wR7mjaaLWNIU9ynQ9Tc2QCLnjJhEatLryRn2wMYouPBs90ZGeV9Y8F+8fBWuPsamm6MrM6jP0y/aOKm9j6AH4lBzNT1Nv1LcOtczwRgmttNvRbIhrWDleMXm33R/S22a5MlzAOQtKO7yprbjHe6k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN7PR10MB2674.namprd10.prod.outlook.com (2603:10b6:406:ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 03:36:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 03:36:02 +0000
Message-ID: <f77412f1-ffe5-659d-8a7d-578e0e8c5e2c@oracle.com>
Date:   Wed, 4 May 2022 20:36:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-5-songmuchun@bytedance.com>
 <eadec7de-2e1a-2fb3-3317-c7b492a84e2b@oracle.com>
 <YnM4DRFhdD6iZIs1@FVFYT0MHHV2J.googleapis.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YnM4DRFhdD6iZIs1@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:303:dd::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1870a15b-d7b7-4983-ed6f-08da2e4860fc
X-MS-TrafficTypeDiagnostic: BN7PR10MB2674:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2674A7EE59B3C46910E81838E2C29@BN7PR10MB2674.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGS/xdby4x/lhJidVIV9VETeS7BEhc2npFfe2XWwEH/QmgQC6NwCgse0DNhlZ0VasFGaR9zSHFuSEDodU0+5NOdCBR+uR7hc+XB8SHpDV4KguvcfchloZqF+qOwIZamaOO6lr/AskdUQrln+yeDgvxkmeMZUkCKAaAiX5HAk0oTMIg2bg9AJHQpfnlulWgNtWaD6ExC/6VQ+XONxaRQN5hAP/WM1ac9rz7i2Z2BLtTZOEfsxC/Vl9Cqt6L6xWlFC9kNxu4Yq6qPV9gnqgpuy32xRkpUsS9DfqtM6/3TtlAfUiMc5lqaQsXnyU9W0Aw1lhezwr2qfLm43gejLc9PEZPSwmRK6Re76dr2xSbJcM/guWAQTkZ8bKfpIZ9YaATVVNGd4zPuzDbfjsfHMFLv7U9HCdI4GlhJvL/zs7NtMQns3DDPwts4ELHTa+gxHfh8Apw4L6e/3ewm3mgct8LXPGoqwAll3MNJJeGzvjGTtIwnvV/y+tiQ+tX5ugEYxWAx18Az1tSzKR5IzFcOLgCxdu2HoGwpE0wobM6zlVXjiXr9LL4rNIKBeXqfrqGSMOwBXE8wD5imAxQ9fmk83OKtKEuy49FsBmhf5eLg6L8UUsOnv/9flbwgN02p9iFhB7U/JYbpbxs2h76+8RcACb0WEccghKgkk0nzNvcIA7sFhp9pESkI2lHbqqJK2qZNwAD2eeXAraNxi0xcB6Tl3qOVaqc5GXWmNC3VyML8X4Rei4PKviO1nSfVYSV3k4XIgwn2Zc9DmPkM+9NoDHbINkUqWEeJ2LAiO83+99RcizXzH0M3MeFKell+InZlt80ezvUfMGQG/syn7TaGpkpZ20W3CvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(6486002)(966005)(38100700002)(38350700002)(2616005)(508600001)(8936002)(186003)(44832011)(66556008)(83380400001)(31696002)(5660300002)(7416002)(2906002)(66476007)(6512007)(36756003)(31686004)(86362001)(26005)(52116002)(53546011)(6506007)(6916009)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnZUM3dtaytGYXh5UVFKeVVLNlIrdFFXQ2JCc0U4UHhqMHgza2NoY2JDS2Jo?=
 =?utf-8?B?cEhKdFZYZ05CS1h0VTZiRHdWbTZOUER2OWNPdnpTTXMvSlU4YUE2NHVWREI2?=
 =?utf-8?B?bkhSWERZWStLTTdNQkc2M1BWS0xFUzNmcUduWW5OWGFTQzRrdDZOd2ZjMVND?=
 =?utf-8?B?K29hbjRORysrUm9EMjkydk94bVlqT1kyYkpzUGVOemowZHZpNTdUUGZsYUo5?=
 =?utf-8?B?bVpBbVp0bmh1bk1pdzlyV0xJSEp6MCt4U1lWb2xEQWhRUjM5N0YyT3ErSkdP?=
 =?utf-8?B?K1p1cmNPaGV5bjZXaDZIT1JmeWlsOGNMRUh5WVN1M0FhUjlvQU5zNHlEeGdT?=
 =?utf-8?B?OEhjcVc1dWh6QSs0bExWT3BLLzRQZEp5djR5aGxzbHM3anNiY2ZZV3VIQUw1?=
 =?utf-8?B?V3pNbnE5MDB6R0pGWW9QY0g4SjBPaDB4eFEzMEVJQ0JQdHBTTXV6TW41Uyt4?=
 =?utf-8?B?T3plT2VieWpBZGZMYXhMUDlhZWl3RmRFUDAxZkE1NXJscjMvcDBSWHZpMU9L?=
 =?utf-8?B?SkRDd0tqcHlHc2R0bFN6ZElsa2s1NjBVUUNpSExMYkZwTkgvTGUwM25ySy9O?=
 =?utf-8?B?Nm8wbWttOXhZNWV5RUFjUHNsOUVESVJ5eVdLb2NybFAzb29XRGEvYzlCekFC?=
 =?utf-8?B?a2FKQTUwZUdvaWJEVDcwRzVuRjNNSEtmOTI5STYxSy96aWpIYUMxMnVHTkNM?=
 =?utf-8?B?TWxJZFNoTE5LK0Y4ZU5KS2NuRkU3TE4zZStMSjk2NmhINi9GNzJqc1JEb3dl?=
 =?utf-8?B?N254T0VGUjNEZFJCdjZ0clk2YWhlc2NJUHFtTEorTkhDQXpSbEg5eU0wTWl1?=
 =?utf-8?B?NHhBb1dPUExTSzdIRi9UL2tnVVJGb1laN0VRc2NIcG1HN0g0WmV4cXdvTkVl?=
 =?utf-8?B?VitaaVA2bnJvYzJiZnJuWUd5UTVTSzZXaDVOZjIwZVY0Zmd6REdIVGVSbkVG?=
 =?utf-8?B?c1dOUVdyVThZOUl3UWZwbW9ZdUdZaGN3dkJaeTJMdmhhTzNxclpjUitMcVJp?=
 =?utf-8?B?T2U2akQvWllwY1NDY0RnNDJ1VngyN1dQeTFzMWJaaTdUY3dSaThnV0RlTGJM?=
 =?utf-8?B?b1UrVE8rWFJ6TWRSWU5tOEl1QnBUdHJIand2OTBHcTVnSkZXK0pZb2VJUCs2?=
 =?utf-8?B?cUxCcjhkSEVGN0Z4cGFtOXdabjI0d2F6dEpaTHQ1YTg0U3QyZVdRRTFpcVlX?=
 =?utf-8?B?UVZCWFJPN3RXTzVFUFZDUzRRSFYrL0JOa3hpSWt0MGJCbmdiODNlTEZPa205?=
 =?utf-8?B?cGt3SXJkcW4rN0FLbGh5b05qT2pRNVJJSTZNaGxvdlg4M29FUCtINXVpYVhr?=
 =?utf-8?B?bU0vQTBqL01DV09IKzR0TUNBL0pOU3pmbVpjS3c5RnBFMFVZb0h5VjhIdEsz?=
 =?utf-8?B?YzBMV0h4bzJqR3RFM1BhRGNJdzk2YzFCWjQ0NFArQlRpMDA5VzdWU0w4VzY1?=
 =?utf-8?B?b1hHWmx4TWN2ekFwNjNKeVhBUmZMdFAxeDJERjlPNUgzL0tQcmE3b0RPb3lh?=
 =?utf-8?B?YUhaNTRMVk16T214UHpncEpYZlhWK2JzandVcEdiVWJJR0JXTEEwL1lEVDE2?=
 =?utf-8?B?NFBHSHBjOHBBWkJvSTkxcUlHMmpvOWhnaHBmbGJtUlFobEdPTUx1Z0ErbmFX?=
 =?utf-8?B?NGtERDRBZnBZUE9tblMrblVWWC9FZ0U2UjBERlhIYXc0V0tIMVZKZXVSV1c4?=
 =?utf-8?B?SU50bHcxTDFERExHRS9ZYmZlcm1oT3htVFdRazFYRGhodXlpNml2bHJSY3Z4?=
 =?utf-8?B?RTZTTjFmT1VWYlcyczc1RUROTE10UzdWb0FkTm5wRzFsbmxXMGFIcjI0cjJ1?=
 =?utf-8?B?SnBOODB0UWZYbDlmUHcxSDgzcGVlMjZrYTA5cWJIRFpRRHdWMWl3QW0wUFpG?=
 =?utf-8?B?cXo3WVVFS3JTeUE1ZElNK2M0YnJJMmh4dFVFdHZWeVJ4NFN0YnhablkraC9a?=
 =?utf-8?B?dnV2ekdhdWtyeHNwU1ZrOCtPbHdWS3NoYkR1eGtoS1Z6VXN3WHczQWlZSTFR?=
 =?utf-8?B?U2FjNXdTdDhsUWc1QXNFdW5jUTdVZkFqU3hBN2xibXhCb1htcTNDek5JWkpC?=
 =?utf-8?B?T0htMmVjcjh2cWpmMDNtR2xmTXZnb21QOW5ucDdyaXptc2FvY2U3YVByZG1H?=
 =?utf-8?B?N2dyQXUzM280bTJBQ2dqN1Y2RVRwZmdrdGdmTEFQYVlZSmlRKzRMRkVSSFNY?=
 =?utf-8?B?bTFLOHhzUnNOY2U1VGVRTjVLV2xxQ1lJSENoMDJvb1krcEdZSVhFaDc0dEFy?=
 =?utf-8?B?K05qbDZzNjNlYlppWEhzdnh2cHdpMnVxb1U0WnJjbnRGQ1dncVlKV3RXd01B?=
 =?utf-8?B?QnQ1SjNUVlgvcXp5VHFBVkhsQnF6VjRLVXFlRXN6bHVESXIwajRTa0F1MzRC?=
 =?utf-8?Q?SAQZjVI/i9pDUZeA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1870a15b-d7b7-4983-ed6f-08da2e4860fc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 03:36:02.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HNi0IDj8SdYmN6MkOqgVnJafhIgYJTLHj9Ijn1AD5NTBdtBMlFJRvQtr89swhJflGf72DqgkonfQwxQXDoeJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2674
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_01:2022-05-04,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050025
X-Proofpoint-ORIG-GUID: euVHL2JYeDTGUL8vCGJP-229MK4IzCi9
X-Proofpoint-GUID: euVHL2JYeDTGUL8vCGJP-229MK4IzCi9
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/22 19:35, Muchun Song wrote:
> On Wed, May 04, 2022 at 03:12:39PM -0700, Mike Kravetz wrote:
>> On 4/29/22 05:18, Muchun Song wrote:
>>> +static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
>>> +{
>>> +	if (vmemmap_optimize_mode == to)
>>> +		return;
>>> +
>>> +	if (to == VMEMMAP_OPTIMIZE_OFF)
>>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
>>> +	else
>>> +		static_branch_inc(&hugetlb_optimize_vmemmap_key);
>>> +	vmemmap_optimize_mode = to;
>>> +}
>>> +
>>>  static int __init hugetlb_vmemmap_early_param(char *buf)
>>>  {
>>>  	bool enable;
>>> +	enum vmemmap_optimize_mode mode;
>>>  
>>>  	if (kstrtobool(buf, &enable))
>>>  		return -EINVAL;
>>>  
>>> -	if (enable)
>>> -		static_branch_enable(&hugetlb_optimize_vmemmap_key);
>>> -	else
>>> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
>>> +	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
>>> +	vmemmap_optimize_mode_switch(mode);
>>>  
>>>  	return 0;
>>>  }
>>> @@ -60,6 +80,8 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>>>  	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
>>>  	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
>>>  
>>> +	VM_BUG_ON_PAGE(!vmemmap_pages, head);
>>> +
>>>  	/*
>>>  	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
>>>  	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
>>> @@ -69,8 +91,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>>>  	 */
>>>  	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
>>>  				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
>>> -	if (!ret)
>>> +	if (!ret) {
>>>  		ClearHPageVmemmapOptimized(head);
>>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
>>> +	}
>>>  
>>>  	return ret;
>>>  }
>>> @@ -84,6 +108,8 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>>>  	if (!vmemmap_pages)
>>>  		return;
>>>  
>>> +	static_branch_inc(&hugetlb_optimize_vmemmap_key);
>>
>> Can you explain the reasoning behind doing the static_branch_inc here in free,
>> and static_branch_dec in alloc?
>> IIUC, they may not be absolutely necessary but you could use the count to
>> know how many optimized pages are in use?  Or, I may just be missing
>> something.
>>
> 
> Partly right. One 'count' is not enough. I have implemented this with similar
> approach in v6 [1]. Except the 'count', we also need a lock to do synchronization.
> However, both count and synchronization are included in static_key_inc/dec
> infrastructure. It is simpler to use static_key_inc/dec directly, right? 
> 
> [1] https://lore.kernel.org/all/20220330153745.20465-5-songmuchun@bytedance.com/
> 

Sorry, but I am a little confused.

vmemmap_optimize_mode_switch will static_key_inc to enable and static_key_dec
to disable.  In addition each time we optimize (allocate) a hugetlb page after
enabling we will static_key_inc.

Suppose we have 1 hugetlb page optimized.  So static count == 2 IIUC.
The someone turns off optimization via sysctl.  static count == 1 ???
If we then add another hugetlb page via nr_hugepages it seems that it
would be optimized as static count == 1.  Is that correct?  Do we need
to free all hugetlb pages with optimization before we can add new pages
without optimization?

-- 
Mike Kravetz
