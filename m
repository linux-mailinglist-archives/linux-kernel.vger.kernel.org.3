Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9C519325
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbiEDBLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbiEDBLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39B231348
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:07:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KsJaW018676;
        Wed, 4 May 2022 01:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=829pJ5QoRAvyGDztFDW7OwGtGanHQ8F5VGqVrkrQSPk=;
 b=LQT8LDalbLIyoueYzvuqsPcneFwcE1/IPF1FmKnmn+q7hYpsuaSC6lY6WQDUfnpY2Dzg
 NRHTZIbCIe++dc51zQW9mP4vv0HxYtAOTOna0ncCKz13aA4v4qk3987WMrerszB1zdhG
 fz3tK4eael0IhVK2yykG/bQF18gH2a8/iAm7VsiPjdwOXDF3CAkUB4XxFKjSbgh8SgGe
 5QsV1ax2qcHpXtQGHr1qV/D5GwW6m5RBPL2igUG1pST4YrIvb8WfAs2KyBX6GK3m/M/5
 06IIAOHiAtiqD5xynMIyI3jvyXM2Vxe0Y4MJm4L2AZmct27TrxmmLojSFV/dLg1aZeyC oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt74ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24414r5U010220;
        Wed, 4 May 2022 01:07:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj91yvc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe1qCMl/2JY7lMbpQq6R0c7hn7j85Rk+Ih8W4s6vixF81I1Ye2ZkQ3LbtD102X67RXVHFkUDcMo/sUAZzqprIOyJYq1wqD6mrxALLNQOfn4KH2OZryWneOpY/ZZ1rA0hEJ18vBYH78h3VMhmWMItABFPH1PCah+xLWSBROus/SluioC/GipQVyYhZdfaS7mJSzevw3WoYYPwzu4vifJATCzzz5RAkxNnowVVhlxa6R6WFM1dgq6X0dbEmOx+Bi5RxSLz4RxiqC3w2tHIfUMZv4QykhNwa4SNfhFCru8xiZCjkSDX2233Vy36amQNcN5MAT8WlCAHolPbshKab7v4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=829pJ5QoRAvyGDztFDW7OwGtGanHQ8F5VGqVrkrQSPk=;
 b=BlQ4hSbjsVim42qWhbWcUdRguYOwQMDvJHBhkK/tVMJJxEsvwPC9HiJcBlbfl11O/QZA+I/4dSI+5H9jwato6miGdzNcPlhZE4YH2JpYs0jnhWxG6hP9/D12bwJMve0+vxH6w31o6iTC+kF7Z2y0GXE5kMWaRBkhgMfLDu4vzpNE8l2D0mWW21TZza3aofSMdeRkngUEVahMlrWOY8twcNlFn2iDJ5GOfhLH40pW6g6j7QkXz5jeI0z/s+gcPpshf/eAtOF/wewL/ki59jrFJehMc5i9Tc5w1U+azecEX+hiAB/t2CXt4jwAwxlTCJotNNtDDTNAGyOCKix1HJ0wJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=829pJ5QoRAvyGDztFDW7OwGtGanHQ8F5VGqVrkrQSPk=;
 b=RLgbuO54VhQBoXhGpkgAWShYw/ex2As8IKlYYZRtKy5fURQcqM/Qpp4NwZ+lrHT+pzT+1BA8+66iysvwT15CRK34oaBo2d1lZCPNgPUwQK6E0HyjjFQfGeTFVxu1GRUniZ2vn8Om0J0j42Icae2XiPqMge8GMfiZrtdPFuQbiT0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM8PR10MB5445.namprd10.prod.outlook.com (2603:10b6:8:27::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Wed, 4 May 2022 01:07:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 00/69] Maple Tree v9
