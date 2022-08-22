Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B759C219
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiHVPCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiHVPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:02:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD737FA1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:02:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpgkT016424;
        Mon, 22 Aug 2022 15:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=m5p4RdPhp7sucqawnIe93shVA/o9rvcwY5gg0AoKzqk=;
 b=sAjNMTpjsgrHnrznPLzpoJt+ldbGFylfzWusMRhO59khlh8MzjUnga8NESEZoHycGSMW
 bBOaDZjqrnayJeLHYyjx9SsMonB4rxhON96b6mdCXivqVuRjnx36/ODNxNPENGqwY2rk
 GvaekJzdYSWDbabXU/n0rJR8lSp4Y8wW4P2fzaS7yrQdA1ai8lg48UQaDDDTfpajm9Nc
 NdFiT1z7ZNFsyBL6gWVgoRCKAjEHk8IqjrNefIn/6jhldOVhnIJ5CJVLDk5doY9AITTN
 gOi6UMNchVMhPzPngeItM80jblyOeUUPtfCaAJ5L6bu+1OZ/o4F0Jgn012mOX698DmWj QA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx68112-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:01:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NQn031804;
        Mon, 22 Aug 2022 15:01:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd32a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDO17JIvlV6HJB4Qqa05Fd2AvbtXI6y9LIuxKzQxiISA7dD/44kateV3uMalH/uhKCQuBhUYsLu3cy/2JoRDfg25B6125EBs27fb/58vm1bTdtdyqttPQAfSKKzZxRBa4DdHvTlRck4tNzfJJtuYfY04w1FfLlfPMV5H4tWB+cczc+4PO2pDmz64lZxIf1uPTGY3CUlCNIaBSwPx69PQmY2I7tVnvgboPkiziBGIX+8cWHw7W1FzkhJD2D5hK0w2iLLE/a74MSbcm9YW8HbDaVnpXSYUAL9/ghcBnf2iQeNlvlNB8aIFYwTs3O73hgGx6VxT29dgRIjdEZBVQvALLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5p4RdPhp7sucqawnIe93shVA/o9rvcwY5gg0AoKzqk=;
 b=hpEk6Umy2T+jB7WpU9lEh9oUOnbzhWQaXj5uzkadF1UNivu08A2DEnY+7icgFW5BPz0HUfDbwqfnZJzhhEeKIhwn7pzxOyocdDm4/a3HU0Ryfq4YC7DZEzGl3tCNuDO6UdcRSJ5oEVVva+7Uw+0PSjL7G73NkcO5c+BZwm6oHnr2zLtyBZekl2n9DRhZ0Wwrio6EbpKQ8z70gcvc+dy2b+Wx5Qv9ajgulrgxrG7ge15lLFthe4D0C6O7eB6DKoXFWJUhJvSFhwct1LatrOQ1oMrIsbQJkBJE6vF/tHokj0xLaX7cywOioVZ9ao/rdRtTlXODpgBPDDro4uLBsiyKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5p4RdPhp7sucqawnIe93shVA/o9rvcwY5gg0AoKzqk=;
 b=nipccmuZ8C6Yi0CAQ22aBLyeIBmMtwHmOMp4kuqs9D6u5DbFxXqU3FlaLCr8tj8OjkUXT2JDEl1bYD1eQcFPsOzfnjwWLsoGLHhgEEQzTPm4Um5OnsXe1QBx4K3kaRmoArqMPxJAoe93NkvKPxAfqGU1xuoqgdn/wbAX4u3J6Zg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:01:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:01:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v13 00/70] Introducing the Maple Tree
