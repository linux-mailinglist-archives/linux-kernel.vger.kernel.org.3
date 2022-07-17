Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029D57733A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiGQCrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiGQCqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD2219C06
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8rBA005795;
        Sun, 17 Jul 2022 02:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=iBMXCyY3bNWfpU1xbyR55kGN2fr7vFbcBSkRWASaYHs=;
 b=FwGRyhoRf1x4O+AaPo7jvog11oGIgFS+/QIQrz64iq41jWkuc2qcoyEX6epG56fqXemm
 gvmzBbCplVEXtGgimFKQQ5zu+RagYp31a9gbKlVhnRbj6jV7UrcjKokaveOhY+ZgbQh1
 jlHHebwMlVPysYk9JkOUpo67sM8nSWplRAmaHw1Gb95h+VyAuY7SUxSz/LqBeCBOWREB
 mzH/iZ/8iVp64gronQHtA3hfebs5sXJocmWcqRdnfQXYAPg+YhHgReHdd3jr77bDkpQ3
 6A2BBrXjHb1bm5hweSsCXOwIVGhEkEjIlcZyeyWHpImca+unHzFDSVCKyZMUllfJhQpO 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3EB005901;
        Sun, 17 Jul 2022 02:46:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d7y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGW+NitsAL0XAY0LFSJndIR1xgmhcIe15ncuE+HouvnRqp0YEpaOcDgO6srOYW4gUw91hoeACqKlnzDDFdmtSeX81ux3wB1yrE/4OztKxtB2lVvUHH6y+N0jZb4d226LcMY8Tsc/BovPVIBedZp2DDbkXlGEtccZ8gpixOE4QstHhYs8eX8WRSEcjHwGUjn2CFZVSIJZIqMqIqYjuOyZLOGn/+AM2vg0z0iEzw8tHUqzZVplcCCeqb9igtm/UGgMBfw9pDradlSCfnVuNh+E7Xb1TdZ53cy1Wc+P0Arwbg1ghkFdJDAEZ47AB7qmlAi2YfffOrQ90JRPZKVaz3AN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBMXCyY3bNWfpU1xbyR55kGN2fr7vFbcBSkRWASaYHs=;
 b=DH/XXfoZUlG+KqTzgmQpGAk3gqsm+YjJRNJgXXrWaL5WjEi6ziIW85B5m27YMFaJvfM+y8ZrEqIadN7aXsE33qv+CcFufZTzJlilmOQrF3KCBK50qYGHm/pe9Ce6uHWy9qe78VApXW/3lzbllHgGmidbEjT871Mu9fFbU7atBT6sqcDu7YOOlrhTTPGDJ7ZK0ac4dh8gyR/41CgDeDZurIfLYbKwNhevCkOU8AtXzsZGcPzWWCg5uDCCkR728o6FTQ9crTW6CJglKp08yh3I5Z85+Yumnc41+pV0TKXqtLodff+7MxjJhQxxfpD1P/pchmMYVprLsCpRZoT+DrKBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBMXCyY3bNWfpU1xbyR55kGN2fr7vFbcBSkRWASaYHs=;
 b=MGg5kCsJh9qTdcchi8mVWxYsWvc/yQtcgFMd84dIaoLCFz1sTDo31GOTrfKPUOxQHgm+AziYP6nzae7ri+hbivVsxFQjA2e0YeSyb+4QDBSWSRcgsQHm8vL9Idh4MKLNHD+D0ia1G/7DCzLtRSoSJnp+vxmquLgxxcOJ0pLDeKc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR1001MB2369.namprd10.prod.outlook.com (2603:10b6:405:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Sun, 17 Jul
 2022 02:46:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 00/69] Introducing the Maple Tree