Thread-Topic: [PATCH v9 00/69] Maple Tree v9
Thread-Index: AQHYX1NY7mnX6OfbA0OUwkg2Tm0KvK0N598A
Date:   Wed, 4 May 2022 01:07:39 +0000
Message-ID: <20220504010716.661115-2-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 270c16eb-34d4-4082-5f12-08da2d6a7bbd
x-ms-traffictypediagnostic: DM8PR10MB5445:EE_
x-microsoft-antispam-prvs: <DM8PR10MB5445D66DD434C0F0FD0FA7E7FDC39@DM8PR10MB5445.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 236Dyy1p00v97PoWzWw4iGg4qH/7lyHm/4TfKCVP4D5SgfbW8HZ/VVmvhcsdqNjGUCuJRBlpnRUwFAetJP9RA/4aNAvFZBPHazioyhsNkOTAhA0kq69J0Bh88Z9L/wnxPVbNvfeWv955ci3nhkSXJCKHz83rKwjyJzR8imAiISBFAkx7KuWjIIHS8S0P1iDnYWIs0ufMKEdkWqNTXKxph1xlxq8654+H0fE1GzkWG/WI+9RKaZqNitZvtCsGgRnvBrWxPbzB8hyBJhU8PSeT+vqOw1nMIaUhBSKYZaazhk7m1s7z/sUVt5l6arCVpa1NNVgAaiG0Jm5BX+5b+zwZs5Ligy7nV4jM/Sa51YpAOT66/GihKhwCo6BG6rU/Kro1pGBObyA5LKs74VClXqo5Vaefuccd4xBaY88aoUQjFAJDrmxTuorI3Oxn+jAfM5BtUwys17z8n86LUFsprNAhs9tP3rHqiuXW7zWVBB6yVMqgzGpcBxBBBx2DOhes05mWwq1hxd5sldx12r0c3Zohd+GMTlQJCwi6q55y9l7MH6rtigOZ27iJKsQBka4QY42n5Q+2aREYQ2RbtyxBWvP8irLbOuGzQFY+tuTD0aqK1bbxpTuXp9G44iiwSQzYSV/oYyewOKraLoUQUsnBFCbov7W5aqjOpC3uOOvsDX4u3aEyFRsMlwP8g+OPw2owKhi3sMWRzq0qu8KIaVbv55UXp9fRo0JzG7J2xCYzK2xxOrtPDkrTeeQjq3v6iMXYpH5HL1S/Aq2n/ChouD2SRAiw4WkGbkBeD8UmIPqfN1mNkk8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(83380400001)(6506007)(26005)(5660300002)(36756003)(6512007)(1076003)(6486002)(508600001)(8936002)(966005)(38100700002)(110136005)(64756008)(66446008)(8676002)(71200400001)(66476007)(38070700005)(186003)(44832011)(122000001)(316002)(2616005)(76116006)(66946007)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KECj2NDoistHbCvtCqpwLS4yevKDi0MA7o395tXzlpWZcA1l2+10VzAxVq?=
 =?iso-8859-1?Q?Gcu0TfHc/r4cruUabSPdqIjA5C2u4Xr7b5srcYOitnDFARjnprEFZaF6GM?=
 =?iso-8859-1?Q?iKdZBJEOycVDJtpYf7RCmIl5+MutNxdPjapjGfrYGKAjbwsVjM0j+NwJ1g?=
 =?iso-8859-1?Q?regoKvbIb+0ersfO2pkxfXtevdkcRBm+cCb8d46YLYjGQbkFdlK/0Ybimx?=
 =?iso-8859-1?Q?UwNipai9m3K3Uafax0SrSLXdmbRjmu8i+RK2EUFw9VXJhXnn4dBx272UCX?=
 =?iso-8859-1?Q?rpLuW3R2RB0+aWXAuxujQXEiMtrRdJuh94Njx9FSvfr3xO6KbN2Gn8HB+w?=
 =?iso-8859-1?Q?FtGlzbNn2hZSkmM+5UrIITAZLTgsX99uMpkir9lOUV9hwf5c1qV2UvCU7P?=
 =?iso-8859-1?Q?o94TTv1gLjaIl0jVdNDJVmMZUfSSTwO0Fh+6VuolMwHeFE/3kfMYdFexC5?=
 =?iso-8859-1?Q?vBGsi0j4P/gt2jTMZLfGJizqBXMOk4Kfzf577ulGaa9R56tfuH1M/h6por?=
 =?iso-8859-1?Q?+mH9d3q5KqYUAO8KNDrm9+9kMHb2lmOM4rDalWDKX29eD/viPa5YFzuUE6?=
 =?iso-8859-1?Q?t5lEMJ1VX6/aYiop909UFrmjXy94rS2Ln7FiuEHYpaz4UTas/7kvamZBlI?=
 =?iso-8859-1?Q?sPjRRwEQPSYOMW2FeDqZbnf3cIx6G7Yy1hRqzMPy+uQuGJo3QgoDmSUGt5?=
 =?iso-8859-1?Q?STlK1aZD6k7NmTSP9j3IFO2gny+QOO0P/wjADLznU1pCSSVl53LvJNoi+t?=
 =?iso-8859-1?Q?IqVllR1Jl+0UcknJ4AuM/6qmNeD7Szl4+16ZtEDabVb60xX0KmCOA1TMCw?=
 =?iso-8859-1?Q?nj5nSuzEh9vhHHwIVzV6kEdshvz2Y29Rvp0uQ5euDQ50QLrfcKDJmI4bOb?=
 =?iso-8859-1?Q?VukcJO1OjFVSql1xsbd4fBfM75wZMyRJC+DRD1Fb04yoNEA77Wd1h9VkgA?=
 =?iso-8859-1?Q?xmv0VB1vIgvQV3fKsVweBNvKDiOmYV88KY47JYep2vNMx9M9W52HATSrXV?=
 =?iso-8859-1?Q?cJ3xr9b0khODNWn/NG8bE/2CobxF4kbzmMmpL/gildG44iiATb5Gc/Kjvm?=
 =?iso-8859-1?Q?3bEp++14xZsuxL2zn+cX3z6Iez9Zx4hu5klo+ixhmUMmChvzyKWGHUnbEn?=
 =?iso-8859-1?Q?1yy9ZHakZz0FnnvxsAmYzwitYW/PGG1nqLQYz7wMtll4h219bkpQkHUfiT?=
 =?iso-8859-1?Q?ir82m0FWiw2wGhsLxFU1m+htS0DiS629Vavq51NP9vnHZ5PXBOHX6k1Mkk?=
 =?iso-8859-1?Q?JMXNFmuQn3IsC1tk5psFiJ/RVFg+ZUYEIeP9yq4f6XF9zrNnPnxKj0SwR0?=
 =?iso-8859-1?Q?5p9LI6+DlLm+rcjrVoOuSbi5nDxmBioXub5MXPl9GMHUwyb97RK9uP+BOs?=
 =?iso-8859-1?Q?Hzq7nq1vQSlBtA64LwqydkeUnuL1RhOZIPpBKJROoD4SJ66td1OfcMsFmf?=
 =?iso-8859-1?Q?dXPdzDvHTiahOQ5aKiM9HsQQyCCW5yOf8/ZbuOKgMiLqvGfKio038tPIfM?=
 =?iso-8859-1?Q?HdP/zyWH6GcbxGbrs4/PzJUTFS3DxrSMwmHfBmTIhkf4EcYuLzM7hpEPat?=
 =?iso-8859-1?Q?d8ovLvHLvftMMDeSve+GVJtTLse1yBzbWF0YajG1Z4UveA4siER2Dx0XZI?=
 =?iso-8859-1?Q?Ist0q+fmZ/ZYaVP3u8Zpkp+8HLJdmxDP0dQQyRm986mVQs9m47Y2wN/YvP?=
 =?iso-8859-1?Q?6IPz3CY80fpjFyBH9HpyewFn0U8AB4CvQuy0UGBUO9ZNgB+ZjlR4PNBkoP?=
 =?iso-8859-1?Q?0PrZ2Q4am9t0ATG7BHvATDzpKY26tCoNqkyjSmTOYoXfG1CyFnu1URtg+w?=
 =?iso-8859-1?Q?1n1h6fWrCTjxINNRkocs5IO/U9LdW4Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270c16eb-34d4-4082-5f12-08da2d6a7bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:39.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3E6bsFdkYyhVWg+jMUHUbbM+tPDmIQPH3+RAUufH41GUYR2iMSGjagEhgO2nY7QNATGBFOUCp0+rticohRFL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5445
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=921 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040005
X-Proofpoint-ORIG-GUID: 0jy9TK1dr451MzWebYzjPTgN0nQQ7DAA
X-Proofpoint-GUID: 0jy9TK1dr451MzWebYzjPTgN0nQQ7DAA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please merge this patch set into the mm tree.

