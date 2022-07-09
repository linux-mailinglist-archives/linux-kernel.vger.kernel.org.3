Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49AF56C59B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiGIBJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGIBJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:09:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBD37CB4D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 18:09:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268JSmif012711;
        Sat, 9 Jul 2022 01:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tyEp4M+E0APdklHGEh5PDqPzN+M7v5K1qTORoTuk4e4=;
 b=BlkpkRVNgJUTZ64g7jNUVssGkwlEiihhXQKfk/nZZZUBuAfKluPBox5CEVrK62beAm44
 Fv1HK8iXlHO3ckwZtsmqwvnwd5lKFSCc8E8GmuhaBGtKqNG3YjI9Uh+l0dxoWAXvbdwJ
 L4LnQ0VfGN72L2aDoz0Zw1Mb6vKcEpc4zeRTVvj2DDo8bPwY93n4goLWp+LWaBeWC2Fk
 F+uYdNcqTHY2wdY60zWLxnXhIazPSnBIheeYzRSUoCvc26oXLtLInfc9q8PPNmAgn0T/
 N+4pT95Jal2V51iNG5jTMhw2zK1EfM7hYYyhXOUqOxp7b5cvVCiCYNZEEBhoRpeqLxxW 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyh2sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jul 2022 01:09:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26910JDA003587;
        Sat, 9 Jul 2022 01:09:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4udahw0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jul 2022 01:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDPv0qrpIshJyvZnZbIiNCtvMJcXfeusyZkQCktO0Y43MDfTKpQahrSQS2FZ5GnX3QZrYp+OFP+/lf9LLf3XRtmQ50QhI9g4+AIYDekSXLip+msiiWpf+TQo3+OmZfG4OUrh2rVf1LH2VXR137AVn+SZ3jzvzdA2ei4RWuJlhDdhz2UaI54gAyVy9xwn358Cl9OZkvjntKpOq8dBeOG+EJuUhaJgX/pt8DyHS5loaGdn5QQs47fN8BjpZhV3+0O6zm1mI7CqKvE11vqSsSaSwCKBnkelqZxdhgCH6Q5ebLGoPOgGbwl+LGYzLzfD3IyEiOyAl71tf6DLcGc8Vf8aSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyEp4M+E0APdklHGEh5PDqPzN+M7v5K1qTORoTuk4e4=;
 b=I7Lkv0QMTNxmtPqlJsV1S9eSLRELwtX3ZaiU2TAtNx2GOoJ6B3ZO9yZrlCL530qViIpo2kb636ImO5dNPbGFqIMaMK7ieC1DLnrSUfdZKUK2keIaMluNoe897RI8c5AAqK8Y0osfmZVb7FJQ+nJyo0qeluAolybQKdedW0rLdpKCD56Q+AAYHyZJswE/H8wV59ZsgTynHEBDjqTv09tLSG8mC7PQZ3cusCg7H7uxqRNqvn9N9puaKuRqI/RZXGTr3efQNE4xsZzzK5XOKEBOe/oP+OaYebLn1tsrg1pWOc/zQJ2ltsyIEf4InN/2QTv5dC5o877ethD3iBV8E08Rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyEp4M+E0APdklHGEh5PDqPzN+M7v5K1qTORoTuk4e4=;
 b=xbBkomTu1MyL+YtpjATzWCwNHMdlUW9ynqpMVYQyDBsIleplj+2mPfL5UeP92U9HT7ZXZGksWLXlc9MnMYFQETNIc6h0RyyalwjnoBRjndExHAkI985DYniCbEf07CNjHt3LZ/L1ciWFhXs/jWgY47cflyKl8Hj/yINUZ7ud6aI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM8PR10MB5462.namprd10.prod.outlook.com (2603:10b6:8:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sat, 9 Jul
 2022 01:09:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::6cb8:8ff0:385f:1c54%3]) with mapi id 15.20.5395.022; Sat, 9 Jul 2022
 01:09:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] maple_tree: Fix use of node for global range in
 mas_wr_spanning_store()
Thread-Topic: [PATCH] maple_tree: Fix use of node for global range in
 mas_wr_spanning_store()
Thread-Index: AQHYkNzinLp2ekiGvkSjFulTKej6T61wpgCAgAC78ACAAoVEAIABWBOA
Date:   Sat, 9 Jul 2022 01:09:22 +0000
Message-ID: <20220709010913.3wsh3vmlwcloqz7g@revolver>
References: <20220706020526.1869453-1-Liam.Howlett@oracle.com>
 <20220705195535.a32ce0de9b45fe73eea72c82@linux-foundation.org>
 <20220706140814.hjf5d2hbfupd6kyp@revolver>
 <e2df94dc-f54c-ebb9-14f0-98b232358d4@google.com>
