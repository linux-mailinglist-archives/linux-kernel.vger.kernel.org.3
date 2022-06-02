Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8453BBA8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiFBPgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiFBPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:36:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD5248538;
        Thu,  2 Jun 2022 08:36:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252FHebR017216;
        Thu, 2 Jun 2022 15:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2C0liBoHnuuSbCsUXWTprdZcSLdqkV2yoTA+KTZUwkg=;
 b=wCj6UPMVQJKF9rZYRUx6m68XdKTaLXB7yzuGPOahCOMUIFFUKgNpFciR/VH1EASDlYZP
 ajaa0ssnJVu7cGFj6Pnv/vB1g+sDP39hV7UwewtgeFKZIcgZEuJ36S+gOvwqvS4t2035
 nnk4ViHQMZMeH/JITJzOkZUPUjiLhk75FjTDGWxKw0dJsyG1pD8CHPeo4Bt6GlhyFcOk
 Ji/2+nYCwJ9mf0zCF8qjQl+8fwsC9fx8Oa7JVDtBHQc4LDdBdWnUZoStFgnmDBni5pUR
 D6otPzWm2IBUFVb00neidqR1GXiUjLJxDjoqQn50EKC6QvCpirLdW5uoH8XChtxfPblq vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc6xare4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 15:35:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 252FAC3I038493;
        Thu, 2 Jun 2022 15:35:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p502xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 15:35:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbf5NSZkGmBkSHM3MuYljCwXudj1L8I12OX9bYw+6rirX3v/VIsgfVOOzaiQudgI/UUj1RyM9li3TaKjIQODdhZecsG1qOyxWZ7oVkWzii+xSV1lW62x9zq3IYsZmzHnHm6DfGNJE88fHgZGjemZU1kqEGiwccwMEa71s0KOIGhs9AmX9a5Ub/dCZg/OFjyYkJhQQIjG0cNP9iGE+MpzYJEcgqO9wt9gRLUexPRun6vSD3KG/s/DeZkUeMGNNSxtAx9xNXtMM/03JNtDBaO4jzmzXIprzSUAiawsrhU03pzWXWAxOzhUIs89ROVUcd4C+hmA8dgBxKt5NerBByhZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C0liBoHnuuSbCsUXWTprdZcSLdqkV2yoTA+KTZUwkg=;
 b=WFU75gQ+hLZVK2QDvkFXab9LM5gjeDcYhCYQ8Z2HZLIgPYlFZ9cd74iYe6M8jqHXhTUIB0RTSED3Kb6zatWjZhdj0M4W25adbJHwht+MSpETynf32FCppSUnfK/lE6x84XXO6SK2PkfWy78XkeSE07soUCNeqxobVINGrlZWU/atxcLSGThCf5Ycya4fLfM5+vno46hQwAVG9XjCC60vK/HZTjxU2oZIt+e4BrmeF+n68hwIdcM1WUDH41SsTA29uceiTt7DGHrFWIZ1kWS/B6sDtgrMjWDi5uo9jKBW5cc2H6+v3rW8/9js5mXm54FLfNjM8tYkvSbzLFqTlW12VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C0liBoHnuuSbCsUXWTprdZcSLdqkV2yoTA+KTZUwkg=;
 b=FQKd4vKQJsEm8rd0GxcQGQIyy8MtpCXCplIDOLmuHdczGNr3W+VYqd+bMEPvDSO+Yb/kCWY6I5iCZhNk17CLgh9urBpbHmGSIcqyROMCvIvxEUeg9ZYRWf6SSTz5fkeTRWQFCkEq6GswwGHdSr24y8qYC63hQQQUkQf5r2Gf9pI=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CY4PR10MB1799.namprd10.prod.outlook.com (2603:10b6:903:120::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Thu, 2 Jun
 2022 15:34:57 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47:2730:1cb1:bd51%6]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 15:34:57 +0000
