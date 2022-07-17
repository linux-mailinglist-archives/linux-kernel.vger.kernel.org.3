Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656C657764A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiGQNCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQNB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:01:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398271403A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 06:01:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26H94Fcl023601;
        Sun, 17 Jul 2022 13:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=S50s97HV3hIG2UBqBszyF+i5N1REGWGdFzPnZ7QUUYs=;
 b=yBEa4nyZ9zWFKqyhlUowSPdLTYKuhECATNPK5HYbU7LpMr2ES+KDzSFrelVGKpOA6SMh
 cPtrgERyE1UdAE3QpbbLrUZPdvfzUfbJXZKU/dGNc+icUVOEXqh6ZKPIGwQG++emGEYA
 rRgD+/uc++jDlS75gDV81Ln5QAlAfQHiONys/DZuXlWjajJHK7/4NrHjymuaU71vgRHS
 HVo65LpLf2HYCvKyKBIP2uq98jCGR3w73/e/4lS0unulR/IIU7REvMp/Nppc+ZkRc9Ru
 +ULt4thNMk2HFo4OZzrW5tQ/plQWkTyqSxEtw+3CFWQh7LW/r1IqJUHG1FP1Q0XBq9cp vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs1g72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 13:01:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26H9XMsr007937;
        Sun, 17 Jul 2022 13:01:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejxs9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 13:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIgkWgxzG/injxy0JCsWBweZ5NeXIIBzvduSy42qbcb2oAE0Kru1+nLf492wrehb0qamFAnrEU0A2qW1G2AHNgMYGoXtEIwqyAFGCC1hCEsmYyutQ5f1gzQEnebdgKApfUxTVqzwhTHVpLbCq11t+C9dgs3RQ1qHRTVyARxcETumQucwL4t8MxtShJbDFVKPghrjFwS6EcdWsC5x8iORkd062RN6EMPcLqqIeObBxbhjN3l3RbQdP+6jUgoee98Qq6NT2C28oRfJZgL8e0GMbPZhfMga6gkf4Ne7/Y4nR6E5g0zosW+nhVL20YhYux9dfstvwt+Uoo7rNlo0N4VDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S50s97HV3hIG2UBqBszyF+i5N1REGWGdFzPnZ7QUUYs=;
 b=Cl/uLWa8t4Hsenyjvmaf0Mg7RmfWCOzARPrDqv1xjHPi2S2uOcnGAsxl7ez6vzVLT529Zw2l941KAC/zmuWmGfRmp9jnjgm7UwEQrFrmXOAaKjIbUsiisTsB1n/CSYt5VTpz7accYsQTRnRyloCQnKexNUj+3eDN4HTnPoaXu9/IG/M3LJOGAzKSGDHVi6dpUo28ixlg57Edp6hOFrhp/SmIU5NF2CKbSy3DhxbRnHNqimzZmSiD80Jw/u4gpFO2CGhtu+S/YsFfOcv2TYhxMoyFEqyt/Wt5T+G825dfMTu+IleWSCGrvVyhZ7lhN4L+RYJL/n1wE1vEXi8/2lilsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S50s97HV3hIG2UBqBszyF+i5N1REGWGdFzPnZ7QUUYs=;
 b=yoA3s7zHespDr6qnEpaoY7ZGnMDr5IQKkOafgNi+2gHUiy/CkXjCeMAWMRXpOWXa4N7qlOzbtP9+qec0eeENeOmtZAHdG/6zFFzLqmxhdqYylivAT2U1M4oCp4umVkBy4oNvXWqz2i3iGziban0TqB/b4q8n4GZBnqwxo7MmGJQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5837.namprd10.prod.outlook.com (2603:10b6:303:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sun, 17 Jul
 2022 13:01:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Sun, 17 Jul 2022
 13:01:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v11 00/69] Introducing the Maple Tree
Thread-Topic: [PATCH v11 00/69] Introducing the Maple Tree
Thread-Index: AQHYmYdscyeMwVIPS0CbwXe7JFDqlq2B9iIAgACRfQA=
Date:   Sun, 17 Jul 2022 13:01:42 +0000
Message-ID: <20220717130134.njpljof5ebeofsx6@revolver>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
 <20220716212050.562604df2a48683dfbcc7e57@linux-foundation.org>
