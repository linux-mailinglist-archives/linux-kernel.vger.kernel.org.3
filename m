Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5D577376
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiGQCxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiGQCw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612DC24F19
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8rBE005795;
        Sun, 17 Jul 2022 02:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=My1u8L89oS8WI5S7QDBr4CIuX7QK6R5aLrjhMcWTzHM=;
 b=oDVILfoYZUBZ2KMeO/uBLAl7Sz1FwFLC4GI1UY47R9uo0rQ2/LtRrYQdUO1eOCyQtIbE
 tO9Bwnp8qEX72kTg1BHwnoTiGrLbK21OxpPKv/eFXez8yIocpVlX0IM5/VKUgkenkNp5
 f6O88qSaT3ZNHB3H62rtK06koLF2R3zG2ADlO71a+gobodml9Jc/hQZTC/SEVqFYtJaM
 2N6kOA3Q18mIz6O5idMxFTQ9EFlXJ3n6NuzZJcdbGIjHLv35uodoxjHjDgxkmE2s0vzK
 ePtEfY9Jq/lKX55v9QkGJXx3UiMs2lhFqsU4JgCU9RX0pZv9yPpQL8wdRyLBZ7hWjRQm zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMXgIj021817;
        Sun, 17 Jul 2022 02:48:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k1n7ky-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIw17IM0kEzGVnlPaQ4sBE4H4Xv8I1KArBZO0riPTT1yeCuDsYriRYEIwvhrkQ7bkf1a1cAPR58W2Wpm+M3PPv7vb7ucOZTuH9Z+Fg2910KQPaojSgcVdxqVAFmOo4kONWc2kyT4Kv/McHMnGBB94/7rB0fDuFXUjQaBWmEp/AGtJjSyMnJSqrfkAOsGcRE55bSwIB4hRYr/Gwybk7yZmm2vJaolrrS8LXfbiUYysP7f1VjRV4y31IVOxd9evfxGIqHhqiLgV5NGck+WxJoJbzWXD9RNP0crzmw5fk+KUU3GKEYfFP5S7yxZ3FtGBw9Nr0dCFT5T7iX9JZCT6m8ipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My1u8L89oS8WI5S7QDBr4CIuX7QK6R5aLrjhMcWTzHM=;
 b=GupdKz/2sEaUHOJEXHyfd/5CAsdUdtWwGqeiwsnOy/0O4zUdsfStdLAmgxSqIzGRDCQ74phN4BjU5FZKxIpsZfDrqBxyUrgOGGMWGPcP1o3SfmnGQfT9E5JCV8hEN9WAgrY+anfm059GLthgz3lGY/zXgr1Jbg/+qcWKMsihDPIGZK7edyerflSntHLlk0LvQN9FTIz0VbSTBpJnuegHQmVGSmTh4lWQVfW3XjYyTnVzw2sC7377l/juQ9heRtdJp7JFEKff05zWevtSRnCCX9dorg03z8n/MN59pI46bmoVsSZXbMY+HCk67fNzYMzwtQ9SGdMmJ+yOh8NCPRHu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My1u8L89oS8WI5S7QDBr4CIuX7QK6R5aLrjhMcWTzHM=;
 b=ZhzKIugoSLSAELSx67lqjbWh+LA2XZRwlFWttNNmVanMafX5PnIHGITROJw9pNy8Nn0xlZYl/2629TbybiRzMGcwqWWg/WMItXEPhLMc48MbdG/kuLLMsD+PZD8fTvQIGg/+gENf1fg55RAeL02edB+xziCIq1ipYba/llxlezk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:48:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:48:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 67/69] mm: remove the vma linked list
