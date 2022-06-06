Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1753EF81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiFFUWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiFFUWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:22:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02752A19F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:22:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256JP4tu002554;
        Mon, 6 Jun 2022 20:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=hEvEoeSig8HHMEjaixIlVBLZWPY91AfXXyj9GOsNcyk=;
 b=V2t32qvfAGjRFZSOnyB6sQ8VbMydLdjZtKZ+hxG3DZIfgj8X4dvW1ZMOYHMfiGtgmuf0
 OAm4WDt8y/I36qLkIgYIWzep1smhu+A+XE9sRWdhJtG+ihjqI53Et224kMJXQesQr/Kj
 JOXdoqwyHVPSOFtKVqfY/1JZU1YGZm5lz4/zBaDpbstEa7iqKVPVQL4x7ZtbBLl6FHMp
 ItWdhT/Jgz5OOowrmHD+cOenpnEvs+BqgnAffZRoyuZp3Jq7NjErCM9NuvX/DjDpPRuE
 6tmZK2Or6JGipOGGgWb1xJfW4GoVh/VL1Ysn03D5PMit8wbma2oEce3TZHwZGCoVH+FT AQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxsc5fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:22:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KF83w001176;
        Mon, 6 Jun 2022 20:22:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu9123f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is+0HuNgrhDJHTZn58JZOw+pTBMBAn/cq02PdcNMmT/Sm5eetg7nIrSGFJnlV+sAiX/HPUrCxmud5X23b57nEY3srUipjvwwcr8QrvgfJO0KSQirU9fXCJ97tDblQUzMJu8E+GRQKy+/N7WDkJ26BS5DI4vtfYpGKs89bG3cJtzFhFjXmKz8r76XvKqvcBquRulJ79T1VaFdlaX+Zi7JVkS+GEGJw3eAPdijNPVXnGcN5t5bPWhT89/F6uEezHmkBVdhw/BYzJl+9P+xO5CjAfoXcdPPGRNgyPyqK9zUc8Hs4qyc+pKxnLh2Mtmx105UGbji+I+HGw0klp4+3uMEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEvEoeSig8HHMEjaixIlVBLZWPY91AfXXyj9GOsNcyk=;
 b=XoPPxaGwemCSsxG9IQsNewHNJm98u57VFnVLv341yNqFKPfLcfXTCmHApolZwoYRihO4giFU4tY9Po1pzuMG6ru5U90SMi/cw/22pVsllgFOc0UA+j3xD192darQQVlKexnHHPVuaepULbcNITlC4N/qT79Brf+kwjA9nB2160YdQez8OKMPqDUvP87XEGGP0Z+C1Y/1Axl/qOvsuhkibLFY9HRsUoos3iGlTWGA25qEt2OHtt4pUh99quO9NVOLkR8AKinty3NjrLGut7kk8V15qqSHQZc9WsS8bFaWitYre+ikGvLc4N0KoGSs+ytP6cm5Y1VosbT3u6Rz85Hncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEvEoeSig8HHMEjaixIlVBLZWPY91AfXXyj9GOsNcyk=;
 b=G+qxufo/kiRs7Ei+1hGOkcVgZilD8jSmc6a7AM4NTjPseeVqtoahJA/+Tixh3BITYQ2K4sJ0AIBb5xdwHJQDXqW75P0iumDkmpQXYvNf3fgMEbnQnQtT8IfzU5LvRGe3QFYEsAAvYu9XzVJSYdpvmB3nBE6v0cDR6UvLJwuUTdg=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 DM5PR10MB1772.namprd10.prod.outlook.com (2603:10b6:4:11::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 20:22:01 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:22:01 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 03/21] clear_page: add generic clear_user_pages()