In-Reply-To: <20220716212050.562604df2a48683dfbcc7e57@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13a50252-e183-4ed0-f5e9-08da67f47ed6
x-ms-traffictypediagnostic: MW4PR10MB5837:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: csZJnTGvZ5ED5FN0MiUHAR/QoBSsZ0OP1vji5n7eag4DzfYFH5O2Izi3Hdf7iImrj9sJpOFkOaCuMfnB0q1cpsQ8ShbM1CW70xjI93rOaI8/lgAq09pIuhgRiKlI/DyHL2AGm/NRyGhX9FmJYkkJZa6Ow3Ha+5rIvLB0/PLHBzfjhaRfPrAvNYrFJ+PDta4bVX1uqUDUpe9XOj3gBsFETMFhU5m7m/2Q0FYV0yWO2uPZsHgxaFlMS7H3TNZ/XC1Cq9nrCbAFdHiyfHRYYTZZwt8vT4saPFjOm1EfFjQB2O2GvA3+jAQF4WLe0DEQia3yMAQt07MMyHX0CJusDTdokWeDX3RU16TdZ7rNArnptnaF+ml5BPnysTr7HU23O/IV2eJibGEDyQN0SHKlhLGSYEmhhl0TPzUzmszeaU3WyQhOCfhq+AUtXK+t80+GfJ/MaeMk/ga9HX2eVl82snr1Ix1fGnkpknXmn29UyFkEXCMUz5KFHhkzT8wbGgVWU+UGN1SJVb8pkgE7dsSwyxpSpzFr2Wjjc4+NkySqERXXLJLvqzRdmR3Cy6pmvJ/6vZcZSSUEgC1FmipJHSG5gVuuyWawN/0NPB9jDzprzLBWKgEb6kjFpduNcLtfyzS7jqyCaqlvVKTsYVEzMtKtTbQ9YpFDsGODeJUC1/35XxbMh75MsaQe2Vb5Bb1d9L8R3N+Q7Udq0h9lwjL7z2ZOuck5l6z+jTRfflwvFMg+UyS2LRDiuMen1beBDMDWwuwQxOBxldvyHsPTw1hQnCaL8urjeGi2UbvN2kZq6RGd3xUgsNhxTzyWxsB2DDEbsHXSopri
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(478600001)(76116006)(54906003)(91956017)(8936002)(66946007)(71200400001)(66556008)(66476007)(66446008)(64756008)(86362001)(6486002)(8676002)(4326008)(316002)(6916009)(33716001)(30864003)(38070700005)(44832011)(6512007)(41300700001)(2906002)(38100700002)(6506007)(122000001)(26005)(9686003)(1076003)(186003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nCRCdUhZ1iACokjXYrXpynkDwC5AeBH/lhlpBsP7E4kWIzwP8PsqDc5mc7CW?=
 =?us-ascii?Q?9RP9k+xXnAtlbiPgoQK/GmHNOxjWYX3Ci4S9zHYTwUWvqIYSflG+0npV3QwV?=
 =?us-ascii?Q?QpwJcGT1xLkAnVXH1jRtk2tmsM0vnaief2istWc3XHqfGro65weeyB9Dk8TE?=
 =?us-ascii?Q?eydB1jcjz6/9P/EgZXa4J2L8HB/dNJJRa+ujUGKFQsaweOUoOwphkDjZ/QVq?=
 =?us-ascii?Q?lXe3M/QoZ/nuKGu+kcWcdQj2s4ur6Lqx1tP1bEIrd8JrYjevvXk7aStM9voi?=
 =?us-ascii?Q?HdicLkRx6yW29oFd53fLFfRKWKY0iqp/H3OWfAANBcTQjRyUtHl8FAjTSJK8?=
 =?us-ascii?Q?RzRIbb8PJvy1VXD+t6vcJ57pob/szc1ICfTT3wRLo9ax9uuLMsoChwghZbQk?=
 =?us-ascii?Q?mquC/Gc64qLgM/8Ox1/qyis1Mwa36fE22mR/TLp5swe51zJMiiCxd8z/Ufud?=
 =?us-ascii?Q?q9u5O42c49d+G+p5TpCmpbUc5oAyfhJk1vFqJVZcPrDXenSlf9/5IPZaYCzs?=
 =?us-ascii?Q?Eo86IxezTFN/PKzdIgqwcyJkiMpi3rxJYcLyYc8WKjv/Mx1/5ydykbz54Sln?=
 =?us-ascii?Q?wGEEEFWjydZZ47fWOKNbPDosRYNEjJ5TN4wWdQCTY0+dCoxDa6yyv0QEPkIy?=
 =?us-ascii?Q?l8NHHKmPrjmVjXqZTpXiT1csKC+pIbgzWNs/2uo3wvHmwbTFBOfu6DuekbOE?=
 =?us-ascii?Q?j4v92k2ObPy+0Uz5jFOhuY8ImKVwnFesUl7z5nhW3tTwVfRmnYl5Ie2CDIoa?=
 =?us-ascii?Q?ZS8Q50A+xSBB/fRCcWk19Gv8yxl94J7+MRRhzgzlO6Rp/0sOrs0Up9pP4aOH?=
 =?us-ascii?Q?pi+LeY5GWz3AJYbNUK3ksBDiBNm1JduxFLMDaiR81vpmRJC/xYHXDflVesFS?=
 =?us-ascii?Q?CDeLmJyXb8tzspLH5JIVtJbktIB8EYEDVz7SXMQLOz+5iSdZZmJG9JoVdPpz?=
 =?us-ascii?Q?huANtkcvYfZPraGd93P6utgI5wOu26JjzP56EpsJ+fqL3agMnaxiROpjEBnD?=
 =?us-ascii?Q?YAfpH7CGtBLTmAI6M0rvbXhxTdBHnxjtQIJUSjAtjc3++NB7WFbHI2H7YROT?=
 =?us-ascii?Q?O178bMPjaAGHmt15HkgqUM2Tm0KwKcLKey1BVtvYImX74jROZ1HGIVkEjwBJ?=
 =?us-ascii?Q?hfLY3YZjjXksiE3bOKvDTCRSnpunp06ypwdfZsCxcczlCwJDUCIXdMeLGDwc?=
 =?us-ascii?Q?e4QJw079FqWlnOo0b+ipiUEXvHwexggeEOgUGVpHGWnFfYmxFig0zk+eUvmi?=
 =?us-ascii?Q?nqJa94NXGCauZ7n5HEmyTrlCJ+XCa8M6hFFk0OVOAU25d+nyRWSz28rHaQI/?=
 =?us-ascii?Q?XHyh2phKsc/qlSwfqTTCoioJyP5J62pMsSFbN0r6MSIi5VaMGV8mVjkYwbtU?=
 =?us-ascii?Q?MfQ1jO/4VkdD2Panb8uXrAnEoqSxDR1uy8Y64iQvzdTsxIBLrHUxc6lPjtrz?=
 =?us-ascii?Q?La/BWeAmbf6LV39wAXrF2jnymBvoyjSNsmgC2vQ62fVFjjNGQfhWu+eU3re6?=
 =?us-ascii?Q?myWEj/8GtOnCGjPbvduvEYk5+H9lSOcrvnF4J3Jl7SNTfS3jlLU2ZZ6DwMhb?=
 =?us-ascii?Q?KCAndHt3wWK5n34zNMWHc8pYfaWMqNaJs5PCZ6Ju0x/q1DvOGciIHKysBOjy?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2B3ACCB51983246B400152877DC691F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a50252-e183-4ed0-f5e9-08da67f47ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 13:01:42.3732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MmJSNYwaHFp8wVBQa3SzOUZ8gAqL01YRKqEiLtch4i+Bmk7RdtBGIizy66ZPZtfsMYZMlWO/+WTRCMSOgNNUuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_06,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170063
X-Proofpoint-GUID: Y4_OLaaGlsWHq47iI6ykqU4AnaJt7e7T
X-Proofpoint-ORIG-GUID: Y4_OLaaGlsWHq47iI6ykqU4AnaJt7e7T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220717 00:21]:
> On Sun, 17 Jul 2022 02:46:32 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > This is the v10 + fixes and a few clean ups.
>=20
> I'm seeing quite a lot of differences between this and what we had in
> mm-unstable.  A surprising amount.
>=20
> Please check it all?

