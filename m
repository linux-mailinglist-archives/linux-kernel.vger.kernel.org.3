Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA353EA6B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbiFFQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbiFFQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:16:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA62186B8F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:16:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256FXMPw031331;
        Mon, 6 Jun 2022 16:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+uOBAkbA6pa02NH39Rh5+VLZK1knwhXszvh3tSSIzUE=;
 b=iyIHmQjc3zfFv2fvFC3tk37KyccFRoJ5qK29pKAuwh+IPmpB9iCFLvJjyqnsgOICQHun
 BgMNkpKY+JQv4LglBhLoj5pQCMoTj1p/GFND4/91J/053oMhp07GBEYeIHkqUkhfXrl3
 Lr3AqC+ImsqUQYx4eCh+mHZYOdSNguwYn/LKF5WT7RIEago2F95/+GWhWys+Tj7wsY6H
 PWYlUfegHZ5WHUBMVGDrFHQiqQcIl6F0WGHDahjqyvs8QvxmjO+MS+/aSEz0bYYJ+7T7
 q+nHgQPyBUGwirAAI+sA/4riPEzpfbQH6Bot3T8GCSzlnNG66N2B4cFSIjwr6KY3c7rV 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxsbm6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 16:16:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256FttKt039119;
        Mon, 6 Jun 2022 16:16:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu1u08h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 16:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEjE9t/WSwQu4iTAGgMyfllioVKwzkXy8kG7Z40g4akd9GnIEy7NXUFN9wzCBifS4SDO1R/x6l6YKJkXh7rES5NgeRYKhTkL9O5fxa/uoy7N01+Zs+syj3FCdDlQXEKlA4Nd/V83NzG949hjLHCSRr4vKXLqweHFc3T0DNEhD/vzBSdv6lef9K4NWVJH1g0ty07K4C+6rrT/npxdk0WTDns8gKCM1VP1aOMtrUEmEt2r6gQov6Zo0cinWhhM5AZCTzL34MYx9shLRXKNKslvyhSyEYISesqYqts6/C8zd+K/Jqb5+C+lIs3oN8qYHh2huq6uJl6NdOy296KtnYwEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uOBAkbA6pa02NH39Rh5+VLZK1knwhXszvh3tSSIzUE=;
 b=Ay5pjv6QmGK3c2oOAaVfYTr65XrlzxNAVED/hQUahCtGG7Gan9CepgpkwZLqG2BgMsfVGcEsLfV/8+KTgu3UGv/kroMay50iNpx/iZIlKgnQyJzHrZClndjPE3AlzcoqAp/+jRafiv9bbdqAAMEXbJyPPXkQQzQbyYYYzfJQNFAvC/baeNySv6XCWAT9bM1J3YVtUe5SJSE1Xr9JXPl8iZ0tqw2wyO4awIJKokCFYzjZ2whKdowSKGCq7i9BMDYlLt7U2B4HW4H+8gApfOXbrgxd5vE0pzy/QNkDAlpURCZQ670T4h4b9k3NlDrUb26FXRZM2n9gX6ckxYkpgLIKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uOBAkbA6pa02NH39Rh5+VLZK1knwhXszvh3tSSIzUE=;
 b=KClKc3idOFDk5WP7IVjhoP7MbMgpfiJUhzm8qlLZarWLqNGryJYySgeTylNgKPE00hQTggtYxJnpqO3oJrsULJWjl45S4D8v9KespEbucdXKLjcPTwRTytWMh1R+/lVk9VacyeIgVfwFt1KmanqJJFa7C92oxvJ3Kg4lRSmWw90=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 16:16:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 16:16:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Thread-Index: AQHYX1NhZKDMPG7C/keyeY6aTlfpJ61Cgo4AgABAVgA=
Date:   Mon, 6 Jun 2022 16:16:27 +0000
Message-ID: <20220606161612.ujglo6i3zbnrygqs@revolver>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
 <20220504010716.661115-10-Liam.Howlett@oracle.com> <Yp3yYmNJ5dd8g8Ur@qian>