Thread-Topic: [PATCH v11 67/69] mm: remove the vma linked list
Thread-Index: AQHYmYd8wRZ6YsOYG0isEOPVqBKU+g==
Date:   Sun, 17 Jul 2022 02:46:58 +0000
Message-ID: <20220717024615.2106835-68-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebc5a849-2d6f-4438-d961-08da679ec6d9
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqE+dyg99q2FVDETUurZie9xYiVhkgUyz4a0va0jFgRRFOVfd4QZeXIkbumTnfuP1ZZlzvuaeQD6If82GlKNnJ64XB8JZ7Wp30txjN9n3KXwsjlMI2i4KDGjiumpDO54TQYO3m99qDRgG8+iugTVM6VD2+ferbAlc6RM1JxUMeC/KG+tTXLz3BSK2D7v/ni61WhCxmSs1DUEUhsJsl/cOjjlRZVsj4RmLK3LlRpa5g+RB40RBayoFji3bHgychlfwp0CCckbzAzHOA8vaBZ7J0EDwSTQxr8D166WfSCXfcaJzsz9NYqoKNDlYHesgb7DZPZCYkzi7Yv4XLBQCyW7vfsRn1LjloOKWTjc53kvRzJrBq2Vtb2PRR4V4zRP8apr0orPSB6RZN3z5wnxsf5R+9MPxRVJbR1WPHpD1Dg9x0AFe/fIX5H6C0sZqgiqO9yuCeeyElfYJW83qEKXBIP9iEENWGxzZacV+hM5DXNo9HIooB7/fswzlg5ixce8I/seJQh0anqggeapqBQQxcI6G49WxA2fGBqAyub8ohtkqRG2Cgm2qr2hBTiMmdqRM7NxafYHpNY8A2o0UyrdJ53ELgsQwzyFNiiws3i+jTUEar5K4+AIUZcg1quhIctw35M1wEnG1XF+lzjYYos4ID60SaoLve1j290S8rcrsCQWt0gpVIVUvqUAXvb18dLglbgVfw/KB5HbpAi40OYmB2p3h8whEmo7hk6XjRhTUqmEp0Jrp/EijskF/8lZo03w9GEHFp2OkrIL7Kq0teq0/JWEDiwnrVe+ekX69snjdrw/RjeTBTpbpVqaSACOMwK6/SgW2sT6GuhyOJQLRmWKUR5s0sQpZV9m0jCfnMRAWVzQ3w4WIMGkIym8f+UsOJHENdep
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(30864003)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Yd0w5kWIf3N0Vn6gGrNHkPbqLAIQS4disuzaqg/BmVDKw3IvYPv0zv6BEc?=
 =?iso-8859-1?Q?PTPSlC1x5sxb2UFEhb4bc95yn8hWzAasFzZXeqq+nLE9xCrI9gf+FCPVox?=
 =?iso-8859-1?Q?+j+1SLjlI6xfGit3SR4tTN49DI6NQaXyEqzT8qHnr1qBFdxj7AzCMoxn62?=
 =?iso-8859-1?Q?tJNK4n8XkhXK4AIhOj07oIJ4Sv5TKtaHwsbfOC4wuqusX0S23lC1dYa2Ny?=
 =?iso-8859-1?Q?/7D/TOULJsvithAhL3a1KL0eE6isY9sVrg3UPkSRkSmbsJ8oLauZ04nIS2?=
 =?iso-8859-1?Q?8l/CK7wBUcBXTkS/yaHcTKkGRpn1z9h4QmGrkOEfF3O5HHCaKVSrX9Pi1r?=
 =?iso-8859-1?Q?IXxqU2YxdGQs1ZgMdpADltxFB7vwCTcMxFZlBtvW3m5b+5JURjY9MWh8RA?=
 =?iso-8859-1?Q?9edZMSg3tkhQqDXT6JIigTm2KLoAQ9VJdlNPSr0VTxXfJ0IZih13U/K8MF?=
 =?iso-8859-1?Q?9XbQAZ7mVYUMOZnlnavPbWf7cEXuDhCcMoTt6UZ/ZhsraTXFf+FN14zPQE?=
 =?iso-8859-1?Q?c0V8D0HyoLJKgWDbcFbPRARgLiIJ1kMKX/7X0VHYHW9gB3NkAK55jOT4lI?=
 =?iso-8859-1?Q?7dZ+5zoMeuoP/GQoxCPJTuBwO2XXE2gEzxxwPVhKG7qU1g0E8lK0xTkc1F?=
 =?iso-8859-1?Q?Ebm8c9IdCkj88WgJrqIBGKshE3g8usSu3apqOWlgAoBLC6ygWYBX0uao12?=
 =?iso-8859-1?Q?8l7qr5FQG/gqCf6Ay3eHvsDu8vPoaaFlu+l+3paBn6QgXkvupV1/bSDnA8?=
 =?iso-8859-1?Q?G/ZjhblHOaY6DE62dStiy/FrTAOEdDaOC2Ot53fc6O4fzT1hBgAy+rgwds?=
 =?iso-8859-1?Q?YA1TkIN70oWu1fiSe7uI//WSY2MEPPweTvvJVHraLb8tMKKYzGzmLnk0T7?=
 =?iso-8859-1?Q?u6Up4lS27HIZj9R2ysBYIZYhEp0bxEzBPa8/YpAhAYoccacdCcQyleYPX4?=
 =?iso-8859-1?Q?jetGYeVtHYgbXYreHAnqUBvoAkdFvhqic4L1izz0RO9b9aoSWLHFe+Q6Ha?=
 =?iso-8859-1?Q?DKJl26U2+NuxzkfU0zii7MdMj4jZaFrHBuGkIFEE293Hb5fRKY9NhGBQGV?=
 =?iso-8859-1?Q?EibAMLtmi8dV3obASR2mVASumxMoiMw+kcV3rNIZf6Qw9QAbT3BWIuWTsd?=
 =?iso-8859-1?Q?cvY5rcWNhcpn2ruvy+ewBJoAPEbEAUSdsMU1r3g1pmzJr/uMRNmHoAYgno?=
 =?iso-8859-1?Q?BzcvrcBRyOKEQwYmZqFJs4iW8/ZiCFi9FnoRkpcl4TusanOkuRKD7A3iDO?=
 =?iso-8859-1?Q?ifG++KoxlMsVljtckylLbVAYSUsvXbIGcNCinjhZknUGBYjDYuw1UMu4NY?=
 =?iso-8859-1?Q?0VvcSuKVezFWp13N1QyIspSwWdEqZ61RbIGyBlPxll0Ev6GXns1Q14p5ob?=
 =?iso-8859-1?Q?FcUg+B+9fr/YGry99MYdK1tAEltZULdVokeKai2Oam1tMpwwiPOUe0EdvL?=
 =?iso-8859-1?Q?+FydNRYELwn/sDfAAVsBLBZkzTl+WdSXs8aqiZ8OceGyOLJeaIZ9ryJt1u?=
 =?iso-8859-1?Q?ODlv97xr/YwYNhF4i6Ce+CSDc39yTBiagTUcd1pqquESKrzLdAVz6I+HG3?=
 =?iso-8859-1?Q?XZN0vtqlrmOjkS+PiveZvTQCLmGKUYBJf85dFSDhIYY+uQ2UDIqPBYd/3w?=
 =?iso-8859-1?Q?J8ZEIoHYeLVjF1TdeI4FvKHMRRPVr2S+FJRAgKLGqOjEENZy5CfLQwcA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc5a849-2d6f-4438-d961-08da679ec6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:58.9113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsAHWLl1PKW0mOOvJPI3Xcia0Db0ohJA35f7hvH9FNZJgiYkCydryO1y+KP3ldmLyUBFAwEly+SsUwzKpjEDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-ORIG-GUID: 5Nev6ETzmocYW_i2wDOh7MPLqclDNy-K
X-Proofpoint-GUID: 5Nev6ETzmocYW_i2wDOh7MPLqclDNy-K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Replace any vm_next use with vma_find().

