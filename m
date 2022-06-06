Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E166D53E92D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbiFFOXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiFFOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:23:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5542D5380;
        Mon,  6 Jun 2022 07:23:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256DfpVk018616;
        Mon, 6 Jun 2022 14:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Uy9QsP/R0MZKbtxU78o8R3s7/9lnRVtdDMMArzl8P7o=;
 b=B2JWvNqAqLvnp5DdOD8bJWr3ZT1tk7EdE5RBn6vDD3S36xekPuVWc2r68q/PY0JvaMnp
 cD6t33x5ijyhQ0G3SzW6KlfJZmQQrlos5kPbJwaMzaxEvH9e3xDCHrUqHJckOdWb+dR9
 NGG1zB1FF/y3psq9U2ZGXLm/2NXkVp/sMVwdYrbP1tMOW41vFdo2vl27KQf6HksDh1Ji
 KLMvnzElnjcxj1ujzTwsGl3M8RwsZ5x+I2tYrJwKeM9pWfTLRgccTvmtMqpriMsViZSe
 OPdT3mMK219lEhze4DG2YnUqI3mnXLkWvh4c7T0OW6fXeo5mgnYtKtfBoSWubvz8RP/C 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekb78h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 14:21:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256EB6Tc012712;
        Mon, 6 Jun 2022 14:21:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu8rccj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 14:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8d7+rNLSB+QSVndm73bOVSk7sm41AE+SYBsrjC11bCWK4o7bRdffI1tbf9DfGQ8N3ndVc68Y3btU32SI2GX2RQJ09sYsJMwAJlFuE6ICemf1Y84gy2Y7xJgIR0WxiproMzoELObkk/ix5atvsyI7VCFKW6gJi+Ylc8QuIX4LNNdbsSB+zrjVR+GnIJG+YToS2QqWB6wW/2YnmTlaOKgX3PFXBoJoGdGo1NlDkj7IkRDntjjg0pmY/H/6inM/sdTeOp8eWElkPM62bzboEsKHeNMnQJXaSS2n4iPiNFfQNu1+IB0B0R+HVzllXqcdKJv4UheAtumMH1CkES/C8GAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy9QsP/R0MZKbtxU78o8R3s7/9lnRVtdDMMArzl8P7o=;
 b=G0zQIlb3+IuBPynxH9d2VpzM8UHffvG+Zks4qYzzJ956ldHFkLkrcvOOnkCVGUkZhpnkl4jVircp21oN4i435RriPiCckT381NG6joQU2xzyL3XR7EPpc2XwgLQ6ySQDNWtlNUoWauz0IQ0W2ISBhRmrqby0GcmST34htkjMRhl6TGIycmvYUQipP0zdIxskS7o2CETxvoBFyehyUe3rdHQ0fh0/Z5HnMXLcSDklg2bKcUi6u2gytipmb75s3kHu4NBVSPmWfSKc+Mn9k3reMiavdemloQcJYGU+TlkOQ4/pum//Li5MleanZcnPfJjooMSiaWT863eU3Z0GzpqpJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy9QsP/R0MZKbtxU78o8R3s7/9lnRVtdDMMArzl8P7o=;
 b=PVH6DEVuy5WubppNMblbo9HMg5G1dfl1t9GwJck2/ADot3CRYabwWwZITEliw0an4QLiPp28RMdlX6Cy1gmT9q38SFPSW1nvhjiVCYT71QcTkBANFx7kBXBoKsUK0xxekuiC27KlQruVhzD3mUnZOuxbfo2tBAomOmJOpfBL5pg=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 14:21:51 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:21:51 +0000
Message-ID: <303283d9-5f1c-8bc7-6286-ce284de012a8@oracle.com>
Date:   Mon, 6 Jun 2022 16:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Documentation/security-bugs: overhaul
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@canonical.com>,
        Will Deacon <will@kernel.org>
References: <20220531230309.9290-1-vegard.nossum@oracle.com>
 <20220601031254.GB26318@1wt.eu>
 <42200c3e-fb39-ddab-3d68-5dfb5eb89451@oracle.com>
 <20220603064924.GC29741@1wt.eu>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20220603064924.GC29741@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0029.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::16) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dff59f0d-6155-4068-ad68-08da47c7e5f2