Sorry, I tried to make checkscript happy and some requested cleanups.

>=20
>=20
> --- include/linux/maple_tree.h	2022-07-16 21:05:04.697041964 -0700
> +++ ../25-pre-maple/include/linux/maple_tree.h	2022-07-16 21:05:34.509477=
799 -0700
> @@ -225,9 +225,9 @@
>   * @flags: The maple tree flags
>   *
>   */
> -#define MTREE_INIT(name, __flags) {					\
> -	.ma_lock =3D __SPIN_LOCK_UNLOCKED((name).ma_lock),		\
> -	.ma_flags =3D __flags,						\
> +#define MTREE_INIT(name, flags) {					\
> +	.ma_lock =3D __SPIN_LOCK_UNLOCKED(name.ma_lock),			\
> +	.ma_flags =3D flags,						\
>  	.ma_root =3D NULL,						\
>  }
> =20
> @@ -238,13 +238,13 @@
>   * @lock: The external lock
>   */
>  #ifdef CONFIG_LOCKDEP
> -#define MTREE_INIT_EXT(name, __flags, __lock) {				\
> -	.ma_external_lock =3D &(__lock).dep_map,				\
> -	.ma_flags =3D (__flags),						\
> +#define MTREE_INIT_EXT(name, flags, lock) {				\
> +	.ma_external_lock =3D &(lock).dep_map,				\
> +	.ma_flags =3D flags,						\
>  	.ma_root =3D NULL,						\
>  }
>  #else
> -#define MTREE_INIT_EXT(name, __flags, __lock)	MTREE_INIT(name, __flags)
> +#define MTREE_INIT_EXT(name, flags, lock)	MTREE_INIT(name, flags)
>  #endif
> =20
>  #define DEFINE_MTREE(name)						\
> @@ -520,8 +520,8 @@
>   * Note: may return the zero entry.
>   *
>   */
> -#define mas_for_each(__mas, __entry, __max) \
> -	while (((__entry) =3D mas_find((__mas), (__max))) !=3D NULL)
> +#define mas_for_each(mas, entry, max) \
> +	while (((entry) =3D mas_find((mas), (max))) !=3D NULL)
> =20
> =20
>  /**
> @@ -654,9 +654,9 @@
>   *
>   * Note: Will not return the zero entry.
>   */
> -#define mt_for_each(__tree, __entry, __index, __max) \
> -	for (__entry =3D mt_find(__tree, &(__index), __max); \
> -		__entry; __entry =3D mt_find_after(__tree, &(__index), __max))
> +#define mt_for_each(tree, entry, index, max) \
> +	for (entry =3D mt_find(tree, &(index), max); \
> +		entry; entry =3D mt_find_after(tree, &(index), max))
> =20
> =20
>  #ifdef CONFIG_DEBUG_MAPLE_TREE
> @@ -665,12 +665,12 @@
> =20
>  void mt_dump(const struct maple_tree *mt);
>  void mt_validate(struct maple_tree *mt);
> -#define MT_BUG_ON(__tree, __x) do {					\
> +#define MT_BUG_ON(tree, x) do {						\
>  	atomic_inc(&maple_tree_tests_run);				\
> -	if (__x) {							\
> +	if (x) {							\
>  		pr_info("BUG at %s:%d (%u)\n",				\
> -		__func__, __LINE__, __x);				\
> -		mt_dump(__tree);					\
> +		__func__, __LINE__, x);					\
> +		mt_dump(tree);						\
>  		pr_info("Pass: %u Run:%u\n",				\
>  			atomic_read(&maple_tree_tests_passed),		\
>  			atomic_read(&maple_tree_tests_run));		\
> @@ -680,7 +680,7 @@
>  	}								\
>  } while (0)
>  #else
> -#define MT_BUG_ON(__tree, __x) BUG_ON(__x)
> +#define MT_BUG_ON(tree, x) BUG_ON(x)
>  #endif /* CONFIG_DEBUG_MAPLE_TREE */
> =20
>  #endif /*_LINUX_MAPLE_TREE_H */
> --- include/linux/mm.h	2022-07-16 21:05:07.625084770 -0700
> +++ ../25-pre-maple/include/linux/mm.h	2022-07-16 21:05:37.847526599 -070=
0
> @@ -683,12 +683,11 @@
>  	return vmi->mas.index;
>  }
> =20
> -#define for_each_vma(__vmi, __vma)					\
> -	while (((__vma) =3D vma_next(&(__vmi))) !=3D NULL)
> +#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&(vmi))) !=3D N=
ULL)
> =20
>  /* The MM code likes to work with exclusive end addresses */
> -#define for_each_vma_range(__vmi, __vma, __end)				\
> -	while (((__vma) =3D vma_find(&(__vmi), (__end) - 1)) !=3D NULL)
> +#define for_each_vma_range(vmi, vma, end)				\
> +	while ((vma =3D vma_find(&(vmi), (end) - 1)) !=3D NULL)
> =20
>  #ifdef CONFIG_SHMEM
>  /*
> --- include/linux/mm_types.h	2022-07-16 21:05:07.625084770 -0700
> +++ ../25-pre-maple/include/linux/mm_types.h	2022-07-16 21:05:37.84852661=
4 -0700
> @@ -681,11 +681,11 @@
>  	struct ma_state mas;
>  };
> =20
> -#define VMA_ITERATOR(name, __mm, __addr)				\
> +#define VMA_ITERATOR(name, mm, addr) 					\
>  	struct vma_iterator name =3D {					\
>  		.mas =3D {						\
> -			.tree =3D &(__mm)->mm_mt,				\
> -			.index =3D __addr,				\
> +			.tree =3D &mm->mm_mt,				\
> +			.index =3D addr,					\
>  			.node =3D MAS_START,				\
>  		},							\
>  	}
>=20
>=20
>=20

All of the above changes are attempting to avoid issues with define
using variable names that may be used and potential dereferencing
issues.

>=20
> --- mm/memory.c	2022-07-16 21:05:07.627084799 -0700
> +++ ../25-pre-maple/mm/memory.c	2022-07-16 21:05:37.980528543 -0700
> @@ -1699,6 +1699,7 @@
>  /**
>   * unmap_vmas - unmap a range of memory covered by a list of vma's
>   * @tlb: address of the caller's struct mmu_gather
> + * @mt: The maple tree pointer for the VMAs
>   * @vma: the starting vma
>   * @start_addr: virtual address at which to start unmapping
>   * @end_addr: virtual address at which to end unmapping
> --- mm/mmap.c	2022-07-16 21:05:07.716086100 -0700
> +++ ../25-pre-maple/mm/mmap.c	2022-07-16 21:05:38.104530356 -0700
> @@ -341,27 +341,28 @@
>  	MA_STATE(mas, mt, 0, 0);
> =20
>  	mt_validate(&mm->mm_mt);
> +
>  	mas_for_each(&mas, vma_mt, ULONG_MAX) {
>  		if ((vma_mt->vm_start !=3D mas.index) ||
>  		    (vma_mt->vm_end - 1 !=3D mas.last)) {
>  			pr_emerg("issue in %s\n", current->comm);
>  			dump_stack();
>  			dump_vma(vma_mt);
> -			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
> +			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
>  				 mas.index, mas.last);
> -			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
> +			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
>  				 vma_mt->vm_start, vma_mt->vm_end);
> =20
>  			mt_dump(mas.tree);
>  			if (vma_mt->vm_end !=3D mas.last + 1) {
> -				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
> +				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
>  						mm, vma_mt->vm_start, vma_mt->vm_end,
>  						mas.index, mas.last);
>  				mt_dump(mas.tree);
>  			}
>  			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
>  			if (vma_mt->vm_start !=3D mas.index) {
> -				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
> +				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
>  						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
>  				mt_dump(mas.tree);
>  			}

I removed px here to avoid leaking pointers - although this is in debug,
so maybe it's not that critical.

> @@ -448,7 +449,7 @@
>  		unsigned long vm_start =3D max(addr, vma->vm_start);
>  		unsigned long vm_end =3D min(end, vma->vm_end);
> =20
> -		nr_pages +=3D PHYS_PFN(vm_end - vm_start);
> +		nr_pages +=3D (vm_end - vm_start) / PAGE_SIZE;
>  	}

This was suggested by David, I should have sent it out as a patch before
v11.

> =20
>  	return nr_pages;
> @@ -710,11 +711,11 @@
>  				 * remove_next =3D=3D 1 is case 1 or 7.
>  				 */
>  				remove_next =3D 1 + (end > next->vm_end);
> -				if (remove_next =3D=3D 2)
> -					next_next =3D find_vma(mm, next->vm_end);
> -
> +				next_next =3D find_vma(mm, next->vm_end);
>  				VM_WARN_ON(remove_next =3D=3D 2 &&
>  					   end !=3D next_next->vm_end);
> +				/* trim end to next, for case 6 first pass */
> +				end =3D next->vm_end;
>  			}
> =20
>  			exporter =3D next;
> @@ -725,7 +726,7 @@
>  			 * next, if the vma overlaps with it.
>  			 */
>  			if (remove_next =3D=3D 2 && !next->anon_vma)
> -				exporter =3D next_next;
> +				exporter =3D find_vma(mm, next->vm_end);
> =20
>  		} else if (end > next->vm_start) {
>  			/*
> @@ -762,6 +763,7 @@
>  				return error;
>  		}
>  	}
> +again:
>  	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
> =20
>  	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> @@ -852,8 +854,6 @@
> =20
>  	if (remove_next && file) {
>  		__remove_shared_vm_struct(next, file, mapping);
> -		if (remove_next =3D=3D 2)
> -			__remove_shared_vm_struct(next_next, file, mapping);
>  	} else if (insert) {
>  		/*
>  		 * split_vma has split insert from vma, and needs
> @@ -881,7 +881,6 @@
>  	}
> =20
>  	if (remove_next) {
> -again:
>  		if (file) {
>  			uprobe_munmap(next, next->vm_start, next->vm_end);
>  			fput(file);
> @@ -890,22 +889,45 @@
>  			anon_vma_merge(vma, next);
>  		mm->map_count--;
>  		mpol_put(vma_policy(next));
> -		if (remove_next !=3D 2)
> -			BUG_ON(vma->vm_end < next->vm_end);
> +		BUG_ON(vma->vm_end < next->vm_end);
>  		vm_area_free(next);
> =20
>  		/*
>  		 * In mprotect's case 6 (see comments on vma_merge),
> -		 * we must remove next_next too.
> +		 * we must remove another next too. It would clutter
> +		 * up the code too much to do both in one go.
>  		 */
> +		if (remove_next !=3D 3) {
> +			/*
> +			 * If "next" was removed and vma->vm_end was
> +			 * expanded (up) over it, in turn
> +			 * "next->prev->vm_end" changed and the
> +			 * "vma->next" gap must be updated.
> +			 */
> +			next =3D next_next;
> +		} else {
> +			/*
> +			 * For the scope of the comment "next" and
> +			 * "vma" considered pre-swap(): if "vma" was
> +			 * removed, next->vm_start was expanded (down)
> +			 * over it and the "next" gap must be updated.
> +			 * Because of the swap() the post-swap() "vma"
> +			 * actually points to pre-swap() "next"
> +			 * (post-swap() "next" as opposed is now a
> +			 * dangling pointer).
> +			 */
> +			next =3D vma;
> +		}
>  		if (remove_next =3D=3D 2) {
> +			mas_reset(&mas);
>  			remove_next =3D 1;
> -			next =3D next_next;
> +			end =3D next->vm_end;
>  			goto again;
>  		}
>  	}
> -	if (insert && file)
> +	if (insert && file) {
>  		uprobe_mmap(insert);
> +	}
> =20
>  	mas_destroy(&mas);
>  	validate_mm(mm);
> @@ -1613,8 +1635,8 @@
>  	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRI=
TE;
>  }