Date:   Mon,  6 Jun 2022 20:20:51 +0000
Message-Id: <20220606202109.1306034-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95c6d1f2-f12f-4f34-4e99-08da47fa3658
X-MS-TrafficTypeDiagnostic: DM5PR10MB1772:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1772B0B22D12AC9C1B41E69ECEA29@DM5PR10MB1772.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYg15oXLjxoAFPvRRajQMYLdp+8Xe04grDw94LCwxeSdabQFra+Sb066b1Yl8+H8tVNFYp7bpgtlqOWBmRkTnNsBhren1HV951PlIP/HRqTZGLRBfyUnCR0K0bFfX0I5GlyiKzXEiiMB9QoOvBCRPIWi88erLSscDzI2l+hTuRlXr5SzxX4fT7KT4rbHVJdT+P2r0kfQmjjub/ZM68Q/g194jOgpdxRkrIUHpBldJ3MlOFaRnDSjV7Vn8G8Jy4t8FzCTcOQchDxr7iMUNQOMo1vdvXP0s5dXx4GBXaNEXRJ4MqFwTQRXDGunirM3VVpuTgtSfeHDkgiBcOqSgZNohcuJotFA+8oBbdBsJP6trhIyMl8VNP9U+5EyM1nlDT1LcCeeT8Q82JmBQ198QuBlJxJWZF+BUHddxOKlnlBXAGYUqsUJ8WwwzeEkoWwn/mYCNx+EQwAOFpu0T2F2xwtuEq5yHkckiTyhhKGrvLDHRRZGqf1VFqxsIOaZtktftD2nbHg3fSirNWpaGsQbQ0bLc5deQCxp6mH1wNVEEw6NEJYJlCAaVUZKl+WGCVnSyjl1KpeyK7uA3wwQzVAjbbtJhWVWDHOGhSJ6FeTE3b0G3vvypWbzbnwvyebtjtAaQ3xObGvSHOin+8BklWhKDGLGUK3Lbvq6pKsCqpisEOJndvNhuX9slyjZt/K0YJduTlK4UZhoZIGnTkrcsdJNWdzAe6Tqr2kmJWBZPzEhWQGqkkt4scb8ps4esSMDvS0+rNV3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(8936002)(7416002)(6506007)(83380400001)(107886003)(66556008)(36756003)(1076003)(38100700002)(186003)(6666004)(66946007)(508600001)(6512007)(26005)(2616005)(5660300002)(38350700002)(4326008)(8676002)(316002)(103116003)(2906002)(66476007)(86362001)(52116002)(6486002)(41533002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9j//PY9j/QZ9WtKluHN6V3uNY4IFNZsk8RyAh5JQbz2TiR6YNsC0uvxH1Rp6?=
 =?us-ascii?Q?t9YJ96P60Ip4mLzfHrFQNw3ByJe0dJAnFe/YomFgzDeJ6yrLOHH8GJJJoiQr?=
 =?us-ascii?Q?rbpDtunFO41Wh2wPEEmi1lk7y23NYOSwKIA/5gpcbHpOfYxP9Xvx2/wGcnmx?=
 =?us-ascii?Q?O9LQyqV653dqiW6mmjp8shXo7FfJhXTBRCkCoOvMmSKNBp6HlcK2pm+Acy+k?=
 =?us-ascii?Q?XoOiRbLSJYNrcAx0HdWsCIFRtw3tyCdmeLzobsaJxHAyGZueDH1hX8v4WhlV?=
 =?us-ascii?Q?KRh7lWC1dUff8XPIa6afNm/kVrz8NI2RjR/0d3GWcventkJQMhvZoyErqfdU?=
 =?us-ascii?Q?JLPRxDs2LggIXVtyn3upY3CfLOPGour3ZmBHaoxvsGbrkBMRJjzGly2aW0JL?=
 =?us-ascii?Q?vSsav11bNOWE0UvMB9jCoJvi2QGWLCHDNA/ouf5yipKqj+GJl6CB7zDiWikr?=
 =?us-ascii?Q?/NUKXV+a2zndv1NqA1yoNzPOovTwa/rgDhVkHlMGdEZnIWqmKT7E2B7z1Kys?=
 =?us-ascii?Q?ag9oZGpCS2Bs0vgLoKM+KNWvWP6LIWv1hTUzwR4Lzrv0aKY+ylGRljV6XLAX?=
 =?us-ascii?Q?U5l9qlJmbZte1Z72Cyy6o6vSIWH4OH6NYo90MVjBa6cd2VqXZJ0vvjHUAbkx?=
 =?us-ascii?Q?GHFRGF57Xf4jLNWDesFtoUTWCq/cKwllPDwtAkXWcLC/4/rr9glVBULUr/K7?=
 =?us-ascii?Q?t7Kq6zW4r2BRHfKOi7d1n8m4n/3el6BSfqeuy6OE6GHO+kXiLSHXVOWl7Ssl?=
 =?us-ascii?Q?XCnWU4cUh3n4ampbegp4SFv1KJmseoZoygcKC5jswct/MyQcLVXTjEbjbKoI?=
 =?us-ascii?Q?yi6CNj9DZ46u8eLs3fcKZ9BzAZD51doKboUU1REs+QszmeNsIU/i1g1vmpZX?=
 =?us-ascii?Q?O/U0U5Bjg57JzLu+z8hVdRgP8zlnqhl46TuHLoGYYnImrk0tSHXiX+TNTvKQ?=
 =?us-ascii?Q?xVUqBEI+rxwPWziX2TYZbC7LWSVa3+aiOC2wwV4Ur537NLJ6lnuKbWixXuXG?=
 =?us-ascii?Q?AY4o7TEyOdw9IvkbwfPKU3vK09K+iWUHIYcoQOGqr37kKaoCsKgTixiMn59l?=
 =?us-ascii?Q?b2Q/dZrC67Ij91CtjeGdr8fRhvYdg1WEBGa53+xkZiBk5YSI2petfzjByIR/?=
 =?us-ascii?Q?w2q95fPFmi1H8+VV1bhlOzYFAhyLk+BlUra2TwUqaxmO7nPhlB82arOo/4Gf?=
 =?us-ascii?Q?4TuvE0R4/iME+Y0SwYuE0cnGq7A64105IjiMH+FyRZN3keQiSQTpZpcIOvN4?=
 =?us-ascii?Q?+PGpuIfPxVqdjWeGEKwe/rLvcWGz/uOvZOOaf+k+xmHzbZNPD4kiIfLZecUf?=
 =?us-ascii?Q?X4aP/6xQclaefiR4pMIsWbsCoIMl54fzZixImzoyIIA4epqKgwVCZxhSxvVw?=
 =?us-ascii?Q?rm0gm/rLf1sUKi1rqUpLL9Orivdx64SbaxRx9Rc3WMQmxI+JukKw+z9p05Y/?=
 =?us-ascii?Q?StaFNX5GsF8QY8UMa1oosMpUBRw4YSaszg29DgUwTAycu8PdLYTZv4cG9usY?=
 =?us-ascii?Q?mcY20a31XAn8vnfweenu0mRDCVflD4WUXpvG5A98jevFyTY7EFxZgCNrmKCF?=
 =?us-ascii?Q?SMYJ1tDjQC4vscrnWYglXJaFCz96o6WfZOZz9JhtMivy8vNx8L+8ftk3Y2IY?=
 =?us-ascii?Q?lEDBdjjUmLPmgDtDtkahtY5/shAGWY5fPz4raxWjDbClWEFFoFV5JS7TMshC?=
 =?us-ascii?Q?/VxBnF3koRuggeA0OOJLvL3pO+c5WqfgRUEPMG4LqZCtpK0XQoWj4H/3AnRg?=
 =?us-ascii?Q?670A9oxgdwl6dFmhnhP7gNBaX33QwH4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c6d1f2-f12f-4f34-4e99-08da47fa3658
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:22:00.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxDC99v9v0IUM/q3lge/Sai9x3yAHUpZVXXe3CpA9lE94KEWcOTqtANr1pTwO8Zt4YHaiNxuhrah4JAjLPl8rOa7OWGVyBIZT0WRDIk2yMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1772
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-ORIG-GUID: slYONR98P7rk9SvASI4CRCxuMoYz3CXJ
X-Proofpoint-GUID: slYONR98P7rk9SvASI4CRCxuMoYz3CXJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic clear_user_pages() which operates on contiguous
PAGE_SIZE'd chunks via an arch defined primitive.

The generic version defines:
  #define ARCH_MAX_CLEAR_PAGES_ORDER	0
so clear_user_pages() would fallback to clear_user_page().

An arch can expose this by defining __HAVE_ARCH_CLEAR_USER_PAGES.

Also add clear_user_highpages() which, either funnels through
to clear_user_pages() or does the clearing page-at-a-time.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:
    1. I'm not sure that a new header asm-generic/clear_page.h is ideal.
    
    The logical place for this is asm-generic/page.h itself. However, only
    H8300 includes that and so this (and the next few patches) would need
    a stub everywhere else.
    (Just rechecked and looks like arch/h8300 is no more.)
    
    If adding a new header looks reasonable to the community, I'm happy
    to move clear_user_page(), copy_user_page() stubs out to this file.
    (Note that patches further on add non-caching clear_user_pages()
     as well.)
    
    Or, if asm-generic/page.h is the best place, then add stubs
    everywhere else.
    
    2. Shoehorning a multiple page operation in CONFIG_HIGHMEM seems
    ugly but, seemed like the best choice of a bad set of options.
    Is there a better way of doing this?

 arch/alpha/include/asm/page.h      |  1 +
 arch/arc/include/asm/page.h        |  1 +
 arch/arm/include/asm/page.h        |  1 +
 arch/arm64/include/asm/page.h      |  1 +
 arch/csky/include/asm/page.h       |  1 +
 arch/hexagon/include/asm/page.h    |  1 +
 arch/ia64/include/asm/page.h       |  1 +
 arch/m68k/include/asm/page.h       |  1 +
 arch/microblaze/include/asm/page.h |  1 +
 arch/mips/include/asm/page.h       |  1 +
 arch/nios2/include/asm/page.h      |  2 ++
 arch/openrisc/include/asm/page.h   |  1 +
 arch/parisc/include/asm/page.h     |  1 +
 arch/powerpc/include/asm/page.h    |  1 +
 arch/riscv/include/asm/page.h      |  1 +
 arch/s390/include/asm/page.h       |  1 +
 arch/sh/include/asm/page.h         |  1 +
 arch/sparc/include/asm/page_32.h   |  1 +
 arch/sparc/include/asm/page_64.h   |  1 +
 arch/um/include/asm/page.h         |  1 +
 arch/x86/include/asm/page.h        |  1 +
 arch/xtensa/include/asm/page.h     |  1 +
 include/asm-generic/clear_page.h   | 44 ++++++++++++++++++++++++++++++
 include/asm-generic/page.h         |  1 +
 include/linux/highmem.h            | 23 ++++++++++++++++
 25 files changed, 91 insertions(+)
 create mode 100644 include/asm-generic/clear_page.h

diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index 8f3f5eecba28..2d3b099e165c 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -93,5 +93,6 @@ typedef struct page *pgtable_t;
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* _ALPHA_PAGE_H */
diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index 9a62e1d87967..abdbef6897bf 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -133,6 +133,7 @@ extern int pfn_valid(unsigned long pfn);
 
 #include <asm-generic/memory_model.h>   /* page_to_pfn, pfn_to_page */
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 5fcc8a600e36..ba244baca1fa 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -167,5 +167,6 @@ extern int pfn_valid(unsigned long);
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 993a27ea6f54..8407ac2b5d68 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -50,5 +50,6 @@ int pfn_is_map_memory(unsigned long pfn);
 #define VM_DATA_DEFAULT_FLAGS	(VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
 
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index ed7451478b1b..47cc27d4ede1 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -89,6 +89,7 @@ extern unsigned long va_pa_offset;
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_CSKY_PAGE_H */
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 7cbf719c578e..e7a8edd6903a 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -142,6 +142,7 @@ static inline void clear_page(void *page)
 #include <asm-generic/memory_model.h>
 /* XXX Todo: implement assembly-optimized version of getorder. */
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* ifdef __ASSEMBLY__ */
 #endif /* ifdef __KERNEL__ */
diff --git a/arch/ia64/include/asm/page.h b/arch/ia64/include/asm/page.h
index 1b990466d540..1feae333e250 100644
--- a/arch/ia64/include/asm/page.h
+++ b/arch/ia64/include/asm/page.h
@@ -96,6 +96,7 @@ do {						\
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
 #include <asm-generic/memory_model.h>
+#include <asm-generic/clear_page.h>
 
 #ifdef CONFIG_FLATMEM
 # define pfn_valid(pfn)		((pfn) < max_mapnr)
diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 2f1c54e4725d..1aeaae820670 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -68,5 +68,6 @@ extern unsigned long _ramend;
 #endif
 
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* _M68K_PAGE_H */
diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index 4b8b2fa78fc5..baa03569477a 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -137,5 +137,6 @@ extern int page_is_ram(unsigned long pfn);
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* _ASM_MICROBLAZE_PAGE_H */
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 96bc798c1ec1..3dde03bf99f3 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -269,5 +269,6 @@ static inline unsigned long kaslr_offset(void)
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* _ASM_PAGE_H */
diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
index 6a989819a7c1..9763048bd3ed 100644
--- a/arch/nios2/include/asm/page.h
+++ b/arch/nios2/include/asm/page.h
@@ -104,6 +104,8 @@ static inline bool pfn_valid(unsigned long pfn)
 
 #include <asm-generic/getorder.h>
 
+#include <asm-generic/clear_page.h>
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_NIOS2_PAGE_H */
diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index aab6e64d6db4..879419c00cd4 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -88,5 +88,6 @@ typedef struct page *pgtable_t;
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* __ASM_OPENRISC_PAGE_H */
diff --git a/arch/parisc/include/asm/page.h b/arch/parisc/include/asm/page.h
index 6faaaa3ebe9b..961f88d6ff63 100644
--- a/arch/parisc/include/asm/page.h
+++ b/arch/parisc/include/asm/page.h
@@ -184,6 +184,7 @@ extern int npmem_ranges;
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 #include <asm/pdc.h>
 
 #define PAGE0   ((struct zeropage *)absolute_pointer(__PAGE_OFFSET))
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e5f75c70eda8..4742b1f99a3e 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -335,6 +335,7 @@ static inline unsigned long kaslr_offset(void)
 }
 
 #include <asm-generic/memory_model.h>
+#include <asm-generic/clear_page.h>
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PAGE_H */
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 1526e410e802..ce9005ffccb0 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -188,5 +188,6 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* _ASM_RISCV_PAGE_H */
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 61dea67bb9c7..7a598f86ae39 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -207,5 +207,6 @@ int arch_make_page_accessible(struct page *page);
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* _S390_PAGE_H */
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index eca5daa43b93..5e49bb342c2c 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -176,6 +176,7 @@ typedef struct page *pgtable_t;
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 /*
  * Some drivers need to perform DMA into kmalloc'ed buffers
diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index fff8861df107..2f061d9a5a30 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -135,5 +135,6 @@ extern unsigned long pfn_base;
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* _SPARC_PAGE_H */
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 254dffd85fb1..2026bf92e3e7 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -159,5 +159,6 @@ extern unsigned long PAGE_OFFSET;
 #endif /* !(__ASSEMBLY__) */
 
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* _SPARC64_PAGE_H */
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 95af12e82a32..79768ad6069c 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -113,6 +113,7 @@ extern unsigned long uml_physmem;
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 9cc82f305f4b..5a246a2a66aa 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -85,6 +85,7 @@ static __always_inline u64 __is_canonical_address(u64 vaddr, u8 vaddr_bits)
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
index 493eb7083b1a..2812f2bea844 100644
--- a/arch/xtensa/include/asm/page.h
+++ b/arch/xtensa/include/asm/page.h
@@ -200,4 +200,5 @@ static inline unsigned long ___pa(unsigned long va)
 #endif /* __ASSEMBLY__ */
 
 #include <asm-generic/memory_model.h>
+#include <asm-generic/clear_page.h>
 #endif /* _XTENSA_PAGE_H */
diff --git a/include/asm-generic/clear_page.h b/include/asm-generic/clear_page.h
new file mode 100644
index 000000000000..f827d661519c
--- /dev/null
+++ b/include/asm-generic/clear_page.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_CLEAR_PAGE_H
+#define __ASM_GENERIC_CLEAR_PAGE_H
+
+/*
+ * clear_user_pages() operates on contiguous pages and does the clearing
+ * operation in a single arch defined primitive.
+ *
+ * To do this, arch code defines clear_user_pages() and the max granularity
+ * it can handle via ARCH_MAX_CLEAR_PAGES_ORDER.
+ *
+ * Note that given the need for contiguity, __HAVE_ARCH_CLEAR_USER_PAGES
+ * and CONFIG_HIGHMEM are mutually exclusive.
+ */
+
+#if defined(CONFIG_HIGHMEM) && defined(__HAVE_ARCH_CLEAR_USER_PAGES)
+#error CONFIG_HIGHMEM is incompatible with __HAVE_ARCH_CLEAR_USER_PAGES
+#endif
+
+#ifndef __HAVE_ARCH_CLEAR_USER_PAGES
+
+/*
+ * For architectures that do not expose __HAVE_ARCH_CLEAR_USER_PAGES, set
+ * the granularity to be identical to clear_user_page().
+ */
+#define ARCH_MAX_CLEAR_PAGES_ORDER	0
+
+#ifndef __ASSEMBLY__
+
+/*
+ * With ARCH_MAX_CLEAR_PAGES_ORDER == 0, all callers should be specifying
+ * npages == 1 and so we just fallback to clear_user_page().
+ */
+static inline void clear_user_pages(void *page, unsigned long vaddr,
+			       struct page *start_page, unsigned int npages)
+{
+	clear_user_page(page, vaddr, start_page);
+}
+#endif /* __ASSEMBLY__ */
+#endif /* __HAVE_ARCH_CLEAR_USER_PAGES */
+
+#define ARCH_MAX_CLEAR_PAGES	(1 << ARCH_MAX_CLEAR_PAGES_ORDER)
+
+#endif /* __ASM_GENERIC_CLEAR_PAGE_H */
diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index 6fc47561814c..060094e7f964 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -93,5 +93,6 @@ extern unsigned long memory_end;
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
+#include <asm-generic/clear_page.h>
 
 #endif /* __ASM_GENERIC_PAGE_H */
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 3af34de54330..08781d7693e7 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -208,6 +208,29 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 }
 #endif
 
+#ifdef __HAVE_ARCH_CLEAR_USER_PAGES
+static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
+					unsigned int npages)
+{
+	void *addr = page_address(page);
+
+	clear_user_pages(addr, vaddr, page, npages);
+}
+#else
+static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
+					unsigned int npages)
+{
+	void *addr;
+	unsigned int i;
+
+	for (i = 0; i < npages; i++, page++, vaddr += PAGE_SIZE) {
+		addr = kmap_local_page(page);
+		clear_user_page(addr, vaddr, page);
+		kunmap_local(addr);
+	}
+}
+#endif /* __HAVE_ARCH_CLEAR_USER_PAGES */
+
 #ifndef __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE_MOVABLE
 /**
  * alloc_zeroed_user_highpage_movable - Allocate a zeroed HIGHMEM page for a VMA that the caller knows can move
-- 
2.31.1

