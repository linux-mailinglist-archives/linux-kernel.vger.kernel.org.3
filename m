Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0A52CD09
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiESH1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiESH13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:27:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7FB8FD6F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:27:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J68WkN009140;
        Thu, 19 May 2022 07:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=2fUjTspUY2YeWYeJPr5FCQwI0aDCLD1nIM/XHvfDGcc=;
 b=vv9AJ19S82C6Uh8c+OVZ5I1q2S6HgdCVQ3yVobSXLfWeGfwUl4OYaQqskNinTF59Gal/
 WazyJGqtQlmylwezgmNIZ+8G1SXgTZXb6fwIk1vpt7jwH9knVsDK/Ba17TylxjuWtsUL
 Av6ZUnE2jca9Ed3f1H+fvj5jqiRyEH9Wb+BVsyPox78Z3hWaw10g3UNHR2yUAWCsfETP
 G+jp9tp6CJ3QgflYIlYExqXqWlOTE7KBekCrPmG4+He+nupS/YOKEZF8B3R5OhD/xWCM
 uHNdNIgDeyWdSx8+hmapLGFb5N8zFDnRyizH2FsHCyHNRjOp6nHuHibeQH0Ip1c0IWHi OA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310ud8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24J7F7FN023351;
        Thu, 19 May 2022 07:27:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v50uqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 07:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoUwxhL0TN//WnB6USBU+tblF4qDdRllQJ2Gostfp+MlS9xpqrcSKLLc8ATV2lz5ISA7lG/6VBno09lbKVduoNXXq9kLfQFwgvIu076E/A4o+gxRHfc0UgbjWV2vUsP06uyqnBn5pX52o9+v1B5zvHF5ymmiAJtHLeaRHT2hCekRgM4nRbRu0QGYEff1+2mkexVK9W4nduhIrkwq+5d0MGzooVgMby2AST1Ci2Jwop38qPRPSZW15aETpySIkdTm0bxj1hvH0DDjBTDOe1rGMoq7hhEXmvSgwyXTMrjuM6HDLHAbOCD3wqzc7bTfH37Wnh4fVKZh66zGvZ4ZVVyx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fUjTspUY2YeWYeJPr5FCQwI0aDCLD1nIM/XHvfDGcc=;
 b=YbmOZr6l0FiCf3f/imBa15zQYim4Brxu8BInaw8M+LXVNoAYgz+dBPTYIxPoXX8sD/OGlBq55pYtVojaJ8u7UtjK4U+3uuiL4PNX7PAg4eej9pPiajsI9ayaUCFPUYlSzoCWPqjKh/WEWlSVohOm3FY+AcBijMevryEE1S0m3FjcN/+K641axd9fs6vDbzEeJerMD+uoy9sd3teEqFqO8TApZqt/CLUZu/FiS1igBUgpWLBTyUC/RiII9ErAN1y26fEki5EdiO09oJDP7CJTCIK+1oR9H578w0V7JW7PS66iGyOeteXz1SfxKe5w6rXvo7UrjzBD8v5digDrc4EjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fUjTspUY2YeWYeJPr5FCQwI0aDCLD1nIM/XHvfDGcc=;
 b=JoZI2IzsdqWqht11TZzoycjgWXOiuqoPG9twnz2mIAke7OHCgb5N/sfKRz70NV/Koc85KZji8DG1ghM4Au04UCMarAjvRfyrWneex3Jfh72RYWHrk8ubsgqrxPituyu1w7lUBl5lZ1rBnXyDm0tg7/OzVUoE+o40d5aRMWt1M70=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM5PR1001MB2154.namprd10.prod.outlook.com (2603:10b6:4:2e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 07:27:11 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 07:27:11 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] kernfs: make ->attr.open RCU protected.
