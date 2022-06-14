Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43F554B719
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbiFNQ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351782AbiFNQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:57:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD422DF4;
        Tue, 14 Jun 2022 09:57:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EEm9fx011632;
        Tue, 14 Jun 2022 16:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=/xGXrp3RkyfWf4hkiJe93T70BYdSKeLUi3Nh2eQEZOY=;
 b=tKz7c7KLOIaU+L8I5MgoLDf6ipjwIJ06O3ll5bFn3WYbJZ+cL94s27cm7gQ9Mnc6cUfz
 /CPzVxc016Cj/b/TVkQrl2hOH0bkTVpgrThQac9XD7d58Kp8GtMRheh5PvlEnp4QpNGU
 kbopkBxPVXUtdxrgY3wPA6Fimb4RS2ZSXzMmTKW6YkNn3+C2iqzy5y3wQ8m7T8InjKNv
 ZFK0hqMZ47CgfmldCf4embhaXCYXKv3ek8KTM9dTudfe1TPxq/gLBR3rDwIiJQjwJCy3
 40okJ9kLp29hikLswxAkjwxmX7ZSUETWzUIgR8l5OwajWh3B1vSQoxQIL/PrlkyKSOj9 sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0ee00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 16:57:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25EGaKas018124;
        Tue, 14 Jun 2022 16:57:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gprbqu2we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 16:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtdwzw4FWjYdBMJsi1DiekCYkARTTXmlxhRLyfIUEpofkJxLPEVrToEE0+E1Vkx0uyI6+AJVm3IY5Nc0XY/aKtEvMSXwd9aE7EYkEDy4jNamDK8fA8hgdteq4jKkJYkOgO973E7FrILv7okzKiHovDR3TfoRYq/hF5CMrpB7P5tJiQFwJyQKAaQfM6MP8+Q2f6Vpjrm/f/JUaUfqvv+/FMnT/r+5NGAVNsStgVICdMDzzMreTNA2CPt3AovpanLjO19BaRQVoqtKLwXafS4LRpqQoTjUnzTIvnloQTAdNmIJlm1rDx1Aud4Z4m80xIg0HtZespAFuhCTaqp2Mjx+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xGXrp3RkyfWf4hkiJe93T70BYdSKeLUi3Nh2eQEZOY=;
 b=ExhXumk37F/wsXmglYuJCUqfB2xr+vpjU9B64spviPlyHZxBnUkHg6YoK+/xTe/ZardYZqPaKwGJ7t6L/TwKgAyURqrPLpP4A02jWaMwu/Wk8ZfHcVugdRrp6fALSGoeKsg4HbcatvdE/JrhXMZAVtEcdnUuo0Rf0x4XJ5MscAQk9X9vO9X8is/tgXXdSvVTvMXXaONYq0P+K9XVYgwUuT8WD5zkjUIfWZIY+4D2U1qXAfhovRG/oBRg08spbmQjhB/ThfRCSnWY19xyh/5nydj7F2N6qdkP76bRsVlkZPawZl5dv3eKbmDzIB3Ws7AYf6zsXK1yl7MArInafaWJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xGXrp3RkyfWf4hkiJe93T70BYdSKeLUi3Nh2eQEZOY=;
 b=ziQigdIwZNjvXWSB8fVQ1W1mcnJpNd0ETEiyXq5nmPM8wrzbxcX52cKY+RjzeNcmlN2E9M92wUhHi5aRh7kjENUjKUpYpHRISj+VyWBDYCj39+psAx5SFBLivjs6BdsfQAaBPH81p61lqfu4WYbJtmLSI4h5cIpdxPwgyMME1T4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 16:57:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 16:57:38 +0000
Date:   Tue, 14 Jun 2022 09:57:35 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Oscar Salvador <osalvador@suse.de>, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/6] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code
 readability
Message-ID: <Yqi9/4aUBBN8nOCG@monkey>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-7-songmuchun@bytedance.com>
 <Yqb2bA25HhLU/mpM@localhost.localdomain>
 <Yqb89waW/jcsgRgo@FVFYT0MHHV2J.usts.net>
 <YqfUxscKfUhT35jR@monkey>
 <YqgL0ZcU5dhhO5uL@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqgL0ZcU5dhhO5uL@FVFYT0MHHV2J.usts.net>
