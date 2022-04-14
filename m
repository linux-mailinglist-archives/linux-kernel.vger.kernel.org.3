Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDCB501747
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbiDNP0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347986AbiDNOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:01:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AF23BBD8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:57:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EDdIUr028178;
        Thu, 14 Apr 2022 13:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3b02cFDFXYnEM4p0l7DQ2sWogdP+j9RarNDfxh8SQco=;
 b=aPF6WCvb0eQ/0YBksHHFNybktc+zBgkYi9jGE8H8ZD/46zrGqomgkQlYbAtrSOU/RBIF
 XJuPVIH5azmetrkYv3SGejL8Mk49RGpAHlOLONtXfc24xkT6B9WAV+6wcqzLFJA98lr4
 m2DsIGfgVSPw3tpgNtqeSUNMcrNVfRwil+r9mPYZf74cSxBa7AJyty2k488yqa9gGWXE
 mzZPZfZ72nfPeTl2lUaITN512JNEpHhnbLthPK6GgCLUIWcSlxK9rf41/DDlmgltbCFZ
 p/na7FU8NKsLWylRT1I1y8htpiYO7Elq9r9jmb3iR0IIypNOWTVFBLzOb3Day6lfB7MN yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a4e7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 13:57:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EDpPDc030104;
        Thu, 14 Apr 2022 13:57:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4tjh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 13:57:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bScEHuCTB8058BkH5QzsTKINN47uh0i8qqXHUCJuMe20PYHKqc3f5ryArqdvFAJoox7n0UBaIWDprwKvG1TpyZIZfLTHQrZ++++Tx5KUTNws0i/QDoYK86H2TSAYQQNuXMFi3bnFXjn8tNdaFxiqaHIHIoJL+a8FM3qT05/uh30v96dirdrAyXOrasgaWyckpM72pFzZHIA858X4nJt/EccuufNlXOB49UPkPUib6Gar4XGkMet9NKlQnqdohE2Vuj1Qv0RZsB19MtVjCqCg70IILmkZDjv0+2xRhdXidxNMcSWKJ1TwDo5Qe/Gz02YsCB1/9nErOz0PEy08qSCExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b02cFDFXYnEM4p0l7DQ2sWogdP+j9RarNDfxh8SQco=;
 b=CCZbaCZWkTxGepO407TkjngToCPKWm1k9VZl+Mq6JCfdmxBdeqKSgVm6nRnKw+kJxCgL0kaCsES691xJsTZ4rk7CdWS6mgEwevGBaHnZakjgTWP+vzsfWM00dtQvbDJxyx5a2/2EsJKL4bceVOn4Bdvxj/z+G7CWQqnG52xZQHQWlCb7mAS0YO/ON0lt6my5dM50AwmRxYt/k+hcuDOVe6HcNFzkx0M8e2y3dox9NN7qJC2ghj/jJJkEnyHUw/3cOfV/aMsCfdpO8RRofjkItjlknbRsFCGZs7pde6eQh/vcIa5pWG2Dh9Ra/vTeMZLXmBzthW1o1e3D30dz0m/51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b02cFDFXYnEM4p0l7DQ2sWogdP+j9RarNDfxh8SQco=;
 b=QaQTYJ2kTkmCZwS61ND/d1Rc1qPmO1ycNi1UIeHcyA8sDShBCPj4ujcmRkiXVjQ76ip7IvEoGVZzdDpcxWQJ4Oo3Jj/f8wbIfJrSP0sdf9h4mcx72/BlMNgyWOmO7YHD23JewXfM5O60yi6lIn4LIzqOtuu2IRTcHrt4Bu7psr0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1370.namprd10.prod.outlook.com (2603:10b6:3:f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 13:57:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 13:57:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkqzvB5KAgAB3GAA=
Date:   Thu, 14 Apr 2022 13:57:14 +0000
Message-ID: <20220414135706.rcn7zr36s2hcd5re@revolver>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
In-Reply-To: <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35f144ff-2c82-4c3d-ff53-08da1e1eaddc
x-ms-traffictypediagnostic: DM5PR10MB1370:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1370F9CEE53F6A082C94C8EEFDEF9@DM5PR10MB1370.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OwWTYw+QVSVBUZNjqdnd/6FyWia11mraxPC6TCalRc7op/Sv6s8/ZJP32aBS+aEAAkRptFGJw6WOpsFpW8zbHSTzJCDkWC7u5pLJ9KRIu9rgOSzU2K8sYuenUc+G9EDQJmznp2k2MI0u0cXzlTzgQAkSQNrl8jhcGKLm3DIXL2b11fs5dknuodtSmOM8dHg0vpCJ0Fel+o3nccST6/aPgpAp8KK2h/EyrpZV+EcimJj/4wHRzuDJQNQWbmAZp3zwsjuC9JtEaRYJoqaFtflEbiIrskc8dh6lzWHsGfFPIMdfrtG2dYXvwSvhimcWpYBj2kgiYLwlGR+jWsw+PPBxj3ovFlYd8gRCPHKJWL8QFj7YJ0dKoe6FK+u04qdvIfQjGlMSZ/OcTKznbjq2Sa3jOV++em/AU1gDbQis81iLMOF8P/su+Dq5ZbZdSbBxnR4f+OBQu6RPoScF3nEbJhSvSVJb4oFFyTFc7UwT/wojzL0F0xKigzVInRDip+9wo2j0/xPBi1Nh59eDQhv1OZqmemxgSvMYtDNDkaBELCdxm9TvvwxIAiKTDAESDNAPqJigPzh1UqSf8XX2NLvmzn14C3getXx7nI8kisWx8Qmr/3U0NWQotnH3FTS+p8BkDzP5VymV4IWZxGT/KFrmQke5EQr9P+JcqJb2UcaYdRPNv3K0WvmWLXRg96gDuFYElu+TN+t2Sw9I2iEbvBaH+MxOrm8bwnZM8mSCaaMNNvYtZ0ZpPqlKMOHxypW3kRK52tnXV9ZkeEZ2sEgnfdauVKwuIfK/q0Mu+0AgmMK1ay5BGime280P4V3MA11HuOYyMHBbIw5m+bIx4mPqPDFvhlbKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(966005)(6486002)(38070700005)(508600001)(71200400001)(6512007)(6506007)(9686003)(83380400001)(186003)(26005)(2906002)(38100700002)(6916009)(54906003)(316002)(1076003)(122000001)(76116006)(91956017)(8936002)(66946007)(44832011)(86362001)(5660300002)(33716001)(66476007)(4326008)(66556008)(8676002)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IO/EeLW+hWlUG2Xng4EZ/rUN1PTE2w3B5nUNeldl2U77fxfJOfFmZWND2BnM?=
 =?us-ascii?Q?E4iEZxagGbzpEQbeerq4CM5qCIMaI5sZXtYylP/afaGQL3Z2HAU2uYU3YAOt?=
 =?us-ascii?Q?OGylD2dOFYG5pHAQ7j9Ph+T3pl73q9+D7nUG53kWNwyrbs9WnoAQeDdA1iCG?=
 =?us-ascii?Q?fko0ZfGZCZicuBECy6NF6S0b7ocIzWjfevfYTNDpSKuybzwnmiTWH9hx7eBT?=
 =?us-ascii?Q?PbkRdYqEpqcrrqJziKnpqbLLpPKFaoefdeacDTt14b5WdwTGbzQMc3G0a5YE?=
 =?us-ascii?Q?z8/pqZ6JbtRhZM4zNzRmIukpO5Gj49kIomqbFjtTygAXqlY4Z0BLe3Ap/efY?=
 =?us-ascii?Q?U/jQ5df7sxQN8tYXmKIbu4wvK9mBovEFJph/F64y7I7oHi15i3Gdna3RV1va?=
 =?us-ascii?Q?C1hdjXclVuDsCgU3BVAXobAQwIBf9+s21cFpvTA+bL9YAySSHZSPqi0dOslF?=
 =?us-ascii?Q?ZQ+XNYi4O/F42CHu8j6Q1nBpyJ00hQKCWRAF3j7vzBjb7jseP3/zOPqoMxER?=
 =?us-ascii?Q?mWHOJCQ9/9qjewdmviOktFSoKQoA923VkzieEGJ7qfkIymqYZWX6wnw+OQ98?=
 =?us-ascii?Q?cKddzeKydVGXiJTA+V6w/ze+F0KpZQGKVOf6zMvUpkGiw7QWeE5Qre37i60G?=
 =?us-ascii?Q?hIs6ho3qlXSTdOxHFsgAEcZaaqQHuRrAUWB/Z+MZMrtfFnoSB4p/F6RHrD7h?=
 =?us-ascii?Q?c+a562aI0LssxSaGMjBtkaX50+HCF3wtW8kdmAJkTMwHEcX18oItHnRCOfjy?=
 =?us-ascii?Q?G+YsN0SxtXmUcJULMURzkgE8yP3GkurIED2XdHX+XvMSIOaWLaMEir3tNJsk?=
 =?us-ascii?Q?xjLj3a65gkK5/RmTvDmBX1JeGRdIAZ8OV1e6bWdpqhsjbWxul0HwKyERgmD6?=
 =?us-ascii?Q?U/Xkhyzri0urfUh8g3C3x2e00P+8rcfGQCYlfQpRH/yY+5R6oA5Qa/6wlBAK?=
 =?us-ascii?Q?Uw3p0NIq0H+eD06K/9t44Of7slqjVznq0kWK/YoD+eED8Qydlv9S6ND9sj1l?=
 =?us-ascii?Q?eiuB1N6fGzvfJ9R0A25ikeepv/kx7ifQ1vt9TAfAt1J57GF+jubDyau4lrlR?=
 =?us-ascii?Q?Qk62CyC0x4XtIVmmUNHis8H+CkSe6rMzsHOljVbLyfkD8tKh0YDjEYMrzLcM?=
 =?us-ascii?Q?kYTg1bgluf1gmCQjoonCqXtNVJ9ukluyYgxMeVc1Z8Dlie9YJ/kRCTQxSrSq?=
 =?us-ascii?Q?ggJm7WZikVSUXjC7/wehuMowPTour+nhmq70clqawZE9m9xETVRRiukVjJHK?=
 =?us-ascii?Q?CMTkoWu26szWzvQ5BTK0VsTq3hsIscBEJ3swr6t5f9iSy0vFgacgUZ7Tp2S4?=
 =?us-ascii?Q?ZKOvuQhtNaJ7bo8LJ9jXyxY6wPDzgXmnxk7zhFm3zOAh+wyewib7H+soSycj?=
 =?us-ascii?Q?drxNRyub/Zrf2UD6BAYIPUtXhJu5d/0FqzoAZ92n9S7Y3bwIHCGmhIZL3rz6?=
 =?us-ascii?Q?4qEV4eItZR6llJCns+2ZAqm1Znzh/ARPpbZ6bW0wibJ/Pk+F5OqbHL4A57aY?=
 =?us-ascii?Q?xgBUXn372tbkfNRyphKxXHzwn4r9Wa9NTjb1QNOML9DgBtd6B/l3nGeTZnTN?=
 =?us-ascii?Q?oQosEiwEHBOCI+YJu2PxaEB+DHe/N7vf/QFQvBNwNTJmMT81T1MtYrwc46gw?=
 =?us-ascii?Q?KQzUQp6GzcvaYaGqyAb0hf9OAycA8R7CsFzCWKm+M3cFVYKCNFyv/GEKbjDH?=
 =?us-ascii?Q?ujSkIcOlymGGhGGLfZwzUohmWT+FLDcu+jKiV2K0TJzwxjT6nP9oDXGzPgG7?=
 =?us-ascii?Q?SkAj6lyQpmaDCRssXiFvlJxc1aZpY2U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40042027B1E8174AA34C5472EB2EBADC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f144ff-2c82-4c3d-ff53-08da1e1eaddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 13:57:14.0359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xytYUCAVA4wdcPNTlwAtHewWU49aVgTu+Udpfbeg3zP5YzZXUCdYOIZkIH7qVTcdwALrtXKJFVR9NXjcDINhaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1370
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140076
X-Proofpoint-GUID: KFdwKNUCF5r-w0pdmQ4YRK64cKpjedrk
X-Proofpoint-ORIG-GUID: KFdwKNUCF5r-w0pdmQ4YRK64cKpjedrk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220414 02:51]:
> On Mon, 4 Apr 2022 14:35:26 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > Please add this patch set to your branch.  They are based on v5.18-rc1.
>=20
> Do we get a nice [0/n] cover letter telling us all about this?
>=20
> I have that all merged up and it compiles.
>=20
> https://lkml.kernel.org/r/20220402094550.129-1-lipeifeng@oppo.com and
> https://lkml.kernel.org/r/20220412081014.399-1-lipeifeng@oppo.com are
> disabled for now.
>=20
>=20
> Several patches were marked
>=20
> From: Liam
> Signed-off-by: Matthew
> Signed-off-by: Liam
>=20
> Which makes me wonder whether the attribution was correct.  Please
> double-check.

