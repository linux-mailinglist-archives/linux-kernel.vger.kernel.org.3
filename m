Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9692569764
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiGGBZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiGGBZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:25:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B642E6BF;
        Wed,  6 Jul 2022 18:25:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266NFGjE010525;
        Thu, 7 Jul 2022 01:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qLHrXtmeahSUKEskteTiZcQFZ0ERQE5aTT4xiF8pg9k=;
 b=jyt5xp9OTPoI7BChqTNeyAT4DgzRVDGMjN/04Bl91+ZHb65n/yooK5xRBRWWu6z5PSkw
 K5z8NIm7lOxQcy6LRBGGwWWYdqkHZK2S4JDAD6VG9BWDY3OAXi8rf6Fri4BQt8dwF51o
 l39Mntb/5laE9AZ51rfRTfLA9U6E7pxRM6XPn/uSXkoZSy2VIWvX5kNRgNHlGjjtjC7q
 VjiUS59HdDTRBNT9P/69yqbj/CnkMWL9Nsv003UqnIdiJjigQiFbsMkQe4WuTfBdbe0J
 7/6a8309FAanriqtQ/xqsn7rbwm40UkMMNtGXWAyt/+EY8J3ZM2gDvSkGs/A0hojW2lC tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubybhg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 01:23:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2671GLB0012099;
        Thu, 7 Jul 2022 01:23:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud8gqby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 01:23:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHdhEE79nvmTCsR2HqHZdO5BAim1RW+BZqxuCJvqkrCo2Ko10U9WjyKN6oJC68fJrxfd62n9JKMyTuojwK3yBqvPw+WRI3sKXw1xBKryKvsZJ5vQK8MLTcLut90RrsXJfY1AuB9gF5cSxdhoktLoBIG45B3KngfFFUXnzOA6UL6Ki9MQUJqC/XlNOUWHBxiBWMloGEIU/EQFATbxA4N7jV+LIgongpT9wRL0SWvQUD8dZA8VkuXgYgTd76RBa/zZfrih7Aqf7DVwM5vSk0Lh0ekf6BB7GchNHKLEKln45aAoLEQhjwTTfw+uW6i8O/ZQCz2UZ/uiU4VkrKOj8u7OCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLHrXtmeahSUKEskteTiZcQFZ0ERQE5aTT4xiF8pg9k=;
 b=Z8BC5zixS8o4HTVqpJewYGv0+DyM9mVFI6gj46n3XntHg4i9gEzFz7RWvWdpjKehBuLphtvsGioGwPhDLBPH2fKuTDK6Vef9pvbp/yt5ifSQnM0E2fDTpdcpfj2DUn4F+x+6CQFPF3EY8OI5VE5IorQ30sFX2KX2e4Pt4MCwEJbv7UrIuvMH2nOMb1GYMembrMjXs+aMTI9aymLFsmi2wUtR9tOnKq+Bv0JJLYysLFojpmjcUJB/caf25b62o5huZBfcsw420RbbV3IIF+6Sq/2ogj4F1Hys40GsQb7rmeupR58tBukWbl5CjPI6+x1n5U99WBUWtsIJr5oKCht4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLHrXtmeahSUKEskteTiZcQFZ0ERQE5aTT4xiF8pg9k=;
 b=iEwbXbrfg6/TQUn6lPfA7kzZFkD7xLmCH+bkGNNVRec+NRRP3H+U50ppmRc6tPEXdj9/bpBC9qtnFZ79evfWUCQcfCTzS/cyYSdKSqLyOMfrcY9ESSzfP+IpXlkFrri/EIXtDMXtBY7bKGLVNQe9jPE7DTfXgMCbyj1/zh4mHSI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1323.namprd10.prod.outlook.com (2603:10b6:3:12::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Thu, 7 Jul
 2022 01:23:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54%3]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 01:23:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "page-reclaim@google.com" <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?iso-8859-1?Q?Holger_Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v13 08/14] mm: multi-gen LRU: support page table walks
