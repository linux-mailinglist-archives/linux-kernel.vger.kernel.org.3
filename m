Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F572543CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiFHTZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFHTZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:25:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A79C19C30
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:25:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258Hd5CB030000;
        Wed, 8 Jun 2022 19:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2021-07-09;
 bh=cU8JROpwmCyKXL928TumwG84ir9Pnth+j1uJVGaPmf4=;
 b=fIJ0x/efswzIOFjcIxJzFzmCJgAm8Ltfz0JdEy+CdrAXBKpWYK4zAVDryj6GvDYP3W28
 bsRsDjLIoSart2hfIY6HlST6SSOT2P5Xoyj9x5JKz6Boy4EZOt1taMMyXO3nvNYiRBC0
 /D6+lC3tkH9cdksEbQDmGibHQFKtnpPgakfvb2P2HRX0tiJSubSi+97FURqROu5KOOC6
 OiMOW/sRawjGhqt5zeTykCiiaoQOuFrSjbpJvCfROqXygpQ5m79JchJJPOK2mF6uJKul
 9EhzPkx7SJ0ntkZ1otic5uusK5KQc1GxJjQFcFj3tWdM3J4W9bwQ9q2877THexwipplh pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghvs3cr2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 19:24:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 258JFrjh003242;
        Wed, 8 Jun 2022 19:24:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu9x36w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 19:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJtEN64whbyQ6gytOVreBt5Bsnrj+DfYAd3UCH3Y5XTbfTIHpj+oC0GMaLDIMMf2ImFOpNNm5EQbf/MA4bnKXe/MxYTYPyk7degz9qE3bghNWu2MUdW5dd75HFOubeqFOSWNFy9XalJYlbqO4pxjYlY45ZpLH+z1f+wGjOlqdFgKOFKmLkKFymJxo4KpSXspqJp/h9PJQfvk17QunLAWImvSAl4WBFEJYm+Pn0xFz5/o1GC8RZU/FZgrfFbr5TdVvwd7pcBfSANEyZuGGVvLJiVxlOM8KmkOeYhNV9QmGHeUSzfMzbpArBQF5Gbp/2ihweagF5E/TxtgWQsZzKEgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU8JROpwmCyKXL928TumwG84ir9Pnth+j1uJVGaPmf4=;
 b=eIiEeDKYg3JLB6GB0hVd/9g0AI7Bz/HWd1kPZ1s8fBifry0ymxFwwrhHPNm41biex/IlKPs7+a/SIKMd8yM4RSy6IKP5N04sb9c/VzzOo9xLwK1GknL2y6fhru6CcIL/NSYHcj9UY14K1qi0yKR+ZcarJpwe4QL1jwrzlKEogP0W5BkWDJKW9SltzV1Esm86JSOjSL608jHgHOL6meKV2sTvX4noJNZL/YuaUcu7neOl3jAMMDRzR0vNf3HjJAH1XIfATOhG6CwDwGD26FFMa5b6rS0itB0mNatiPMl0HjJzlr8WZfvVWhh2O+/KilSNjeJMf26gAOPcm7oE2N72rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU8JROpwmCyKXL928TumwG84ir9Pnth+j1uJVGaPmf4=;
 b=FOYwirSKy8xKzgo1s6BNSqfVHdipjf8PU01VaKBtYvJR6e3lHx9uMTWE7OPKbd31Cdkpcm2CbjqD1h6FRXs/VkgT8nJlSX6ebxa60MsRXGzb/0OlWSk1PWsCXfRq1cjAM/4Sz2jV5c/HqYHi1cx3rfkNAoNteZb4JII5GVvFEd4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB5035.namprd10.prod.outlook.com (2603:10b6:610:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 8 Jun
 2022 19:24:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::f501:65f7:2895:5c35]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::f501:65f7:2895:5c35%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 19:24:30 +0000
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com>
 <87k09s1pgo.fsf@oracle.com>
 <CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@nvidia.com>, jon.grimm@amd.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v3 00/21] huge page clearing optimizations
