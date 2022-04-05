Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED6B4F47FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352336AbiDEVYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446251AbiDEPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22143E099B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:12:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235E8Vup014737;
        Tue, 5 Apr 2022 14:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5T72jHxhYTKuP2eHaZilWrAAz+jHI5CvDX5PzLU/oLw=;
 b=elxNExAw27J4QLIm3QBSAaQK+4DGiCOaBirsLz+OfYg4pz3f0ChGWaEuChEPqJdnAkcg
 xPagKDxgB9YS6X3UdrvT0xmXyuVV61QdZ8kZqcDSi/dYJ2Tf3k8RDi085t1+lBTArLC8
 wWQglulfffvpY5+FkfOZAT7Ftw+liMb4l6pXA4fjc12UoqYQH706FdgWd25Bmli/oozJ
 i5stGrAfeNSoLbNtLh0Ez6j458PSB0qmoAGMwbtaQwLDyKjYEyzKlL4VwiwprW/gWGx9
 cNPlXoeWffuGIngUWBa6AYc5NazEsIpv/GQnRcVQMHlQhjjLQN/clPVqmxxvArfa69Xy 5Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9p1se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 14:12:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235E5evH001839;
        Tue, 5 Apr 2022 14:12:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx3rm34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 14:12:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a56lhhHGVhtNxLoqzJuwjwOCY8jpYErK8XHCa7o9iP+jQal+QyuDXdiQmXxiK9GLZi+cm8J23DSudncUuAtPkx+vJojel6upbECT8zrTCELdI66Tz4bsJ/Q9DSS8HcTGodD2PcEkM7KLOMJ8UqBLh+JAC0YdG3ZrVCGyUY0QNm1OGU5wP9Q6mzvbrih1GV7Pv3MHxphYhFdwoj271bKGWHIVlHOzT1hUcslW21E+BV4926eoquc6FKktPsiYp7dGW0pN/CoxGEi+SRaeR850Z7GRJJ6Nffblq9ELoTnRBvDOWblpxoZvCkk5F3YIkeECgQNrK6wSDH05KNyz0I0Wvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T72jHxhYTKuP2eHaZilWrAAz+jHI5CvDX5PzLU/oLw=;
 b=YkDlIjrfLQSp68l1uz0sERPnXH9Vxw8vQPrJaPiFe0WEMyU9tQZo96zN5eVElmHBEh2QRXiBwA/kQ9/9TahQmsChiARnZliY/ROqqJkNEJgbfSgNyipzcuR1PmecAhnmmdaOtZxTV9K8ukMT9VIt5Rbot4EADTu+ARosj7YwWnidztSDXuHSx1Va6lIpPJjU/0XmiIJChL8Z6cWs99zPETHGx798/zd851N7lYQ2El2j8LbVOvVc2cZYIDOiELxQm+i9FcRy5FB7Zks1uDcXti1zG2f/wNIWs/q5y+fA6V2HE6/XREat3KKVN0c/XDcI87NMjqtq9QDQ6BHvnZN1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T72jHxhYTKuP2eHaZilWrAAz+jHI5CvDX5PzLU/oLw=;
 b=DWDwWfotr1kFZ390Mt/s57elJE2+vRsT52fxwNEyQKFrohdgVLGubCptVODLSH+AH1bav+d0lT7iJ/L4ncHX4bBxJi2H7AlHcVn1BsP3ncZOBaKZTlUSjh/Ob2M2cBcGlsJzmtDoWnfY4+/k0Hn2SJ6WqG/UIZ62WvDBqypYqeQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5083.namprd10.prod.outlook.com (2603:10b6:610:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 14:12:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 14:12:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Will Deacon <will@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 11/70] arch/arm64: Remove the merge workaround for
 VMA_ITERATOR
Thread-Topic: [PATCH v7 11/70] arch/arm64: Remove the merge workaround for
 VMA_ITERATOR
Thread-Index: AQHYSDE/UzI7JBk3bkikM7bPEMSaz6zhDaWAgABQOYA=
Date:   Tue, 5 Apr 2022 14:12:11 +0000
Message-ID: <20220405141205.oxo7unti6giy2lho@revolver>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220404143501.2016403-12-Liam.Howlett@oracle.com>
 <20220405092456.GA24387@willie-the-truck>