Thread-Topic: [PATCH v13 08/14] mm: multi-gen LRU: support page table walks
Thread-Index: AQHYkYPx0l/qAVKhik6/g5Dvbyb24K1x69WAgAAxiwA=
Date:   Thu, 7 Jul 2022 01:23:55 +0000
Message-ID: <20220707012346.xhg2f4z5au4bfxft@revolver>
References: <20220706220022.968789-1-yuzhao@google.com>
 <20220706220022.968789-9-yuzhao@google.com> <YsYMEwJCL4GE0Cx6@google.com>
In-Reply-To: <YsYMEwJCL4GE0Cx6@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d42f776-4841-458c-a818-08da5fb75c64
x-ms-traffictypediagnostic: DM5PR10MB1323:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9dSFPoQIX0IB48bo5kaaJrh/5JI5wVqMUlfuMyoy5lEyH6LsRZhk6/BiUzEAInOVgbiJ3pGJzaXTWuRzgQnQZ8UpTwqBXFwWbdF1gBXUpL28RgzSR0Xje+WLS3itJyVFiqiAO9qbSvi3nZWyoneCTbfUF1ib13I9xC+KEZBF/lY3275pCyT9WP7h2Ik4l8oOW3LGiJBBDBJTAPM/W7Wb/orMICth0PeBxmcj1W7vR485WLisdtEBrSvA3KOkgxnL+eS4XpfpU83kM4SGiTBXgMK5XDch3yvYCPVQpp7gGj0+66Xfz5s77MjpLDAzh6vB1XIH+WTjE0pjPzrSm5lRCF4dNcnGNCXqjQ1KSXAnrr/rpamzVoxOCveuK49PojKlACr5QAlJ+4jRoHelgF4KQt9ENrpPmV9EZJ6SyS8+Cgk60NWGtJDdM/aIPquANl+Yw/kckNVwyQY3WiUjU3UR/rNd6S8l3ajnoA+8BDbQ1HMRTqBVLhnu1OivDsQOviu4fUKhozc5Sg3diRKuX8mQY5vzLhD/eHyjiHc7Y7JjI+TmL0B0YyJT9ho6Uv8it/3aAjazHDvCOB2g1s0yubNfFCb2Sw/NU60TYX0Rw3xTb0ZcMCcnfQ2R8uDQyPn655ZXxBXfgY9jVptDFwxxK9G3XpRe47EBIHVSH12dFHLPmB8LkKn7MoniyACNHddpJ9TWdJFU/6nb1/wA+tIyT9tkXUbwxMg2VcOi2ydsg5Ba6XnobaiEH/GHQpF8Ts4lCXPGFykMQ0l28T9zXpS8qTceCZeE71xWT8Jw0Lhp+661bCnrothKk+NjsuhGQrGWTYM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(346002)(136003)(376002)(366004)(64756008)(316002)(38100700002)(38070700005)(41300700001)(91956017)(4326008)(2906002)(66556008)(66446008)(186003)(33716001)(54906003)(7406005)(8936002)(44832011)(86362001)(8676002)(5660300002)(7416002)(6506007)(71200400001)(76116006)(66946007)(478600001)(6486002)(66476007)(6512007)(122000001)(9686003)(26005)(6916009)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nMl9+khecgWc4lfhGcgV26F6cByyIK94hNK/7yI6t45/3/zo3v63niQp+u?=
 =?iso-8859-1?Q?wC3dAuuh8fW5LKWanYtPk16TvXACliDnroxkd0JaoWiiwhTNJTS9FhcwJw?=
 =?iso-8859-1?Q?oEqMIh9ofP09FRoQ44tXdEcZoN1Dl6jPAFlK1y5KSi+LNFE8OQpCgF2ufl?=
 =?iso-8859-1?Q?FT/aiB3BIIrOIE38dJvNMzEsfLXX3onWS6mKLpxEvpKHr2mBwD6D00jfhv?=
 =?iso-8859-1?Q?abdCRwEiEV2R3u9Tokiw39/7mZ224ernmoFqD1Pthg11NaPA+VUlVbnX6g?=
 =?iso-8859-1?Q?vEvDswfa295iUsjw5Xt4IZIR+I3vKBdKKIUyExkewRAjiNGzsrM+Bx2Vw6?=
 =?iso-8859-1?Q?GxeQoQjxkdOS4YoSbklmugXpAWo7vuE61pnIlmH9sVE6Z/mGZj6SDn3Gq6?=
 =?iso-8859-1?Q?rgl8e3pkuDgQCMCSbB0yVIMSC/trjxC8VAVDSXz86oQGVf/YWOZuvxd0u/?=
 =?iso-8859-1?Q?579YHoqGd3xFUkoVSyJB4t58g4IKg4lNNHVFQzNxPSI81CEKIpx6/4sByE?=
 =?iso-8859-1?Q?BfpStBr3puJ1i3gGCgbhlfs8onHehWChytJ5xKh7V6k4U4Ier8KLLFXJkr?=
 =?iso-8859-1?Q?VkjnN6WBAg03y1nKyOn/tpTnAh6Fmct/nzNtl0On6oqLJEvRZGWvxGOj2f?=
 =?iso-8859-1?Q?ilwFn/xcNv+8ZO41U+cv4jSex05ym00c1K8X2s4GFtEbLboB2o/aT+Rd6U?=
 =?iso-8859-1?Q?ITt2XYWIyvOKRN03SlMmzVKGyw6weJDOlYQCvOHRjvXuX1aZnxpohjfHoC?=
 =?iso-8859-1?Q?q/jRiqwHW+mlTmYZq2I3HdSEhNUcn4R+vK4Koyol/OtSaDHx26GqvISY73?=
 =?iso-8859-1?Q?Cs+UouFjR7BrWlBY+akdJ1mmXYYZwQJNw2+FVLNL3lpdWJKr2fFeKQpAVP?=
 =?iso-8859-1?Q?d3uTZAXZdyWk5scYP5iZEhxDLwgTirx/qY43bNI39uW796nfk2daXw1ulX?=
 =?iso-8859-1?Q?E9qzOI23BT4f7vEOo1hQFMfiqaLek/IhBCWYfIkujDp2BIwuduwca7UwL6?=
 =?iso-8859-1?Q?B32crzV9/B1J92yBYSoEdr/U/lt8l9hEuJu8NQHIJs1mwvr/UAoeoszMsR?=
 =?iso-8859-1?Q?P0fJf4oRw6507sRpZf+RRV/mvOnv/6K8sKo8mwZZKmvApYu9M9/25C4PRO?=
 =?iso-8859-1?Q?htea5aJwtxzJ8b4OjUTlhremw+4nA3qGIchu7ZjIDY+3ZwTdPP5XEBaAPq?=
 =?iso-8859-1?Q?4rBZU0u5e8eobE3xzNvuErVmAAi73L1xaaxK7LAnw9+Ut/eo1qddIUKoiN?=
 =?iso-8859-1?Q?nlJYbPB4k3Og+rIadsXQMdz6H3umAy2FXgH6UXNKSuNn9mRz22EeOQYJDe?=
 =?iso-8859-1?Q?rT0NP5X+GUS9Qa7hTmI8+AVYNlMtBNkqgKkaXaODVJbnrIJMZ7Xvp0+zU8?=
 =?iso-8859-1?Q?D6qpPKAw7YX4+3aDkWXFB53HTLmZgICCCu3AQ6gGCjHYnJMLmWOla/zaRg?=
 =?iso-8859-1?Q?nTza4hLdYuIpSAdMVvX7d/Jo/IgujhbkpeMjN1vH6xhqxIQGvYvMNQVjAD?=
 =?iso-8859-1?Q?1bVN681/ueuyV2kAK/0KU8gJu6labS5CRP1Wkhp6SJgpTZwAFBBCc6puya?=
 =?iso-8859-1?Q?4JbXpQUSyB4Apns1FHKfQnX66HSK72GVKyx9WWWi9mjwJ8/X/b9TUU2Osh?=
 =?iso-8859-1?Q?fbpmR9xkZLvPCZvlM4V7R0XtXeNXKa/UNz9m8khBuIenW5sgCmeg3hYw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F9C60B5014073345AFA8649958973EB6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d42f776-4841-458c-a818-08da5fb75c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 01:23:55.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwyiaRKe9zn27GqhWKbBFZ8X8WtD8zUpMhTGX2UX9/yZMtB6N1nayQcLiqI6zV1vw56Iul8nS9zxv3buFDwAnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1323
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_14:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070004
X-Proofpoint-GUID: KMtPiq8vTJYb1iyLpEY3XgRh8YtHjgnF
X-Proofpoint-ORIG-GUID: KMtPiq8vTJYb1iyLpEY3XgRh8YtHjgnF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220706 18:26]:
> On Wed, Jul 06, 2022 at 04:00:17PM -0600, Yu Zhao wrote:
>=20
> ...
>=20
> > +/*
> > + * Some userspace memory allocators map many single-page VMAs. Instead=
 of
> > + * returning back to the PGD table for each of such VMAs, finish an en=
tire PMD
> > + * table to reduce zigzags and improve cache performance.
> > + */
> > +static bool get_next_vma(unsigned long mask, unsigned long size, struc=
t mm_walk *args,
> > +			 unsigned long *vm_start, unsigned long *vm_end)
> > +{
> > +	unsigned long start =3D round_up(*vm_end, size);
> > +	unsigned long end =3D (start | ~mask) + 1;
> > +
> > +	VM_WARN_ON_ONCE(mask & size);
> > +	VM_WARN_ON_ONCE((start & mask) !=3D (*vm_start & mask));
> > +
> > +	while (args->vma) {
> > +		if (start >=3D args->vma->vm_end) {
> > +			args->vma =3D args->vma->vm_next;
> > +			continue;
> > +		}
> > +
> > +		if (end && end <=3D args->vma->vm_start)
> > +			return false;
> > +
> > +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> > +			args->vma =3D args->vma->vm_next;
> > +			continue;
> > +		}
> > +
> > +		*vm_start =3D max(start, args->vma->vm_start);
> > +		*vm_end =3D min(end - 1, args->vma->vm_end - 1) + 1;
> > +
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
>=20
> To make the above work on top of the Maple Tree:
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7096ff7836db..c0c1195da803 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3689,23 +3689,14 @@ static bool get_next_vma(unsigned long mask, unsi=
gned long size, struct mm_walk
>  {
>  	unsigned long start =3D round_up(*vm_end, size);
>  	unsigned long end =3D (start | ~mask) + 1;
> +	VMA_ITERATOR(vmi, args->mm, start);
> =20
>  	VM_WARN_ON_ONCE(mask & size);
>  	VM_WARN_ON_ONCE((start & mask) !=3D (*vm_start & mask));
> =20
> -	while (args->vma) {
> -		if (start >=3D args->vma->vm_end) {
> -			args->vma =3D args->vma->vm_next;
> +	for_each_vma_range(vmi, args->vma, end) {
> +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
>  			continue;
> -		}
> -
> -		if (end && end <=3D args->vma->vm_start)
> -			return false;
> -
> -		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> -			args->vma =3D args->vma->vm_next;
> -			continue;
> -		}
> =20
>  		*vm_start =3D max(start, args->vma->vm_start);
>  		*vm_end =3D min(end - 1, args->vma->vm_end - 1) + 1;

This looks correct to me.  There are a few subtle things that happen
with this change but it all works out rather nicely.


Thanks,
Liam=