Update free_pgtables(), unmap_vmas(), and zap_page_range() to use the
maple tree.

Use the new free_pgtables() and unmap_vmas() in do_mas_align_munmap().  At
the same time, alter the loop to be more compact.

Now that free_pgtables() and unmap_vmas() take a maple tree as an
argument, rearrange do_mas_align_munmap() to use the new tree to hold the
vmas to remove.

Remove __vma_link_list() and __vma_unlink_list() as they are exclusively
used to update the linked list.

Drop linked list update from __insert_vm_struct().

Rework validation of tree as it was depending on the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-52-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220513141548.2019143-1-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-68-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Hulk Robot <hulkci@huawei.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h       |   5 +-
 include/linux/mm_types.h |   4 -
 kernel/fork.c            |  19 +-
 mm/debug.c               |  14 +-
 mm/internal.h            |   8 +-
 mm/memory.c              |  33 ++-
 mm/mmap.c                | 478 ++++++++++++++++-----------------------
 mm/nommu.c               |   6 -
 mm/util.c                |  40 ----
 9 files changed, 229 insertions(+), 378 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 75ac5664af69..7f2d3ec50718 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1874,8 +1874,9 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigne=
d long address,
 		  unsigned long size);
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
-void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long start, unsigned long end);
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+		struct vm_area_struct *start_vma, unsigned long start,
+		unsigned long end);
=20
 struct mmu_notifier_range;
=20
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c7580a191449..98cfa4183a28 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -403,8 +403,6 @@ struct vm_area_struct {
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
=20
-	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
=20
 	/*
@@ -468,7 +466,6 @@ struct vm_area_struct {
 struct kioctx_table;
 struct mm_struct {
 	struct {
-		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -483,7 +480,6 @@ struct mm_struct {
 		unsigned long mmap_compat_legacy_base;
 #endif
 		unsigned long task_size;	/* size of task vm space */
-		unsigned long highest_vm_end;	/* highest vma end address */
 		pgd_t * pgd;
=20
 #ifdef CONFIG_MEMBARRIER
diff --git a/kernel/fork.c b/kernel/fork.c
index 4b7b0b7dd446..2d7ce88da540 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,7 +474,6 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struc=
t *orig)
 		 */
 		*new =3D data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
-		new->vm_next =3D new->vm_prev =3D NULL;
 		dup_anon_vma_name(orig, new);
 	}
 	return new;
@@ -579,7 +578,7 @@ static void dup_mm_exe_file(struct mm_struct *mm, struc=
t mm_struct *oldmm)
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
 {
-	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
+	struct vm_area_struct *mpnt, *tmp;
 	int retval;
 	unsigned long charge =3D 0;
 	LIST_HEAD(uf);
@@ -606,18 +605,11 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 	mm->exec_vm =3D oldmm->exec_vm;
 	mm->stack_vm =3D oldmm->stack_vm;
=20
-	pprev =3D &mm->mmap;
 	retval =3D ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
 	khugepaged_fork(mm, oldmm);
=20
-	retval =3D mas_expected_entries(&mas, oldmm->map_count);
-	if (retval)
-		goto out;
-
-	prev =3D NULL;
-
 	retval =3D mas_expected_entries(&mas, oldmm->map_count);
 	if (retval)
 		goto out;
@@ -689,14 +681,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		if (is_vm_hugetlb_page(tmp))
 			reset_vma_resv_huge_pages(tmp);
=20
-		/*
-		 * Link in the new vma and copy the page table entries.
-		 */
-		*pprev =3D tmp;
-		pprev =3D &tmp->vm_next;
-		tmp->vm_prev =3D prev;
-		prev =3D tmp;
-
 		/* Link the vma into the MT */
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
@@ -1119,7 +1103,6 @@ static void mm_init_uprobes_state(struct mm_struct *m=
m)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct =
*p,
 	struct user_namespace *user_ns)
 {
-	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	atomic_set(&mm->mm_users, 1);
diff --git a/mm/debug.c b/mm/debug.c
index 2d625ca0e326..0fd15ba70d16 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -139,13 +139,11 @@ EXPORT_SYMBOL(dump_page);
=20
 void dump_vma(const struct vm_area_struct *vma)
 {
-	pr_emerg("vma %px start %px end %px\n"
-		"next %px prev %px mm %px\n"
+	pr_emerg("vma %px start %px end %px mm %px\n"
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
 		"flags: %#lx(%pGv)\n",
-		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
-		vma->vm_prev, vma->vm_mm,
+		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
 		vma->vm_file, vma->vm_private_data,
@@ -155,11 +153,11 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px task_size %lu\n"
+	pr_emerg("mm %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
-		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
+		"mmap_base %lu mmap_legacy_base %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
@@ -183,11 +181,11 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, mm->task_size,
+		mm, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
-		mm->mmap_base, mm->mmap_legacy_base, mm->highest_vm_end,
+		mm->mmap_base, mm->mmap_legacy_base,
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
diff --git a/mm/internal.h b/mm/internal.h
index 7cf12a15475b..eba79d1d3b06 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -84,8 +84,9 @@ void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
 void deactivate_file_folio(struct folio *folio);
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vm=
a,
-		unsigned long floor, unsigned long ceiling);
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *start_vma, unsigned long floor,
+		   unsigned long ceiling);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
=20
 struct zap_details;
@@ -479,9 +480,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
 }
=20
 /* mm/util.c */
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev);
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
 struct anon_vma *folio_anon_vma(struct folio *folio);
=20
 #ifdef CONFIG_MMU
diff --git a/mm/memory.c b/mm/memory.c
index ed45dbf9c31e..fdfc119f181d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -402,12 +402,21 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr =3D next, addr !=3D end);
 }
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long floor, unsigned long ceiling)
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *vma, unsigned long floor,
+		   unsigned long ceiling)
 {
-	while (vma) {
-		struct vm_area_struct *next =3D vma->vm_next;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
+
+	do {
 		unsigned long addr =3D vma->vm_start;
+		struct vm_area_struct *next;
+
+		/*
+		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
+		 * be 0.  This will underflow and is okay.
+		 */
+		next =3D mas_find(&mas, ceiling - 1);
=20
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -426,7 +435,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma =3D next;
-				next =3D vma->vm_next;
+				next =3D mas_find(&mas, ceiling - 1);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
@@ -434,7 +443,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 				floor, next ? next->vm_start : ceiling);
 		}
 		vma =3D next;
-	}
+	} while (vma);
 }