Message-ID: <42200c3e-fb39-ddab-3d68-5dfb5eb89451@oracle.com>
Date:   Thu, 2 Jun 2022 17:34:48 +0200
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
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20220601031254.GB26318@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0108.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::24) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4c92d9-b2b6-472e-bb8f-08da44ad72d4
X-MS-TrafficTypeDiagnostic: CY4PR10MB1799:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1799C8E91A27C16320E8A31697DE9@CY4PR10MB1799.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06cZ4McSDuNNHzwEQC+9qZ/EY3wKwzxTAUJn2U/w412oehAdmU8yOHp/iSEvt683hD1MODTrKmTCTlaEDqwjYzpju25q9vFmr0bDjAtViVis/O7BZnaJbghbSAM7AS5pMf/jKlg0nwS5t5s7H+cG0Hu9M1CjYL64XL4eWBQM0eFKHIxXwVFuxmCXY7xNDGKBeis1KDPkHQVVT61ux7jNcz/BMnBXmuuv1Bz/K9Q28kHYObbCTOAdzFVFH9a3FcFzKzAoEgT1aqLXdPmW+hVng2+aCd8DnzIs0wfJdA5xQgJRxtNr/V3pX1lRQvXc0ba1WAukF6X2XOQhUtgU4iTd8RA+/27oumsIjQPfN38D3CBef0kOUHBteNSm6ilhkmjnypQENnUiDNA6smxWDS1qtvhszfjuvAZ0774L4wM6Wlt6/uQ/Q7/MjbNxNLX0/7qsNzN9CUNOYY8VYNyJmM6DnWo87n0JT/SPTgrxyezg+NtSwY/rZFBCAQD3Hqq6/6Ncu50Q8Ig/t3zISZQbfD8uQXyxCvhBPHV/hPcgRfGooGRO95+VwgGNo4j4c9CVj1g2Duu0e2UEN1+m7nbkechvt4RqfLNH5p1/Wz37ggjWh41WWFEAUbHscza3D6TzXJjEg1s/BnlVn0Ia4tXjSyc/WNj9w1Szod2MPBzMScTp94+bFm5XFjTrxThECKe6xMeYuf/eTfTrHlV9wI+/ejRNuopnpAZOQHTc5euOo8DH6ji3QqftwDZbmbX0Oed8OHvCqr+iL9oUT3FebEpL1AUkCAA4xj+9LOA2xpygbsCaEusPGywKYJvOFM0VgZhjxBlrIJvj0OOSRCJv1LxfZlKWwm9E6Q1K0XQMfwSKK7n86fneFJEtQzm8VlUGnH45+VtG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(2906002)(38100700002)(2616005)(31686004)(44832011)(5660300002)(6916009)(186003)(26005)(6512007)(36756003)(38350700002)(54906003)(316002)(6506007)(86362001)(31696002)(52116002)(66946007)(66556008)(66476007)(4326008)(8676002)(6666004)(8936002)(83380400001)(15650500001)(966005)(7416002)(508600001)(6486002)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clB0MEhkK211blcyZGRYRVl6ZThqYWlnV3duREYrNHhmcW1HalAremVlREx3?=
 =?utf-8?B?NmkzdDB5dnVYNkpxTnZkWjhXa1ZuMnBRSzE2R1E0ZE9oK2VEVThibkhSSU9F?=
 =?utf-8?B?Sk9zeFZNZ1NtWEhFenQ3UFZWbWVwd2daYm9PRDdtNDB3TjNvZG84TjNmaWJr?=
 =?utf-8?B?V0lsUTBVcGdYYmp4dFVFY1I0cXdhS2oyUkx3bnYxSy9wMHFCcFFxSGdGK09M?=
 =?utf-8?B?SXhUTGtHajVUSlArQy93L2dZZFFUVldNUVN5bWxZWXZjK2ZTZFNpNC9yRHNv?=
 =?utf-8?B?Ri92dys2bytGSzY4SEFJTjI0dXVNdWhtWE1PNGlLRXpZMHYxUUVTNVlzVWto?=
 =?utf-8?B?MTZkblFCejY5aE5PUkFtT3FlSURPTjRiVERtWTMxMVowTGUwaW51bXE5aFhq?=
 =?utf-8?B?bTRscDJLWUp5cndVTWZJWTFFVHZIVlRscXVhZFp2QkpDOEZIS3J6Y3pPUzM3?=
 =?utf-8?B?V3NMd054dWx3UmtvK2FpdjdTU3hCeVZvMDdVZmlSMllEKzI5dzVGWlpoaFVE?=
 =?utf-8?B?NHhacHlieHhFNHFOaGVGc1IvdVArTE9GcFlnbHZ3YTFaeVNTZU9YbnlWVHlj?=
 =?utf-8?B?K2tOY1QxdnFwZkZicCs5QmtTOHhsTmd4WEwxTjNJNWZGcTZsT25jV2d4cFBC?=
 =?utf-8?B?MEdKTjNiQWlNV2VxcnlTQkZYM1FWQUNTN3FoQWxXUHRrNzFnc0JadlpQdUpv?=
 =?utf-8?B?Q2w1R3JNOEFWVWw2R01MY01FSGx4VWxUZDI1Mk11UTVjVmVlTUNQK1RWUVNY?=
 =?utf-8?B?RVJzbklLRkZjUnM2MExIa0FiWXBBMUFmRGVpQ0VobGpWdmlMM2VPTkdacWJl?=
 =?utf-8?B?QWtBdjNDN09hKzBzaTgwKzlNTjk0cWVaL3NGSnZtbHRhV3hDRTc4OGl4dVBO?=
 =?utf-8?B?WStQb1ViOHpIVzZ2bXlHTjJXeEhKalQxbG5ZY2Y2dTVORTdiYnhldU5zNUUx?=
 =?utf-8?B?Q2d5SVY4WFo2elRxV1NremxDN1NsbkxyZFV1U0J0M0ZkbXhsd1FTWC9yTXp1?=
 =?utf-8?B?WDVOalBoYnNYamUrY2hjbDZDdE1TVkJObUdBdUp0RFhSRmxXaHYyU2pxc00w?=
 =?utf-8?B?a2RRQnFLTmRJZDBQQlNnaHJOYVBGUlNLVW9rRFJXRWtsU3l2UGlqNytkRmlj?=
 =?utf-8?B?cXlwQWRyVkM4ZFBGaTBMT0c1bS9NenpONG0wTENQbmFZTWN2ZDVzb3d5MGJn?=
 =?utf-8?B?Mk1CNGpaeEk4UnZiKy9CSGVhd3NkRnIycnpZVFVtUFRtVk5BZnFrLzNwcVRt?=
 =?utf-8?B?dk5KZkR5ZXMxL1dGTEdTanlneUJiTzdOeWNncjd0WXZta29ReER2K1pUcUFF?=
 =?utf-8?B?OVZBOWxWb2x0d0FwbnFsUFpoeXVueWtPQWZCZk1VTERKSEp0R3BEYWNldUhq?=
 =?utf-8?B?TlhWNmIvc05NS3FLK3hVQm11eW40Y0JmNUlkd0EzWEV2L1ByTzA4MHFTU0Rv?=
 =?utf-8?B?elpoMWlYV2dhWkE1dVZQdG90ZFpGZkRHY3dDQmkxL01jakVoSjYzTDBlbko1?=
 =?utf-8?B?aWxJYmQ4LzFYZ2FjQThpRkNXZjlkdWlNRi9pQmYrOE5aVm1wdFM2b3hwMGJi?=
 =?utf-8?B?NDY5RnROZHZsbldXUzQ3SC9aT2ozNTFxUUlQdXZtTmRBQVJtYjlQdngzdjI3?=
 =?utf-8?B?KzhBV2Radnd5eU55VUptV01uQXZNcDNyamZRUXZZZEhIcnpzMHc0aFh4cWNj?=
 =?utf-8?B?NURwU2NaRTA3ZHFhUUQyUk5lU3hGaG1sWlYyR3dxWk1xSTkwbE93U0ZaZWpH?=
 =?utf-8?B?SUxLam10OCtvWkUwd0tmcitlcExnL3h4R3FZUGRKTjllS09iVjAyckhyNW9F?=
 =?utf-8?B?S0tobmEySXowdHB3NU9DdkZZR2tnOEhwMnBtbkxkOFVTN1Jnc2tiM2pOanBi?=
 =?utf-8?B?YUxpZjVLMGdEaVByNlk3U20vM014aEVVK2tTRTg5REVmUStjY1dZNUFBZG5k?=
 =?utf-8?B?dzFwYitOT2YwZURCcVRib1NjdlNBRE1vc0t0RmZnVU5MOC9sR0FCY0YrQkVM?=
 =?utf-8?B?Tm0zRkVOZ0RUaGdmeXM5Z0dYeUFqajVTWllrSVQ1Nkdia0RBSXBtVTRhVTdl?=
 =?utf-8?B?M1VwTWw0eXByVmlhbm1RQ0ozY0plWTU3MGVhUCtNZW5UVk1YKzJ4dUFYYlFZ?=
 =?utf-8?B?MURyWkhvSGRjZ2pCSy8vOFczWkJLWXQvSkthWW9uUzFlditId3ArR1R2RktF?=
 =?utf-8?B?bHlua3JCazNuR2ptelEyZktmcmxtcVJwQThvcVUyU1lWWXZ5YUxOQ01STFE5?=
 =?utf-8?B?NUY2blJTTlE5c0RWZ3BtTFlZaG1BZzFxYUE3YnA5T0djdnRKSDNpc1hLdEll?=
 =?utf-8?B?NDhLd0NjOVRWYzJrZ25oQ2JNSGpIVjhqb2hDVUhMNlQrL1BiZ1hXNWVRSVJQ?=
 =?utf-8?Q?ILRWR0WfluwX1jas=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4c92d9-b2b6-472e-bb8f-08da44ad72d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 15:34:57.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtSyKvF5bBgRQyix/AtCrKLJFdk3nFbyg5aMMOHz6cUG0UJNSG06vepJ0Z4uAiKXQJI8PTu7nuvRXaRevtUMbSzNQrA/7SfFmkABInVP7WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1799
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_04:2022-06-02,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020065
X-Proofpoint-GUID: pNl25d-t7nKoDv8OVW4j_caMa1ZtIGPS
X-Proofpoint-ORIG-GUID: pNl25d-t7nKoDv8OVW4j_caMa1ZtIGPS
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/22 05:12, Willy Tarreau wrote:
> On Wed, Jun 01, 2022 at 01:03:09AM +0200, Vegard Nossum wrote:
>> The current instructions for reporting security vulnerabilities in the
>> kernel are not clear enough, in particular the process of disclosure
>> and requesting CVEs, and what the roles of the different lists are and
>> how exactly to report to each of them.
>>
>> Let's give this document an overhaul. Goals are stated as a comment at
>> the top of the document itself (these will not appear in the rendered
>> document).
> 
> Thanks for working on this, I'm having a few comments below.