X-MS-TrafficTypeDiagnostic: PH0PR10MB5846:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB58467FF8AEFA5DC4D163F1C597A29@PH0PR10MB5846.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ss9vXQCSlHpDZ0lBtrp8iaeIiCAZfG4ojBtLdMdcHtHwpdTuky5divTsTvEvTNm8f44WOammW8CzdaBC7QmCNIHJnT7cONlkmAwe+mdfwQCp09hySPaEKBymZc9LrUdSw3p64eAAFsGolY5Xvuj0ay6NPtE+E1H55YqQPUotVLrO5FJh5cw78vSqaMIM1wajHto9LxkQf03KrvYv8RVhHmvVB0rj+nh0BQBGbBkz1028p7RyOq03/X04cVV4FlSxcnMgETdvG9T6nHk6KMe7NO4eyuJ5fchGo2ZjLL/GLl8dAGi6sOoaUWzC7I592Ty3Gceiha/KM0sDLuz69t+O+8VjDiAWXTpliQ+gU1GF+8lJr1Ahs70kNce8BlHYlrFIMz05zdDwryUOysvlEUXoE3J8GO7VtEDnl0NwNVijOi7c8kMmCE+bO4nTEVjwziyh8YVWHdD+WtM6D0lRwk/znxRLRdzg9MuE2PsWlV2qerTyv/a2hyC8kPKPJ+xFPxL/1XdM0/o8iwv26MtARbblDsL0h3DkPx/3fOHOKUGbo6+fOjC/adBwZCikRYUJomOsSm627PVE5TJAfAIuF6dSh05RjxizPAhCUPrZNAI2hGj5L3kgz9tUQF0f1Hh83gav5lCnauKsGLvTvT9LQwFMTnzwQBSIuCQuyxFQen0Ssy1Pbcr73MwGAr+LPycZ7TwBgIcS42nhFyCmpjarJ3iSHgeNnRMHp9oG6deQz9oYRkFLTHLFcBvkJWFaT88BLqRaAJ756rm82R84lIRSQBktlaG8aJf3OMES09pjSacdze4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(31696002)(83380400001)(38100700002)(508600001)(186003)(2906002)(6512007)(31686004)(2616005)(36756003)(5660300002)(7416002)(8936002)(66556008)(66476007)(8676002)(66946007)(6916009)(4326008)(86362001)(54906003)(6486002)(6506007)(53546011)(38350700002)(44832011)(52116002)(316002)(26005)(15650500001)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ExT1Jxb3MzYlhvNVFmbk9tY1lta1NwVEpKUHlMZTJ3ckxqOXNTTlVtK04w?=
 =?utf-8?B?WDFaODUwUHlBRWpwV1dPYTJVUWw4Vjk3VFNERUVEMHIwd3JwaWIxWUZWenVi?=
 =?utf-8?B?a3d6dnBQVTNQdTJRMFVxU1RuR2gxL2pQL29LRFdOVzM2bkh5UDZWQTg2TEdP?=
 =?utf-8?B?RmREY0V5dnVFWVVtRXN4QTQ0TXRzTjhMVkxhOE93Q1dJOUprMW9rMkx2RWg1?=
 =?utf-8?B?cG5KRjJPSXo2T3ZSWk9rMXhyUTRUYVlLaFZBS2lqRkJuSmw2aWVGKzVEMzlX?=
 =?utf-8?B?UXp5UmFkck4vWDRKZEVZOTFscmU3aTI2Y3hRcHdYOVI3YjRqRXlzNEQ0RjA5?=
 =?utf-8?B?Ry9FckRlQTE3eHREcTBwTEVaOXY0cHZLUlRvVUpZazJEeFc4QVQ5aGVoMlBV?=
 =?utf-8?B?em9Jbi9OVCt4UUlUeVhNU1JFRkZNNWsvd0FVRmNjT3BUOG9ETWE5d0F4MGVx?=
 =?utf-8?B?NG5vcUl3VGdKT2ZjMzJHMG91Uzc0YmZUMGRHVXhyQ0pxSmFadFRhN1Q5Y2pB?=
 =?utf-8?B?aW1hSHVodFFGK05LU245aE12UTByOVNLTjF4UXRlbkhTU1ArUzRLcHNiRjkz?=
 =?utf-8?B?bWhESmdQR2ZGRzVkWCtlTjdPUFhBWThYSVZ4NktoNllGQUR6eVlLT2pFWlUr?=
 =?utf-8?B?RnE3WkFjY2t5d1dtY2ViMGxVS2hkMkxrYlViRkdIODVqc1VzVXZFOFhpdlZ4?=
 =?utf-8?B?bVJaR3FVYXBUaTl2WmdKVTRrY0doM1NsNHhiUVpuc2htODhNZW04aHJEaURx?=
 =?utf-8?B?MHd5WGNXYWJ4L1pmNWZFTjBjS1NBRlp2dlVST1V1Q09acHNLVWg5b0JRSVZy?=
 =?utf-8?B?OVB2V05zS0xWNGdXUk1Kc2ZxTU84cWVDZVl1VXYvczJocHc5S3QyMnNQQmNq?=
 =?utf-8?B?QVliVlc2ZlVob2Y5NTNhTnppVnNkVHlITEdPbG16MzlLWlpKYU5BQmR6M3hG?=
 =?utf-8?B?THZEcjBwM3VDTmF2RWRna21KMHpSa3crYXlTVEE2RlRMaGdmQmFpNjVGK0Mx?=
 =?utf-8?B?Y21HajZYdllybFUyeEdwZlkxRHM5QmtyVmlaOGRYUmZjVWtBMUUydmkzLzd5?=
 =?utf-8?B?dktZcVd0YytPSTNOU3hnVkJjdTFCUFJtOW02RUkyMFJ0M3h6RndUSXgvUExv?=
 =?utf-8?B?aFJkVU52NGZDQzdYN01nT1YyUzdaSk5zZUhPNFBSQnZ3UnB6cGdsQVVuSzlw?=
 =?utf-8?B?bzlETmN2K2NQakhkZnBNeVJBbzFGeWcvU2R3b09oSXlZS2wrSTIvY21mMW5P?=
 =?utf-8?B?UHY4Qy9YNTU5NXZNVW5nZTBFZ1FnSjZLVkY1dWh2RHNHTlBjcWhrTG9iZzVJ?=
 =?utf-8?B?aEIzUG9oVW45RW5yZ3JWMjBjUmZrNlV1cFZWenZkN0dUa29hL2YwcUFycExE?=
 =?utf-8?B?c241Z1VJTVJZbDNoa1VsMURXSEZzVUN2WjQzZ2Y2aWVvdlU3S2RRVDhjRHVy?=
 =?utf-8?B?NTg1RlN5WVhNZll6ZlAxWnBOY3dJS3dHREc1MFBFSDIrWTM2bVVNYnpnSExu?=
 =?utf-8?B?ZDAvRHlOWm0xaUdkYXVqRHNMWXZuMEdhVVhrM0JJeXpHcUZzOUwzeFYvZ2Vk?=
 =?utf-8?B?WXVHS3NnTVloUVg5YTdKdmRMTnlYN3RQVFh3ZEpEVjJmVUpiUWozSlE0RlpJ?=
 =?utf-8?B?OHhxOGphVCtCR2daZlVHbXBBbjBMMTRyLy9OSlFsZ0JiQ29KUnF0R21ZWWpv?=
 =?utf-8?B?KzdFM3E4OCt6ZHhYckhoR2FGMUtta2RlUlM4TmNxVzlxWlRUUW94Nk1EOE9h?=
 =?utf-8?B?azBRL1R0NWw4UWUxeEVFWHpFSHBWOSt4STFwREkrTlkvckNETWVDazMvUUdj?=
 =?utf-8?B?OUNpTDJhRmpTQnJQVXp0a05ERlhaNkE0cWZKNUdwclcwWERSV2w3Mk9JdzhQ?=
 =?utf-8?B?d1hzblZGZmVhM3lod3EzM0FZa2tvVDJ6OEl0cnZucEFXMjZFSmtkTHRTTTBF?=
 =?utf-8?B?cW84d3MrTzRhamdHbWdHNU9ESjhDUWx1Zk03U21kV3k2eXJwWXcwSTd1c29s?=
 =?utf-8?B?bTJZemQ1ZVBxRlFIZGwxck1UTlFYNGNVUmN2eDRaZGlMK01lTnU3ZncycUZJ?=
 =?utf-8?B?SitNbzdQL0RHMXhKNXZyYTdFUkpvaHJMalNVNUhzY2dQSWdjZ0VTY1A5dUFX?=
 =?utf-8?B?NzhCWUV1SUZNTWM4RUZXNTVvMm81UnFpWlp2MkRyOGxXUyt3MC9qR01wYXpP?=
 =?utf-8?B?dHpiVXBNY3hNcTRPMEVoUnBJcU1OVis0S05hNU14OFRqdlhpZzdXUTd6Q0dz?=
 =?utf-8?B?Y0R1RC9ydVhwSFVrK3A5bCtYa002cHRJUStIQTh1eStnckptc25IQlJVellM?=
 =?utf-8?B?bk9EQ1hoTkVOSjJPdGRYUzV5VTMycGo4WldaLzNzQzZZM0Nramtsc2x6ODdD?=
 =?utf-8?Q?V+M4o59WRBWf/Bvw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff59f0d-6155-4068-ad68-08da47c7e5f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:21:51.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBAmR30CIWjShXgq1GWpcccMM3wWk8ghG6F8JtCbcJ3+Gb9aU0LTbQOLtMKjbxkKElkK2X8s4GXb3SqwRLpmGHP/WU64WNbY9YLA5xJKgtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060066