Changes:
 - Removed mips rename patch to allow maple tree data structure to be
   the first patch
 - Moved pretty cover letter to the first patch
 - Boot tested m68k and s390 builds
 - Had to disable KASAN for s390 due to qemu bug [1]
 - Added error paths for preallocation failures
 - Added error path for brk failure instead of dropping dead code
 - Added s-o-b SeongJae Park to damon patch

It is based off the mm-stable branch.

1. https://lore.kernel.org/linux-mm/YnGHJ7oroqF+v1u+@osiris/

Liam R. Howlett (44):
  Maple Tree: add new data structure
  radix tree test suite: add pr_err define
  radix tree test suite: add kmem_cache_set_non_kernel()
  radix tree test suite: add allocation counts and size to kmem_cache
  radix tree test suite: add support for slab bulk APIs
  radix tree test suite: add lockdep_is_held to header
  lib/test_maple_tree: add testing for maple tree
  mm: start tracking VMAs with maple tree
  mm/mmap: use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: use maple tree for unmapped_area{_topdown}
  kernel/fork: use maple tree for dup_mmap() during forking
  damon: Convert __damon_va_three_regions to use the VMA iterator
  mm: remove rb tree.
  mmap: change zeroing of maple tree in __vma_adjust()
  xen: use vma_lookup() in privcmd_ioctl_mmap()
  mm: optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: use maple tree operations for find_vma_intersection()
  mm/mmap: use advanced maple tree API for mmap_region()
  mm: remove vmacache
  mm: convert vma_lookup() to use mtree_load()
  mm/mmap: move mmap_region() below do_munmap()
  mm/mmap: reorganize munmap to use maple states
  mm/mmap: change do_brk_munmap() to use do_mas_align_munmap()
  arm64: Change elfcore for_each_mte_vma() to use VMA iterator
  fs/proc/base: use maple tree iterators in place of linked list
  userfaultfd: use maple tree iterator to iterate VMAs
  ipc/shm: use VMA iterator instead of linked list
  bpf: remove VMA linked list
  mm/gup: use maple tree navigation instead of linked list
  mm/madvise: use vma_find() instead of vma linked list
  mm/memcontrol: stop using mm->highest_vm_end
  mm/mempolicy: use vma iterator & maple state instead of vma linked
    list
  mm/mprotect: use maple tree navigation instead of vma linked list
  mm/mremap: use vma_find_intersection() instead of vma linked list
  mm/msync: use vma_find() instead of vma linked list
  mm/oom_kill: use maple tree iterators instead of vma linked list
  mm/swapfile: use vma iterator instead of vma linked list
  riscv: use vma iterator for vdso
  mm: remove the vma linked list
  mm/mmap: drop range_has_overlap() function
  mm/mmap.c: pass in mapping to __vma_link_file()