Thanks for the comments, I'll send an updated v2 shortly, just wanted to
address individual comments.

>> +Linux kernel security team at security@kernel.org, henceforth "the
>> +security list". This is a closed list of trusted developers who will
>> +help verify the bug report and develop a patch.
> 
> + "in case none was already proposed".

Done.

> There's indeed recently a tendency on the list to get a lot of first-time
> reports from individuals showing that some work was done trying to make
> some code parts fail, but no effort was made to try to figure how these
> ought to be addressed, and that costs a lot of time, because once the
> analysis was done, the person who knows best about the problem and how
> to fix it is the reporter, and we must absolutely encourage that the
> work is finished and a candidate patch is proposed. Usually, returning
> reporters propose patches, so I think they understand the value in doing
> the work properly, which makes me think that we just don't make that
> obvious enough from the rules. It's also possible that many reporters
> are not used to working with OSS projects and imagine it's inappropriate
> of them to propose a fix. But the question that's the most commonly
> asked on the list is "do you have a patch for this?".
> 
> Overall it seems that reporters are willing to do their best but that
> it's never easy to engage in such a bug disclosure process which may
> involve short times, and that it can be stressful for the reporters
> who forget to do a lot of the parts they would do for more regular
> bugs.

I think there's also an argument for encouraging reports whether the
person has a patch or not, presumably it is better to know about an
issue so it can be prioritized against all other known issues, no?