Date:   Thu, 19 May 2022 17:26:54 +1000
Message-Id: <20220519072658.736370-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0079.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::12) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef041701-7772-40fa-4c3d-08da3968fd25
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2154:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB21546B2183B503EF32423F99B0D09@DM5PR1001MB2154.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYuKCjpYJIpF1vVOR/0IOr62hBdLJdf5K+LoWtURZC0vwH33op7ZiSa9p48+HfPdNrf3pQsSwP9a5JwQ4Hv9vHh/DO6tsgjmlCES0dADHy+PS2NCHClIR22K5Hul8F6nkTOtoEzD7xn2SjqqfHRqg2kO+zWYT3pDLCLy143Pf13SiNFsy5iSLqZvoV6/x7slfh7esKV0SQSLeLKDoDBHFYe9Pm5HoiCM9cyMMbTjCE+eh9a7hGk/W/qHf2d4UolxUVPToN9F4FK3UmQoG4JBG3if0Sv7MD2SQKXS4a+4a5IMIuMBXBs3y9/Mdijw20hhTSJOmHeFnZdrqwMVki43Gakxj1zlvovc6AeiUQC8vUxS2W7PKJunyvlsCOjXqiNlVkJovEWq99Ip35DSsuaOISc4fsSFR3tzuMTS5fcEdjBIoZdyTTzf3c0MJYGPT1FqEqP26jgUxG9svF0HG1IrpX0LueSUST37nHhdF0IRLlCnBeYDKWp/57qTWNoJIqlD+62Bh/JMb4tqzajAi2FZT6ftgNJABXvuJxhHGXch4wuQofcFesvvJglvucLexehbrYB8As7SF8j+g363EPn8Y2GD/vvwZshSepvXiOwhQRYoWsnTi3i9pl/2Cl5eAY1c5i+akT9OeSCstelf6PqXTriU5EXEoKhTtv59zf6PWlhwdQqDzxjwBeIylEneYPQurQOKfWoax8VKUHA/JNJi5U6REM2Mhf9lg8kYuENpdlRLmWlbuEv0sp8NXLKVYlq4CdsNL8ksdyadpu8MYof0/zwWJOVHdRijjgCjx92p+MlmOasSQWaZlJADq9oygsy7c4ZLT8Ji1o6rkRKJw1k7tmDDS12pP+nVi1tfgtNh+SU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(103116003)(8676002)(83380400001)(86362001)(186003)(66556008)(6666004)(38350700002)(4326008)(66946007)(36756003)(66476007)(38100700002)(1076003)(6486002)(8936002)(966005)(2616005)(508600001)(52116002)(2906002)(26005)(6512007)(6506007)(5660300002)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ajp/7LHzuwiLBiiwBhsEdCorjeitzE7/HsbMl679zB0HDAVflMnHshhE/Tkq?=
 =?us-ascii?Q?Rcn1xihyMjDh2Zl4wBbtTvCr6eAcJCWHZP2AhGV/M8iI7bGv5ygTw36ZF9Ge?=
 =?us-ascii?Q?+amw2M/IaotGkMLMw6CW5qFwfvcMKN8FXLDst2+8F0tQVfS8YBl9ULSmtSxl?=
 =?us-ascii?Q?XFD6oyeMa3i9OQHRmYpIs1NTnGQo7/HBS0qn3HGWj9BX8cz3qnP9ztWu7XmD?=
 =?us-ascii?Q?xN7rkv7m8NPrFEJKQppFMdVGmXWF4UNye3i0aF4axccbcibavtGafcNKPdQu?=
 =?us-ascii?Q?du0P/lPjA64+Pgk2B5UUeWuAQGMXl5ut/PYBFxMnGU2e8O1rjZqbilTsFgZj?=
 =?us-ascii?Q?o8Ny3KlMW3RDsUg5RA7I4iIHrOPJhBCfhPP2MjhhOPNYnq1IfL+K+ltoSdDB?=
 =?us-ascii?Q?yX9Zn3DQyttceDOkGvDOtdhDppe0fMI4LljJOcVhuwbw51u/vt8HetXdDpBr?=
 =?us-ascii?Q?bOuQRH+fTHPp+dwDtuyNLV8c7wTdTuIzgU+LBZ86piSPdimyY451q4XTD/qX?=
 =?us-ascii?Q?1gBSESKYfKzKc3APqFM8ORnmYzhZakfueHtZzlyv9MTHIspvAjARxkWolU4Q?=
 =?us-ascii?Q?turicLI7qfa69Q9mcpi+hz8VKb74iyYjkLtfgtyOiz6wHUU6Ne0s+94lQqYM?=
 =?us-ascii?Q?35FJdka3peZDXTqEwSNDUO0ES0apsJMQKYD1MNv/4vjlRH2kcyLks+cLBZ0M?=
 =?us-ascii?Q?EXxA4kOS02ZbTUrLOhrgChC65YEYo16KmkkIGVFe1d/Lpoyz4T49hQpZl7iX?=
 =?us-ascii?Q?DxFh4ovG/FB7f0HnAV20HQarV+0l0k1Bk2v/OscDZ0RyByaDTlwdw2NDSogq?=
 =?us-ascii?Q?rqIO6H7LvJe28GZmBE03kkaMfTYwr5I/VQn1Cpq5/DKDHJvBOdt7i1m39nEW?=
 =?us-ascii?Q?RI516IA+m4y/2N3qMiEDC6B6BkzQMoDHYlvZphJJy2XPsZK2goFG6ZFyT/KX?=
 =?us-ascii?Q?sdA96uoSwmhyAwQexwBxExdc4ajD2xty18aDTJRom9+kuRERtQhZI5OQxnU7?=
 =?us-ascii?Q?F+tvmCr8DofdfN4AZU/+2G1/uYwxYpqShWmpJ5MGmW96UW2j+oQfBZCHbOii?=
 =?us-ascii?Q?OqglANhSBzuZEtFCl93E0BPZx5EgHcyy4HvoPRP4UdbF23KfsBTLADLoODS/?=
 =?us-ascii?Q?tTz0A2qG2EYzN5UsVsN0/tjljM33+H9mULcp8kcW6FIStwDTiDPEY03QOnLK?=
 =?us-ascii?Q?V/c6GJ1WiAW5xxZm7EqtvEdgFOOlgB0FPvq5jKKTTqTBIrRU3laW3W5MD+Zj?=
 =?us-ascii?Q?UsY/VCnNzrFsrWuXfqNJF5k+cYKAGN4dnMSOgtm+o9Hw2g2AoSsKc6+vHVgZ?=
 =?us-ascii?Q?99e5e6KxI+wP0nModoMsNZSTHIj/9vB3E/f7golSzhKB2nxAkLs52XSQDBFf?=
 =?us-ascii?Q?zIvVE0mgtK8rs0jNvq2mcvGZ4NXhSameNeC2etTvLeGfb8xDGVk5AgHWnyhE?=
 =?us-ascii?Q?Kh40hunRi/ZjRH1HOR3pqcKG92YFmttP9xNJ4AP3rhg1yKcLooR7Alg5AFV1?=
 =?us-ascii?Q?mvLC5HwKQW4JkuE8+XOpZEhsdDdO5Uqia+fUrpJajzfXpInAn4uxEkrObRbP?=
 =?us-ascii?Q?Nx+9D4fNGKEP0yee83j4tJlbOreuT1l5dAegQj2dBqTDpINP4chmvMVyIEuz?=
 =?us-ascii?Q?wUG0SPIUrW8FPcEDAcIBG3//VM0eeHHuW49fbQszKta4H/Mi3xd7V5Tbfn3h?=
 =?us-ascii?Q?qF166c9gEeA954E6oI84vk29Ny9cRPyzm6EE0c7rQ1VN5xqSGm7J03w9YYKY?=
 =?us-ascii?Q?+VqY2cVwgLRUaf6lF2hIOPHVHaesqQk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef041701-7772-40fa-4c3d-08da3968fd25
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 07:27:11.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDJ5YVlqZRgB2amVU79t5JoNMSU3wrjH5iC8uRCiokxaw5DY09nmbCcfORcfVscEMMmXdMbNGAbW8H+/4OQlng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_01:2022-05-17,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190045
X-Proofpoint-ORIG-GUID: b73Dh82CrTmYRmZgWE4eH7JIeN8eM1HQ
X-Proofpoint-GUID: b73Dh82CrTmYRmZgWE4eH7JIeN8eM1HQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in this version of the patch set are as follows:

PATCH-1: Make kernfs_open_node->attr.open RCU protected.

PATCH-2: Change kernfs_notify_list to llist.

PATCH-3: Introduce interface to access kernfs_open_file_mutex.

PATCH-4: Replace global kernfs_open_file_mutex with hashed mutexes.

Changes since v3:
 - Rebase on tag next-20220518
 - Rename RCU access related helpers and update their description
 - Address errors reported by kernel test robot
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2,3,4)

Changes since v2:
 - Rebase on tag next-20220510
 - Remove PATCH-1 of v2 because it is present in tag next-20220510
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2 and PATCH-3)


Cover letter for v2:
--------------------------------------------------------------------------

I have not yet received any feedback about v1 of this patchset [2] but
in the meantime an old version of first patch from [3] has been integrated in
linux-next. Functionally first patch in both [2] and [3] are identical.
It's just that [2] has renamed one of the functions to better reflect the fact
that we are no longer using reference counting for kernfs_open_node.

In this version, I have just modified first patch of v1 so that we use the
modified function name as done in [2] and avoid those parts that are already
present in linux-next now. The remaining 4 patches (PATCH-2 to PATCH-5) are
identical in both v1 and v2 albeit v2 has been rebased on tag next-20220503.

Changes since v1:
 - Rebase on tag next-20220503

[2]: https://lore.kernel.org/lkml/20220428055431.3826852-1-imran.f.khan@oracle.com/
[3]: https://lore.kernel.org/lkml/20220324103040.584491-1-imran.f.khan@oracle.com/

Original cover letter
-------------------------------------------------------

This patchset contains subset of patches (after addressing review comments)
discussed at [1]. Since [1] is replacing multiple global locks and since
each of these locks can be removed independently, it was decided that we
should make these changes in parts i.e first get one set of optimizations
integrated and then work on top of those further.

The patches in this change set introduce following changes:

PATCH-1: Remove reference counting for kernfs_open_node.

PATCH-2: Make kernfs_open_node->attr.open RCU protected.

PATCH-3: Change kernfs_notify_list to llist.

PATCH-4: Introduce interface to access kernfs_open_file_mutex.

PATCH-5: Replace global kernfs_open_file_mutex with hashed mutexes.

[1] https://lore.kernel.org/lkml/YmLfxHcekrr89IFl@slm.duckdns.org/

----------------------------------------------------------------

Imran Khan (4):
  kernfs: make ->attr.open RCU protected.
  kernfs: Change kernfs_notify_list to llist.
  kernfs: Introduce interface to access global kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.

 fs/kernfs/file.c            | 270 +++++++++++++++++++++++-------------
 fs/kernfs/kernfs-internal.h |   4 +
 fs/kernfs/mount.c           |  19 +++
 include/linux/kernfs.h      |  61 +++++++-
 4 files changed, 258 insertions(+), 96 deletions(-)


base-commit: 736ee37e2e8eed7fe48d0a37ee5a709514d478b3
-- 
2.30.2

