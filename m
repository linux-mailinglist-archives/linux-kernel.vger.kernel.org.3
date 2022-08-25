Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E192D5A1753
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbiHYQ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbiHYQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:58:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B253B2DA1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:58:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PGhkT8023815;
        Thu, 25 Aug 2022 16:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SxlVpM8XRG/92ZQTn0KqThMeLlIYMQrQfiWWkqUX7uk=;
 b=IHHvWJ/tro7JrPm6Fvs/RA8bN6810/bwNCNPYV/U2hJLAVdIuOXAISGFsnHUOjLmZfoX
 F8jzyAGG8FAkv2OmDAcX2epMFb8BlYkZPyq5Y+58f2plcw0LlYe9SbsZCgvVOiMvwAQS
 hEVWBQ9waqIT29JHwj8aRwD4Tm/XUsBtLMyLjaAeRKlAPE+eulNSHlZxIkLbQkfrrgP9
 jZZUqLKQi0XjTyjNtKaIryNnwybPqZ43rgGxSXQgo7fTx9sXfUt0dAla3pxqzJOz5D9z
 a3gLSzigLftg3ot7mYBI9hKH/zJjRJjIj68q9m09G9aLr05yZwrVikJNWtqGAIEuVBUH VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25q1a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:58:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFJIh5016685;
        Thu, 25 Aug 2022 16:58:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n57uk55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9+Cq/8b+sexw4jswOYbjfK1kIKTNxSjhwz2916v4hbvjHJad6jBJ11ItmGDjtx44K4zchj7sC+oKqPKtcUgsgzuLoT1cjSfZBW1y/IGgO/l9vcCWduBjSrxuYVYZD5wGyij8KkBPIifoDXaxDXvbbBg/ZC2Y3kDbiQenE6sHGbQyOVzW5FHOd6lQHCODa5vTQ1JS1QWF3ms4ctcAgBoHWQ67pOUedEIu8WCP+fuO6wOQ7xfZlc6FINRBQTPoHrZaXMGDv3Mot+bRn3G3jnmPfQG28gLjfp707fPfKRt5VrkhF5aL7I69zJKh91f9qppdYmj56gkW7Ewg9k2FFehiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxlVpM8XRG/92ZQTn0KqThMeLlIYMQrQfiWWkqUX7uk=;
 b=j+8uYkRrysoORZHF8CmQ0Iw5e4byBka6Zvi1DmN732pWuzfuynqP3ec76PhBYoENfTZx5GWF2f23wYSrPNzKfAo23HafvKqETefb5B6MqDoU+2UsGd93XNEf9dbWw5Qhus87+1MZPJeK2B5bb4Ui3oScc9XNj6Bk0T2XctzMhq0jf1Ugg+c85AOwLs5JOAQ/DzkuPBOMQxQru3QDh7xI2ZNCn6jsuyVmGa19wWz2HLbIU5VSUjOoBt6M1CBHVJ3WqmEe5X+czkxbv00wuUhH4bVSRTASR1V5+p8HHjgsp54/eq76eVmfil8eLNDirMLf3PYbPyzSJx5XRg4PlGbF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxlVpM8XRG/92ZQTn0KqThMeLlIYMQrQfiWWkqUX7uk=;
 b=Wai8vd6ak1Gou29AFeF5C5sn9fd1SuhQM6jNonrCGB9lGRKhbHowSRZDEm/AvGPb60OikEkeef5dFh0gn+xZf41Uaq7i4cWpDtSaQhBzVaWCnMvHby8nlmKbHkvpkegYVKIp4vhV2J+MuQ0lLGi23anVKG8IyFLhBmWO0yOIbTI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 16:58:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.025; Thu, 25 Aug 2022
 16:58:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs/proc/base: use maple tree iterators in place of linked
 list
Thread-Topic: [PATCH] fs/proc/base: use maple tree iterators in place of
 linked list
Thread-Index: AQHYt8v0Vq3Ph7IqdUqrxirJlcBD3q2/yEsAgAAP2gA=
Date:   Thu, 25 Aug 2022 16:58:24 +0000
Message-ID: <20220825165816.fisg2infeoec54c3@revolver>
References: <20220824012121.aj2qkzrmdyywu45t@offworld>
 <20220824151129.2023451-1-Liam.Howlett@oracle.com>
 <20220825160132.w4bphicoifyh2an5@offworld>