=20
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
@@ -1705,7 +1714,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-void unmap_vmas(struct mmu_gather *tlb,
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr)
 {
@@ -1715,12 +1724,14 @@ void unmap_vmas(struct mmu_gather *tlb,
 		/* Careful - we need to zap private pages too! */
 		.even_cows =3D true,
 	};
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
=20
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < end_addr; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
+	} while ((vma =3D mas_find(&mas, end_addr - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
=20
@@ -1735,8 +1746,11 @@ void unmap_vmas(struct mmu_gather *tlb,
 void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 		unsigned long size)
 {
+	struct maple_tree *mt =3D &vma->vm_mm->mm_mt;
+	unsigned long end =3D start + size;
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
=20
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
@@ -1744,8 +1758,9 @@ void zap_page_range(struct vm_area_struct *vma, unsig=
ned long start,
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < range.end; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+	} while ((vma =3D mas_find(&mas, end - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 60c0c45ab186..b494c7e3dcb0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -75,9 +75,10 @@ int mmap_rnd_compat_bits __read_mostly =3D CONFIG_ARCH_M=
MAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
=20
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end);
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end);
=20
 /* description of effects of mapping type and prot in current implementati=
on.
  * this is due to the limited x86 page protection hardware.  The expected
@@ -177,12 +178,10 @@ void unlink_file_vma(struct vm_area_struct *vma)
 }
=20
 /*
- * Close a vm structure and free it, returning the next.
+ * Close a vm structure and free it.
  */
-static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+static void remove_vma(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *next =3D vma->vm_next;
-
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
@@ -190,7 +189,6 @@ static struct vm_area_struct *remove_vma(struct vm_area=
_struct *vma)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
-	return next;
 }
=20
 /*
@@ -215,8 +213,7 @@ static int do_brk_munmap(struct ma_state *mas, struct v=
m_area_struct *vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
 static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
-			unsigned long addr, unsigned long request,
-			unsigned long flags);
+		unsigned long addr, unsigned long request, unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
@@ -285,7 +282,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		mas.last =3D oldbrk - 1;
 		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
 		if (ret =3D=3D 1)  {
 			downgraded =3D true;
@@ -340,44 +336,21 @@ extern void mt_dump(const struct maple_tree *mt);
 static void validate_mm_mt(struct mm_struct *mm)
 {
 	struct maple_tree *mt =3D &mm->mm_mt;
-	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+	struct vm_area_struct *vma_mt;
=20
 	MA_STATE(mas, mt, 0, 0);
=20
 	mt_validate(&mm->mm_mt);
 	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if (xa_is_zero(vma_mt))
-			continue;
-
-		if (!vma)
-			break;
-
-		if ((vma !=3D vma_mt) ||
-		    (vma->vm_start !=3D vma_mt->vm_start) ||
-		    (vma->vm_end !=3D vma_mt->vm_end) ||
-		    (vma->vm_start !=3D mas.index) ||
-		    (vma->vm_end - 1 !=3D mas.last)) {
+		if ((vma_mt->vm_start !=3D mas.index) ||
+		    (vma_mt->vm_end - 1 !=3D mas.last)) {
 			pr_emerg("issue in %s\n", current->comm);
 			dump_stack();
 			dump_vma(vma_mt);
-			pr_emerg("and vm_next\n");
-			dump_vma(vma->vm_next);
 			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
 			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
-			if (vma->vm_prev) {
-				pr_emerg("ll prev: %p %lu - %lu\n",
-					 vma->vm_prev, vma->vm_prev->vm_start,
-					 vma->vm_prev->vm_end);
-			}
-			pr_emerg("ll vma: %p %lu - %lu\n", vma,
-				 vma->vm_start, vma->vm_end);
-			if (vma->vm_next) {
-				pr_emerg("ll next: %p %lu - %lu\n",
-					 vma->vm_next, vma->vm_next->vm_start,
-					 vma->vm_next->vm_end);
-			}
=20
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end !=3D mas.last + 1) {
@@ -394,23 +367,19 @@ static void validate_mm_mt(struct mm_struct *mm)
 			}
 			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
 		}
-		VM_BUG_ON(vma !=3D vma_mt);
-		vma =3D vma->vm_next;
-
 	}
-	VM_BUG_ON(vma);
 }
=20
 static void validate_mm(struct mm_struct *mm)
 {
 	int bug =3D 0;
 	int i =3D 0;
-	unsigned long highest_address =3D 0;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	validate_mm_mt(mm);
=20
-	while (vma) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
@@ -422,18 +391,10 @@ static void validate_mm(struct mm_struct *mm)
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
-
-		highest_address =3D vm_end_gap(vma);
-		vma =3D vma->vm_next;
 		i++;
 	}
 	if (i !=3D mm->map_count) {
-		pr_emerg("map_count %d vm_next %d\n", mm->map_count, i);
-		bug =3D 1;
-	}
-	if (highest_address !=3D mm->highest_vm_end) {
-		pr_emerg("mm->highest_vm_end %lx, found %lx\n",
-			  mm->highest_vm_end, highest_address);
+		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
 		bug =3D 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
@@ -493,29 +454,13 @@ bool range_has_overlap(struct mm_struct *mm, unsigned=
 long start,
 	struct vm_area_struct *existing;
=20
 	MA_STATE(mas, &mm->mm_mt, start, start);
+	rcu_read_lock();
 	existing =3D mas_find(&mas, end - 1);
 	*pprev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	return existing ? true : false;
 }
=20
-/*
- * __vma_next() - Get the next VMA.
- * @mm: The mm_struct.
- * @vma: The current vma.
- *
- * If @vma is NULL, return the first vma in the mm.
- *
- * Returns: The next VMA after @vma.
- */
-static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
-					 struct vm_area_struct *vma)
-{
-	if (!vma)
-		return mm->mmap;
-
-	return vma->vm_next;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -600,8 +545,7 @@ static inline void vma_mas_szero(struct ma_state *mas, =
unsigned long start,
 	mas_store_prealloc(mas, NULL);
 }
=20
-static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev)
+static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping =3D NULL;
@@ -615,7 +559,6 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma,
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -626,22 +569,6 @@ static int vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 	return 0;
 }
=20
-/*
- * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
- * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
- */
-static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, unsigned long location)
-{
-	struct vm_area_struct *prev;
-
-	mas_set(mas, location);
-	prev =3D mas_prev(mas, 0);
-	vma_mas_store(vma, mas);
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
-}
-
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -724,15 +651,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_=
area_struct *vma,
 	}
=20
 	/* Expanding over the next vma */
-	if (remove_next) {
-		/* Remove from mm linked list - also updates highest_vm_end */
-		__vma_unlink_list(mm, next);
-
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
-
-	} else if (!next) {
-		mm->highest_vm_end =3D vm_end_gap(vma);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	}
=20
 	if (anon_vma) {
@@ -789,7 +709,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
-	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -824,7 +743,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 					next_next =3D find_vma(mm, next->vm_end);
=20
 				VM_WARN_ON(remove_next =3D=3D 2 &&
-					   end !=3D next->vm_next->vm_end);
+					   end !=3D next_next->vm_end);
 			}
