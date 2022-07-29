Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9875852FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiG2PmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiG2PmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:42:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BFF261A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:42:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TETbxo021558;
        Fri, 29 Jul 2022 15:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OyaJ9pl25/GWHJM6Ldivcup5XsiGBBRtIX2wva388Lg=;
 b=rvef1N2c+kSdkYwRkDVdFV16247p73vTJO6/BjAI9+zn0raTu3gUi3Cm6y02Hv3O95ZU
 SEVi3yp7LEnrIzno/K50dfj6mzWQKaB5JXI3XOxkAPfqWjF4fh+5kiGXpN88r9ORyEzJ
 AJioeZRz61R05MF4khRanBFfcx7kjo7qZo6G4rk3mBxAy1e+9ll6SyZJ9CqHGT4DRYIg
 OsPt/4EcsO4KsAE4EvFEeNI7xW1mveaJ7kGPzoRGYq8fCpsdZeUu2AcEPNJa9JmKQar7
 +1Koic+BD+r+GjQjYrf4BWOsTfuDJRNrCcnhanaJ+GySvee8uPZQPBz3iSkwNn/CKGn6 OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ap738j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 15:41:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TEYZJX023031;
        Fri, 29 Jul 2022 15:41:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yymfkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 15:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM8FRGtEUHNFiTIBKXEbm94eOuKhkXZdmUtxdUFXgJ9tD/wIGCjL+Q3vJ7MfsmoqcFpsQvGFn130y7GcKDuDxh0F+LQRZZFg7sk1+qTuaMSPxrDX2lQlyL0zaWImZjOpfmwxLL1YSmlQGzsP0ks3KDtaucYlrKhFD+OMZEwIUzfI0JlHw5wWYcKkBI2Wk+OWAb75qdAIqQDoImPC29vzwxRfBtFK7Vbuk1E0Ezm3gB6r44d1x3rfCfC4FSRDb/B46+zi9lQSgTaGFgcH6mTyFVJH5XtQLeIN0MrYRzO8QMVe7L3hrSnNupUeZvYaPEWOE3QLpwZR6hbghajlzGBAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyaJ9pl25/GWHJM6Ldivcup5XsiGBBRtIX2wva388Lg=;
 b=axaPYRl9ZqnFDDUMdfN4AJ/gzi/KLKQ2D/pXYsso0v7joUzlDVaN3v+uyg9NyAwnQABVrJR/EoULzVWO//6obKX2fkZCpuF6+ppq5M2oHue+24VPOh2XTXZPTcPPlVsmjiEky3DKUI7GuEje0Ent/PLp2Hrv+wF27gGXmaStigV3BNn86D1E2vxy8KpSypDFo04OlkS8KlO/I55+0v00lUyqM3vgftZkZBWTF4sGlMofueWDvXDrNKgsqd/W13Wx+eRnXC/bOlMJ0Usi1NOs99ISeQi2fEdseDGD/uKiC53olRyIYVy9iHtNqY8OzFy5PZmnP/j7TmATwiUeGEruCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyaJ9pl25/GWHJM6Ldivcup5XsiGBBRtIX2wva388Lg=;
 b=XCDza+wLh9VW+ItmV98+soPMQKZhaYGqdw8JSZtD9M7/cVhuZvCSw4V7LRCYdhERW0ae9JEPktxdIvxAex4wxt16MAd3eXpKV9ef8zb2h8o0mb+CdSeFQDXGxEgnmqV22UMB22BlySqIoMQUYpxt70z/1Evfr6LDgxZhsdvGAtA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 15:41:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5458.026; Fri, 29 Jul 2022
 15:41:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v12 08/69] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v12 08/69] mm: start tracking VMAs with maple tree