In-Reply-To: <20220825160132.w4bphicoifyh2an5@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db16b92e-cc0f-4a1b-b773-08da86bb05d5
x-ms-traffictypediagnostic: BY5PR10MB4179:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 896OlLTGSAF4j67JpswWnLDbxXhW/KN70sBllq+3xKpT2Lc8J43szU4Jo7LoaH6dExODTeDG/No7CeTIjOhSmZicGFq7bo3m3buh9JSLMjp+Mkt7hoaCZbejkq/JnOkL/eSwLoqmVfUX/jUkQB9XiPEoyj6l3NBI5578V5wN/s2tP1iOlnFD46qDy5iaJwsh9EEhbyeRKCfx3JbWsH7m5OMTiDLRlLQ7MpWc/ck8OZRZE/wOm6rnyvIONdwISj7g99oZV50X0Y743cHO4Eb8D4oZszwY+XfnVZyDiFqa9E5LZttZzPg6pZ/UG5uz6dgyPshHsgBMcQXwib0InY6Yw8V7UAlnU1m3NFmr9fJfh2W/qHZu+wTi0Jhibay1GFxOhvHE2mgsSnxYHmRKg4HoSnmeakRCvSnkAZv9XbWklqBJlVSFogw6PBYW8dxOsZ72uk3ekQeMAbHjXBC1bUjgi74P9OcbiUR37HTHJ/9A6QndryfwrId0IGItbKq9ySCf9BB9qrsfpq3uQ/+P9RY6ljhTA/C/uv4XTB7SJIZ/e9oyW/H1cLrtYUbovArbGfXB+5fXWz8dy/HKPKH73TdDM7chSj+krOHTEjNoB8F2NjqNMDgTdukjSqWDAoeRhLJhtz6kGI5juc88BqdhLcMRdDYZ7A/IRVe++u2E27jbV/JUxOrtjjLJOCX6tQasgBciNbojKG5kuoIm0KrAgnxlzeLc62ZoDdIBQPcUUw/U5DfmQaf6iQxjFhrX6gd31v8RDa5lbxXtwlj52HOWHHq/1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(396003)(366004)(346002)(39860400002)(41300700001)(44832011)(9686003)(33716001)(2906002)(478600001)(6512007)(6506007)(91956017)(110136005)(26005)(6486002)(86362001)(71200400001)(316002)(122000001)(38100700002)(186003)(1076003)(38070700005)(66476007)(66556008)(5660300002)(8936002)(66446008)(8676002)(76116006)(64756008)(83380400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eweV3unVAkR8y+EJEn+7wEfJxsHb7Cf1DU2jAaaNerwStDd1CrvbKhQP1Q+3?=
 =?us-ascii?Q?goxEKUYsEwtfcN93xsgYvQfH5udNQTLedCCNLolssTt3t4tEku+u+mAKcYHz?=
 =?us-ascii?Q?/SYCKCPGa7501XXyZ4f+sHv0PcxxERFhMjmLZcI6U2eob5en4JleNDgByAAT?=
 =?us-ascii?Q?TDeFN6wpamDkQTma2G9vcZDjCKDgyBvZJf09LjAUX9JoIz/A0Wfz752poqNK?=
 =?us-ascii?Q?6elB70os/Mz5hUe0ahzqD6kxDRArvEGT3+XdeFk9g/AiZTo1h8/DDYBLnoin?=
 =?us-ascii?Q?dF4Ja6lJ9iSv9ywPnDBHQFClFBp3jK4A3gNADVaCMXwtoGoFk6fzf9BOWAVE?=
 =?us-ascii?Q?5FnVZ5JgmRgKU/kNOeBypxLqadmNReb/vYGyc7+T1u0Pg6qfTK/ZctaaylmD?=
 =?us-ascii?Q?9mffHuGJlBf6PN3Lc3hF5Hkewz2kNkzDrCIZ3FcWUyINOLPb12UmyY640NwO?=
 =?us-ascii?Q?h2iOQRfRcQtOJPPvbQMy5QgIupvYxMut1lEoDIAS11XulTvjK2GKI8G7Fe8H?=
 =?us-ascii?Q?H4e3Bcif6exC7iHIwnBzBYg11q2gHd9oNn+sFYB7ueREhQXjOWT/bR9xUIkb?=
 =?us-ascii?Q?xHHE8IieKBpqiSBqFhCxkbkUa6CQjzy7B0T5dcFYg9cQl47e3mN1ArqUuQBA?=
 =?us-ascii?Q?MHXY5JQPq8u1rVa29sEwcNnZenGFDxnpTBWiVcvrnhG+njDAfk01gYnlhY0d?=
 =?us-ascii?Q?X+OE/HQcBV0n1bVjOL51mlr0y9i+0hbpjMqBkciQ+wYT6ZMfdugCzs9+qWW/?=
 =?us-ascii?Q?/ECmjg5/bJVf1PkRWQRJ4wPVvwxfxtBsl5Wj3ojf8n/tnHZ57GrC1/7JV+Uo?=
 =?us-ascii?Q?HVtlgcFf4zj8r5MpU33WaUHnk2jQVkTinsICzdkoKoNgVUBao/ZTmO38lYyJ?=
 =?us-ascii?Q?b0g1nBDGQ1z+5x1p8hj049O+nSC8SRVNroHRXuurxBFojiBqONOA1odIoDIL?=
 =?us-ascii?Q?5+88U4EsJSv9wM5OOo2KL9n0m7OjNutpk4EQNdKncIZG+CCZeY1Lg+U1U8UF?=
 =?us-ascii?Q?kU8nbK9G4/81UTnMvQXmCOpYW2tw9rpZ9ia3Zg2VDpgIVJdwilPz+N+K/zod?=
 =?us-ascii?Q?61TXjGHajZPs+h75t9aO1emg05WiBbnskaM9Skm3YoPMDyfYI8uL/qeUl2Rf?=
 =?us-ascii?Q?45TPlxkuWP87DTh7lOwSq3s9J3yTz2q0QuTa5peM1YVCLqboBFAM6+Oj22dZ?=
 =?us-ascii?Q?Q/rlVDfXhEgY/7+YbYcolKODRv7qW/aR8b1JSfz3jw2Cg3AFA5tKHiDF3Iz5?=
 =?us-ascii?Q?fem/nrt4DIOIvdqp36Lf0Hl2HWWS8YJs+vXKQj3MTRn3OAx5eercZhHwzucJ?=
 =?us-ascii?Q?SfkAwcPFkJ9qUeqKFQKSEwjbznPJNPKQbyMYclrfF1NLBX0jOqBNz9NJGio3?=
 =?us-ascii?Q?E6zlbO+eaSrdQ2inK4HKRnMvylDMGSFxb+oRWpkCPyNAuDONbMz2D3pV3o89?=
 =?us-ascii?Q?n27e6ZAOn1igQUswHtABYJXYwCldz+gjyDCfegTsmOW6WEw0Q2uI+oUITerl?=
 =?us-ascii?Q?uB1LfRSao8QfQVeqfBouvEY5mWEH2JLXlCJ2tqqjCoWsjkYrTI3UrmTMdPSR?=
 =?us-ascii?Q?avFGsAUHmZVuxus+ewzlREHqQ0rhdjq6Ey2NkJTyoYgAh5j3fgC3QV7q9z95?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A567C6B68A3104CBE541BA66771CB0C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db16b92e-cc0f-4a1b-b773-08da86bb05d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 16:58:24.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQDXfobQOicxXhJgMxskOT9cI0N38H9MMU3ZN8axzeuL42tBBnJl6Ae8IbS9BkNdCutixETV60/5UfxRY9je+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250064
X-Proofpoint-ORIG-GUID: BptywlIqtlh-Z932u1QAaDFRV1Hl2ovf
X-Proofpoint-GUID: BptywlIqtlh-Z932u1QAaDFRV1Hl2ovf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Davidlohr Bueso <dave@stgolabs.net> [220825 12:19]:
> On Wed, 24 Aug 2022, Liam Howlett wrote:
>=20
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Use mas_for_each to iterate the list of VMAs instead of a for loop
> > across the linked list.
>=20
> Hmm so why isn't this using the standard VMA_ITERATOR?

the VMA_ITERATOR is for the easy cases.  This one was probably skipped
due to the pos =3D 2 in the for loop and the unknown mm_struct.  I worked
around that in my patch and I think we could switch to the vma iterator,
but it won't be any better than what is there now.  We will need to
declare the struct and call vma_iter_init() once the mm_struct is known.
It would get rid of the ULONG_MAX in the mas_for_each() line though.

>=20
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> > fs/proc/base.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 93f7e3d971e4..0b72a6d8aac3 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -2350,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct =
dir_context *ctx)
> > 	GENRADIX(struct map_files_info) fa;
> > 	struct map_files_info *p;
> > 	int ret;
> > +	MA_STATE(mas, NULL, 0, 0);
> >=20
> > 	genradix_init(&fa);
> >=20
> > @@ -2377,6 +2378,7 @@ proc_map_files_readdir(struct file *file, struct =
dir_context *ctx)
> > 	}
> >=20
> > 	nr_files =3D 0;
> > +	mas.tree =3D &mm->mm_mt;
> >=20
> > 	/*
> > 	 * We need two passes here:
> > @@ -2388,7 +2390,8 @@ proc_map_files_readdir(struct file *file, struct =
dir_context *ctx)
> > 	 * routine might require mmap_lock taken in might_fault().
> > 	 */
> >=20
> > -	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
> > +	pos =3D 2;
> > +	mas_for_each(&mas, vma, ULONG_MAX) {
> > 		if (!vma->vm_file)
> > 			continue;
> > 		if (++pos <=3D ctx->pos)
> > --=20
> > 2.35.1=