In-Reply-To: <Yp3yYmNJ5dd8g8Ur@qian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 217be93e-1c0c-421d-9b04-08da47d7e923
x-ms-traffictypediagnostic: SJ0PR10MB4623:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB462342E23B9AF0BCDD36D317FDA29@SJ0PR10MB4623.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfHJM5Ec6Tjv0s3e+4wOqkwdItP4Mo2vvpl/TUi/ivdTkkFskcnT3s/iVHReQoeesBDlP+xwIHP+YXl1MWVAPuklQMt+lw0bAgd9sinW8Kz9Y0P4NRz/seTg2q+qSc5Rxv5LgiqVvMaf05oKMJ6tAbbiymf0OasS5RuZT+U6aC+tVU7jY4nEEO6AjU9s8oIpxjEcmG+MJeWbX4Pb+Mw0JbTqavvQx0mB/i2w+JrJOfYvC5VfGgZjDPSTdoCnsoDC5hqcri5xmr2KzovKrMeAVsoxQYSFN6ksH8G3pKXx716MWcXfhXDHxoJUYqd8Zi1wApTwirC/qBbzTvM+WYHLcQtZtdWLP5SZZUB7a/hww7zFC2QjtGpCYDvStJI2uvqnFrdYWW6GbaikOISUP0ZHr5lY2OpsEO+0N+G3/5B04ggAEeZ3iYoje2QXqb9RjTd0LXQh9iPgynKscXsH3z9/tB2pFMlaNgPeigssvHafMB2Qib+M/RSD1OoTNxzeSxDQw2WdW7jthpfKvbFoVojhshd8umAhDIpKTMq07HIIbXQfbPaynpJuaKBOPii4V34ydKBmeDLdJTPAgmq/2JlLgz11tz+3W1w6Hj2x3O8vRJ3Kjxp3oe4dQlY8ZPCNJhpGdjroAZYML4EaPX5mfwJ2O05ypLAIKDQzHJ+BcuWVxzavpKQq64a8Fhce/mzt1X7tr0e5wCAJ4fWxM6bXdb1r3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(86362001)(122000001)(2906002)(33716001)(54906003)(66556008)(8676002)(64756008)(4326008)(66446008)(66476007)(76116006)(66946007)(6916009)(44832011)(5660300002)(71200400001)(8936002)(508600001)(91956017)(38100700002)(6486002)(6506007)(1076003)(186003)(83380400001)(6512007)(9686003)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DGfnIaFmB8vv8JKC++qf8JhDNxxqTxd+2Hs9yofuphZCr3MmVISPEuqV27Ns?=
 =?us-ascii?Q?n6PvupyUtj/mVXWmq5blvmIPnT+2NQb/fDmAltxN0thQ3kEG5KEyCiO/t+nv?=
 =?us-ascii?Q?9AiGDO5Fe8gLqzOI+HRb2Eij0Xx3OfSpbUT653PA5SrFXiAi8dTCiO101HXz?=
 =?us-ascii?Q?FZ4O2r8vJk+HiHBy/mQF5NcjQ8gfdo4CKbscsgjaFwUakOdA4qsIPe5yCO7S?=
 =?us-ascii?Q?7ENDy1zA/sS8sJ84RG+TumRoKNPN/1WJOLlhFFEaDqqZoanTwG4m1z1eFepP?=
 =?us-ascii?Q?eGCQb2vhUZhrZDW1jQYdjclNjE1lUhjzBMaOtKceoxuDgblZYMbCpfNonIqq?=
 =?us-ascii?Q?1ewV3hFMBLMeJGQHvaHGkBn9RV6KMngcotvgpazRK7Nr7I4IBVBj3np5Dj7B?=
 =?us-ascii?Q?tNKEFXLUGa73ytQucOwFTL4fd6vlFTCVVkVsAHfaDwekkLR5LZHm02/XSSDK?=
 =?us-ascii?Q?ki7U5ui/5DG2FsrIojei3BAZGmKyY6DOS6cjHEUO/qajWquQJiPtYMaHCfk0?=
 =?us-ascii?Q?/+PvJTKYZzpkF6KYsZJsU6vIAHskGQMndXnUh5p+Pn3KvA+goMbNXfJADKjS?=
 =?us-ascii?Q?L7jKIRuRCBzc1G9qNWmi2BPwx68mWSXMEBi3bBe1tkols3DrSJVTyI33p8Yx?=
 =?us-ascii?Q?xM2iZE1YGvE0oLCQ8NcZhMV6n6a13EYNeJemilof6bs1ak9W4EegIJvNuMgf?=
 =?us-ascii?Q?bX4694Cnrq/YDzyTSimWJADEbwcJgTPNnoyizqvLFCnQ8NjdPmuzWEdrYH4T?=
 =?us-ascii?Q?+9Y8JsY9Gqffp6XE5OTMy7SDwFRBq7MjIQwFMO/hhtcGTG57ZO1+VMDviJWs?=
 =?us-ascii?Q?SaZmGjT9cqoVqWYOvGM6ZYaGnRgT7Tfs5R7Urmdr+pmXELzltqADzSZS6S28?=
 =?us-ascii?Q?BXrF9gJBAhU3fqWNww35CcKnGrVr0IPNJq/FB6Hh7DoIFe6/mNPEGsfE99I8?=
 =?us-ascii?Q?uk6rVxNmK3RfMprCY9QXGnUpzHRfL3L778LFWYi9TAUFhPBa6vGIyavXMygp?=
 =?us-ascii?Q?8+7JQeiCR50ZFdFrHWjS9+Cl/gBH1g7Nae1900F1ZPgHUYtYxBmjEWGkBanr?=
 =?us-ascii?Q?OxB987HSZzcIMajn5Q6c3DkN8pg1Z16AkbRClDHoVzwMz/lVMpE7KKq52t5J?=
 =?us-ascii?Q?rxqILwi+v7Ep8I9gje8LZGn4KsPOIS+h7dihCnvIWYYXm7pf8bGVIk5auLw/?=
 =?us-ascii?Q?9HoSi/e2W8NV/zoG73EG3EbQXoEaCvDXEdiJHD0MvXNSNY9qY1ejCQ/8ZrII?=
 =?us-ascii?Q?L0zKM2L44tAz94pUwsXFLKJewS6mErXib+Kd+P701ymYvwlZ19Gpt7OdNWZr?=
 =?us-ascii?Q?xs3G8vwyXrNZVDdvtJw4dlfKGiS/XOu3iDo2aC2lf2+wPIxvyE2N4o9iRVOv?=
 =?us-ascii?Q?w/P5I32vuaFxXb/8kpXRDdzQTH0e+mcK4Qbl7a0xd4bbXBxVUQH9KN52xzTi?=
 =?us-ascii?Q?ghP31clV/dirtKpY2DMkibp8JRIyMvbWQttHbJ/57J1qP1ksm6fDyIA45KnQ?=
 =?us-ascii?Q?CrV+92gQLSwZjxG79nyQ05U/+GUH21D15I2gOYeAxmKKTVZj8B31gOSeMAyU?=
 =?us-ascii?Q?71+wdtBuMKe1Snr2H8/eXwSRE4t+48EJM0gfnLXBwyryxmvw2TL6zPDqZ0Q7?=
 =?us-ascii?Q?+ACeSo6p1LXzjpWYZIqpQg4ZM1x6iynqowr2vENYl8+ITGnGjiGmSPmKlW2H?=
 =?us-ascii?Q?71OhWKhBmdL1QpcXpvETzwI64SVqmYP6nwg2KlArRMq6RHG7acDmBnSvBn11?=
 =?us-ascii?Q?At+0ggveHiiDRR0gPPbB3hnB29F3JxI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6794BB504C13184D9FCDB017885F89E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217be93e-1c0c-421d-9b04-08da47d7e923
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 16:16:28.0687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qopda8rkB6UeRh+MuUT5Kl9jy1NcIb3i2ne0fbUfboSQ0WOIhSzSWg+gOJEm9zi3KlLFXsFynd7ByOkOpI+rwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060071
X-Proofpoint-ORIG-GUID: 4os9EUdxEpGGkonnOeUUJcgQ9PzMrQmN
X-Proofpoint-GUID: 4os9EUdxEpGGkonnOeUUJcgQ9PzMrQmN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Qian Cai <quic_qiancai@quicinc.com> [220606 08:26]:
> On Wed, May 04, 2022 at 01:07:52AM +0000, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Start tracking the VMAs with the new maple tree structure in parallel w=
ith
> > the rb_tree.  Add debug and trace events for maple tree operations and
> > duplicate the rb_tree that is created on forks into the maple tree.
> >=20
> > The maple tree is added to the mm_struct including the mm_init struct,
> > added support in required mm/mmap functions, added tracking in kernel/f=
ork
> > for process forking, and used to find the unmapped_area and checked
> > against what the rbtree finds.
> >=20
> > This also moves the mmap_lock() in exit_mmap() since the oom reaper cal=
l
> > does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ...
> > @@ -842,6 +969,12 @@ int __vma_adjust(struct vm_area_struct *vma, unsig=
ned long start,
> >  again:
> >  	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
> > =20
> > +	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> > +		if (exporter && exporter->anon_vma)
> > +			unlink_anon_vmas(importer);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	if (file) {
> >  		mapping =3D file->f_mapping;
> >  		root =3D &mapping->i_mmap;
>=20
> Running a syscall fuzzer for a while could still trigger some memory leak=
 reports.
>=20
> unreferenced object 0xffff4021439c6100 (size 256):
>   comm "trinity-c32", pid 1329067, jiffies 4301918356 (age 231692.944s)
>   hex dump (first 32 bytes):
>     00 61 9c 43 21 40 ff ff 1c b1 65 1d 02 40 ff ff  .a.C!@....e..@..
>     ff 2f 42 97 ff ff 00 00 ff 2f 43 97 ff ff 00 00  ./B....../C.....
>   backtrace:
>     [<ffffd4be60434e28>] slab_post_alloc_hook+0x98/0xf0
>     [<ffffd4be6043a2e0>] kmem_cache_alloc_bulk+0x26c/0x4ac
>     [<ffffd4be60d549c8>] mas_alloc_nodes+0x1e8/0x500
>     [<ffffd4be60d7cc68>] mas_preallocate+0xc8/0x210
>     [<ffffd4be603607a0>] __vma_adjust+0x27c/0x1290
>     __vma_adjust at mm/mmap.c:762

I assume this is 5.18.0-next-20220603?  The line number seems to be
correct.

>     [<ffffd4be60361b0c>] vma_merge+0x358/0x650
>     [<ffffd4be60370e20>] mprotect_fixup+0x160/0x530
>     [<ffffd4be60371544>] do_mprotect_pkey.constprop.0+0x354/0x710
>     [<ffffd4be60371978>] __arm64_sys_mprotect+0x78/0x130

This must be on arm64 then.

>     [<ffffd4be5fc43a24>] invoke_syscall+0x74/0x260
>     [<ffffd4be5fc43db8>] el0_svc_common.constprop.0+0x1a8/0x260
>     [<ffffd4be5fc43f1c>] do_el0_svc+0xac/0xe0
>     [<ffffd4be62d68144>] el0_svc+0x84/0x1c0
>     [<ffffd4be62d687dc>] el0t_64_sync_handler+0xbc/0x140
>     [<ffffd4be5fc12548>] el0t_64_sync+0x18c/0x190

Does your fuzzer create a reproducer at all?  It would be helpful a lot
since I cannot see my bug right now.

Thanks,
Liam