In-Reply-To: <e2df94dc-f54c-ebb9-14f0-98b232358d4@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9161a51c-55a9-4985-538d-08da6147a863
x-ms-traffictypediagnostic: DM8PR10MB5462:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yY1M4Z1M0MJBcYvxh7oCAA+aLsdj/ECfDWLn1T4oVyno9txGrlnEj/oIdcI+1GrDUC8fp8JKENn0W+ogHbV9yfzhVgrQrfu5guZ/In8KCy80IXOS4NnanT8ZT52b+Jiv6+gqzDhe+oSahbJNT8Ff9apCqBzcbBmTltghVVmcwS6gD4uZ0yvLWvLy9+CKEsqEyyb5U3KjEEgZeGA39WGSpVpahTmP5TVIhtZYP45k0eNSuyrpH03zQ84rG6ie+FlBnWdYjTd8WlrWaf7W4N3hin1csvYx8c8SNjWs94NwSnF/z55zx8ofj0IzT9IRJFpo9XfFE725iDLm5IQK5pHM3WVDCSxsyALofAui/lQd7IGWib6fGtbB7WIGsFCXyAzMfxdo9Bm56rd3/3lrKM7GgrE/p+WLyRjcD2SouWbv1fSpt3Y9VdFCwbci4VHoPb+DYvW67+M4wh+L0kVdD7ce7fpbdzfR+WhqaVtX7lqld2EHENF/ytU6HfFPLJWc6I1ED5usG1ODomLnhiCvJuOzKR8DBRIod4XA2xBoNYuw6qYRVLRex13GXu6qHKfslRNHhkYvYYptgB+Slq7FfoJnPjqkz2TvQp5+U92Pe8tgfbULnZ4b0ktcqAbU4fPyKAI2qKaibuUDF4Gpt718FqVWMA33oWjwM1fGycofY4BjSbkpZ3vhSeYz9vxSpqqJc2gmcbF2HkJwmK2XOtqVzX9aF1OsHWpVHB3ENwPgUMKgHDaJ8UG3DvUKBr3a6Rjm/7h5YS4A/MlcPxetpFwHx8QAHN7UkhUr/GzalpQqxrQnRBERjpwVNpH8+Ymy4Jdv2Yl7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(396003)(346002)(366004)(376002)(33716001)(54906003)(316002)(66556008)(66946007)(76116006)(64756008)(4326008)(66446008)(66476007)(91956017)(122000001)(38070700005)(8676002)(38100700002)(6916009)(9686003)(6512007)(26005)(44832011)(41300700001)(2906002)(71200400001)(5660300002)(6506007)(6486002)(83380400001)(478600001)(1076003)(86362001)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d+fyfNTi/FxoFnhOrAsGC0rxWE1rRxc8NZQVBphros9Dqdl8vqqimUWfZAyb?=
 =?us-ascii?Q?XdimIhS4gbSBeaVIscuHiPnT2UfZXVdFDKQqPO3/tI4rMHfY0GbkuaTg0Dn0?=
 =?us-ascii?Q?hjlBwovTM0msz0pPY5/+jNMZF8OpYZhscQuP6DeTVBk5OnQieSQVi+gBtHnu?=
 =?us-ascii?Q?Sqly80tezNSiUfRLvTWB7x/RuYfz0Uc7fr8L70QQbBums86iRpbs6mLsox+0?=
 =?us-ascii?Q?tu/wt2n6GzgPHLIR7d8Iywmsi6EuejgdapBZu2gGMGGYF4YTyM9b7fbWfW5e?=
 =?us-ascii?Q?fTJR8NRJq1ne/tFTtvR4Bg2rM+kYS9FmbLusja2PUWzG7qiOFLjRKpRAYqRx?=
 =?us-ascii?Q?yv07HvQQZnzzf2ZOhu52CYnc4YIuaE6Hwe+NiVVANMRZ+w/1Pf3Jl1Le+JGY?=
 =?us-ascii?Q?dGsegQC8s4l/dOZngV/X+fpPDKH9XBscdSoLQkW8F6DsUrE/XYXxD7hyWZ25?=
 =?us-ascii?Q?64bcsFxoDrIvxIOfqxLo79tE7mScshytSJlPfs2BFTJFUXCsdofIyVr1SasN?=
 =?us-ascii?Q?4WklYBi/Gi5E+htcmvZSivb0ERl3nA9pEO3sV3ZDkBAyORUS+7gFka4grkrt?=
 =?us-ascii?Q?7XiAS0WRrWinr9s/RqOcZ68DHqB4mvkR131uIGSPaUStWl1AAOCldhgjUwCp?=
 =?us-ascii?Q?T3hYEa07N37jGY8wUa09y1OmDBlQiaLX6W/bGSSi6Zvn3XZlfAwNxhaq78zO?=
 =?us-ascii?Q?5yBkGmCu7cjBm27SGCcHYT/pP+X2YWgAIygT+1NHOy4vs5LJPpNJFbMGKiLV?=
 =?us-ascii?Q?s7jqogpw2hiznHvvws4pSx5G1irTUTReqLf2UFAWNNfYlDQjxRqtRUlkfAo2?=
 =?us-ascii?Q?x1hwsBUopmegvZfTtK8qOEIPGeWpbKGz5gwObWM4YJnE9bbnmLO52rrJmtYB?=
 =?us-ascii?Q?lf0K1VLaqF/mr6msDbJTL6hH1gXY+L8kIIrm08FeOM09zzSo8m1MCemjXo/k?=
 =?us-ascii?Q?QqkxRmA6fg9PgHIk3Zy54L+OhYvMojEofn7lUFHWomYJ3+4fDFIV6/G4ND8s?=
 =?us-ascii?Q?7IkOIH39AJjchQIces7o/do94XRxY/d2F83TOGFDWyCNpYT3Pc3btofq0FRE?=
 =?us-ascii?Q?08nPQsMzRdkTZnvyijyzpLui93eWtdmU95qYUzKqvqtHfekJjADPeO95L4sK?=
 =?us-ascii?Q?RywfOQRtUu0TNXBkKShIaxFFdVnoKqDTNxyRuqR76QW8itt/JDjMBAavrzI8?=
 =?us-ascii?Q?tEfRLMHeY4XiLUlXNeNequFCeCZ1nDiUbohBkGqImjSPprXvsItxbAvh/22l?=
 =?us-ascii?Q?La03wk2ntztQpNWZ/M9GLsCaZpknivT79CdLbtwAxY6JR7dzNJ5cqKkwgDN3?=
 =?us-ascii?Q?U0WBioyKhDHilfIxLBZjI3LQd5GauFtZb3d3nTJofwdfKkmvn5Zinruw5fCI?=
 =?us-ascii?Q?BC1KrfHEBNm9KDbGTo+huncum1DRCqJ5rHJ/Ylq+rLmjc/O1MqgwnTVN1/Kr?=
 =?us-ascii?Q?Yg7e6sfmumnxNqR21WkTcAdzx1qQ3NZpXVjbxigoqjty/bGDswASZyjbPiYS?=
 =?us-ascii?Q?uvWe9S6UNqmdj5Hlccc+jlHZeaVvEtFG/GgEYH4L3WqWlETltwU9mhEag4Kt?=
 =?us-ascii?Q?wokXmHJyIjkSay8Q5gHWPqe/LjMhY/BtcgBPwDrYAptK4r79OHVwxBXj9otV?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99C4ACDBE132974196ADB5DBC5596C14@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9161a51c-55a9-4985-538d-08da6147a863
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 01:09:22.1688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JjtZ8dOqNlem/gQyhLIMJALB37t0YJ8MbBy/81yvsdy+X1RgkE+Dc1BkWdVS+bulexl2gtuGq/aDSm1pyGhZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5462
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_20:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207090002
X-Proofpoint-GUID: UYOsn0L_wvEPtJrnJTGcP9Ju-GmtGdxg
X-Proofpoint-ORIG-GUID: UYOsn0L_wvEPtJrnJTGcP9Ju-GmtGdxg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [220708 00:37]:
> On Wed, 6 Jul 2022, Liam Howlett wrote:
> > * Andrew Morton <akpm@linux-foundation.org> [220705 22:55]:
> > > On Wed, 6 Jul 2022 02:05:37 +0000 Liam Howlett <liam.howlett@oracle.c=
om> wrote:
> > >=20
> > > > When writing a range with a NULL which expands to 0 - ULONG_MAX, do=
n't
> > > > use a node to store this value.  Instead, call mas_new_root() which=
 will