X-ClientProxiedBy: CO2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:100::24)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d19851ec-070e-469d-4119-08da4e26fcdf
X-MS-TrafficTypeDiagnostic: CO1PR10MB4786:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB47866E5B2B1D2AD7C717BE28E2AA9@CO1PR10MB4786.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiBcRN2ZHPnRc/YRiiO7aRmuuGM7IvTKX56pmoGirLK853O8Gih1MLWpzh0tGtce14aiJqqkaNk3ZcMlk1+GV3GkoW2oD+OVQwLeQn1qU7vcZElYs30q6cUfIABQAWvjPTmF5P3owdAPBxonPpK4MQzztz3/eaSwY3Ipbe9jslJ1f1zy+HRPwRs1AdSc74yRAtjR1fllal14rR+DF4J5kkrPf0vnn9TBo9cqFWT07Klmx4tUNI+/FNwnhkeVlkiXai0McJAWiXI2YPkue6PsaEFBz2ehiIy0QkfxatDTWF4ugIMeC9gEbj02PUeddev/msfKg3p9ZH0lO47TuKKEJjcxCyo4wPHGzlu9Il/fLMwV4m2l5yNm9Ocpvkjf/McOvJD/pK0GTpEBp8XqUj2bMGocp4C3gcUS3VpDf//m7AoVmukWGUbTtxyb0tCXvcpr72OSw14AGM4zTIs+m9JcIwdPeQ4fvjD2UzqoFXzpNqQ9ZIdXZm/odWYlEiYSHEp//3fTjDh8q9y77dfdFZkT2iwHkibcLOPE/csTsburMADGegeb5wcw8KuRVp3aqNqLHMiu+2rmXkMHeS1Aa1t7UMInzWVThhJgTra0mBrxkZ5gxnz1TtHzPq2toTNwfVb8jfQKkf26txiTb2OA1aagUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(508600001)(38100700002)(6506007)(44832011)(6512007)(9686003)(83380400001)(8936002)(26005)(5660300002)(6486002)(2906002)(8676002)(4326008)(6916009)(186003)(316002)(33716001)(66946007)(66556008)(6666004)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JCbEc3Y21KNnNjbWRjSW8wbHVPWGVSczNrRVQydmpVNUdqekM3ekhjem5L?=
 =?utf-8?B?b3o4aWlTUVl5ZmZZZ05JLzg1MUl4RlpObmlHSHNEUzUzdXJmT2ZYaUFnc0tk?=
 =?utf-8?B?aFY1SnRxeXdCZVFtVnhMbGZuWEJkS3Z5Mkw5OW4wN083bDZIdmFaL2lZQzNH?=
 =?utf-8?B?THBKNDVBWXlnY1A2WG13TEpLd3VQNlpZR0ZycjRZVHRkWE5NNHFjQ3hFS1gy?=
 =?utf-8?B?TEpjb25GSlhEVVZvYXJrcmRkdHYrelZDWFl1cnlLemJDOG1HWG9VeFNCaWlP?=
 =?utf-8?B?TWZaeVA0a1o4cjNIUHNLYy9sY056OVloNlJ6NStPcDc0akJ3TTB4M1lhUG04?=
 =?utf-8?B?Tk16ZnR4aHk3Q3p3L0RqSlhvTm12Q09WdHM4YXpZb1M1SUQ2ZHA5NkVSZ1Bh?=
 =?utf-8?B?ZzNvSmxYaVkrbk9oWkpQTEhTN2k5alVGa2lmUXZoVUhCOTNSYW1aR3BYUzdX?=
 =?utf-8?B?OWhuV3YzNHZ5TTErb0M3a1AyQWNYMzJvUWpmWE1QNzFsMXNSMld1R0t6Ri9T?=
 =?utf-8?B?bnFZYWRRSlpHK2xZNG5OeE9zZTRHVHQ4UG44bnUzREE4T01jWk51NWZHbDdp?=
 =?utf-8?B?NzUyc01BdXVERElSQVExZHNkK2ZOUzlJcW03YlZ1TkIzVVJ2WEl1R21rZjZv?=
 =?utf-8?B?eTliSFFjNlRyUXp3ZU13OUtWOGxrZklHZW45TWdZMkZvcFluUldESE9mMEhy?=
 =?utf-8?B?Z0NKbnU3cmhTdzl5US9LdXM4dGtzR1gvVytxVy84c0JVQWFITk82bGlGMFd4?=
 =?utf-8?B?cE9RRDJBV3RCejRHOWorN0tXTzVyMlRVeWMzYklCZGZVRk5lMFhDSGlHb2Zr?=
 =?utf-8?B?dkk5WlVobnpIM28rbmRTUDFxNWl3SE9Ib1plN004WkxIQUZpVys0dDFlejdm?=
 =?utf-8?B?eEZOOHY1ZktYN2kyWDh5Z0ZRa0poZ0Q4OWl3bi9YZDVTKzZTdkFOeVYwS0U1?=
 =?utf-8?B?TzZWWVQ1eVlWV0VVMzF0SEJXbFUveFlRazViem5TbUdZM1gxdldaRE8waGND?=
 =?utf-8?B?VnBtbEExb0h6ajAyRTU1RGp5OUl1c242MWQwQnk5am82QVRzL09sTFNWZ0R2?=
 =?utf-8?B?YzZBWk1CQnFsa1BFK2FxakdZWkt5algrUjQvS1huUU1JNEhFSWJwSzM0V0lo?=
 =?utf-8?B?SDZiUlhESHN0a1h6OWVFU2pvUlpzYiszaEFPenUvK3BGdUs1d21Vb0QyeWo5?=
 =?utf-8?B?Ni8zZVNNV0h3ckdrbC9YT1lGbEhBS3M3Y0UvY3FISEJyZSsyZlE2Yk1ITWNr?=
 =?utf-8?B?WFJRbjYvUjdkWklEYS9pNmZkWWcrMytwNE1xYW5nOGFvcmJoR3RpWWxDNDdM?=
 =?utf-8?B?N3BLaVhOTVBYZkppMTVveENjT1ZuNndDZ002SlFSdzhCVWFvWnVpV1hqWG9l?=
 =?utf-8?B?VEpYL3ZXOWd2R0NuR3podSsvMzRod3FIWXl6dnVVaXpqOTdlZzhMNEJjWjVU?=
 =?utf-8?B?YjJwWktnT2N1YzkwTk4zbUhNOWhDYVErNVYzU0luZEVrZHRNL094T0Fqa1hJ?=
 =?utf-8?B?TDJVL0ZQY2ZuVGlkaEU3d01sLzZveUpqVVhPWXVRM2FHazM3bi9VRS9MMzg1?=
 =?utf-8?B?NkRoVkpScXRZYnduT1d0Uzdra0xQUWFUS0tvNFdQSGEyeVZnWEMva0YxSU5L?=
 =?utf-8?B?SkhVeTZBaWwxeGVlL2hPR2YveEI3d3pxS1Z6aXg3ZW44bnV2S1RWUy93amR1?=
 =?utf-8?B?V0F6Mzl1UmRoUnpsZ0F3am5tMkYyNUJQMHdKSzJ4T1NvVGxZL2FrNythQlFl?=
 =?utf-8?B?RTFiYUEyUndUR0lETTlra1EwNkFkSisySGhFa2ZVL0lHQTNVaFlwbXQ3V2pY?=
 =?utf-8?B?dkVxc0xJSjladmk1WUhsKytXS3dtSk1IS2pFaEc0UXR2Mzh5b1QrcFUwbElr?=
 =?utf-8?B?N1V5VUpJVmdsTFZHZldzY2FBUnlIb2VTdThLMFlTSXlFcmg5Qjc3RmJtcHYw?=
 =?utf-8?B?ayt5Z3c2RzhIUEpxK3B6c2lnVWRTYm05eHRPTlVGeDhqTmk1SW0xWGE0VGN3?=
 =?utf-8?B?N0d6WURmR0U4TkRHc1plYkZwQWxLSFpwR1d6L2NHODhXTzFWNE5TSFlndzVZ?=
 =?utf-8?B?cUFWYjBaWTBPN1ZKZ3hDY2F0aUs0a0d0SFRyTmhpdVZ5VmEvL0VLQmpOcTZM?=
 =?utf-8?B?OE5ZN1h2NTJVOUhKTGlIM1d4MWlOUzlRMmZaQjl2aXdFTEJoYlR5a1E0cTV3?=
 =?utf-8?B?bkFmOXZ3OGtiRWI0YTkwL1JOK1lxTGpmdE16ZE9Yb0hjTlhMM1RIVHRXYmdj?=
 =?utf-8?B?bGMxR0pnL1RwaVlnbW9mamVwdE0rMUtmRVRYTlZ1UWo5TXZPb3JtNXRhWWFL?=
 =?utf-8?B?aHNkT2J4WUFuaUtrQkk3SHRNWUJkSHdNRS83MWpQVVlmeklCVVluWUcreUZR?=
 =?utf-8?Q?pMBGcZyrAVa5Cbrw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19851ec-070e-469d-4119-08da4e26fcdf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 16:57:38.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjasKe3T8zD3Y3mOgFOgCSvOcKt9bhx2KTlrL9Y04hOIM5xYCB8LkY+q4gumMNvcVlqX7pj2L5tmoUeIpI6Ftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_06:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140063