In-Reply-To: <20220405092456.GA24387@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68d2d831-ec11-404c-5dff-08da170e46e2
x-ms-traffictypediagnostic: CH0PR10MB5083:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5083416864743F12D1326995FDE49@CH0PR10MB5083.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYCrarcVtqNGzHg0M2fkOytw/5FNcp1/Nu5A6UxnqXfsUdVX6wTdZkRc6f1+h7pVbZpxg2jwV5MCs2JKpavbduVcVUPmaWjFiSxLGFuMjaQVb2YB292u+V0QRcDAQcR/hxrDVcMWRxMlf16+CvgDaMbE7yF+Qgh7V1DIWKi4XNIHKgyDxHX9W03g3B2evgRyYBVUJcJ4KHgYexepgodVSKxeCRoh2Y9OC0B6+P0LYmdUDc2SXuS7aCSCQYB5zAwVPHAenhZX6XzVFokt5vxnMdmGCyiPO4T33G+FwDsmekk6syxnFl5ZF9VedxyZPukECSmnNvDvPHgSw9UItp+fPHJpoKWQ9yyagFk/1i9CYM65wxY9mJU8+KIevskOFLd2xliuP+3ZKtbZLQiNVYrbazJ59frzw3qkM/JywQPaL0lTg8kbaADZ3WE1HpTFLTW4P3kozhwP3ehembzKkt10hoUkNgwlu1vsg8vR0GSxKdfIVVLogDF2/Bti9JSv32InCtPSqEcG8/KVwWGfjlrHz7QVN6exHBjp7Jpynqh8VY8bSP7ptkZQ33ZnNKfbA57ZmKu0A0Rei6okmC692eLLzwLCIIZ/ghWat8DEzv9gXe3Wjuf1Q7cR2nvlysMeOAhjV2uQHckzng6fs5UWr22KAy7/9cVvkV1ewXKbrYUqTV2M6ggqS7GNe0/HaBVXCZaKgVCyj/WdyQFeE1shLj8gjYqK8Po9nUh8Ul6Oo7vuIusRNChqcZO9eNBMQj3w/h3gm7hyi20HFT3kWKgEAqc/VslgnvlkIEg1AO9/t1N70ss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(316002)(1076003)(5660300002)(8936002)(38100700002)(26005)(83380400001)(76116006)(54906003)(71200400001)(38070700005)(91956017)(186003)(8676002)(4326008)(66556008)(6506007)(966005)(66476007)(122000001)(9686003)(6512007)(33716001)(66446008)(6486002)(86362001)(66946007)(44832011)(2906002)(508600001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cqar20Ajen6/G30c0GLwaRlU0iEN1SjV0VOs/xae2NVPJA4LZoSQnaNquzqY?=
 =?us-ascii?Q?Lkr1MYNd6MWZOIeJQfMJj/fu0BZv8YXVt0O6oCuS+FMKaDtp27S9hIguWd2P?=
 =?us-ascii?Q?3wUMHVjgnPePoiDBRYqV5Nov2xIZiiUFS+dWFAm8YJ+87xOUY8yZUtXHn0Hb?=
 =?us-ascii?Q?nETywX8KhT+6TpCEruK5exSL28nhO1YIkjwfYYFAc0qGY/eKIFvG34AThmlj?=
 =?us-ascii?Q?kKChnB7iRtLcrZEWaBehWCNoCmUNK75mmag9EAcStU0pkM/I1xjw2S1Er9h5?=
 =?us-ascii?Q?op0iq6m9EXoj+zTYh0L9sQ80Uw/oQO0ARe9hgZ0jQaQbh9UYHBeEMxF5+VIK?=
 =?us-ascii?Q?zAROP47hVtw4Y3kFx2LmdIMf3WqIIeX+ZkuIC2mDFc+J4V06JPrvQmv+DFYH?=
 =?us-ascii?Q?5CuF3x2aEkrxnTsQb8aWXimt7V6q5Bb1fohnj8kOvOX4EcCEXP1DGzoSLM9g?=
 =?us-ascii?Q?CXf7l1Xs3cwiAUXeR6CJ0u85gKHfeANXCqLLyvIluEiiYtVOi0JxIzDbKOFv?=
 =?us-ascii?Q?cknxSOBmCg+oLeLJzMz/mwDAR+mF6htbIiQyq3jF3Be08S0aZj1ScLDvlVyh?=
 =?us-ascii?Q?4j+wjZk1y0jmo6YouINUYLys2O2V8xKiCLkqPdSV1xaFfbv2Tc5cDAh0n/y5?=
 =?us-ascii?Q?spjhrvsqewVa1zrR8CCsHv82oNNMqqzxzKcoVU3EPrlGs3HB/6rxOyt/jmrB?=
 =?us-ascii?Q?bX99IzMbgCxsIONC1Gj/guWtSFVIz1hI88X8DyBqYePFgE9AZX26CVqXuNPc?=
 =?us-ascii?Q?J/SlMITYO9TyThC7Sd43wDy6O5yVJghdK9jDcgqQAK8qfpPfQDK9mu8HQ1Rs?=
 =?us-ascii?Q?XHI6Km880VnVNZbTkXgpJk6rGhlNQs2Cb6ECFF5ag0aJFnfiIcOwaId2Fk/4?=
 =?us-ascii?Q?3ETk41cpKrKqJcq/vMyqOfIUTeKCA0LOXgcFA6FLp0jTeR5HyEHuBlnE/RG3?=
 =?us-ascii?Q?0Tn3gV5HfqShRy+vblF/alAWcdhrpkoHloajucljSNmOrIRmHsiYu1G07JPI?=
 =?us-ascii?Q?hVfN3ba+C8BrFoo8M7A+H/9TB1L29pU57tJheeQiy3LbuhWCs0SO2B8IlCuD?=
 =?us-ascii?Q?9/sb/0zwduqwdOkylyp0esYKdNNw+tw9bEmmsWUwdgJWglO6irTZ2aA1e4Fn?=
 =?us-ascii?Q?Ri/6/B4HFvOkwttviiw56c0ERg6V59MhIJbrJUj76Mvp/4WmeuVQUtsux9Th?=
 =?us-ascii?Q?PdkD9uM5wTSei+Axp6C7ljRECb9B9OgoB2LSAszpKHZX6cS+DI5XZtgBKfU7?=
 =?us-ascii?Q?85NP3BAgjoeHTV8VGDH80ERVsrpWyuzpP1+2rG1y79jOUGRJEY2UFvt3P30O?=
 =?us-ascii?Q?Nw25s1oLOdkY4ZjOnPzTBRFsMdIvSWdjCWB04goXQYS1CBI6A7rPpE/NVOXd?=
 =?us-ascii?Q?yb/CeZ6sbHW+OnsuZO1q7Y7JEfLNMGFjOcBhN1IjW65pXwffjYVP9+QTY5E2?=
 =?us-ascii?Q?7LVCfE145MHstjlUQUPFndSXlLyBFA3IDy1FVJhPS1tKWiCUYxWzO/Az79qc?=
 =?us-ascii?Q?2LpErF6peiXCR7vokkOoKEjMjbVnNP5eUcJO0L6QGmzCZs9Zw/NutJoO1owV?=
 =?us-ascii?Q?Ygg44lczDtAttjj2TJ7nyuZHWXHWf9eaUOQh2Ym/VlVGUhO3abj+c/FzCj2w?=
 =?us-ascii?Q?8TXMOSqYE9zZVH4vOlo7Prk72l3rJuluLGXCAJby1eC/3gaLmi4is0R8QWhi?=
 =?us-ascii?Q?UdKzJcGkTk3DY2XIPRX3yQLeWrh3zmDfpZVeht7JohG5McEeh2KnRxKl7i45?=
 =?us-ascii?Q?puEhTWFaNXjs3sHWvSQPhBQ2yrZQL0o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9861C61918915A43864B2BAC4530AC6A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d2d831-ec11-404c-5dff-08da170e46e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 14:12:11.1786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8IZZ/+EqZj3h2KFyB+CxUct+OfvHx9jTSdCSC2DysBUrQ+vqPJPsqPVLI4WzhjcQWZUkhpq4fyPQR9k+/AFlWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_02:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050083
X-Proofpoint-GUID: CcscDHmq-tH_LZ86vgzBdXXgRSk_qzHc
X-Proofpoint-ORIG-GUID: CcscDHmq-tH_LZ86vgzBdXXgRSk_qzHc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Will Deacon <will@kernel.org> [220405 05:25]:
> Hi Liam,
>=20
> On Mon, Apr 04, 2022 at 02:35:36PM +0000, Liam Howlett wrote:
> > Now that the vma iterator is in the kernel, remove the workaround.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  arch/arm64/kernel/elfcore.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >=20
> > diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
> > index 3ed39c61a510..930a0bc4cac4 100644
> > --- a/arch/arm64/kernel/elfcore.c
> > +++ b/arch/arm64/kernel/elfcore.c
> > @@ -8,13 +8,6 @@
> >  #include <asm/cpufeature.h>
> >  #include <asm/mte.h>
> > =20
> > -#ifndef VMA_ITERATOR
> > -#define VMA_ITERATOR(name, mm, addr)	\
> > -	struct mm_struct *name =3D mm
> > -#define for_each_vma(vmi, vma)		\
> > -	for (vma =3D vmi->mmap; vma; vma =3D vma->vm_next)
> > -#endif
>=20
> I already have this revert queued up as an arm64 fix:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=
=3Dfor-next/fixes&id=3Da0ab7e5bc9651d65637f50ee9c09e083919677ed
>=20
> Should land for -rc2.

Thanks Will.

Note that I'm asking Andrew to include the set into mmotm and not
directly into linux-next this time as requested by Andrew.

Thanks,
Liam=