> > > > set the tree pointer to NULL and free all the nodes.
> > > >=20
> > > > Fix a comment for the allocations in mas_wr_spanning_store().
> > > >=20
> > > > Add mas_node_count_gfp() and use it to clean up mas_preallocate().
> > > >=20
> > > > Clean up mas_preallocate() and ensure the ma_state is safe on retur=
n.
> > > >=20
> > > > Update maple_tree.h to set alloc =3D NULL.
> > >=20
> > > Cool.
> > >=20
> > > How are we looking now?  Any known issues still being worked on?
> >=20
> > Did you pick up "Subject: [PATCH] mm/mmap: Fix copy_vma() new_vma
> > check"?  I sent that yesterday as well.
> >=20
> > I think we are in good shape.  There were two outstanding issues I had
> > and this patch plus the copy_vma() patch fixes both.
>=20

First, thank you again for looking at this patch set.  Your analysis of
my changes always end up educating me and making the code better.


> I'm not so sure.

I agree, I have a few more issues now.

>=20
> I haven't gone back to check, but I do think there was a very recent
> lib/maple_tree.c change or set of changes which greatly improved it
> (say an hour to reach a problem instead of a minute).
>=20
> But errors I do see still (I've only had time for it this month, and
> there have been three other non-maple-tree bugs in linux-next which
> got in the way of my huge tmpfs kernel build swapping load testing).
>=20
> I see one kind of problem on one machine, and another on another,
> and have no idea why the difference, so cannot advise you on how
> to reproduce either.  I do have CONFIG_DEBUG_VM_MAPLE_TREE=3Dy and
> CONFIG_DEBUG_MAPLE_TREE=3Dy on both; but might try removing those,
> since they tell me nothing without a long education, and more
> important for me to write this mail now than get into capturing
> those numbers for you.
>=20
> One machine does show such output, with BUG at mas_validate_gaps,
> doing __vma_adjust from __split_vma from do_mas_align_munmap.
> That's fairly typical of all reports from that machine, I think.