X-Proofpoint-GUID: SQflM3O3A3GC89IhO14VJ5BOrHCR7767
X-Proofpoint-ORIG-GUID: SQflM3O3A3GC89IhO14VJ5BOrHCR7767
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/22 08:49, Willy Tarreau wrote:
> On Thu, Jun 02, 2022 at 05:34:48PM +0200, Vegard Nossum wrote:
>> I think there's also an argument for encouraging reports whether the
>> person has a patch or not, presumably it is better to know about an
>> issue so it can be prioritized against all other known issues, no?
> 
> It depends. For a few months now we've seen a huge increase of reports
> for things ranging from "if I modify this driver this way I can make it
> fail so I think it could be insecure" to "this outdated driver that is
> not enabled in any distro anymore has a one-byte info leak bug, can I
> get my CVE". There have been weeks with 2 of them every single day. It's
> obvious that there's a quest of a CVE to be held as a trophee, and that
> for a CVE, a security bug is needed, and that for this it ought to be
> demonstrated that some random bugs in certain circumstances could have
> a security impact. Thus there is a huge bias.
> 
> I would really like it if we could get back to what works fine: use> the security list only for currently exploitable bugs that are not
> trivially worked around, and please use public lists for everything
> else. It takes way longer to fix a bug in a small team having to
> forward messages to maintainers, trying to fix in a small group without
> knowing if we're going to break someone's use case than it takes when
> a non-critical issue is discussed publicly. And security fixes that
> cause regressions are the worst that can happen because they discourage
> users from regularly applying fixes. As such the vast majority of bugs
> ought to be discussed publicly, on the relevant lists. Bug given that
> some reporters are not interested in getting a bug fixed but just in
> getting a trophee, that's difficult to get a patch from them and to
> move the discussion to a public place where the fix will just be
> handled like with any regular bug.