Thread-Index: AQHYtjgakMrLy4S81kaBMJGfJYV5OA==
Date:   Mon, 22 Aug 2022 15:01:49 +0000
Message-ID: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8f3ec9c-7db9-4c1e-7557-08da844f3d48
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZ1TarSTksKPzirkJbPEe4L8mW9C1LcRehSB4Y9zgeCSvvtdp/K5X/3Da1AM/YTniyb/7xf2FFoUWQ/3mudn3Jaa7/BKFCPImPg9d6xLpiCsCsiknrxMa4O+mvZJ0Fnaz5kW2fVZmPOsTf3TDLQkAYqCayYThq39HXKlQjJVEPgYt/knr1+fiLiJH0daNtrpMbm4IJj5PwlmSlcOATFoq31Z1YXz4ywWurHECe0yZ/z+h7VTvtr2y01hjaT6BxC6sgAPB03ncKtSitw8FZMsZ3XGe10BzXTlGIj8IAIODSOksBuWSgtO3iZF9KTJ0Rg3waVheInnXCTY9svS/5WdkcIeyMqVp8WaMvbK3GX5+B/UIHJLnDJawYgn3OsjDWxwOWdKg24wP6F2Cze7+7jRyney015i89pZaX8METF/lW+c0tJ37vhcZsFXAl+/Lws6XPBChjwosBR7q5iEDh7VctCRxsv18nqYcSy/a0h4qsslvU8GW22VtWxTAMM/10pBXt2TWIto7w3yd/Fv7+NPuP6VBoAzB9IY3RIvqQhVV4G1rPCoe94j91my6I55MvcaNdPGOWN+qUbZD5GUqBPuMuzEUPU6PQA0OzJ9JXhLifsZUW01wJWwaPzYsFimlsmJRmCCFDJFSDLWHVDBXvBWKw2m/ECnH0AkbmefoESYiiHU1ycE5pBSSS2GLqJlZX7fwwrA+0hp8PYzagdVIWeIkVrQvXSyRWoD1VqNY9nCQzs2QNbGD/S5Jd508TldA9OuqY2qTpxFRP8aTtNKwoDSKR124tlaLM91WR+VpMpgOX5uS7h3K3fTi3uEYtFh5N7Ylwtsx6GGemEjnGPny8yQsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(8936002)(26005)(6512007)(5660300002)(30864003)(44832011)(6506007)(478600001)(6486002)(316002)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005)(966005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4rWgFMYnoe1ZHIdBnmfHKcku+r5S8hjbvt8+/Pk0Y3jeiiQXsal6xjlLlW?=
 =?iso-8859-1?Q?bi1yr0WlOzby1jp9GpIZYJyUKswPbywY8kk2CZIktwXKbVLvV6t2IizfXp?=
 =?iso-8859-1?Q?ZaEmdW3Sdl4QWU8qS45fFgpYx8b54Mfsz5B4W/vnDh9oMykohs3/BwdYXj?=
 =?iso-8859-1?Q?lmCtZijyhV4fitV/MAdFjCg04wpW+OiKTEpd56yFo5Ul3c+Sxw5ib238Kb?=
 =?iso-8859-1?Q?7CFVYqLAdzBNQBnbUu2cMSgR8a81GF6sbXSmpwvAM3M/NajoKtq9N+5/XS?=
 =?iso-8859-1?Q?QsPzLnVGSNjBFfShSstmLwMPjSlUE3W1Lxdxe4SMPrH/5FSf4uj+feqdoh?=
 =?iso-8859-1?Q?LbADH7n3Su7evc+OhSGavEKRyOIN/JQ9gAW/3SgXBN72xNJOQ7Pe4ATuA9?=
 =?iso-8859-1?Q?h0c2uo58JfawOHkUl0nk/GCer4DxTzjVQGsTAXBl9wBgezUI8BamKU+y3v?=
 =?iso-8859-1?Q?EaeZHVim+e/IX2l7A3dw9VbwHfeM2cFQPSlzwV82JJlZsJ6LNl7/vz4bzx?=
 =?iso-8859-1?Q?a09HvhemOSwTPgLPI6zwRXuBDhLa0rqlq1C9nKy5hYgwLGgCxtYotd2YQx?=
 =?iso-8859-1?Q?Y3+J2MzQXa0Sgq326NHe1tFMnjU7s1FyA8L9d6xxg4UNpwP/VH1nPkb31p?=
 =?iso-8859-1?Q?bFm7jADHoh5tIOhoh9Ot782YAFz5m01OdQkZ3KAHzLMGNlQmeXUAyFqZzu?=
 =?iso-8859-1?Q?9HhqzdHcnHXcKMPoKP/A9JxUbSFJHOHynIl94yC4DLXkxT7zU8lH5wkr2U?=
 =?iso-8859-1?Q?c20uMsobM0FvQajXLSZPb6aDNS4SV+3PZjpf0/C3hKZVhbYL0cAoBOI9+x?=
 =?iso-8859-1?Q?XHWbBtQ8MowqSkFwX0BeMIW9CXGEPvN9cFLPs5KdrEUrgqWUnZen0rnMwX?=
 =?iso-8859-1?Q?3/aMUVo6kqGPm+E3PQzPLkzpL0SYnmA+eeCJ3EbFxoVnZmtzP5+zJBHD6V?=
 =?iso-8859-1?Q?7k9N2ttKjM7CtSWHOACz8p6PTRhAnjcSFEwxTJLAcVtatbrg/2tjG2cVy6?=
 =?iso-8859-1?Q?36Q+5SGuxHDdJ3SLXMukYBKbFG/Y+W8r8QwlMl7avqbn6SbdxgvW0Iyvfo?=
 =?iso-8859-1?Q?jamJOu8of2jJp5mufvYv19Ox7fu1pxnmPfRXTZpMhsHLDLtJLt720EAkyF?=
 =?iso-8859-1?Q?iQcVTQGkVfJ3DP+9vqKYM5XryEzeLytektemXSaL6exsDWOYNXc+IvbbJh?=
 =?iso-8859-1?Q?xWBboVw0dygxmdRYUcmgofHAZuNk2J2uy21/hxlDP2zBRdcjUkwjyCmuf9?=
 =?iso-8859-1?Q?N/leQ/SYMnBOjmTgdvZuBg1QFK3caFEV6mnrxqmVTd6d1DmjlPlYYrquOG?=
 =?iso-8859-1?Q?CxzWvNJwcHm5lMwxVmeJu15ZZ+mFtcWQFrN4FF4GdSwgm+by2Xowc4GFWr?=
 =?iso-8859-1?Q?UBqJo9AWU+XSWcZgXVkQZezQeEDEuj3I/Fw1GY0FVckUavSMnZ9YoOF8cr?=
 =?iso-8859-1?Q?aM7Q0LvtrW9yISS6MRzx974uCQ8Nq546RyKZri4cURPdh6j5ZxCms+YJsz?=
 =?iso-8859-1?Q?IElu6lFiA5fvEBU1Yw80aqCdystVsfgt2W60OWfaYDYk1KpT0x475XqH4u?=
 =?iso-8859-1?Q?fK1i5ULs80UpEHAWdaeCw80letNE8Tr/eJHhhQuFycIM1Eat4Liw23GQ9G?=
 =?iso-8859-1?Q?TKh6B8dtJ/Y0DFSaJpp3v+H4yK845zE+rp8MjYRgZzu/WpBKG9RPB2UQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f3ec9c-7db9-4c1e-7557-08da844f3d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:01:49.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvPtLkO0HpeshmAITa6vAs5xJ1Vlrnmtz72D0W/toMckw3SAzdqbqTmSNcrHgnSKL40nXHBEhNiCrWOwg/RuqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: KK3qpfBvrsW7ymzvbj9PdeQIMHpndYfO
X-Proofpoint-GUID: KK3qpfBvrsW7ymzvbj9PdeQIMHpndYfO
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

This is the v12 + fixes and rebased against mm-unstable
v6.0-rc1-140-geb22a5b1b495

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220822

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

Changes - all previously sent as patches besides the last MGLRU fixup:
 - Fixed 32 bit allocation issue - Thanks Dmitry Osipenko
 - Fixed calculation for mas_expected_entries() - Thanks Nathan
   Chancellor & Yu Zhao
 - Added detection of failure to store in kernel/fork dup_mmap()
 - Added mas_destroy() call to failure path of mas_expected_entries()
   due to potential rare node leak
 - Added preallocation mode to maple state & warn_on in the case of
   needing more allocations
 - Moved mas_wr_bnode() to its own function to allow compiler to chose
   to inline for stack size concerns
 - Added patch to remove VMA linked list from MGLRU - Thanks Yu Zhao
=20

v12: https://lore.kernel.org/linux-mm/20220720021727.17018-1-Liam.Howlett@o=
racle.com/
v11: https://lore.kernel.org/linux-mm/20220717024615.2106835-1-Liam.Howlett=
@oracle.com/
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

Liam R. Howlett (45):
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
  mm/vmscan: Use vma iterator instead of vm_next
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
 kernel/fork.c                                 |    62 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    17 +-
 lib/Makefile                                  |     2 +-
 lib/maple_tree.c                              |  7130 +++
 lib/test_maple_tree.c                         | 38307 ++++++++++++++++
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
 mm/mmap.c                                     |  2154 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   249 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     4 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmscan.c                                   |    15 +-
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
 89 files changed, 48574 insertions(+), 1892 deletions(-)
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