I'll have a look, thanks.

>=20
>=20
>=20
> I made a lame attempt to fix up mglru's get_next_vma(), and it probably
> wants a revisit in the maple-tree world anyway.  Please check this and
> send me a better version ;)

What you have below will function, but there is probably a more maple
way of doing things.  Happy to help get the sap flowing - it is that
time of the year after all ;)

>=20
> --- a/mm/vmscan.c~mglru-vs-maple-tree
> +++ a/mm/vmscan.c
> @@ -3704,7 +3704,7 @@ static bool get_next_vma(struct mm_walk
> =20
>  	while (walk->vma) {
>  		if (next >=3D walk->vma->vm_end) {
> -			walk->vma =3D walk->vma->vm_next;
> +			walk->vma =3D find_vma(walk->mm, walk->vma->vm_end);
>  			continue;
>  		}
> =20
> @@ -3712,7 +3712,7 @@ static bool get_next_vma(struct mm_walk
>  			return false;
> =20
>  		if (should_skip_vma(walk->vma->vm_start, walk->vma->vm_end, walk)) {
> -			walk->vma =3D walk->vma->vm_next;
> +			walk->vma =3D find_vma(walk->mm, walk->vma->vm_end);
>  			continue;
>  		}
> =20
> @@ -4062,7 +4062,7 @@ static void walk_mm(struct lruvec *lruve
>  		/* the caller might be holding the lock for write */
>  		if (mmap_read_trylock(mm)) {
>  			unsigned long start =3D walk->next_addr;
> -			unsigned long end =3D mm->highest_vm_end;
> +			unsigned long end =3D TASK_SIZE;
> =20
>  			err =3D walk_page_range(mm, start, end, &mm_walk_ops, walk);
> =20
>=20
>=20
> I flung a tree up at
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mmtemp containing
> mglru and mapletree and a few other things.  Could the mglru and
> mapletree people please runtime test it, send any fixes?

Sure thing.

Thanks,
Liam=