In-reply-to: <CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com>
Message-ID: <877d5rt0uz.fsf@oracle.com>
Date:   Thu, 09 Jun 2022 00:54:20 +0530
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86de3920-540f-4f89-0048-08da49848226
X-MS-TrafficTypeDiagnostic: CH0PR10MB5035:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB503530D0317D36AD72AF858ECEA49@CH0PR10MB5035.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1Znz6Jt0N3OvYB0HTj1K4cVtYqXMD/LGV+QZOT6feqYDKdG1kVkma7grriMHDrfgff6Ifgp6ydy5OyUid2MChEnytp5n54zZcygF89eakSW6yZjPVqRw/UwLeMYs5v+7uU85rlZDJNMWz3pSGRtqAs6oZ1KLUMQ418h0vuEyoQ4d4GA10G2IZ9SmlkS8mhvDUZnzdi0tkMqm0N4r1+LYST8QyJ42PhPO8VJpmjYukUvoo0Nm8tqZ2L//W7F6LhV7ikaxwoiox/w35ofmFfWnHwgMBUcKEJxOcRshaXX8lT5af1qB7RD09W5s9zPvftMFktDUuO6Fp/chFn7uiZwCgYciXREa/cmnAjEt//KRs15ElrtRuo2ss3Zu+64Z/PX6z08jZswN5uoAj7m0xVq3jALMnSaNrs/mLvq8wipInCWMoeuOb91oQoQDg39AK35dt8tlI3YfJvzJuGzUuHv62NHHqEmTafLOrmgxjMT3cLnKXqbYsYNLJ7y4oi8twSaGpss67CUrVqJAYyMcLRgLyLRhuJzswEw6meCDSZ2IVYdqz5iLxl3EXLztNbaweWPP6fXgUOIfpBsuIyvSrGadGzkCGZVP+3tdgL+YUo6B8ah2IKpfeklNf3m/qWQ9AiNMX7Mttt4Kpq0cuKQ8pUbF+kspkZ6GkASlgwSLuDoNTuyAAotBLxNU0BmUmk96EykukgnSMTV157X8mXBINugMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6512007)(508600001)(6486002)(316002)(2906002)(86362001)(6916009)(54906003)(6666004)(6506007)(52116002)(53546011)(38100700002)(107886003)(186003)(2616005)(36756003)(8936002)(4326008)(66946007)(66476007)(66556008)(5660300002)(8676002)(7416002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hpTnJeGWhU7ek0lJGUfR/I+24Ho314t1R0XX1rCevecsZkO64lys/vreYig+?=
 =?us-ascii?Q?j4hhgcSVJ2KaWXotgV/td6Kdby7UlX+plJi1Qcz61XkTVVPDwB6h3+/aPjJs?=
 =?us-ascii?Q?0f8WyVNTWuYdzbcnSerUdSYXW3t9khhpDkMnDBjFoSFQlQxeJztMf/2kUWyQ?=
 =?us-ascii?Q?b91PqanQJTgeB2Jwp6XQ5eZYjSWLcqAqP45tC4LeMXSkb64iO6KPXoKthwUg?=
 =?us-ascii?Q?hRNxoNIK+oG+FSgj94fAL6lDeDBj93cgltXINeWGLqllmfsPui5jtgC9TxUP?=
 =?us-ascii?Q?Cv3Cr7VKMn8fIGnbdxhu57pWggZ5eXzJgvIi5MG8szwYsqN1/qnMhxThkC7L?=
 =?us-ascii?Q?IubPYhYBmqH5FT1b5w8ViY0rB6rCGBm5CxQHNQShWGtHneZBekCfQGcI2+Gb?=
 =?us-ascii?Q?4h1ak5gE0BEhBucsUy70ccmfD15CDaSk59GRrg0eYSEPLdQ7xpFVAvvPj1hX?=
 =?us-ascii?Q?6k+A82CkEFv1bAVCq4X4d6193LmmXxg5h4dN61VqThogmuYBAUUKwU6shloa?=
 =?us-ascii?Q?hHogiwY1MTe7YDQJ5iRFd9tyRuYL4igVFJj4lYts882tYJRvfw/niCb/4jPj?=
 =?us-ascii?Q?OQRTJLG6bvVzNEQ4vZ5O2B0FNg+Tv4Xqz1mHO7i9uzJr0H/oa30A156HFULp?=
 =?us-ascii?Q?yPE3Mu6CB1GIYQmpDP7pF89wH6JtufIDJsF8+J+OxoLWriF61+N12TyELsr3?=
 =?us-ascii?Q?zrvbP2xd5PdfurOi3WZ01cxgQ6ze5l78vvkLq4mVPGcIV8SN90QyoN7fFxA0?=
 =?us-ascii?Q?nBOluVBsk0cbcUVZHXOP/r0sVQ+OZ0qfio/RyeGtEN94fxaNNGZzGx3w8V3Q?=
 =?us-ascii?Q?afkF+3Ojykpyd0etSWAt7Weogj/qjMzfH5FOWBr83759izRbLATE3LV9gawN?=
 =?us-ascii?Q?5sfIx5TdQ9YO5YfDOEQvRnjKiVOcRtpMZ5EVZ56qWPmjdBWst6FSfjlmiPuZ?=
 =?us-ascii?Q?kFXlGjvqs4+018n8xktEnwHcIHyZboAeov15s4tgsiSLYONaM5AfNUHhrg4v?=
 =?us-ascii?Q?R9gf1mjxwKItiQrGabCu0cck1icnfXz4cbPFnjuFKsBo2wSUySS71F68/yjv?=
 =?us-ascii?Q?jWhnYMBiuDKQGK2LYFvTyivqR62U7ZDDUOFinw60AaL337GCc9ETJnwoGMwo?=
 =?us-ascii?Q?EB9vMngQy+5edIpaPPg8iHpnmtRBJREaivUHe61+ImxCA8xycgcDemwQ7lSi?=
 =?us-ascii?Q?Dlj7NWFMP8zG4CTHzHEJsVVGePgZQg5UELhckgvxCTqf3/AIsKc6NWVnsl2o?=
 =?us-ascii?Q?EnLvqfVR7xOIDX15/b8gd16rtdNCzRHNUSQ3oRP902aBuPND1juMWPdxSscq?=
 =?us-ascii?Q?XEmeALWJCEHrdVRPX325ht4NwQVer+59DEXjZwiryeEq4biO2Plh2FV39F/p?=
 =?us-ascii?Q?4B6BETn+8PVNRX1eblNsHj5iKtdO2EDT7MSxwLozF6S7Bi5R7RkVx0zkHOov?=
 =?us-ascii?Q?0ZnyhZxMpPFCYzSg1+n5C4WYWnp9Tx0xSIwKHiXazJUEOxYuw901Ii7gZ+AP?=
 =?us-ascii?Q?u/R9IUIN2OHLXmSUK71cPLm0H8UYyjCmRfKIJ08Adka5DYPBzTg3b6Dz/6F5?=
 =?us-ascii?Q?ac8c9JftkpCrYELRhfk8Kl8oo5PpgCFsVXF47pF+cZ14FOY7Yrmk0ghZY8l6?=
 =?us-ascii?Q?jGgo5q/DJ9XHY0sjbLP+IeX1rxFmp3EMv9RUCBmqAwwNiteil9TGl4f+FitE?=
 =?us-ascii?Q?oqjnMJ85O6jSnLpr0sdjsJoi6thPzXamVXqweNUXntalGwCI9cZk8/63xzci?=
 =?us-ascii?Q?R/DIMK4oTjkf/itTpFTwPOqzbVwe/qTk9qjILY2P2EELQFzp3/YgPpPci4zH?=