In any case, I have amended the text like this:

+Reporters are encouraged to propose patches, participate in the
+discussions of a fix, and test patches.

>> +While the security list is closed, the security team may bring in
>> +extra help from the relevant maintainers to understand and fix the
>> +security vulnerability.
>> +
>> +Note that the main interest of the kernel security list is in getting
>> +bugs fixed; CVE assignment, disclosure to distributions, and public
>> +disclosure happens on different lists with different people.
> 
> I think it's also important to explain that sometimes some patches may
> be merged ASAP to plug a hole and let them flow to stable branches,
> while letting the reporter deal with the full disclosure once they
> consider that enough time has elapsed. The recent "dirty pipe" fix was
> one of the best examples of a report that went smoothly and allowed the
> reporter to work on a nice description of the problem:
> 
>     https://dirtypipe.cm4all.com/
> 
> There's always this gray area between getting a fix merged and disclosing
> all the details of the bug. A bug indeed becomes public once the fix is
> merged, but that doesn't mean that all the details are shared, so the
> reporter still has the opportunity to write their story about it. The
> reporter must only understand that it's only a matter of time between
> the merge of a fix and the moment someone will understand how to exploit
> the bug and publish about it.

I've changed the bit above to address Jon's comments as well:

+Note that the main interest of the kernel security list is in getting
+bugs fixed and getting patches reviewed, tested, and merged; CVE
+assignment, disclosure to distributions, and public disclosure happen
+on different lists with different people, as described below.