=20
 			exporter =3D next;
@@ -835,7 +754,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 			 * next, if the vma overlaps with it.
 			 */
 			if (remove_next =3D=3D 2 && !next->anon_vma)
-				exporter =3D next->vm_next;
+				exporter =3D next_next;
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -933,17 +852,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start !=3D end)) {
 				vma_mas_szero(&mas, end, vma->vm_end);
+				mas_reset(&mas);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
-			} else if (insert->vm_start =3D=3D end) {
-				ll_prev =3D vma->vm_end;
 			}
 		} else {
 			vma_changed =3D true;
 		}
 		vma->vm_end =3D end;
-		if (!next)
-			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
 	if (vma_changed)
@@ -963,29 +879,19 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		flush_dcache_mmap_unlock(mapping);
 	}
=20
-	if (remove_next) {
-		/*
-		 * vma_merge has merged next into vma, and needs
-		 * us to remove next before dropping the locks.
-		 * Since we have expanded over this vma, the maple tree will
-		 * have overwritten by storing the value
-		 */
-		__vma_unlink_list(mm, next);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 		if (remove_next =3D=3D 2)
-			__vma_unlink_list(mm, next_next);
-
-		if (file) {
-			__remove_shared_vm_struct(next, file, mapping);
-			if (remove_next =3D=3D 2)
-				__remove_shared_vm_struct(next_next, file, mapping);
-		}
+			__remove_shared_vm_struct(next_next, file, mapping);
 	} else if (insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, &mas, insert, ll_prev);
+		mas_reset(&mas);
+		vma_mas_store(insert, &mas);
+		mm->map_count++;
 	}
=20
 	if (anon_vma) {
@@ -1019,54 +925,12 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
=20
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove another next too. It would clutter
-		 * up the code too much to do both in one go.
+		 * we must remove next_next too.
 		 */
-		if (remove_next !=3D 3) {
-			/*
-			 * If "next" was removed and vma->vm_end was
-			 * expanded (up) over it, in turn
-			 * "next->vm_prev->vm_end" changed and the
-			 * "vma->vm_next" gap must be updated.
-			 */
-			next =3D next_next;
-		} else {
-			/*
-			 * For the scope of the comment "next" and
-			 * "vma" considered pre-swap(): if "vma" was
-			 * removed, next->vm_start was expanded (down)
-			 * over it and the "next" gap must be updated.
-			 * Because of the swap() the post-swap() "vma"
-			 * actually points to pre-swap() "next"
-			 * (post-swap() "next" as opposed is now a
-			 * dangling pointer).
-			 */
-			next =3D vma;
-		}
 		if (remove_next =3D=3D 2) {
 			remove_next =3D 1;
+			next =3D next_next;
 			goto again;
-		} else if (!next) {
-			/*
-			 * If remove_next =3D=3D 2 we obviously can't
-			 * reach this path.
-			 *
-			 * If remove_next =3D=3D 3 we can't reach this
-			 * path because pre-swap() next is always not
-			 * NULL. pre-swap() "next" is not being
-			 * removed and its next->vm_end is not altered
-			 * (and furthermore "end" already matches
-			 * next->vm_end in remove_next =3D=3D 3).
-			 *
-			 * We reach this only in the remove_next =3D=3D 1
-			 * case if the "next" vma that was removed was
-			 * the highest vma of the mm. However in such
-			 * case next->vm_end =3D=3D "end" and the extended
-			 * "vma" has vma->vm_end =3D=3D next->vm_end so
-			 * mm->highest_vm_end doesn't need any update
-			 * in remove_next =3D=3D 1 case.
-			 */
-			VM_WARN_ON(mm->highest_vm_end !=3D vm_end_gap(vma));
 		}
 	}
 	if (insert && file)
@@ -1074,6 +938,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
=20
 	mas_destroy(&mas);
 	validate_mm(mm);
+
 	return 0;
 }
