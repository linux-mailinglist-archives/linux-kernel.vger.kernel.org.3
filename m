Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1123543D7E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiFHUWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiFHUWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:22:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4438344A2F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:22:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258Hd8Fc020388;
        Wed, 8 Jun 2022 20:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=o/i58C22SyhyIDQ0Mcfqm72W+aEegDPV1F5bU8Xs4eg=;
 b=xCfbtyFB13ZI/4F62RXjkGSY0QHc62sdMC2M8mx8sHn++7s/oxLipDzBz9YSeng3rRLH
 vsIc3qzif96QZmlyKglO17XFmnOqjH4N3OT2vsei87r/50/ArlRhlbaibWHYenpdW/Z3
 +Yde6000sazybzHMpqmvgbSozD6DMiC0pJmgjY2Brqr2mbNup8BOmW/+42uHJnmofp6Z
 w1I/7n4+6yUTxxQyrE2T5bdFuEq0K4H/qbLfm4OCRxonq0be3zSFl+D4JYsB99W53CFc
 vwpeuvIdbGXgeEatj7cR3myIsh30Zk99yc7ZD4HHGTIkfHMjDmhImYMtlyuZ/1UjYET+ Xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqsdqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 20:21:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 258Jxqjp008323;
        Wed, 8 Jun 2022 20:21:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu9ygt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 20:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnyFkW2Bh1QWL3/UEbiegLUt5aLHR1CB4I/cGzOwRhIF9Nb/YzBbYbwZilbpz6uLzTZ6z+sOdxDNc3SuD4PSxay2WXwBjsghgvNEQIe46U74q8mbtC69mkcYKzungBUdsXuMcLi3hYjy+sGdYPrmJfA7XnkSyEMlcUIAwekwblHYis9t2tfzMKPXZJTa+D1MJWM09sCreGkypw/jrc/dzZN1sxuAHXRKR+m3beaKa7pmNfzbcEfxe9wnVEk0XvIyZs912IH5qFX2Fsivl00hD6w4RTo3q8MWsR9n+GLcLJNz6+BJwZOS1p1dd6Ea7jh08XgaYIjuYiK26oDYq2Afqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/i58C22SyhyIDQ0Mcfqm72W+aEegDPV1F5bU8Xs4eg=;
 b=Ma3lzh2G7U/IyVIF6Bm/sfsQqmQOalFtaVu+aPFVBzTvIcw29HMzoXS3WZOJGuwx+kAPpbdNHRdpWCpijR8Y6yUD/RiWfqhJt/dX/zzs3jChzdbUUeYuH2oi+XQPSOlGkG87pITfREOMIaIhnHX/aMB35t4som1VBF9ymlav27fdJjf6JJ6ZY/783eei8LE10km7zRwG/rqmaTPbLruFgifN/f9xtxgHcU78uvAcU1aYMS9BtXQzoYwNy1MPlbOypZTIKsULXyQr8+U1cjGFERWxK4YTrs+CJ5hUbwILrf92bo4q09t90g2e4VJkmbiZZzswEzDhutu4on7MESCgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/i58C22SyhyIDQ0Mcfqm72W+aEegDPV1F5bU8Xs4eg=;
 b=pfxZ8Xq4yufuE7cJ/HpjBdx4iCMZtW/8FPXMMt1fq/CAEUaEO5j408XN5H2S8Ia/DRjBA99t5NCcnYCJzfjeE9vwgFQqpnZ9Haqq6Qum90DUmJK76b1w6YgXGLilptcMKBz5tuJ732tUqCOVenP4dTfQxq9JzIKARRmT+16cGLE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BL0PR10MB2980.namprd10.prod.outlook.com (2603:10b6:208:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 20:21:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::f501:65f7:2895:5c35]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::f501:65f7:2895:5c35%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 20:21:53 +0000
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com>
 <87k09s1pgo.fsf@oracle.com>
 <CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com>
 <877d5rt0uz.fsf@oracle.com>
 <CAHk-=wgGjmCwyrs4Druy26rUddoWj29PjAKRZD=q0pzfVNioDg@mail.gmail.com>
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
In-reply-to: <CAHk-=wgGjmCwyrs4Druy26rUddoWj29PjAKRZD=q0pzfVNioDg@mail.gmail.com>
Date:   Thu, 09 Jun 2022 01:51:45 +0530
Message-ID: <87zgimsy7a.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d337f4ab-384e-40e1-0e5d-08da498c8696
X-MS-TrafficTypeDiagnostic: BL0PR10MB2980:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB298019A27CB8F676B3634EE2CEA49@BL0PR10MB2980.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqDlwS0kV5Rda4q/BF2lnBfQGAqqUfkuEQjR187/ZE9aUUXKKn7rSlF+RWSIcZx3xLO/mHFVV6WQV4AiqHc7g1wxMALxqnclCTSn0WT9ExziebYsgBlVaiKo7v7f4eD7kqjGeQSzVKscAtQsogQsQi/g5ccGvE8g/akIyAfEmIwIn8f2G1/ihXKKH5UyT2baG09CG5uxZMIu6+6izin+bwofRlKiC+PlHe9bUdYdqj1ScisF1MQp7gu7DvbtOOBXvA81ecgWZWTEW3yJRsEQHkSVN1S7cVKqxM+biuJZSC5mMQFejWoQ9Ae/FM+jAxvaYRKnUiXHo+Jg5uof2hVYr3Yst21Um4T2vPi5b2vIJRzC3gCCbNl6Q2jsUNIjPK/f5x7MungNycVudKEf3C9JxJQ2JmoW3nMGG9zUnDOVltsxIZmgX8O+NU9b/hXq37WTT7yRPYB+RPoob3pTf6zdVfyAE8JRyLWYTxgyRLSh3F5lOJP1/A6lok9tVOdKdIeimRCtOxXOo/9CvMAQDFT8XGJmD2pJHr4jyP8nZSTYgg8C7ejN4VhJ2LlSaXsHC+Nn9pLWyVmpMJhmm4HlHaB2Z6JwATCyQHqqd65EIJzLp5AukL3UbyQdgY9WAsYXIpcuq0F4/BSjSIrjgObEn6+yzzE3vdsyhpjswb3gDU4zhD4KwIXYvyuJrqdcbfsAdIpXpH6DpRsLg1hlsK6328QN/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(107886003)(186003)(38100700002)(52116002)(6666004)(6506007)(53546011)(508600001)(6486002)(316002)(54906003)(8676002)(4326008)(66946007)(66556008)(66476007)(8936002)(5660300002)(6916009)(86362001)(2616005)(7416002)(36756003)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ONm/J1cLfgACQBaK/oVvFKPoZI30CJ8tdhVqZL7349xmFtmCZJbY/yQ5Q7ih?=
 =?us-ascii?Q?sPfQzaULn0htWBptb79Wri3FKa1r77XV7JL5fy8Xg+moxbI7GcVC+1bCs59S?=
 =?us-ascii?Q?8B35J89Etb4xiu+d46H0pTkxHuqCX8CoJK0bhV41dUXAEpbAZELLn9tbNAQv?=
 =?us-ascii?Q?lzTpyxRpGbNSgKtAptElH9fE8Pt2X4MXO9crbGAndSzF1T9QPxDWs6ymXSRf?=
 =?us-ascii?Q?JXJA8Nn/ntOXEUgJ+4zLB6FwRPshxd6yAH6YMbE7wWjpLW+i8sfgnhP2QNJo?=
 =?us-ascii?Q?H58vhF7CuVJcPJbxZlTdM8Sg5N4c8gKFZz3Hj9qKLylvbq2zkTWdZxrksW7T?=
 =?us-ascii?Q?UEh0rHQEx/H5DwzFKiPOIfZThMe/GZdD28/rr0OiSEIlneoi3PQWEnVG/de/?=
 =?us-ascii?Q?7UOds0MLOx6CCkaRgf72W/m8kvQepoyg5yes9o3e7MN1kJZ7Dt/xKengEuTj?=
 =?us-ascii?Q?n5pYSIQa5773dgJkFgV3UuepjNaOogFYtOiG9vuu/G46ZyfZAc/q36Ita5kP?=
 =?us-ascii?Q?lRSvp0dJa7UXiRx1WMb9hClbL7dd5O4HOVmM4ttQSizXg2QXrWvJ7/PyiPVe?=
 =?us-ascii?Q?jSn9n0bUf0dov1uo7GH2Y3sSKH28LDkoOlAljcPMHandEUitnN+wZcvbFIib?=
 =?us-ascii?Q?JabJuGozCcujtQvDSeIDbICf6W0fnUH+Oa1Lc7PjrvW/kpAwBIq5WBoAvNmO?=
 =?us-ascii?Q?972makcSOkDZVbSMpOVKiI4XS7TKM8YPT4UEPJ1rJ7TdqoT4hloKwBU/z0/H?=
 =?us-ascii?Q?YJpNPd+vxUyCzlUH/DgzII8K62iw6P5xzKWTZX4jhbsL2CnKyrq+IoF32Byo?=
 =?us-ascii?Q?7gj/j9PuV+o0K18aO9stEeZXmWsU6Uf41Y33XGOIEx5Os05sFKywwoqQ/CvK?=
 =?us-ascii?Q?jF8IyM3fqsAwhLgKdQWxSXeK8PquCzmz4wvSG4ChiDXPIaZaC0gy6xvB5nD9?=
 =?us-ascii?Q?hM97zaw7nnPK4BRiLZj9aB6IH3rRpONqdGCkwe5Cqt7aXR6ekk32WlSyc3xA?=
 =?us-ascii?Q?mwQYULhpJnEqcrDO9mwu+2SrPS1m0cVFy0LsDZ1OCtxkUSyqMcdly1QtfL/a?=
 =?us-ascii?Q?l9IOJe43tmE6temTLrdKxRZbTAW1uLiR4VInRj72vYH0J7DYoGZaGpqWi1hN?=
 =?us-ascii?Q?URsl81C81am/+Tx+5N9QIm9iAiqI2kB2PHAmWE272Rwtg0441Gd8z3D4UThE?=
 =?us-ascii?Q?R+h9PBqYdjLFgICoEeykU+rT1z0NHMFyj8iX1LCgEDhLgK7qcZgNBwGVGp8R?=
 =?us-ascii?Q?Vvd0pvfbTH/0xShXMfemGNBcsxOIDO6pP/qtXoINO/JVGi2hcT0a55y6AgDU?=
 =?us-ascii?Q?X7mpJcwO1U+vv4T+RAqPlkg06fqySdMnF732Z2mJJjoEZ6No6QqB5GZ/a0Jn?=
 =?us-ascii?Q?XJL8S0y/o7mDYwOnNHgtm8sC+P796CoIm2M4429qAxuB+DsuTjy6CKyxSgHJ?=
 =?us-ascii?Q?jt1mb+9ixs5TaEkGcCi2Fo/W4J5xGkdYr4YIBrWtSUt4PZme1UilptnxYb8K?=
 =?us-ascii?Q?gszcFurrs5oq6vgxv2m2MBqCH34LqPeGbJH1EakHrO/xvc5UUDCk6NM9WCMx?=
 =?us-ascii?Q?/0D0g96+dBuhknW0POjH6E8t77JSwftO8YGbjKtjouknT6Dpuorg1xbqJprO?=
 =?us-ascii?Q?iTCtaZFmqHUzrYgyYNFkdhrRE7vQLPyqWae6VuxFtJlW+DBzWDa5z/HgPjso?=
 =?us-ascii?Q?Q6b9FjV+lHEuoaFO3RHiKU3xMa38LUPxDDEaMDiko7F4CkzUi2P5aVP3/iwH?=
 =?us-ascii?Q?QG+iFwww/19uGeXbJL9BWnM9GOg0BkQArhYFFq0ikS2PqGxY/AYkKs5tj12a?=