Matthew Wilcox (Oracle) (25):
  mm: add VMA iterator
  mmap: use the VMA iterator in count_vma_pages_range()
  proc: remove VMA rbtree use from nommu
  arm64: remove mmap linked list from vdso
  parisc: remove mmap linked list from cache handling
  powerpc: remove mmap linked list walks
  s390: remove vma linked list walks
  x86: remove vma linked list walks
  xtensa: remove vma linked list walks
  cxl: remove vma linked list walk
  optee: remove vma linked list walk
  um: remove vma linked list walk
  coredump: remove vma linked list walk
  exec: use VMA iterator instead of linked list
  fs/proc/task_mmu: stop using linked list and highest_vm_end
  acct: use VMA iterator instead of linked list
  perf: use VMA iterator
  sched: use maple tree iterator to walk VMAs
  fork: use VMA iterator
  mm/khugepaged: stop using vma linked list
  mm/ksm: use vma iterators instead of vma linked list
  mm/mlock: use vma iterator and maple state instead of vma linked list
  mm/pagewalk: use vma_find() instead of vma linked list
  i915: use the VMA iterator
  nommu: remove uses of VMA linked list

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple_tree.rst         |   218 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/elfcore.c                   |    16 +-
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/parisc/kernel/cache.c                    |     7 +-
 arch/powerpc/kernel/vdso.c                    |     6 +-
 arch/powerpc/mm/book3s32/tlb.c                |    11 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    13 +-
 arch/riscv/kernel/vdso.c                      |     3 +-
 arch/s390/kernel/vdso.c                       |     3 +-
 arch/s390/mm/gmap.c                           |     6 +-
 arch/um/kernel/tlb.c                          |    14 +-
 arch/x86/entry/vdso/vma.c                     |     9 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |    18 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |    14 +-
 drivers/misc/cxl/fault.c                      |    45 +-
 drivers/tee/optee/call.c                      |    18 +-
 drivers/xen/privcmd.c                         |     2 +-
 fs/coredump.c                                 |    34 +-
 fs/exec.c                                     |    12 +-
 fs/proc/base.c                                |     5 +-
 fs/proc/internal.h                            |     2 +-
 fs/proc/task_mmu.c                            |    74 +-
 fs/proc/task_nommu.c                          |    45 +-
 fs/userfaultfd.c                              |    55 +-
 include/linux/maple_tree.h                    |   685 +
 include/linux/mm.h                            |    74 +-
 include/linux/mm_types.h                      |    43 +-
 include/linux/mm_types_task.h                 |    12 -
 include/linux/sched.h                         |     1 -
 include/linux/userfaultfd_k.h                 |     7 +-
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    73 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    21 +-
 kernel/acct.c                                 |    11 +-
 kernel/bpf/task_iter.c                        |    10 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    57 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    17 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6965 +++
 lib/test_maple_tree.c                         | 37854 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr-test.h                         |    37 +-
 mm/damon/vaddr.c                              |    53 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     7 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |     8 +-
 mm/khugepaged.c                               |    13 +-
 mm/ksm.c                                      |    18 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    56 +-
 mm/mlock.c                                    |    35 +-
 mm/mmap.c                                     |  2129 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   135 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     4 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 tools/include/linux/slab.h                    |     4 +
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |     9 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/lockdep.h      |     2 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     3 +
 88 files changed, 47857 insertions(+), 1820 deletions(-)
 create mode 100644 Documentation/core-api/maple_tree.rst
 create mode 100644 include/linux/maple_tree.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 delete mode 100644 mm/vmacache.c
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

--=20
2.35.1