X-MS-Exchange-AntiSpam-MessageData-1: zzLAhSogn1c8hvq8n/9VrFBTl8P9nTa5axY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86de3920-540f-4f89-0048-08da49848226
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 19:24:30.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9qrR4LlKbUG74Wb31V54B6Izi0sZA3KGlwn/8Lf6Vycj0RKvBnXx23vtkVSIn5glz/aQpJoupPH2QpVI3N0GK1QQEGbWp2Zm6PMQUnu8t8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5035
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-08_04:2022-06-07,2022-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=960
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080075
X-Proofpoint-ORIG-GUID: 96tE7tUN4NEc34Dng3Khr81ENRteUPFr
X-Proofpoint-GUID: 96tE7tUN4NEc34Dng3Khr81ENRteUPFr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jun 7, 2022 at 8:10 AM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> For highmem and page-at-a-time archs we would need to keep some
>> of the same optimizations (via the common clear/copy_user_highpages().)
>
> Yeah, I guess that we could keep the code for legacy use, just make
> the existing code be marked __weak so that it can be ignored for any
> further work.
>
> IOW, the first patch might be to just add that __weak to
> 'clear_huge_page()' and 'copy_user_huge_page()'.
>
> At that point, any architecture can just say "I will implement my own
> versions of these two".
>
> In fact, you can start with just one or the other, which is probably
> nicer to keep the patch series smaller (ie do the simpler
> "clear_huge_page()" first).

Agreed. Best way to iron out all the kinks too.

> I worry a bit about the insanity of the "gigantic" pages, and the
> mem_map_next() games it plays, but that code is from 2008 and I really
> doubt it makes any sense to keep around at least for x86. The source
> of that abomination is powerpc, and I do not think that whole issue
> with MAX_ORDER_NR_PAGES makes any difference on x86, at least.

Looking at it now, it seems to be caused by the wide range of
MAX_ZONEORDER values on powerpc? It made my head hurt so I didn't try
to figure it out in detail.