Thread-Index: AQHYm97mkLAkGOHngEOceAlHl5MTva2RZ8gAgAGT8YCAAo/ngA==
Date:   Fri, 29 Jul 2022 15:41:44 +0000
Message-ID: <20220729154135.zz6use7o25dz4uhm@revolver>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
 <20220720021727.17018-9-Liam.Howlett@oracle.com>
 <YuCGoB3Ackadj5up@dev-arch.thelio-3990X>
 <20220728003401.7fmppx5kbfqmzyjb@revolver>
In-Reply-To: <20220728003401.7fmppx5kbfqmzyjb@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e36b245d-c207-4071-6257-08da7178d76c
x-ms-traffictypediagnostic: CH0PR10MB5081:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ne+1riMaGV9mmLqLUC7GFMoeOAkQ2UStkqgA/gZDXEmAaRrRpG0HCHhILzi7pLqnse9e/5OSACERptHGaQKMrXKWIub+TcZpVKVTiqIC6hjJJEMwt4txmfjnqqx3+XLUZcS2ONl46RpCZpBK2+oYYRD26TvPvKd4HuX3lGfHepLsReTpPgk6HNZNy2yvZ+9nMRd3QYx3RFAi2zPCUPTJJEuQr0MsKSVdzRrgnL40cmCr4FgsfO869eJAWuHhCAH9iauD8109YQzmETNTt20acQNYc40rXVU0zeHnnnX47Iv7mr3FTSuEkMIhmlgsHSDozgaM29nHnQOcfjZf3HoSJ7FWe7kKY8RvBhdAwagIFvj5z3G/W295wW/piej7fHECYpfI3mS2cjLJ1fLSfWaj/YtzlJk2fWkIBLEcSKauCKn6D0z8xv3YShlY7pJH5xV6JF9uRpqufZ61GhWAquQHXwCkAyTrX1npwpEhG+Su0f01fkgxy7yMFzF2SExDXzUHpoJND1ygaSe85sko84l/WhvK0hYkYdQrnTbkjj5Oly61fdOlegPjI0qlRCP0RLplimrUSfce1aEq7ggVIuziUoD3SbM0LltwnHWAi/y0HN3CG2hMmnhZisogv8J7B3u70QAsSWDs+RZI6BvKlAlmw4BNciArenqlsrKkAwlNDDPnmqSP1AyobEf3hUU6CR3Af452rqBOUy9SAxZ14nFb625klagBnm5+L3SOt986P7G888ydc63S+45uU7uVwcqO5xK1ur1d58pXLlb8gjzleqEzEOASO83kQSGn5fRXvJdGOAUblujvDtqlnygFpDayEuh0ukvUiN469z0CDioMrVLy78kh3ZQ2LlQg+ypJWHRHNpAq4vMReVGxdO9DCzKm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(366004)(39860400002)(136003)(396003)(8676002)(66446008)(64756008)(33716001)(478600001)(45080400002)(110136005)(966005)(6486002)(71200400001)(66946007)(76116006)(83380400001)(66476007)(66556008)(1076003)(186003)(91956017)(86362001)(2906002)(8936002)(5660300002)(44832011)(316002)(41300700001)(6506007)(26005)(6512007)(9686003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oDfpWnCBqQ2POZ+OmklmG1BNZaE+vgI4+E1SyamglPuFsPqi/9Ph1868THOX?=
 =?us-ascii?Q?4F9Htp+99XUaD1EBEZW3Vlww0hG5af7y07mR+RId/3Pq/viCt37rKRiExjxR?=
 =?us-ascii?Q?0V9FcYLHogvph3t0GpT9rPzNa6yLbxIyOmQQOYoiYzykLNYe5zadw6esp2Ds?=
 =?us-ascii?Q?cWtFX/8kOe7KF+z7n3r2+ZeUqsNTemjbNoX6bywJcO+NwIQLbrHsCkP53a+2?=
 =?us-ascii?Q?jmt7ncIwypFFVfM4EDPqfa1qbkX9nrY8ir4qMVrnetrN3KKlWuc7j1V/6iWi?=
 =?us-ascii?Q?PHaDfoeINn2lqWD8Pe3eqKT4AFA/hamBZKZtsWzDl2CqlKNB/KNDukUaJCPJ?=
 =?us-ascii?Q?Mi1562GDd58SZsfYu4DpsoMj30vW8RGA8i8xHvU4Mc2eESPXc7BDuYKIyOM8?=
 =?us-ascii?Q?2OckJwQnr1X4mjlAJN3nZnRPAVhVuwLy18GMd0o+3hQA6vQKZxmh2E85QcAG?=
 =?us-ascii?Q?riszh9Z3tkPq0FrdaPm/3fCpAL+JcB9fgtXLqAafxb0k+ZFwppfoHKs0+8y6?=
 =?us-ascii?Q?4mx1TFkYtctCvSn3gKP0ttUgogVrn0sniqCsm53L3G1x7UOFqQr0OpZeEtrE?=
 =?us-ascii?Q?UQkAEgTnWwT2FQ5num3VxB1xfKjIi5ttrNUzQE6tXNVZmSE0l1SwRTTJhLHA?=
 =?us-ascii?Q?UC2MTmFivaD/zk4REzw8Ab2XkgbDeKS649E5dYoYoTUwRDBu1pnKMCe1iGv2?=
 =?us-ascii?Q?ba1YaL7Sjopj4WqSehJH/QNZwvBvxQwIFZWE9YWUsXZCjPeR3NAxQ/0hhaKt?=
 =?us-ascii?Q?8PSY0oxmLYxhioHcjXBlP348vZIbvodNR1yHoXQ7Kd5rUffXqmo/8MwLHn6z?=
 =?us-ascii?Q?nXL/sQgq7APdev6zTrH9KrM8q1612qML9xRfhsef8dRMhggoh4cYeGmWA65P?=
 =?us-ascii?Q?/aHdM4LbgToKOUHare0j0RFFWEybmUhJqTBINcDFBwvBaEL0zQ8uhdhJE/cc?=
 =?us-ascii?Q?Oc7yqb78EUAnqKRl2B6pBza3DO8jUjak1QaLCX51qOWysC20TC8/FwuRKhQ1?=
 =?us-ascii?Q?usT4e0K9eETnC5m4PU/jDDLH0LYF202aKylGoM/hDng1rd1u0qsFHWWy0wl7?=
 =?us-ascii?Q?cMFSHxHxqrlTmMXs21qCQbPMwaC1cRuFy92LxMgt89N8nBYe4fcM0KlLe2qW?=
 =?us-ascii?Q?iW+49O8rhIk6ISh3MMhvRGMUT611wbVh0rHvAYAxR0E4BYvggA5PDkdtOeh6?=
 =?us-ascii?Q?896UKf/qaN/iEnJIVycW3UAD5eWhUG0N8Gwxsrf02r9pczXylerGqSXUmElr?=
 =?us-ascii?Q?eGw+y3QofXrtrud25aT+/LXZ+RkzkAdbYLKaoYUrwHjOc9xwiSEDwkUzr5zS?=
 =?us-ascii?Q?QcgeSNMGdX513iGxRumY4XL+00JD7qGPiDAhwy2K9TD2zCbr57TDiDvTGK/k?=
 =?us-ascii?Q?aJ9F40Rvv2yXahArOaUe80sOBjsFZnxxfm2JI6Pv8MesE3mwS8qiFYZq3Mic?=
 =?us-ascii?Q?WRU42uIcj6ODLtZ7lYkUOwf2MkFj5Yu5/yeEoy3yZ/nYTGZm50cDXn5xldmR?=
 =?us-ascii?Q?ND+cbq2c96HTlWvCnkFswoQsFpAYS17WLfnqpQ6BjzJnnx3vJcVMLJwXzobq?=
 =?us-ascii?Q?CKhhPpQRk2HvhNRkBUaLP5aBt9D91O6YGnGXwc0SrIhZiBObpEJNB6bCrfXi?=
 =?us-ascii?Q?Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB5C9CDD81F8C7449FA54C6C4AF43BCC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36b245d-c207-4071-6257-08da7178d76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 15:41:45.0252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsE5TU8lz9styiYnTP9DwXRUb2lY9VB1lqHLQnlkD0r9hkrsm462ntrvZvlrlEId2WMb07sR+8viAja8OAA9og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_17,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290070
X-Proofpoint-ORIG-GUID: 1XFW2ghG87z1dKsbbXtxHDZdY8fpNT5-
X-Proofpoint-GUID: 1XFW2ghG87z1dKsbbXtxHDZdY8fpNT5-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220727 20:34]:
> * Nathan Chancellor <nathan@kernel.org> [220726 20:28]:
> > Hi Liam,
> >=20
> > On Wed, Jul 20, 2022 at 02:17:45AM +0000, Liam Howlett wrote:
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >=20
> > > Start tracking the VMAs with the new maple tree structure in parallel=
 with
