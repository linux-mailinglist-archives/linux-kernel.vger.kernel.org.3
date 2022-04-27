Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37869511D88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbiD0QzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243474AbiD0QzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:55:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E926949CC1A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:52:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RGmdFQ025784;
        Wed, 27 Apr 2022 16:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=6YGFqcSGHFNF8B6rdG3pccTXtT8nKPqzULXByNpkdrI=;
 b=foq8Jt8yGldEyiZTynbknYxXVJI8xvy03kiBghAjXedjBZWFv+VJi9ugi21l2JtEPXlE
 8gZyoh6dxzqDpOn/xhtez2dvWi20oqGovB31SKImwt/CQod0WgevhrcXuNLKx3B4NoRv
 mnOzMsqD2PYX6y6wibVx1GIL7gDnpf9zmWaOrcGXP444sai9ay0ajXkj9mCj8AFmTzx8
 xp4/5jvhd2tthNOpEGPR7s8ZanDvQsIEsurasoRbRnRRXcBuMLXGzo3mmfvkne/pJJLB
 SBhR+LCHD5ekqkd413WcSvN1FNayjr9hatws21kbu0bt4gaSf49ZfvZ2aDMIYuBvvFUK oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1msrkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 16:51:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RGkZZj024044;
        Wed, 27 Apr 2022 16:51:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ym8vm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 16:51:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7AzpsHuVSj/1QBkGgQef+17NJ0K6/fx6PrjKj1jLunFdzw3exf1QjtZV0VjewXxrhLoBN9DhMGrcpRXAFE/hmVyJWD5mds5W9NMzjwo2RUqTHgkpMH85B2cCnmTpDQtTdwCIOrjRQtjL7cVAh71DCPArWWcqdlV8KO+4IhKkP7I7MV2EIbwjoAWyYiAyh+okQSfPrdHziIvqQy44gGM6mF3hYhAi/Totyn2i7GCK5GyQHJErPcJR0zNq09UQPm2DwgMeyITG+344q/Br6r3ox+cjp9+lrKz7Xn+GFNVvgR8rdhR1pp1juBg/lmwRXxkd8yOu7ObRyaUvPzVLct6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YGFqcSGHFNF8B6rdG3pccTXtT8nKPqzULXByNpkdrI=;
 b=EXdwRcZ1QbqzO9qoXPZsXE2+uzmJ1toXfB4SDgX1ZJesIK+npItNwgbGkl0PCVS89AlxaeIHV9vZcrLhWPK5lDQCuBvTl8s38CsHPDrBGsd+q8NddSRwMoTZ+kQEO0PvjJkapkLmIXu7qljlfEaMSZJfrBa3HxG7ZjTPkZDwO2Dekb39lsl4x52tJ+iBRPR+50s2xkHV5HmGUu+ZOHX450WaaBKXLgYgHsBtQOK2LT2I75H9VNhaZjyQFhbLcM04U1lMxgyVzZHdEemxkvK1d/2jxcWWA5lrOB/JmIZ+Mth0WhFcB6bKsoOrVGBawOzACrZJGITjKqmiKmhdMrawTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YGFqcSGHFNF8B6rdG3pccTXtT8nKPqzULXByNpkdrI=;
 b=KB+RHfXlJv+mLon/V8J6lM7cPqXyZhrWi4i+MJ3UYifdXMg8iJYlV93Ca+oN8pnUQ+wjJPX1oS3ncG1XM63AhutUmLszgfTVPhIKRUYFiTF5Ug/eErdniLxOQcSCIl+IfWTocpfsCgzQkFIMOUWOykDZdPB+UIe3iaiyx3y0ECo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5300.namprd10.prod.outlook.com (2603:10b6:208:334::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 16:51:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 16:51:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Index: AQHYWX8vSnmCSFccn0+psIQVsVvpYa0D76aAgAALhwA=
Date:   Wed, 27 Apr 2022 16:51:50 +0000
Message-ID: <20220427165139.5s3qcj2u5vqrvwlc@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220427161033.GA1935@qian>
In-Reply-To: <20220427161033.GA1935@qian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0817ec48-ec4a-48cc-a82b-08da286e39d8
x-ms-traffictypediagnostic: BLAPR10MB5300:EE_
x-microsoft-antispam-prvs: <BLAPR10MB53000B2E39E325F1DBC0A757FDFA9@BLAPR10MB5300.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O5NYYHco+a4pBUBmVJGLDxY7iW4zQRH7TdxJdwsU0GMvt6/To/CWiR1j0LXMu1eVy8rVI6Yozj163y6dktY+hSpq2AafDIFocrbmSUsfmxzuPTnNNj8BnFZMVp27f/of1QquXmiyG6l/kjma+XJJIWKNcqDZwDjyJGe77UYbUMxEGbVSnfa6mlcX+0swvmOtlW0juAucAnTyddJF90jJQEkGrVoOlQSbSaVIdQ3hT1muIKY5+Ex7eBymLV30plrbKJ+bVnNgpywv1YZFmhXmsrkZtiFLIatdMV3ZD+v+sp/SIHEgMVkIA2neiCWA5ND9Ii065nPXogOPNzDTbJ/lR94Nd9uyLGQULe3iEA6fZSHnKI4449XyA+4vVzKxR4VO+Txw4ZK4keoluoK5Z/msSq4bgrr71Vyb17eKq8ZkjA/fA7pTn96DyWvUDHmrrVOR7XMxJok6PvD/8yN7IHP1rwH9pHRn3pdkDX5P40uUJSBl3pA4HUgk9zSs4Rbjani6jAxrE/s7QVY5uW09L/aBwO/GbJY4H/wglfgm6Gvx20/lscul6mmEQFrIs6E54r7c4Xg1K4pu9ZO1PUQbQQZ2nZWnKxo6K4v6agUwoCnyU23Mmo0Ch38nSYy9h3Q3CAZxyjC19NzrpT2NgZ9Ja1rzVeetTccfEakfZ0zWZuI7DvOOO/eFsSGZ7Twr5qzp068hqpWH7RKDIidYQXa3Bdwy1nOmerObvVWtq/RwsyroxIx99DDdnjaraRtYnclyG3Rw3UVzJSy5rf9FWldW0BG6yudsdyVA5KnqO1vs9IA2xCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38070700005)(8676002)(4326008)(91956017)(966005)(66446008)(66476007)(122000001)(71200400001)(83380400001)(66946007)(33716001)(38100700002)(64756008)(76116006)(86362001)(54906003)(6916009)(316002)(186003)(9686003)(1076003)(6512007)(99936003)(66556008)(6506007)(508600001)(26005)(6486002)(8936002)(5660300002)(2906002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LK0v7OCCJvv3qhD1pW0XNpUHCOgGGsC2TFxHuozoKFnnggEygTzHm123Fsu+?=
 =?us-ascii?Q?0qOFxgN2Gr1KQrvZvA1vgi9mfCUBBkNhmPBDB6peSMLLHPo0ql/7vi0/eqMx?=
 =?us-ascii?Q?HSoriqrkBS/MNoKjo0VJ/VVy0rz0RQ1bv6rFOdi02reyvMk3wScKHR//DEIP?=
 =?us-ascii?Q?YFb9IvfwGfMGuLPKdZvKQnzbNVU324Vwk55Gg1alfdfwhv6R/NbYmIhcShOo?=
 =?us-ascii?Q?eqfnSMmsB2S9MoSoNlXBd140KkS0MjJKwTgZv5a4IsIFoOseQK5XP895R28q?=
 =?us-ascii?Q?etHYis6JSs5u4/jsx94NBjSR3DL4cp+dTflKNQ1YzWlT0YyjeXqofGBn2L3m?=
 =?us-ascii?Q?OUKrycw2tElsHxsyzhj6jCju085ocjiZQ2hMLnO/ZQOKi9s7Bq5sgZM/5Z4S?=
 =?us-ascii?Q?qJq9yJig6MNjUgtR8QvFgNVPag3Ns+82f3fUHVJ/BpVIH1lV45yGa80zjg0a?=
 =?us-ascii?Q?XeXgUcFQ6IYpYvWnfa3u/iNxWk8sIaWCQ7rTIoV5TGfiXHezLh/LN/AX7Rfp?=
 =?us-ascii?Q?OaZ69pmRqiHAHXbNK0Du/VYeLI0VzqqUNTWEujbDvVxsWEB++79d0vZ32NDH?=
 =?us-ascii?Q?jln41jEnWswhBAstwI9ay243AiZ2P7FNq0NvQvin+kLD5K8gATbO1ZSPsFMy?=
 =?us-ascii?Q?Yovk9XRy7jHzt80YAceikJjeRgUnLrDqVKZcjiRMIVWZpseL9KLfiTzPWBw+?=
 =?us-ascii?Q?JpU7ok4s0OH9iU8fLbMVztgqqF08lQpljnctJfCjJNFuvWa/1ZGyEy7HEOXg?=
 =?us-ascii?Q?DCZNNdmyh5+BNyiCuqm+ZBH3A+qHS7kyizJkcC847ZrA56BdCGzmV4leaOxd?=
 =?us-ascii?Q?OrfCvMrzTO6WZUAx9SSLa19DRzan9dzpDOoq7t8S/YH97WXP4UWt6CnVOqBd?=
 =?us-ascii?Q?AZdNGhgSpNUwQyGWdsqGQEBcTLWh+ymaC6EdHEj06S1GJr2lKEK+EgEd6QU4?=
 =?us-ascii?Q?iwq3oo4Jlk0aLK/GAbH0VwTWml8AL4x9k5Psv83ZQBGmjTEUh4yddFfATynY?=
 =?us-ascii?Q?C8SvaKLN31QHr3MsWmn8wlvf+FaUUxIIbNBtjuw4FWq9dYyf8FrgoqbtUhIn?=
 =?us-ascii?Q?KH87MnC1rI0H6yd44F7Hh6yO0ID8salqSxjEuolvQzoETLsAku+Qbla/NS1G?=
 =?us-ascii?Q?zkWNNNrnX/4Tacs4HrPTkuElOq0bBRGk54ajvEHxSnAnpj1vF3FO65WL5TXM?=
 =?us-ascii?Q?11Exd8zRGuso5/3BW686tjzph2feVqs5JsDiDTPPVl3ixam3ZzMtkul0HKkP?=
 =?us-ascii?Q?fbEfwlc8EI5CL4Yx21e1gaET9OsULBwEH6lL8OSLI+V31SlHAZHrm7dBVfs1?=
 =?us-ascii?Q?XAmVb+i1l+hg226bXYeHpfYwRPy0kuwcY5n1gts+CFPOmj9RW8P3laQZUy0a?=
 =?us-ascii?Q?UmGyZT2mIIljcPBX8hlRcBcYmE2mGHo1ZQsJnwzfDRJWMA20WwWzCAYPaCvL?=
 =?us-ascii?Q?QD48fYLwAV4SflNLS4DR/IYwakPb6u3FyJ7aiO4WVV3UP+r6GNbJulCld8Q/?=
 =?us-ascii?Q?HBYCWlLAsRopLA1B0isV20ZDqzGfKIVno4AySFVmYkS3VZCTNISi7E7nj4jA?=
 =?us-ascii?Q?qNXpy0aJLcV8HT8AfxXLXSKIJTxkgQaB+26WUQmUcK1tvaeoaXx+PBpzqWLK?=
 =?us-ascii?Q?yYcJ8cFqPR3luJgk+7eIVBIGlIKf2NPOQdFrEb6oOGruM51+rkpSJPYZBslU?=
 =?us-ascii?Q?Br73+8xyCQCcFrmAYED80uUGgpBklnvqBNZ0uCRbPEqewyJtIPOOobhZF9lz?=
 =?us-ascii?Q?S7jcs4CcBWdXj1Ov+mj+8+4t9JLUGtI=3D?=
Content-Type: multipart/mixed;
        boundary="_002_202204271651395s3qcj2u5vqrvwlcrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0817ec48-ec4a-48cc-a82b-08da286e39d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 16:51:50.8047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2YmkjreA7kPl3lehF37SDcBjAW6yB6Ig6fkIat1k3mVzdpZyvh1V/7GLKWMrY/aD/3H3/Q0pR8vH3GSe/zu1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5300
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270105
X-Proofpoint-GUID: XXogk7oGvrnPGTo_MhlMPx3faE_rYjaD
X-Proofpoint-ORIG-GUID: XXogk7oGvrnPGTo_MhlMPx3faE_rYjaD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_202204271651395s3qcj2u5vqrvwlcrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44BBF39BB18BEE4081EB32E9D90044B8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Qian Cai <quic_qiancai@quicinc.com> [220427 12:10]:
> On Tue, Apr 26, 2022 at 03:06:19PM +0000, Liam Howlett wrote:
> > Andrew,
> >=20
> > Please replace the patches in your mglru-maple branch with this set.  I=
t should
> > be a drop in replacement for my patch range with the fixes into these
> > patches.  Adding the preallocation to work around the fs-reclaim LOCKDE=
P
> > issue caused enough changes to the patches to warrant a respin.
> >=20
> > The last patch on the branch is still needed to fix vmscan after mglru
> > is applied.  ee4b1fc24f30 "mm/vmscan: Use VMA_ITERATOR in
> > get_next_vma()"
> >=20
> >=20
> > Here is the pretty cover letter you requested last time.
> >=20
> > ------------------------------------
> >=20
> > The maple tree is an RCU-safe range based B-tree designed to use modern
> > processor cache efficiently.  There are a number of places in the kerne=
l
> > that a non-overlapping range-based tree would be beneficial, especially
> > one with a simple interface.  The first user that is covered in this
> > patch set is the vm_area_struct, where three data structures are
> > replaced by the maple tree: the augmented rbtree, the vma cache, and th=
e
> > linked list of VMAs in the mm_struct.  The long term goal is to reduce
> > or remove the mmap_sem contention.
> >=20
> > The tree has a branching factor of 10 for non-leaf nodes and 16 for lea=
f
> > nodes.  With the increased branching factor, it is significantly shorte=
r than
> > the rbtree so it has fewer cache misses.  The removal of the linked lis=
t
> > between subsequent entries also reduces the cache misses and the need t=
o pull
> > in the previous and next VMA during many tree alterations.
> >=20
> > This patch set is based on v5.18-rc2
> >=20
> > git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220426
> >=20
> > v8 changes:
> >  - Added preallocations before any potential edits to the tree when hol=
ding the
> > i_mmap_lock to avoid fs-reclaim issues on extreme memory pressure.
> >  - Fixed issue in mempolicy mas_for_each() loop.
> >  - Moved static definitions inside ifdef for DEBUG_MAPLE
> >  - Fixed compile warnings reported by build bots
> >  - Moved mas_dfs_preorder() to testing code
> >  - Changed __vma_adjust() to record the highest vma in case 6 instead o=
f
> > finding it twice.
> >  - Fixed locking issue in exit_mmap()
> >  - Fixed up from/s-o-b ordering
>=20
> Running some syscall fuzzer would trigger a crash.
>=20
>  BUG: KASAN: use-after-free in mas_find
>  ma_dead_node at lib/maple_tree.c:532
>  (inlined by) mas_next_entry at lib/maple_tree.c:4637
>  (inlined by) mas_find at lib/maple_tree.c:5869
>  Read of size 8 at addr ffff88811c5e9c00 by task trinity-c0/1351
>=20
>  CPU: 5 PID: 1351 Comm: trinity-c0 Not tainted 5.18.0-rc4-next-20220427 #=
3
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-5.fc3=
5 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl
>   print_address_description.constprop.0.cold
>   print_report.cold
>   kasan_report
>   mas_find
>   apply_mlockall_flags


Thanks.  This is indeed an issue with 0d43186b36c1 (mm/mlock: use vma
iterator and instead of vma linked list)                                   =
             =20

Andrew, Please include this patch as a fix.

Thanks,
Liam

--_002_202204271651395s3qcj2u5vqrvwlcrevolver_
Content-Type: text/x-diff;
	name="0001-mm-mlock-Use-maple-state-in-apply_mlockall_flags.patch"
Content-Description: 
 0001-mm-mlock-Use-maple-state-in-apply_mlockall_flags.patch
Content-Disposition: attachment;
	filename="0001-mm-mlock-Use-maple-state-in-apply_mlockall_flags.patch";
	size=1576; creation-date="Wed, 27 Apr 2022 16:51:50 GMT";
	modification-date="Wed, 27 Apr 2022 16:51:50 GMT"
Content-ID: <2EF9DC2C01AD494CB855382BA09F5E2C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA2MmM1MGI5NjgzZDEwY2NhYTBiNjg5NDU5ZWZhYTQxNzk0ZGIxMjliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAyNyBBcHIgMjAyMiAxMjo0NjowNCAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBtbS9tbG9jazogIFVzZSBtYXBsZSBzdGF0ZSBpbiBhcHBseV9tbG9ja2FsbF9mbGFn
cygpDQoNClRoZSB2bWEgaXRlcmF0b3IgaXMgZm9yIHNpbXBsZSBjYXNlcy4gIFNpbmNlIG1sb2Nr
X2ZpeHVwKCkgY2FuIGNhdXNlIHRoZQ0KdHJlZSB0byBjaGFuZ2UgYW5kIHRodXMgcmVxdWlyZXMg
dGhlIG1hcGxlIHN0YXRlIHRvIGJlIHJlc2V0LA0KYXBwbHlfbWxvY2thbGxfZmxhZ3MoKSBpcyBu
b3QgYSBzaW1wbGUgY2FzZS4gIFVzZSBhIG1hcGxlIHN0YXRlIGFuZA0KY2FsbCBtYXNfcGF1c2Uo
KSBpbnN0ZWFkLg0KDQpGaXhlczogMGQ0MzE4NmIzNmMxIChtbS9tbG9jazogdXNlIHZtYSBpdGVy
YXRvciBhbmQgaW5zdGVhZCBvZiB2bWENCmxpbmtlZCBsaXN0KQ0KU2lnbmVkLW9mZi1ieTogTGlh
bSBSLiBIb3dsZXR0IDxMaWFtLkhvd2xldHRAb3JhY2xlLmNvbT4NCi0tLQ0KIG1tL21sb2NrLmMg
fCA1ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL21tL21sb2NrLmMgYi9tbS9tbG9jay5jDQppbmRleCBkODU0OWIz
ZGNiNTkuLmM0MTYwNGJhNTE5NyAxMDA2NDQNCi0tLSBhL21tL21sb2NrLmMNCisrKyBiL21tL21s
b2NrLmMNCkBAIC02NjAsNyArNjYwLDcgQEAgU1lTQ0FMTF9ERUZJTkUyKG11bmxvY2ssIHVuc2ln
bmVkIGxvbmcsIHN0YXJ0LCBzaXplX3QsIGxlbikNCiAgKi8NCiBzdGF0aWMgaW50IGFwcGx5X21s
b2NrYWxsX2ZsYWdzKGludCBmbGFncykNCiB7DQotCVZNQV9JVEVSQVRPUih2bWksIGN1cnJlbnQt
Pm1tLCAwKTsNCisJTUFfU1RBVEUobWFzLCAmY3VycmVudC0+bW0tPm1tX210LCAwLCAwKTsNCiAJ
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsICpwcmV2ID0gTlVMTDsNCiAJdm1fZmxhZ3NfdCB0
b19hZGQgPSAwOw0KIA0KQEAgLTY4MSw3ICs2ODEsNyBAQCBzdGF0aWMgaW50IGFwcGx5X21sb2Nr
YWxsX2ZsYWdzKGludCBmbGFncykNCiAJCQl0b19hZGQgfD0gVk1fTE9DS09ORkFVTFQ7DQogCX0N
CiANCi0JZm9yX2VhY2hfdm1hKHZtaSwgdm1hKSB7DQorCW1hc19mb3JfZWFjaCgmbWFzLCB2bWEs
IFVMT05HX01BWCkgew0KIAkJdm1fZmxhZ3NfdCBuZXdmbGFnczsNCiANCiAJCW5ld2ZsYWdzID0g
dm1hLT52bV9mbGFncyAmIFZNX0xPQ0tFRF9DTEVBUl9NQVNLOw0KQEAgLTY4OSw2ICs2ODksNyBA
QCBzdGF0aWMgaW50IGFwcGx5X21sb2NrYWxsX2ZsYWdzKGludCBmbGFncykNCiANCiAJCS8qIEln
bm9yZSBlcnJvcnMgKi8NCiAJCW1sb2NrX2ZpeHVwKHZtYSwgJnByZXYsIHZtYS0+dm1fc3RhcnQs
IHZtYS0+dm1fZW5kLCBuZXdmbGFncyk7DQorCQltYXNfcGF1c2UoJm1hcyk7DQogCQljb25kX3Jl
c2NoZWQoKTsNCiAJfQ0KIG91dDoNCi0tIA0KMi4zNS4xDQoNCg==

--_002_202204271651395s3qcj2u5vqrvwlcrevolver_--
