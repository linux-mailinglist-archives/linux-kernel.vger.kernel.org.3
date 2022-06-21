Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB95553BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354355AbiFUUrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354307AbiFUUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698724BFD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ8op2004752;
        Tue, 21 Jun 2022 20:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=cilVImFo5R3WFEa98NrQYbO5Euu1E97zmKbHStTO/Uk=;
 b=KnadmXRJ1OZP3w5QejHtuV94HHtRY9Xhpr+m8uFgI4N3nWACLQTBJwZl0KLrJD7PzaDA
 hyc1N58iAMtS0+vVoyE1nzuVtebzRq4Fvsbwf1t7Qak2ViEWo9P9xMgeGhDE18yva6Ca
 6neWrFMIojJd+u4K12Uc1DgkKICZqOR3SGQ+QMdghMtii/9hsLEeDFe3L6b7Dnt7cbkj
 5xnef73Ug39PoCmaZUH/MD4ogK25HecrXxsQ0tEVuLwGvKUEUEywDP4d6K+F7KVF31tq
 +Bf8p44hlQ/bMWBn/yDDRJLAPXwz8s4VtK/FXwMw5Ep8ZwJx0OOg4tDwOgtfY/I8BEKT Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeaMX010747;
        Tue, 21 Jun 2022 20:46:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3vkghq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAGVp3mgEPV2wEQPRFQcLzsgvjpalt3iEfQnY7HlesE+rFV5JlP48ZX/PeepS9nKGe1rmvq56h1S1DIE5aBzWg2n/9NfuC40KFFgx11DKOT1r0G0vD2yr+Zd9x2zPyuu1oIOvfYkAqI1hBkLx2H78pKX4wcimGaYGaWAO/m5CVOA/VduUw9xHsMCjo995XX6wLtmAI6//TTNmgqCVwY0gVYxwv1YVzC1NRQ1GuqBfhY7RIMaMcjh8KUeNmCsvYvcC/6DdQC7buqNYcWiNHvsj54JlspoBBqUN7dGv8VGff17e6nY/SGUSyraF8IB8EeSCqh4o1JJULt+4BEST2sHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cilVImFo5R3WFEa98NrQYbO5Euu1E97zmKbHStTO/Uk=;
 b=SHf2EDmm/MbnICtG7eJCkG3l90fvkan98VEuU56xJxq8UtEOYSgzikekVSidcrPU+hL6a2M6q98uwmGnWsfRZyK8TDn7g8tBigvEmKAfshYf8PtqOqoXh685ajjwAfyIQm7tnv44chhsr497ts33/XMFl0AQPp3UkbgRVgV7aJ8dj+qT/31wOxI0wNETehIaWViYJy5ls9RW/EKLHv7aAngh0JAulPfIekp7NZtelezybfhUQ1a0OGhl99mUmjVfzc+fguXNO9XajXpgxWpuvWuO+oM8KGsz+l1D8h62GBd+OeGbsp08sACYv9Pus/Wq5SHVQaMiAegSeCWOAd3t/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cilVImFo5R3WFEa98NrQYbO5Euu1E97zmKbHStTO/Uk=;
 b=VtsoRY/uP6/SZcA3VAz4coHL++H1J6dw8IP0VOXYWL9BtBmj5OMFoaCQR87qN4fU6KHZZKoGw0PVLPlZ1hy0IH1sReB9BIimMorRrULZ/3Am/7lcUryTXjpWpk1Tzcgd9RGUNHWlFRZi9zESiv6OM2GsINLuAg7NLJ3kSZrV200=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB3074.namprd10.prod.outlook.com (2603:10b6:208:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:46:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:46:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 00/69] Introducing the Maple Tree