=20
@@ -1233,10 +1098,10 @@ struct vm_area_struct *vma_merge(struct mm_struct *=
mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D __vma_next(mm, prev);
+	next =3D find_vma(mm, prev ? prev->vm_end : 0);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
-		next =3D next->vm_next;
+		next =3D find_vma(mm, next->vm_end);
=20
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <=3D prev->vm_start);
@@ -1370,18 +1235,24 @@ static struct anon_vma *reusable_anon_vma(struct vm=
_area_struct *old, struct vm_
  */
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_end, vma->vm_end);
 	struct anon_vma *anon_vma =3D NULL;
+	struct vm_area_struct *prev, *next;
=20
 	/* Try next first. */
-	if (vma->vm_next) {
-		anon_vma =3D reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
+	next =3D mas_walk(&mas);
+	if (next) {
+		anon_vma =3D reusable_anon_vma(next, vma, next);
 		if (anon_vma)
 			return anon_vma;
 	}
=20
+	prev =3D mas_prev(&mas, 0);
+	VM_BUG_ON_VMA(prev !=3D vma, vma);
+	prev =3D mas_prev(&mas, 0);
 	/* Try prev next. */
-	if (vma->vm_prev)
-		anon_vma =3D reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
+	if (prev)
+		anon_vma =3D reusable_anon_vma(prev, prev, vma);
=20
 	/*
 	 * We might reach here with anon_vma =3D=3D NULL if we can't find
@@ -2153,8 +2024,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	if (gap_addr < address || gap_addr > TASK_SIZE)
 		gap_addr =3D TASK_SIZE;
=20
-	next =3D vma->vm_next;
-	if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
+	next =3D find_vma_intersection(mm, vma->vm_end, gap_addr);
+	if (next && vma_is_accessible(next)) {
 		if (!(next->vm_flags & VM_GROWSUP))
 			return -ENOMEM;
 		/* Check that both stack segments have the same anon_vma? */
@@ -2205,8 +2076,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				/* Overwrite old entry in mtree. */
 				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (!vma->vm_next)
-					mm->highest_vm_end =3D vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
=20
 				perf_event_mmap(vma);
@@ -2226,16 +2095,16 @@ int expand_upwards(struct vm_area_struct *vma, unsi=
gned long address)
 int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
 	struct vm_area_struct *prev;
 	int error =3D 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
=20
 	/* Enforce stack_guard_gap */
-	prev =3D vma->vm_prev;
+	prev =3D mas_prev(&mas, 0);
 	/* Check that both stack segments have the same anon_vma? */
 	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
 			vma_is_accessible(prev)) {
@@ -2371,25 +2240,26 @@ find_extend_vma(struct mm_struct *mm, unsigned long=
 addr)
 EXPORT_SYMBOL_GPL(find_extend_vma);
=20
 /*
- * Ok - we have the memory areas we should free on the vma list,
- * so release them, and do the vma updates.
+ * Ok - we have the memory areas we should free on a maple tree so release=
 them,
+ * and do the vma updates.
  *
  * Called with the mm semaphore held.
  */
-static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *v=
ma)
+static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 {
 	unsigned long nr_accounted =3D 0;
+	struct vm_area_struct *vma;
=20
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
-	do {
+	mas_for_each(mas, vma, ULONG_MAX) {
 		long nrpages =3D vma_pages(vma);
=20
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D nrpages;
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		vma =3D remove_vma(vma);
-	} while (vma);
+		remove_vma(vma);
+	}
 	vm_unacct_memory(nr_accounted);
 	validate_mm(mm);
 }
@@ -2399,18 +2269,18 @@ static void remove_vma_list(struct mm_struct *mm, s=
truct vm_area_struct *vma)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
+		struct vm_area_struct *next,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, vma, start, end);
-	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
+	unmap_vmas(&tlb, mt, vma, start, end);
+	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 }
@@ -2494,24 +2364,17 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline int
-unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
-	     unsigned long limit)
+static inline int munmap_sidetree(struct vm_area_struct *vma,
+				   struct ma_state *mas_detach)
 {
-	struct mm_struct *mm =3D start->vm_mm;
-	struct vm_area_struct *tmp =3D start;
-	int count =3D 0;
-
-	while (tmp && tmp->vm_start < limit) {
-		*tail =3D tmp;
-		count++;
-		if (tmp->vm_flags & VM_LOCKED)
-			mm->locked_vm -=3D vma_pages(tmp);
+	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
+	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
+		return -ENOMEM;
=20
-		tmp =3D tmp->vm_next;
-	}
+	if (vma->vm_flags & VM_LOCKED)
+		vma->vm_mm->locked_vm -=3D vma_pages(vma);
=20
-	return count;
+	return 0;
 }
=20
 /*
@@ -2531,9 +2394,13 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_=
area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool downgrade)
 {
-	struct vm_area_struct *prev, *last;
+	struct vm_area_struct *prev, *next =3D NULL;
+	struct maple_tree mt_detach;
+	int count =3D 0;
 	int error =3D -ENOMEM;
-	/* we have start < vma->vm_end  */
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
+	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
 	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		return -ENOMEM;
@@ -2546,6 +2413,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	 * unmapped vm_area_struct will remain in use: so lower split_vma
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
+
+	/* Does it split the first one? */
 	if (start > vma->vm_start) {
=20
 		/*
@@ -2556,35 +2425,60 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
+		/*
+		 * mas_pause() is not needed since mas->index needs to be set
+		 * differently than vma->vm_end anyways.
+		 */
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
-			goto split_failed;
+			goto start_split_failed;
=20
-		prev =3D vma;
-		vma =3D __vma_next(mm, prev);
-		mas->index =3D start;
-		mas_reset(mas);
-	} else {
-		prev =3D vma->vm_prev;
+		mas_set(mas, start);
+		vma =3D mas_walk(mas);
 	}