I woke up to a log of this, or something similar on my server - I've not
seen it on my laptop either.  There have been some connection issues
here so I've not been able to get the details I need to reproduce or
narrow this down.

>=20
> Other machine (laptop I'm writing from) has never shown any such MT
> debug output, but hits the kernel BUG at include/linux/swapops.h:378!
> pfn_swap_entry_to_page() BUG_ON(is_migration_entry() && !PageLocked().
>=20
> I've often called that the best BUG in the kernel: it tells whether
> rmap is holding together: migration entries were inserted on one
> rmap walk, some may have been zapped by unmapping meanwhile, but
> before midnight strikes and the page is unlocked, all the remaining
> ones have to be found by the second rmap walk.  (And if we removed the
> BUG, then it would be mysterious rare segfaults and/or data leaks:
> which I cannot call "stable").
>=20
> Hitting that BUG suggests that the rmap locking is deficient somewhere
> (might be something else, but that's a best guess), and I wouldn't be
> surprised if that somewhere is __vma_adjust() - which is not quite
> the same as it was before (I wonder if the changes were essential for
> maple tree, or "simplifications" which seemed a good idea at the time).
> If there's a way to minimally maple-ize how it was before, known working,
> that would be a useful comparison to make.

I have not seen this bug.  I have re-evaluated my changes to
__vma_adjust() and do not see any lock moving as you discovered in
vma_expand().  The changes to __vma_adjust() were to remove the linked
list or inlined functions that were reduced to a line or two.  That, and
preallocating to avoid the fs-reclaim lockdep issue.

>=20
> Here's a patch I've applied, that makes no difference to the problems
> I see, but fixes or highlights a little that worried me in the source.
> Earlier, you had that anon_vma locking in vma_expand() under "else",
> it's good to see that fixed, but I believe there's a case it misses;
> and I don't think you can change the lock ordering just because it looks
> nicer (see comments at head of mm/rmap.c for lock ordering, or mm/mremap.=
c
> for an example of what order we take file versus anon rmap locks).
>=20

I will fix the issue you pointed out in your code. I'll also have a look
at any other areas I may have messed up the locking -  as soon as read
that block at the start mm/rmap.c a few more dozen times.


> Hopefully maple tree stable is not far off, but seems not quite yet.

Al Viro also told me he saw a significant regression to xfs test 250, a
slow down of a factor of 2.  I started to look into this as well.  I
have not seen this slow down in my testing, but that must be flushed out
as well.  Perhaps my access to larger machines will help in the
reproduction of this issue as well.

So there are still a few issues to contend with before this is 'stable'.
Any analysis of the patches you are able to do would probably expedite
the stability path.

Thanks again,
Liam