I think this points to a bigger problem, but not with CVEs being held up
as trophies. There's already a huge monetary incentive to find bugs and
sell them as 0-days so IMHO we _should_ be encouraging people to find
bugs and either fix or report them, whether privately or publicly. If
having CVEs helps with that, that ought to be a good thing...

If you think a reported issue is not security-relevant, can you not
simply ask/encourage the reporter to make a public post instead?

If the security team is swamped with legitimate, security-relevant
reports, then that sounds like an issue with manpower and/or
organization. In my (admittedly limited) experience, Linus tends to be
one of the first to reply, so maybe having a designated person or group
to triage issues (maybe in a rota system) before engaging the rest of
the team could take some of the pressure off?

> I don't know how to adjust the wording but I think that the spirit is
> there. By the way there's something I would like to see added as well
> to this, which is the the ultimate goal is that a bug fixed is perfectly
> understood and documented. So either the details of the cause of the bug
> are in the commit message, or the researchers prefer not to publish them
> yet because they intend to present them at a conference or in a blog
> article (pretty common), which will serve as a reference for to get all
> the gory details. But in this case there must be a reasonable delay, it's
> not acceptable that the details of the problem are withheld for months.
> 
> As such I think that we could mention something along:
> 
>   Upon reporters' request in case a forthcoming presentation of the issue
>   is planned, it may occasionally be accepted to temporarily keep out some
>   of the detailed impacts of the issue, however the security team reserves
>   the right to publicize these details if no other publication happens in
>   a reasonable time frame or as soon as the fixes are found to cause a
>   regression.
> 
> Because quite frankly, not being able to explain exactly why a patch is
> done this way and not slightly differently is not acceptable.

This unfortunately directly contradicts the current policy as stated:

"All other information submitted to the security list and any followup
discussions of the report are treated confidentially even after the
embargo has been lifted, in perpetuity."

So again, unless there's a clear consensus to change this, I wouldn't be
comfortable making the change now.

If I could make a different suggestion (which is in the same spirit as
the rewrite, actually), the security team could encourage the reporter
to report to linux-distros once there is a patch or the patch is public
-- that way, it's: 1) not on the security team to disclose anything, 2)
distros get a heads up on the patch, and 3) everybody gets to know about
the security impact of the bug when it is eventually posted to
oss-security within 1-2 weeks.

Thanks for your comments/explanations, it certainly helps to have more
perspective.


Vegard