X-Proofpoint-GUID: KeTgtIty6lplrN_txufeXa0PyaXPpGon
X-Proofpoint-ORIG-GUID: KeTgtIty6lplrN_txufeXa0PyaXPpGon
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:17:21PM +0800”, Muchun Song wrote:
> On Mon, Jun 13, 2022 at 05:22:30PM -0700, Mike Kravetz wrote:
> > On Mon, Jun 13, 2022 at 05:01:43PM +0800”, Muchun Song wrote:
> > > On Mon, Jun 13, 2022 at 10:33:48AM +0200, Oscar Salvador wrote:
> > > > On Mon, Jun 13, 2022 at 02:35:12PM +0800, Muchun Song wrote:
>  
> > BEFORE
> > ------
> > [    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc1-next-20220610+ root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepages=512
> > ...
> > [    0.330930] HugeTLB: can optimize 4095 vmemmap pages for hugepages-1048576kB
> > [    0.350450] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
> > [    0.359282] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> > [    0.359285] HugeTLB registered 2.00 MiB page size, pre-allocated 512 pages
> > 
> > AFTER
> > -----
> > [    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc1-next-20220610+ root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepages=512
> > ...
> > [    0.409068] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> > [    0.409071] HugeTLB registered 2.00 MiB page size, pre-allocated 512 pages
> > [    1.246107] HugeTLB: 16380 KiB vmemmap can be optimized for a 1.00 GiB page
> > [    1.246110] HugeTLB: 28 KiB vmemmap can be optimized for a 2.00 MiB page
> > [    1.246123] HugeTLB: 512 huge pages whose vmemmap are optimized at boot
> > 
> > When I read those messages, I am not sure if 'optimized' is the best
> > word to use.  I know that using alloc/free throughout the code was
> > confusing.  But, wouldn't it perhaps be more clear to the end user if
> > the messages read?
> 
> Well, I agree with you at least. "free" may be more friendly to the end
> users.  I'll change the word "optimized" to "freed".
> 
> > 
> > HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> > 
> > Also, how about having report_hugepages() call a routine that prints the
> > vmemmmap savings.  Then output could then look something like:
> > 
> > HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> > 	 16380 KiB vmemmap can be freed for a 1.00 GiB page
> > HugeTLB: registered 2.00 MiB page size, pre-allocated 512 pages
> > 	 28 KiB vmemmap can be free for a 2.00 MiB page
> >
> 
> Well, we eliminate the prefix "HugeTLB:" for memory saving log.
> Maybe it is not a good choice since it it not easy to grep the log
> (e.g. dmesg | grep "HugeTLB" will not show saving log).  If

Agree, we should not drop the HugeTLB prefix from the message.

> we combine both 2-line log into one line, the log becomes a bit long.
> So I'd like to not eliminate the prefix but gather this 2-line log
> into one place. I mean "HugeTLB: registered 1.00 GiB page size,
> pre-allocated 0 pages" is just followed by "HugeTLB: 28 KiB vmemmap
> can be freed for a 2.00 MiB page" without any log insertion in
> between. But I have no strong opinion do this, I'd likt to listen
> to your opinion before making decision to do those changes.

I think we are talking about the same thing.  Did you make a mistake when
saying amount of vmemmap freed for 2MB page followed 1GB hstate size?

My thought was that it would be good to log the vmemmap savings near the
message that notes the hstate/huge page size and any precallocation.
Just my opinion.  So messages would look like:

HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 512 pages
HugeTLB: 28 KiB vmemmap can be free for a 2.00 MiB page

I really do not have strong opinions on this.  However, if we are going
to change the messages we should try to make them as useful and clear as
possible.
-- 
Mike Kravetz