X-MS-Exchange-AntiSpam-MessageData-1: o84m+SCofkA2XMlDQPyWoSoohgDRnHjB9+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d337f4ab-384e-40e1-0e5d-08da498c8696
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 20:21:53.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuwCFkOUHVu0FsDW494KgeyvwfDmP7lhXQZXT4LVCu3a/bb6neB7eTiKTfr1XgYwhBYZ1B7GjEUorkB1kE7EFKRlcTI8B2qJD3vQw7384d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2980
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-08_04:2022-06-07,2022-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080077
X-Proofpoint-GUID: aBGo82EPoGJj4RfGJ4IXJtqirOjAUdjq
X-Proofpoint-ORIG-GUID: aBGo82EPoGJj4RfGJ4IXJtqirOjAUdjq
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

> On Wed, Jun 8, 2022 at 12:25 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> But, even on x86, AFAICT gigantic pages could straddle MAX_SECTION_BITS?
>> An arch specific clear_huge_page() code could, however handle 1GB pages
>> via some kind of static loop around (30 - MAX_SECTION_BITS).
>
> Even if gigantic pages straddle that area, it simply shouldn't matter.
>
> The only reason that MAX_SECTION_BITS matters is for the 'struct page *' lookup.
>
> And the only reason for *that* is because of HIGHMEM.
>
> So it's all entirely silly and pointless on any sane architecture, I think.
>
>> We'll need a preemption point there for CONFIG_PREEMPT_VOLUNTARY
>> as well, right?
>
> Ahh, yes.  I should have looked at the code, and not just gone by my
> "PREEMPT_NONE vs PREEMPT" thing that entirely forgot about how we
> split that up.
>
>> Just one minor point -- seems to me that the choice of nontemporal or
>> temporal might have to be based on a hint to clear_huge_page().
>
> Quite possibly. But I'd prefer that  as a separate "look, this
> improves numbers by X%" thing from the whole "let's make the
> clear_huge_page() interface at least sane".

Makes sense to me.

--
ankur