We could maybe add something like this to the "Disclosure" section of
"Contacting the security list":

+Please note that although a fix is public, there may still be value
+in withholding the details of its security relevance and/or how to exploit
+it for another while; see below for when and how to properly disclose the
+security impact of your findings.

I'm not totally happy with the wording here, probably because I don't
really agree that patches should be published ahead of disclosure in the
first place. Anyway, happy to take other suggestions as long as we can
keep it short.

>> +Here is a quick overview of the various lists:
>> +
>> +.. list-table::
[snip]
> While this part renders well on your HTML version, I'm afraid it's totally
> unreadable here in the text version, and this document is supposed to be
> the one reporters will use. I suggest to try again with an item list
> instead of a table.

Jon had a good way to do this that looks good in both text and HTML.

>> +**Disclosure.** The security list prefers to merge fixes into the
>> +appropriate public git repository as soon as they become available.
>> +However, you or an affected party may request that the patch be
>> +withheld for up to 7 calendar days from the availability of the patch,
>> +with an exceptional extension to 14 calendar days if it is agreed that
>> +the bug is critical enough to warrant more time. The only valid reason
>> +for deferring the publication of a fix is to accommodate the logistics
>> +of QA and large scale rollouts which require release coordination.
> 
> I'm still having an issue here. Originally it was something along "up
> to 5 days if there's a really compelling reason". Then it was extended
> to 7 days in order to better match the tuesday-to-thursday range. Then
> "up to 14 days" for exceptional cases (i.e. hopefully never). But the
> wording tends to make all reporters think that asking for 7 days is
> normal. We really need to make it even clearer that:
>   - the default is no embargo
> 
>   - if there is a *really compelling reason* (that has to be justified
>     by the reporter), it may reach *up to 7 days*
> 
>   - in exceptional cases (the bug-of-the-year with a risk of massive
>     exploitation requiring coordination) it may be extended to 14 days
> 
>   - "I already contacted this or that list so you must respect THEIR
>     embargo" is NOT a valid justification to withhold a fix
> 
>   - dealing with embargoes is a pain, a withheld patch risks to be
>     forgotten or confused with a previous version of the patch that
>     appeared in discussions, it's difficult to synchronize stable
>     and mainline, and the risk that it leaks by accident grows with
>     time and with the number of participants in a discussion.

I've changed this section to:

+**Disclosure.** The security list strongly prefers to have patches posted
+for review and testing on public mailing lists and and merged into the
+appropriate public git repository as soon as they become available.
+However, in exceptional cases, you or an affected party may request that
+the patch be withheld for some days; as a rule, the maximum is 7 days.
+Only in truly exceptional cases will the security list consider deferring
+the publication of a fix beyond this, and the only valid reason for doing
+so would be to accommodate the logistics of QA and large scale rollouts
+that require release coordination.

Note that I'm only trying to clarify the existing policy here -- I'm not
in a position to change it. There is no mention of 5 days in the current
document, which is why I've kept the wording of "the maximum is 7 days".
The justification for the current wording was given in commit
544b03da39e2d7b4961d3163976ed4bfb1fac509. If there's a consensus to
change it back to 5 days then I can incorporate that, or somebody can do
an incremental patch.

In any case, I would assume these are also things that can/should be
discussed on a per-bug basis as long as the overarching rules have been
given here. What do you think?

Thanks,


Vegard