=20
-	if (vma->vm_end >=3D end)
-		last =3D vma;
-	else
-		last =3D find_vma_intersection(mm, end - 1, end);
+	prev =3D mas_prev(mas, 0);
+	if (unlikely((!prev)))
+		mas_set(mas, start);
+
+	/*
+	 * Detach a range of VMAs from the mm. Using next as a temp variable as
+	 * it is always overwritten.
+	 */
+	mas_for_each(mas, next, end - 1) {
+		/* Does it split the end? */
+		if (next->vm_end > end) {
+			struct vm_area_struct *split;
=20
-	/* Does it split the last one? */
-	if (last && end < last->vm_end) {
-		error =3D __split_vma(mm, last, end, 1);
+			error =3D __split_vma(mm, next, end, 1);
+			if (error)
+				goto end_split_failed;
+
+			mas_set(mas, end);
+			split =3D mas_prev(mas, 0);
+			error =3D munmap_sidetree(split, &mas_detach);
+			if (error)
+				goto munmap_sidetree_failed;
=20
+			count++;
+			if (vma =3D=3D next)
+				vma =3D split;
+			break;
+		}
+		error =3D munmap_sidetree(next, &mas_detach);
 		if (error)
-			goto split_failed;
+			goto munmap_sidetree_failed;
=20
-		if (vma =3D=3D last)
-			vma =3D __vma_next(mm, prev);
-		mas_reset(mas);
+		count++;
+#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+		BUG_ON(next->vm_start < start);
+		BUG_ON(next->vm_start > end);
+#endif
 	}
=20
+	if (!next)
+		next =3D mas_next(mas, ULONG_MAX);
+
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2601,35 +2495,36 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 			goto userfaultfd_error;
 	}
=20
-	/*
-	 * unlock any mlock()ed ranges before detaching vmas, count the number
-	 * of VMAs to be dropped, and return the tail entry of the affected
-	 * area.
-	 */
-	mm->map_count -=3D unlock_range(vma, &last, end);
-	/* Drop removed area from the tree */
+	/* Point of no return */
+	mas_set_range(mas, start, end - 1);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	/* Make sure no VMAs are about to be lost. */
+	{
+		MA_STATE(test, &mt_detach, start, end - 1);
+		struct vm_area_struct *vma_mas, *vma_test;
+		int test_count =3D 0;
+
+		rcu_read_lock();
+		vma_test =3D mas_find(&test, end - 1);
+		mas_for_each(mas, vma_mas, end - 1) {
+			BUG_ON(vma_mas !=3D vma_test);
+			test_count++;
+			vma_test =3D mas_next(&test, end - 1);
+		}
+		rcu_read_unlock();
+		BUG_ON(count !=3D test_count);
+		mas_set_range(mas, start, end - 1);
+	}
+#endif
 	mas_store_prealloc(mas, NULL);
-
-	/* Detach vmas from the MM linked list */
-	vma->vm_prev =3D NULL;
-	if (prev)
-		prev->vm_next =3D last->vm_next;
-	else
-		mm->mmap =3D last->vm_next;
-
-	if (last->vm_next) {
-		last->vm_next->vm_prev =3D prev;
-		last->vm_next =3D NULL;
-	} else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-
+	mm->map_count -=3D count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
 	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
 	 */
 	if (downgrade) {
-		if (last && (last->vm_flags & VM_GROWSDOWN))
+		if (next && (next->vm_flags & VM_GROWSDOWN))
 			downgrade =3D false;
 		else if (prev && (prev->vm_flags & VM_GROWSUP))
 			downgrade =3D false;
@@ -2637,18 +2532,22 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 			mmap_write_downgrade(mm);
 	}
=20
-	unmap_region(mm, vma, prev, start, end);
-
-	/* Fix up all other VM information */
-	remove_vma_list(mm, vma);
+	unmap_region(mm, &mt_detach, vma, prev, next, start, end);
+	/* Statistics and freeing VMAs */
+	mas_set(&mas_detach, start);
+	remove_mt(mm, &mas_detach);
+	__mt_destroy(&mt_detach);
=20
=20
 	validate_mm(mm);
 	return downgrade ? 1 : 0;
=20
-map_count_exceeded:
-split_failed:
 userfaultfd_error:
+munmap_sidetree_failed:
+end_split_failed:
+	__mt_destroy(&mt_detach);
+start_split_failed:
+map_count_exceeded:
 	mas_destroy(mas);
 	return error;
 }