This is fallout from the syzbot bug from the patch I sent Hugh.  This is
the expected difference that had to change a few patches in the series
as it went through.  I should say that it's slightly different than
Hugh's copy.  This copy searches for the required VMA only when needed.
I actually really like how this turned out since it was able to simplify
__vma_adjust().

> =20
> -/**
> - * unmapped_area() - Find an area between the low_limit and the high_lim=
it with
> +/*
> + * unmapped_area() Find an area between the low_limit and the high_limit=
 with
>   * the correct alignment and offset, all from @info. Note: current->mm i=
s used
>   * for the search.
>   *
> @@ -1640,15 +1662,12 @@
> =20
>  	gap =3D mas.index;
>  	gap +=3D (info->align_offset - gap) & info->align_mask;
> -	VM_BUG_ON(gap + info->length > info->high_limit);
> -	VM_BUG_ON(gap + info->length > mas.last);
>  	return gap;
>  }
> =20
> -/**
> - * unmapped_area_topdown() - Find an area between the low_limit and the
> +/* unmapped_area_topdown() Find an area between the low_limit and the
>   * high_limit with * the correct alignment and offset at the highest ava=
ilable
> - * address, all from @info. Note: current->mm is used for the search.
> + * address, all from * @info. Note: current->mm is used for the search.
>   *
>   * @info: The unmapped area information including the range (low_limit -
>   * hight_limit), the alignment offset and mask.
> @@ -1671,8 +1690,6 @@
> =20
>  	gap =3D mas.last + 1 - info->length;
>  	gap -=3D (gap - info->align_offset) & info->align_mask;
> -	VM_BUG_ON(gap < info->low_limit);
> -	VM_BUG_ON(gap < mas.index);
>  	return gap;
>  }

These were added in an attempt to restore the previous VM_BUG_ON(). I
must have errors in them.  These should be dropped until better tested.

> =20
> @@ -1884,12 +1901,12 @@
>  EXPORT_SYMBOL(find_vma_intersection);
> =20
>  /**
> - * find_vma() - Find the VMA for a given address, or the next VMA.
> + * find_vma() - Find the VMA for a given address, or the next vma.
>   * @mm: The mm_struct to check
>   * @addr: The address
>   *
> - * Returns: The VMA associated with addr, or the next VMA.
> - * May return %NULL in the case of no VMA at addr or above.
> + * Returns: The VMA associated with addr, or the next vma.
> + * May return %NULL in the case of no vma at addr or above.
>   */
>  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr=
)
>  {
> @@ -2642,7 +2659,7 @@
>  	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
>  				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
>  		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
> -				       NULL_VM_UFFD_CTX, NULL))) {
> +				       NULL_VM_UFFD_CTX , NULL))) {
>  		merge_start =3D prev->vm_start;
>  		vma =3D prev;
>  		vm_pgoff =3D prev->vm_pgoff;
> @@ -3036,7 +3053,6 @@
>  		unsigned long addr, unsigned long len, unsigned long flags)
>  {
>  	struct mm_struct *mm =3D current->mm;
> -
>  	validate_mm_mt(mm);
> =20
>  	/*
> @@ -3092,7 +3108,7 @@
>  	vma->vm_flags =3D flags;
>  	vma->vm_page_prot =3D vm_get_page_prot(flags);
>  	mas_set_range(mas, vma->vm_start, addr + len - 1);
> -	if (mas_store_gfp(mas, vma, GFP_KERNEL))
> +	if ( mas_store_gfp(mas, vma, GFP_KERNEL))
>  		goto mas_store_fail;
> =20
>  	mm->map_count++;
> @@ -3155,7 +3171,7 @@
>  	vma =3D mas_prev(&mas, 0);
>  	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
>  	    !can_vma_merge_after(vma, flags, NULL, NULL,
> -				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
> +				 addr >> PAGE_SHIFT,NULL_VM_UFFD_CTX, NULL))
>  		vma =3D NULL;
> =20
>  	ret =3D do_brk_flags(&mas, vma, addr, len, flags);


These are all cosmetic fixes for checkscript.  I now regret making these
changes as I increased confusion for very little gain - plus the second
from the last is incorrect.

I should have prioritized stability over cleaner code this late in the
cycle.  Let me know if you'd like me to respin with just the addition of
the one fix sent to Hugh.


Thanks,
Liam=