Thread-Topic: [PATCH v10 00/69] Introducing the Maple Tree
Thread-Index: AQHYhbAFrq8r+zaR/UmcxMg5XSF3ng==
Date:   Tue, 21 Jun 2022 20:46:46 +0000
Message-ID: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83436416-9a27-4373-8428-08da53c72857
x-ms-traffictypediagnostic: BL0PR10MB3074:EE_
x-microsoft-antispam-prvs: <BL0PR10MB30744A261D41C843E7D1DB5DFDB39@BL0PR10MB3074.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHpuN3/KcLIn2KNiXCHAc7cgMN9xnoyAZyy7/U4mMtYLWmLKVQFrtPmwi5xlvIyyPKPdp6Rqg54PVBrULIOFRyh4hakFVk2Bl5JdX35mv75cpQONEuc1zkllHA2SBxWmpZlHayL2CqilZ411tK2FQvqbFW3wS7ZnqM7b69SB0cFKMR3cHFhVesvDmP2cwicw6LX6S2KdAyeav8RUowSy15VI5cm9QXOR1N+AOPzxRjqx3Kxs2E6aqTCcnNYRy302/iF9glZvfAazdU0k8r9DHClHHUqZSW7Q3JOU3a3vwPfsxvx9PyjN3nk1LLWkbw6fOkGlpLyTuRnbZVbWkMjgT2bhhwsuTb0v1yYu/QcPVZjCLi1IN75vIONTNeNDCKUIpxal4jcx80WKf+V/L3z0/jQBaoYOUy6b+kxtRgZZ8F9UJpBgJCVKd7bTNvCngDQ3P+5tgo8Piq8nkAhPxSMMUKKiVvs9VMaP1Emc/DPWKjAXQ8J6/uUwexXxNcc/FvdVkO5HGBG1iP1+kZaysSVecN2OvcFOujt+aItpOsgqLYUAEeofvVtv4xg0xXeGXkcAkKqIQ9By8KRPkby3cZHlboMqMxfsiHrmJ4NTChkQHeHGouocg6jUH7WnRX1EevaL2BvrqSAKniylEt2/QDoGCzlE4+KkXimrxK7UbWLK8IVycOTIsJ4+LVcwSs7wl5kUIdvYz5IYBY6nQyP89/xqK7sSp6x/8oVGFWWanJ+mVUR8v9eF9tx+wjWLEHusLbxVRzqcg6GZPBIjojgK5H75Vh7p1dg4aWdvii1YpTPOCeD2u3b0GrtcaW4OLRYe0ksNDFGqxN3yFc4abQDmdascwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(2616005)(186003)(6506007)(71200400001)(26005)(66476007)(8676002)(38070700005)(1076003)(41300700001)(86362001)(83380400001)(36756003)(2906002)(122000001)(6512007)(966005)(66946007)(478600001)(110136005)(30864003)(76116006)(8936002)(38100700002)(66556008)(64756008)(44832011)(91956017)(316002)(6486002)(66446008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XiGF26Lp2Uo8MOwMiG7xG/bAcPADDnWQThS2O5t1QY8hljFZmdLmZUZrE+?=
 =?iso-8859-1?Q?YPCQk5QCorD2updlIHdcXInK1rgqpUu0/VTF6GINfsQG/vw4DAgfkU6oEv?=
 =?iso-8859-1?Q?ZdvltTyinSVJngiVrhMTmn3FhuUaf4z2hyEnuxYLc8koPQa/tiLt7TmbCp?=
 =?iso-8859-1?Q?X+eC7fA/m9EMU7/gLafe80mKAxwOrivf8cSpcRxd5E5RkW32SC2DyEWCd/?=
 =?iso-8859-1?Q?UM58QnoOvz7VxeYNdsVM7VYqNciO55vCYFgdEGBgobBgg6I6qQMxwDKTsT?=
 =?iso-8859-1?Q?IhHDHHmwQo7u87/yeK7S8DljOsuCTB4oZoujcX6S5v2PJy835WIFO0FsQq?=
 =?iso-8859-1?Q?VvLFpNWJgkSKMf40W/t46VtC9xCf9pEPYZqRSzOSNdcehAkV3iPt6K18a3?=
 =?iso-8859-1?Q?70SH5G9JDhr4Pqt7NCUGRrlpu+p77pyq4iqb7oU7GCM+OIZFTF/QvPfOO9?=
 =?iso-8859-1?Q?OpaB3RkbaMZYy24Gu2jjnFe6Ulq+72MgsRE8UN8I+sJMWPw1RfXSFcrVSf?=
 =?iso-8859-1?Q?ysbu2BrSx9GOhATpUfQpTmX/bfwb4i/GezfVoxt+cUB7swfvQot6KGABmc?=
 =?iso-8859-1?Q?4EmojOMxTYD5ToB63I7FYaZowp/Rix2dsFHa4EV1aIXMkrCRofG2FRENYI?=
 =?iso-8859-1?Q?KZ52mab6vOLVTN3oukyEcr26WsHYYLVCqJmmKDPpFtHuVh1lcpqr4Jg509?=
 =?iso-8859-1?Q?Ou+UG7ivf3UQK6cqSd4rF0VD4iqBsO7MpNJXajQOkPai1sKywVxqa/0Kk2?=
 =?iso-8859-1?Q?8Vl54XnJxJzeB01LK2Bcz8igvcMzwc6QsO23TYtK/HSl+ppIlVkSVenqr2?=
 =?iso-8859-1?Q?j6xeAiSlxML+b56ZCcLqujs/czdeGCP42QdptGiQYVL5yUSAcdqBidZ08+?=
 =?iso-8859-1?Q?8HJ++nRzv71sf88KACkCCoDXSxOoDDDDoJ5LYGFnT9f4aRiIN1rh94bMXB?=
 =?iso-8859-1?Q?gmiaacXFF9cQyVNSVVMbzNEWhUHX4eAlvI7cp0WE1buMTIgvzRepAzs3N+?=
 =?iso-8859-1?Q?zJB3kNPVKkPo/dhEK2ZcqNl81iuZh1OhZic7scMSbUwghFZ9ve6/tkd72/?=
 =?iso-8859-1?Q?RTT/1ZY3Cfo2xXkQIw92IMzx6cwudkUIUbaSjFWrPOmB6UgBeH8l29oTER?=
 =?iso-8859-1?Q?rfvlP7oS+oIbntK6j0b339rFqIv4x+lBOV9fUDNrw8ttJCs72kNkKEsmBh?=
 =?iso-8859-1?Q?3+hde38VyYy+oGH3C79eGw8W5oK944oyqPAieu4PZWEZ1zf1Cn4xD5N6/k?=
 =?iso-8859-1?Q?Z+WkISuhEDrNqjBodJLqQLFU9XPDlObjZnMkvxGwJ1D8Rur2rX19HfCvY6?=
 =?iso-8859-1?Q?wMwkzUTuVmKBljDNvzzjlieTMdJQiIS7avMiJirnFiVZmpnhpWCjOSOKH7?=
 =?iso-8859-1?Q?WooJYF/tyJBboE8nK+KZYdfG+YF2ilrR72mlwCJ9Vj8ROcQ0rSZ19keIOh?=
 =?iso-8859-1?Q?mUzqwVvNhoWaTcA60M14RaJRMRycprfv41vjFZWRrkiyIkaPdTv03uuBvX?=
 =?iso-8859-1?Q?6l0RGKch44J5Q6BBHbOu0Wd487r4aqN9owZsDb29cOa4UC58XZc6GIXCEy?=
 =?iso-8859-1?Q?MNslZhmVbBa69A0higqmppv225HU5Hm+5nwWIMiua3K59nHIMubzFQUUJI?=
 =?iso-8859-1?Q?10LWc9Y8gGXngvvPJr+QXwIUXCTPVBID2XyNUINTKlnFadfI177Ppc1H/n?=
 =?iso-8859-1?Q?MiRm24igrZfQuJNaHXWe+uLIogdXCaW4NJ9iYYf+9djp9LU+3Pj/EwagIT?=
 =?iso-8859-1?Q?pMoTCj2xbEuWxo2P5cQiTc6g9oDfp4m+6DK43lnms5DZYg3eV+5RWtaD1v?=
 =?iso-8859-1?Q?sydsQ8Bxrwld/o253JZI+igqoBVSNK8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83436416-9a27-4373-8428-08da53c72857
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:46.6455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: to5PuXR2gw9Tb0VYiuWZ45o+xfub2g9DzBnhxHP0k7D4dyOJJHQAhT0UCH/0vJjzmoGFWGd+XSCpYPEel53nug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3074
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: vUvzLdMCDOgZ9ZiykJNKz6yP-u_ztIl1
X-Proofpoint-ORIG-GUID: vUvzLdMCDOgZ9ZiykJNKz6yP-u_ztIl1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andrew this is safe to ignore as it is v9 with all the fixes in
mm-unstable branch with the fixes squashed.  I've revised this patch set
for easier review as requested by David Hildenbrand.

I rebased this patch set on v5.19-rc3

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220621

Patch series "Introducing the Maple Tree".

The maple tree is an RCU-safe range based B-tree designed to use modern
processor cache efficiently.  There are a number of places in the kernel
that a non-overlapping range-based tree would be beneficial, especially
one with a simple interface.  If you use an rbtree with other data
structures to improve performance or an interval tree to track
non-overlapping ranges, then this is for you.

The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
nodes.  With the increased branching factor, it is significantly shorter
than the rbtree so it has fewer cache misses.  The removal of the linked
list between subsequent entries also reduces the cache misses and the need
to pull in the previous and next VMA during many tree alterations.

The first user that is covered in this patch set is the vm_area_struct,
where three data structures are replaced by the maple tree: the augmented
rbtree, the vma cache, and the linked list of VMAs in the mm_struct.  The
long term goal is to reduce or remove the mmap_lock contention.

The plan is to get to the point where we use the maple tree in RCU mode.
Readers will not block for writers.  A single write operation will be
allowed at a time.  A reader re-walks if stale data is encountered.  VMAs
would be RCU enabled and this mode would be entered once multiple tasks
are using the mm_struct.

Davidlor said

: Yes I like the maple tree, and at this stage I don't think we can ask for
: more from this series wrt the MM - albeit there seems to still be some
: folks reporting breakage.  Fundamentally I see Liam's work to (re)move
: complexity out of the MM (not to say that the actual maple tree is not
: complex) by consolidating the three complimentary data structures very
: much worth it considering performance does not take a hit.  This was very
: much a turn off with the range locking approach, which worst case scenari=
o
: incurred in prohibitive overhead.  Also as Liam and Matthew have
: mentioned, RCU opens up a lot of nice performance opportunities, and in
: addition academia[1] has shown outstanding scalability of address spaces
: with the foundation of replacing the locked rbtree with RCU aware trees.

A similar work has been discovered in the academic press

	https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf

Sheer coincidence.  We designed our tree with the intention of solving the
hardest problem first.  Upon settling on a b-tree variant and a rough
outline, we researched ranged based b-trees and RCU b-trees and did find
that article.  So it was nice to find reassurances that we were on the
right path, but our design choice of using ranges made that paper unusable
for us.


Changes:
 - Does not include binder fix - moved above these patches in the tree.
 - Does not include mm/page_alloc optimization to reduce fragmentation -
   moved about these patches in the tree.
 - maple_tree: Fix expanding nulls off the end of the data
 - maple_tree: Fix mas_next() when already on the last node entry
 - maple_tree: Fix 32b parent pointer
 - maple_tree: Fix potential out of range on mas_next()/mas_prev()
 - maple_tree: Fix typo in MAINTAINERS
 - maple_tree: Some checkpatch fix ups
 - maple_tree: fix mt_destroy_walk() on full non-leaf non-alloc nodes
 - maple_tree: change spanning store to work on larger trees
 - maple_tree: make mas_prealloc() error checking more generic
 - maple_tree: Fix return from mas_prealloc()
 - nommu: Fix nommu build issue
 - mm/nommu: fix compile warning in do_mmap()
 - mm/nommu: move preallocations and limit other allocations
 - fs/userfaultfd: fix vma iteration in mas_for_each() loop
 - remove unnecessary include in damon test code
 - mm/mmap: fix leak on expand_downwards() and expand_upwards()
 - mm/mmap: fix do_brk_munmap() when munmapping multiple mappings
 - mm/mmap: fix potential leak on do_mas_align_munmap()
 - mm/mmap: Fix exit_mmap() comment
 - mm/mmap: Drop exit_mmap() mm->mmap =3D NULL
 - mm/mmap: Allow vma_expand() to lock both anon and file locks
 - mm/mmap: Change do_mas_align_munmap() to avoid preallocations for
   sidetree

I've tried to preserve the data in this change set by adding the links
to the patches sent to the mailing lists to the commit messages where
they were absorbed.


v9: https://lore.kernel.org/lkml/20220504010716.661115-1-Liam.Howlett@oracl=
e.com/
...and
https://lore.kernel.org/lkml/20220504011215.661968-1-Liam.Howlett@oracle.co=
m/

v8: https://lore.kernel.org/lkml/20220426150616.3937571-1-Liam.Howlett@orac=
le.com/
v7: https://lore.kernel.org/linux-mm/20220404143501.2016403-8-Liam.Howlett@=
oracle.com/
v6: https://lore.kernel.org/linux-mm/20220215143728.3810954-1-Liam.Howlett@=
oracle.com/
v5: https://lore.kernel.org/linux-mm/20220202024137.2516438-1-Liam.Howlett@=
oracle.com/
v4: https://lore.kernel.org/linux-mm/20211201142918.921493-1-Liam.Howlett@o=
racle.com/
v3: https://lore.kernel.org/linux-mm/20211005012959.1110504-1-Liam.Howlett@=
oracle.com/
v2: https://lore.kernel.org/linux-mm/20210817154651.1570984-1-Liam.Howlett@=
oracle.com/
v1: https://lore.kernel.org/linux-mm/20210428153542.2814175-1-Liam.Howlett@=
Oracle.com/


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
  damon: convert __damon_va_three_regions to use the VMA iterator
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
 Documentation/core-api/maple_tree.rst         |   217 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/elfcore.c                   |    16 +-
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/parisc/kernel/cache.c                    |     9 +-
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
 fs/userfaultfd.c                              |    62 +-
 include/linux/maple_tree.h                    |   685 +
 include/linux/mm.h                            |    77 +-
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
 lib/maple_tree.c                              |  7041 +++
 lib/test_maple_tree.c                         | 38186 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr-test.h                         |    36 +-
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
 mm/mmap.c                                     |  2173 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   249 +-
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
 .../radix-tree/trace/events/maple_tree.h      |     5 +
 88 files changed, 48396 insertions(+), 1859 deletions(-)
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