But, even on x86, AFAICT gigantic pages could straddle MAX_SECTION_BITS?
An arch specific clear_huge_page() code could, however handle 1GB pages
via some kind of static loop around (30 - MAX_SECTION_BITS).

I'm a little fuzzy on CONFIG_SPARSEMEM_EXTREME, and !SPARSEMEM_VMEMMAP
configs. But, I think we should be able to not look up pfn_to_page(),
page_to_pfn() at all or at least not in the inner loop.

> It most definitely makes no sense when there is no highmem issues, and
> all those 'struct page' games should just be deleted (or at least
> relegated entirely to that "legacy __weak function" case so that sane
> situations don't need to care).

Yeah, I'm hoping to do exactly that.

> For that same HIGHMEM reason it's probably a good idea to limit the
> new case just to x86-64, and leave 32-bit x86 behind.

Ack that.

>> Right. Or doing the whole contiguous area in one or a few chunks
>> chunks, and then touching the faulting cachelines towards the end.
>
> Yeah, just add a prefetch for the 'addr_hint' part at the end.
>
>> > Maybe an architecture could do even more radical things like "let's
>> > just 'rep stos' for the whole area, but set a special thread flag that
>> > causes the interrupt return to break it up on return to kernel space".
>> > IOW, the "latency fix" might not even be about chunking it up, it
>> > might look more like our exception handling thing.
>>
>> When I was thinking about this earlier, I had a vague inkling of
>> setting a thread flag and defer writes to the last few cachelines
>> for just before returning to user-space.
>> Can you elaborate a little about what you are describing above?
>
> So 'process_huge_page()' (and the gigantic page case) does three very
> different things:
>
>  (a) that page chunking for highmem accesses
>
>  (b) the page access _ordering_ for the cache hinting reasons
>
>  (c) the chunking for _latency_ reasons
>
> and I think all of them are basically "bad legacy" reasons, in that
>
>  (a) HIGHMEM doesn't exist on sane architectures that we care about these days
>
>  (b) the cache hinting ordering makes no sense if you do non-temporal
> accesses (and might then be replaced by a possible "prefetch" at the
> end)
>
>  (c) the latency reasons still *do* exist, but only with PREEMPT_NONE
>
> So what I was alluding to with those "more radical approaches" was
> that PREEMPT_NONE case: we would probably still want to chunk things
> up for latency reasons and do that "cond_resched()" in  between
> chunks.

Thanks for the detail. That helps.

> Now, there are alternatives here:
>
>  (a) only override that existing disgusting (but tested) function when
> both CONFIG_HIGHMEM and CONFIG_PREEMPT_NONE are false
>
>  (b) do something like this:
>
>     void clear_huge_page(struct page *page,
>         unsigned long addr_hint,
>         unsigned int pages_per_huge_page)
>     {
>         void *addr = page_address(page);
>     #ifdef CONFIG_PREEMPT_NONE
>         for (int i = 0; i < pages_per_huge_page; i++)
>             clear_page(addr, PAGE_SIZE);
>             cond_preempt();
>         }
>     #else
>         nontemporal_clear_big_area(addr, PAGE_SIZE*pages_per_huge_page);
>         prefetch(addr_hint);
>     #endif
>     }

We'll need a preemption point there for CONFIG_PREEMPT_VOLUNTARY
as well, right? Either way, as you said earlier could chunk
up in bigger units than a single page.
(In the numbers I had posted earlier, chunking in units of upto 1MB
gave ~25% higher clearing BW. Don't think the microcode setup costs
are that high, but don't have a good explanation why.)

>  or (c), do that "more radical approach", where you do something like this:
>
>     void clear_huge_page(struct page *page,
>         unsigned long addr_hint,
>         unsigned int pages_per_huge_page)
>     {
>         set_thread_flag(TIF_PREEMPT_ME);
>         nontemporal_clear_big_area(addr, PAGE_SIZE*pages_per_huge_page);
>         clear_thread_flag(TIF_PREEMPT_ME);
>         prefetch(addr_hint);
>     }
>
> and then you make the "return to kernel mode" check the TIF_PREEMPT_ME
> case and actually force preemption even on a non-preempt kernel.

I like this one. I'll try out (b) and (c) and see how the code shakes
out.

Just one minor point -- seems to me that the choice of nontemporal or
temporal might have to be based on a hint to clear_huge_page().

Basically the nontemporal path is only faster for
(pages_per_huge_page * PAGE_SIZE > LLC-size).

So in the page-fault path it might make sense to use the temporal
path (except for gigantic pages.) In the prefault path, nontemporal
might be better.

Thanks

--
ankur