@@ -2883,7 +2782,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		i_mmap_lock_write(vma->vm_file->f_mapping);
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 	if (vma->vm_file) {
 		if (vma->vm_flags & VM_SHARED)
@@ -2941,7 +2839,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_file =3D NULL;
=20
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
 	charged =3D 0;
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
@@ -3030,11 +2928,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 		goto out;
=20
 	if (start + size > vma->vm_end) {
-		struct vm_area_struct *next;
+		VMA_ITERATOR(vmi, mm, vma->vm_end);
+		struct vm_area_struct *next, *prev =3D vma;
=20
-		for (next =3D vma->vm_next; next; next =3D next->vm_next) {
+		for_each_vma_range(vmi, next, start + size) {
 			/* hole between vmas ? */
-			if (next->vm_start !=3D next->vm_prev->vm_end)
+			if (next->vm_start !=3D prev->vm_end)
 				goto out;
=20
 			if (next->vm_file !=3D vma->vm_file)
@@ -3043,8 +2942,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
 			if (next->vm_flags !=3D vma->vm_flags)
 				goto out;
=20
-			if (start + size <=3D next->vm_end)
-				break;
+			prev =3D next;
 		}
=20
 		if (!next)
@@ -3090,7 +2988,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 			 struct list_head *uf)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct unmap;
+	struct vm_area_struct unmap, *next;
 	unsigned long unmap_pages;
 	int ret;
=20
@@ -3106,6 +3004,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	ret =3D userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
+
 	ret =3D 1;
=20
 	/* Change the oldbrk of vma to the newbrk of the munmap area */
@@ -3127,6 +3026,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
=20
 	vma_mas_remove(&unmap, mas);
=20
+	vma->vm_end =3D newbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
@@ -3136,8 +3036,9 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm -=3D unmap_pages;
=20
+	next =3D mas_next(mas, ULONG_MAX);
 	mmap_write_downgrade(mm);
-	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	unmap_region(mm, mas->tree, &unmap, vma, next, newbrk, oldbrk);
 	/* Statistics */
 	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
 	if (vma->vm_flags & VM_ACCOUNT)
@@ -3161,11 +3062,9 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
  * do some brk-specific accounting here.
  */
 static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
-			unsigned long addr, unsigned long len,
-			unsigned long flags)
+		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *prev =3D NULL;
=20
 	validate_mm_mt(mm);
 	/*
@@ -3208,7 +3107,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
-	prev =3D vma;
=20
 	/* create a vma struct for an anonymous mapping */
 	vma =3D vm_area_alloc(mm);
@@ -3226,12 +3124,6 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct *vma,
 		goto mas_store_fail;
=20
 	mm->map_count++;
-
-	if (!prev)
-		prev =3D mas_prev(mas, 0);
-
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -3239,7 +3131,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return 0;
=20
 mas_store_fail:
@@ -3320,6 +3212,8 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int count =3D 0;
=20
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -3344,7 +3238,7 @@ void exit_mmap(struct mm_struct *mm)
 	mmap_write_lock(mm);
 	arch_exit_mmap(mm);
=20
-	vma =3D mm->mmap;
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		/* Can happen if dup_mmap() received an OOM */
 		mmap_write_unlock(mm);
@@ -3355,22 +3249,29 @@ void exit_mmap(struct mm_struct *mm)
 	flush_cache_mm(mm);
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
-	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, vma, 0, -1);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
+	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
+	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
+		      USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
=20
-	/* Walk the list again, actually closing and freeing it. */
-	while (vma) {
+	/*
+	 * Walk the list again, actually closing and freeing it, with preemption
+	 * enabled, without holding any MM locks besides the unreachable
+	 * mmap_write_lock.
+	 */
+	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D vma_pages(vma);
-		vma =3D remove_vma(vma);
+		remove_vma(vma);
+		count++;
 		cond_resched();
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
+
+	BUG_ON(count !=3D mm->map_count);
=20
 	trace_exit_mmap(mm);
 	__mt_destroy(&mm->mm_mt);
-	mm->mmap =3D NULL;
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
@@ -3407,7 +3308,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	if (vma_link(mm, vma, prev))
+	if (vma_link(mm, vma))
 		return -ENOMEM;
=20
 	return 0;
@@ -3437,7 +3338,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		faulted_in_anon_vma =3D false;
 	}
=20
-	if (range_has_overlap(mm, addr, addr + len, &prev))
+	new_vma =3D find_vma_prev(mm, addr, &prev);
+	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
@@ -3480,7 +3382,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		if (vma_link(mm, new_vma, prev))
+		if (vma_link(mm, new_vma))
 			goto out_vma_link;
 		*need_rmap_locks =3D false;
 	}
@@ -3785,12 +3687,13 @@ int mm_take_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_assert_write_locked(mm);
=20
 	mutex_lock(&mm_all_locks_mutex);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3798,7 +3701,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3806,7 +3710,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->anon_vma)
@@ -3865,11 +3770,12 @@ void mm_drop_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_assert_write_locked(mm);
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index f6b187090d95..7b3fad611895 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -584,17 +584,12 @@ static void setup_vma_to_mm(struct vm_area_struct *vm=
a, struct mm_struct *mm)
 static void mas_add_vma_to_mm(struct ma_state *mas, struct mm_struct *mm,
 			      struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
 	BUG_ON(!vma->vm_region);
=20
 	setup_vma_to_mm(vma, mm);
=20
-	prev =3D mas_prev(mas, 0);
-	mas_reset(mas);
 	/* add the VMA to the tree */
 	vma_mas_store(vma, mas);
-	__vma_link_list(mm, vma, prev);
 }
=20
 /*
@@ -647,7 +642,6 @@ static int delete_vma_from_mm(struct vm_area_struct *vm=
a)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(vma->vm_mm, vma);
 	return 0;
 }
=20
diff --git a/mm/util.c b/mm/util.c
index 2ffc32294a97..331bc94423c0 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -272,46 +272,6 @@ void *memdup_user_nul(const void __user *src, size_t l=
en)
 }
 EXPORT_SYMBOL(memdup_user_nul);
=20
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev)
-{
-	struct vm_area_struct *next;
-
-	vma->vm_prev =3D prev;
-	if (prev) {
-		next =3D prev->vm_next;
-		prev->vm_next =3D vma;
-	} else {
-		next =3D mm->mmap;
-		mm->mmap =3D vma;
-	}
-	vma->vm_next =3D next;
-	if (next)
-		next->vm_prev =3D vma;
-	else
-		mm->highest_vm_end =3D vm_end_gap(vma);
-}
-
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	struct vm_area_struct *prev, *next;
-
-	next =3D vma->vm_next;
-	prev =3D vma->vm_prev;
-	if (prev)
-		prev->vm_next =3D next;
-	else
-		mm->mmap =3D next;
-	if (next) {
-		next->vm_prev =3D prev;
-	} else {
-		if (prev)
-			mm->highest_vm_end =3D vm_end_gap(prev);
-		else
-			mm->highest_vm_end =3D 0;
-	}
-}
-
 /* Check if the vma is being used as a stack by this task */
 int vma_is_stack_for_current(struct vm_area_struct *vma)
 {
--=20
2.35.1