> > > the rb_tree.  Add debug and trace events for maple tree operations an=
d
> > > duplicate the rb_tree that is created on forks into the maple tree.
> > >=20
> > > The maple tree is added to the mm_struct including the mm_init struct=
,
> > > added support in required mm/mmap functions, added tracking in kernel=
/fork
> > > for process forking, and used to find the unmapped_area and checked
> > > against what the rbtree finds.
> > >=20
> > > This also moves the mmap_lock() in exit_mmap() since the oom reaper c=
all
> > > does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens=
.
> > >=20
> > > When splitting a vma fails due to allocations of the maple tree nodes=
,
> > > the error path in __split_vma() calls new->vm_ops->close(new).  The p=
age
> > > accounting for hugetlb is actually in the close() operation,  so it
> > > accounts for the removal of 1/2 of the VMA which was not adjusted.  T=
his
> > > results in a negative exit value.  To avoid the negative charge, set
> > > vm_start =3D vm_end and vm_pgoff =3D 0.
> > >=20
> > > There is also a potential accounting issue in special mappings from
> > > insert_vm_struct() failing to allocate, so reverse the charge there i=
n
> > > the failure scenario.
> > >=20
> > > Link: https://lkml.kernel.org/r/20220504010716.661115-10-Liam.Howlett=
@oracle.com
> > > Link: https://lkml.kernel.org/r/20220621204632.3370049-9-Liam.Howlett=
@oracle.com
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: SeongJae Park <sj@kernel.org>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >=20
> > Apologies if this has been reported already, I tried searching the
> > mailing lists but I did not really find anything.
> >=20
> > I bisected my arm64 test system failing to boot to this change as commi=
t
> > fdfbd22f37db ("mm: start tracking VMAs with maple tree") in
> > next-20220726 (bisect log at the end).
> >=20
> > [    4.295886] Unable to handle kernel access to user memory outside ua=
ccess routines at virtual address 0000000000000000
> > [    4.306595] Mem abort info:
> > [    4.309381]   ESR =3D 0x0000000096000044
> > [    4.313118]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [    4.318422]   SET =3D 0, FnV =3D 0
> > [    4.321464]   EA =3D 0, S1PTW =3D 0
> > [    4.324592]   FSC =3D 0x04: level 0 translation fault
> > [    4.329461] Data abort info:
> > [    4.332329]   ISV =3D 0, ISS =3D 0x00000044
> > [    4.336152]   CM =3D 0, WnR =3D 1
> > [    4.339110] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000020a9712=
000
> > [    4.345539] [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000=
000000000
> > [    4.352321] Internal error: Oops: 96000044 [#1] SMP
> > [    4.357188] Modules linked in:
> > [    4.360232] CPU: 6 PID: 264 Comm: dracut-rootfs-g Not tainted 5.19.0=
-rc4-00288-gfdfbd22f37db #1
> > [    4.368918] Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIO=
S EDK II Jun 21 2022
> > [    4.376994] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    4.383943] pc : mas_split.isra.0+0x50c/0x784
> > [    4.388295] lr : mas_split.isra.0+0x204/0x784
> > [    4.392640] sp : ffff8000094a3510
> > [    4.395942] x29: ffff8000094a3510 x28: ffff08dd66c0c000 x27: ffff800=
0094a3610
> > [    4.403067] x26: ffff8000094a35d0 x25: ffff8000094a3578 x24: ffffd82=
3cb5448b8
> > [    4.410192] x23: ffff8000094a3650 x22: ffff8000094a3690 x21: ffff800=
0094a3738
> > [    4.417316] x20: 0000000000000002 x19: ffff8000094a3af0 x18: 0000000=
000000002
> > [    4.424441] x17: 0000000000000000 x16: ffff08dd66c45450 x15: 0000000=
000000000
> > [    4.431565] x14: ffff08dd66c459c8 x13: ffff8000094a3748 x12: 0000000=
000000001
> > [    4.438689] x11: ffff8000094a3610 x10: 0000000000000003 x9 : ffff08d=
d66c47300
> > [    4.445813] x8 : 000000000000001c x7 : 0000000000000003 x6 : 0000000=
000000006
> > [    4.452937] x5 : ffff08dd68a44409 x4 : 0000000000000001 x3 : ffff800=
0094a35d0
> > [    4.460061] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800=
0094a3738
> > [    4.467186] Call trace:
> > [    4.469620]  mas_split.isra.0+0x50c/0x784
> > [    4.473618]  mas_commit_b_node.isra.0+0x1e0/0x274
> > [    4.478311]  mas_wr_modify+0x10c/0x28c
> > [    4.482048]  mas_wr_store_entry.isra.0+0x10c/0x4a0
> > [    4.486827]  mas_store+0x48/0x110
> > [    4.490131]  dup_mmap+0x268/0x514
> > [    4.493436]  dup_mm+0x68/0xfc
> > [    4.496391]  copy_process+0x864/0x10b4
> > [    4.500129]  kernel_clone+0x88/0x494
> > [    4.503692]  __do_sys_clone+0x60/0x80
> > [    4.507342]  __arm64_sys_clone+0x2c/0x40
> > [    4.511254]  invoke_syscall+0x78/0x100
> > [    4.514991]  el0_svc_common.constprop.0+0x4c/0xf4
> > [    4.519683]  do_el0_svc+0x38/0x4c
> > [    4.522985]  el0_svc+0x34/0x100
> > [    4.526115]  el0t_64_sync_handler+0x11c/0x150
> > [    4.530460]  el0t_64_sync+0x190/0x194
> > [    4.534112] Code: f9000125 f9400e65 9278dca5 f94000a5 (f9000045)
> > [    4.540193] ---[ end trace 0000000000000000 ]---
> >=20
> > I was also able to reproduce the same crash in a Fedora virtual machine
> > using QEMU with Fedora's rawhide configuration [1]:
> >=20
> > [    5.913992] Unable to handle kernel access to user memory outside ua=
ccess routines at virtual address 0000000000000000
> > [    5.914510] Mem abort info:
> > [    5.914581]   ESR =3D 0x0000000096000044
> > [    5.914705]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [    5.914858]   SET =3D 0, FnV =3D 0
> > [    5.914951]   EA =3D 0, S1PTW =3D 0
> > [    5.915065]   FSC =3D 0x04: level 0 translation fault
> > [    5.915215] Data abort info:
> > [    5.915321]   ISV =3D 0, ISS =3D 0x00000044
> > [    5.915465]   CM =3D 0, WnR =3D 1
> > [    5.915624] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000103051=
000
> > [    5.915799] [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000=
000000000
> > [    5.916196] Internal error: Oops: 96000044 [#1] SMP
> > [    5.916504] Modules linked in:
> > [    5.916771] CPU: 2 PID: 202 Comm: dracut-rootfs-g Not tainted 5.19.0=
-rc4+ #1
> > [    5.917003] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/=
06/2015
> > [    5.917339] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    5.917584] pc : mas_split.isra.0+0x50c/0x784
> > [    5.917794] lr : mas_split.isra.0+0x204/0x784
> > [    5.917949] sp : ffff8000086334a0
> > [    5.918038] x29: ffff8000086334a0 x28: ffff5b65c095a258 x27: ffff800=
0086335a0
> > [    5.918289] x26: ffff800008633560 x25: ffff800008633508 x24: ffffdb3=
0c80d9778
> > [    5.918844] x23: ffff8000086335e0 x22: ffff800008633620 x21: ffff800=
0086336c8
> > [    5.919277] x20: 0000000000000002 x19: ffff800008633a80 x18: 0000000=
000000002
> > [    5.919533] x17: 0000000000000000 x16: ffff5b65c095a4b0 x15: 0000000=
000000000
> > [    5.919747] x14: ffff5b65c095a898 x13: ffff8000086336d8 x12: 0000000=
000000001
> > [    5.919971] x11: ffff8000086335a0 x10: 0000000000000003 x9 : ffff5b6=
6f42e2a00
> > [    5.920214] x8 : 000000000000001c x7 : 0000000000000003 x6 : 0000000=
000000006
> > [    5.920493] x5 : ffff5b65c3077309 x4 : 0000000000000001 x3 : ffff800=
008633560
> > [    5.920739] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800=
0086336c8
> > [    5.921051] Call trace:
> > [    5.921152]  mas_split.isra.0+0x50c/0x784
> > [    5.921303]  mas_commit_b_node.isra.0+0x1e0/0x274
> > [    5.921459]  mas_wr_modify+0x10c/0x28c
> > [    5.921565]  mas_wr_store_entry.isra.0+0x10c/0x4a0
> > [    5.921725]  mas_store+0x48/0x110
> > [    5.921864]  dup_mmap+0x268/0x514
> > [    5.921993]  dup_mm+0x68/0xfc
> > [    5.922074]  copy_process+0x864/0x10b4
> > [    5.922213]  kernel_clone+0x88/0x494
> > [    5.922315]  __do_sys_clone+0x60/0x80
> > [    5.922444]  __arm64_sys_clone+0x2c/0x40
> > [    5.922576]  invoke_syscall+0x78/0x100
> > [    5.922686]  el0_svc_common.constprop.0+0x4c/0xf4
> > [    5.922847]  do_el0_svc+0x38/0x4c
> > [    5.922947]  el0_svc+0x34/0x100
> > [    5.923056]  el0t_64_sync_handler+0x11c/0x150
> > [    5.923179]  el0t_64_sync+0x190/0x194
> > [    5.923365] Code: f9000125 f9400e65 9278dca5 f94000a5 (f9000045)
> > [    5.923833] ---[ end trace 0000000000000000 ]---
> >=20
> > If there is any additional information I can provide or patches I can
> > test, please let me know!
> >=20
>=20
> Hello Nathan,
>=20
> Thanks for testing this and your report.  You are the first and only
> report of this failure so I very much appreciate it.
>=20
> I run a number of tests on arm64 so I will have to try your kernel
> config.  Thanks for including the link.

Nathan,

I am having a hard time reproducing this bug.  I had to modify the
config you pointed me towards with the addition of virtio block device
support.  I tried the next tag you had the issue with along with my most
recent patches and neither produced the crash.  Although I was not able
to reproduce the crash, I suspect it was to do with insufficient number
of allocated nodes at fork time.  I've been running stress-ng with fork
& clone in qemu but so far no luck reproducing it.

Can you decode the line number of mas_split.isra.0+0x50c/0x784 ?

Could you test git tag howlett/maple/20220728 from
http://git.infradead.org/users/jedix/linux-maple.git and see if this
issue still triggers?

Thanks,
Liam=