Thread-Topic: [PATCH v11 00/69] Introducing the Maple Tree
Thread-Index: AQHYmYdscyeMwVIPS0CbwXe7JFDqlg==
Date:   Sun, 17 Jul 2022 02:46:32 +0000
Message-ID: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6a82676-479c-4329-6887-08da679e8ead
x-ms-traffictypediagnostic: BN6PR1001MB2369:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X1JG73yQWTxpspQ3jqz4FHvUhjw4S5rYjct/+q2GZ+e0f04QGS1R5Hp2khsx8H4HUzw0z4sK8LCfDwfORvtS8d82HkcUuTygeCGLPQCH6SDYzC9P4AeioE5PNZ50WeXg8Y2cX7+k5rRwM/1pA80zAeLpn12aipg+9STBCTMfh9ThJwoOrlVrfzV1IvnOY67K6SZQxbHNrVPqqTOWF4uh+n2bZft52BNBq6S1CRN8XgkSlwYVyYQl2SdB8Sa4xFx/ENZQx+7oq9zkIUihIJF/NEUlFh2z82rDypJjUGGIVzVGjCQ5Saspg7maliMTKwnMfvy+8KjKkvk0mla7EbJuItFzi4DEu5vZtuUvBVryA96HjObrQeXjjPrBR3WB+/vpXR7k452zi25HkYg9sMbIPhKHIQV5catD7mHLQ3AY26amR3rvdxiaDob98txA92WNDfZPt7nVAgH997kwQR3+f+cRUNSIImSmc9Yz1BuKtlL4RdidX87aB1AqgXicPmJcbyGtTeWjf8INJ0u24qK3kYbHVoKBl3wjLFm6Fqejgxb1t6Zqh10+0WK4RsmiMUZun/pTzDQuvg+Ey9MX2AcGEbz27j7DPm8uxxPy2sIjgwq3sa3BwUXX6O/h5Y6zN6sNACS0Lj4lyLI8SxwaaEuK6eq3Q/NCoCvgXZNRS3q7nj2P00Z6vuuE8tJvyFhIDIlnI2cqjHn0vrF4kCoBdLKnbKFAy023OuY7CvjDoa4g/LpqCNDLOh0YF3oqB8cCqY/4NdLBMspksr0agwWM1WgBEasHfNOrXCTLLFgKGGCkmRdezbgNje1nCUN+HotYI1ZNpKuRLhOaEgVjmIo3P3FMf0/uBRwM/pDI8HkKaZE7B05klkg669iZhVoPm1jVzbIb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(1076003)(6486002)(966005)(71200400001)(186003)(478600001)(38070700005)(6512007)(76116006)(6506007)(2616005)(41300700001)(26005)(122000001)(38100700002)(83380400001)(66946007)(36756003)(8936002)(2906002)(5660300002)(30864003)(44832011)(110136005)(316002)(86362001)(8676002)(66476007)(66556008)(66446008)(64756008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h+oC3YvdJstOOxtUuyZVCbV13EtlRgTy9jA7nUHE0yQMDpEPE3aNxnAoZh?=
 =?iso-8859-1?Q?fYpMbJ1lZELvTo3kmcOZKCFEEb4lL2B1gP3DhotaAK9ZqLtmDG5iKl/sBY?=
 =?iso-8859-1?Q?5rd2fiK7ESxD5U4NbEE3RzatM1OWn+/VP6tDoQo5WQw6RKa5qvWU2SgVFU?=
 =?iso-8859-1?Q?q6aM9F4Q8ixjSlSYbeByS6j6om1x1c9yNMT2gXLlqh+ZiZhfeeILlC0C/4?=
 =?iso-8859-1?Q?CC8+Px2o5IlMBGkFVKi3OEdgGR0XRPg9Oq3kKF+lPRka2itOJLEU/xZUkU?=
 =?iso-8859-1?Q?d0fKoryJLEfhr+SWlodOAKlo6vrux6Z2cOe8/WDp1v9fWuXyDOAM3RpV3a?=
 =?iso-8859-1?Q?7QLQ8KRshZOXzrAnSy4zJudnlXDF+afkm6GXdxP6/GyBSB8NyV6PpE6l5K?=
 =?iso-8859-1?Q?lKj9Crtku1pQzV4668ywiLyOEhATSVggDQzlfUHmuqpQ9giNOXRtpQH7Hi?=
 =?iso-8859-1?Q?EmEim0rha0e/IRmPTsJVG32mqj9Bp0GWXC+enLhh/iXcLu6bm+jKOAFrhs?=
 =?iso-8859-1?Q?p+644XFOI7z4Wx1IzqEM7w+WKU34a/iOlVFk1GFRAg0TBopVFI2PnMG5Nn?=
 =?iso-8859-1?Q?eo0Rg3G1OHiR+jFYPo2jEIhe6XMQXyhPBSChfxyirm8rRPD9ADXjKPGuOO?=
 =?iso-8859-1?Q?8DIuN5p/0Ucx5+KP/uYi5wazaJTvRO6r5ltuTpMPupJl53rvtQKM1CgM2B?=
 =?iso-8859-1?Q?mUmeMOCJtJCdYWOxxemckZB0C+kJeTXEakTut7z86DQxw59vG9ufhfJ+q7?=
 =?iso-8859-1?Q?IgEeQNqlRj7d+XXKUCojHPGRiwzRm36i0Pxx2gP3F76XCXJAgwUmjWQEjK?=
 =?iso-8859-1?Q?lX9wDTmBEY+N7N+1d101TGWvtLpUWgbSYL/lFXZnhgQsaWCs14e1bHKnTv?=
 =?iso-8859-1?Q?uIhw8A9boWeUYtQwVvp8LwtOtI5sClaSUQCbNkvfdmvIFirZg53K1EfkZX?=
 =?iso-8859-1?Q?m0qCX/+pZy4eU5PpgH85V7MdOBBwF9PwyjX7H5jVrawjfgwXvh/KK9F8UR?=
 =?iso-8859-1?Q?sq6/SBg+oNN1LWuRhQE6drjBjdJPUf3p+2ec2n/5zGqx4QY7AsPmouf2TR?=
 =?iso-8859-1?Q?zQenONhDZKbiVrCcVtmfVVEKHPQ9bxNGEQ/GYdLAwHZ66SQ8B7LGPDmb4t?=
 =?iso-8859-1?Q?IUoRV2yLK6YTPfv8QYB4d2lkDEPHW9Z9TTIp9f1HRFw9JM6iEewk2NHvfm?=
 =?iso-8859-1?Q?6OrmRP9I4xRmv67fcIq3ZkTt+S/L/Ipw4R5vV6jnPc9fwzV/8m8jDL/uV+?=
 =?iso-8859-1?Q?kRE1qjcdaPZu5C3T56XBhwg+y5X6voA0E/PhFdEaoPckWOaROYyPX7Mu/7?=
 =?iso-8859-1?Q?4lCauKACT06NkPOdJSQaEc7XMP6GxvBKjjDL9pGsEIAaAvKpzKKQq01sSj?=
 =?iso-8859-1?Q?DoV5G09oei6ltXCl3Kd5woeg2G/wOf8UYv4xdAqM/gairTq+2fMsLcdT3t?=
 =?iso-8859-1?Q?TYmclPpdyrgs/RTY2+9EK4C7WLwqiBJe6CiA2h8czTDHCfWmw+xxropZCs?=
 =?iso-8859-1?Q?i5Pu53uZDVExMRUF86TpQtd74XcFqNiQnBeqk2CzipY4rSmvsxfGOsAswH?=
 =?iso-8859-1?Q?SsidyzAC1RfVkg7VndOGXVSJ5p87324Hoo4/tgH6ySKwEhyoJfkW8hsGhT?=
 =?iso-8859-1?Q?gQ1shWgC9Yl8sJPDr48iZPovIhgjhya8StmCSbHmFfPOZPUkUYT7Njww?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a82676-479c-4329-6887-08da679e8ead
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:32.1944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXzb6C1SDMHKzDpyTguYGODubUP2Wt0ZNfYYObDRrbFbLoTpRypPJxWsLT12UeAe6B7nj/wiAvEBw6joRR1/MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: zp-P6f4JjHKBXYKSYL59e8xBFTWlC6Hu
X-Proofpoint-GUID: zp-P6f4JjHKBXYKSYL59e8xBFTWlC6Hu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the v10 + fixes and a few clean ups.  I used the mm-unstable
branch and patched in place.

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220716

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
 - maple_tree: Fix underflow in mas_spanning_rebalance() - Thanks Yu
   Zhao
 - maple_tree: Fix mas_spanning_rebalance() corner case - Thanks Yu Zhao
 - mmap: Reorder validate_mm_mt() checks
 - VMA iterator: Add underscores and parentheses - Thanks David
   Hildenbrand
 - maple_tree: Add underscores and parentheses - Thanks David
   Hildenbrand
 - maple_tree: Fix sparse reported issues
 - mmap: Fix locking issues in vma_expand - Thanks Hugh Dickins
 - mmap: Fix reutrn on maple tree dexpand fail in brk() - Thanks Hugh
   Dickins
 - maple_tree: Fix mas_empty_area_rev() search exhaustion at root node -
   Thanks Alexander Gordeev
 - maple_tree: Fix out of bounds access on mas_wr_node_walk() - Thanks
   Yu Zhao
 - mmap: Fix __vma_adjust() issue on memory failure
 - maple_tree: Fix stale data copy in mas_wr_node_store()
 - mmap: Change comments to be more specific - Thanks David Hildenbrand
 - mmap: Use PHYS_PFN() where necessary - Thanks David Hildenbrand
 - Removed %px use in patches that only existed in the series
 - Fixed a few checkscript reports.
 - Added necessary tests to cover all bugs found.

v10: https://lore.kernel.org/linux-mm/20220621204632.3370049-1-Liam.Howlett=
@oracle.com/
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
 include/linux/maple_tree.h                    |   686 +
 include/linux/mm.h                            |    78 +-
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
 lib/maple_tree.c                              |  7102 +++
 lib/test_maple_tree.c                         | 38206 ++++++++++++++++
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
 mm/mmap.c                                     |  2206 +-
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
 88 files changed, 48494 insertions(+), 1877 deletions(-)
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
