Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4AA5766F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiGOStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGOSth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:49:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9056A7822E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:49:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGbtVP027473;
        Fri, 15 Jul 2022 18:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x/1z4NRR+GSpNZ/ZGaeDSVxk6ILrCQb/pAhsH3WbK44=;
 b=aedtNpxTbqOdr/Ma8n8Fav55u371IWaCMHha5zFoVFc1uV4DQMm0VUF5F/WAaPp4Hseh
 IOjpgWTjXrZE2XesfCkIa2AZ+Y6n5Nl5OO/lih0wrbngVP8BOo85rIGikF83OdNxb0Ia
 K5SWQ72clB13CUrJJYZyKcfGg4bicL/idQ1/Y37+LvMFyuttN700dm2JM8liAT5vRHlj
 I88EXGvSMeSoV3pmxWZJp6Ev/lRbibN3G01+OMmPQ612mwNBvhu6g8K1SnrjjFH3IRcU
 iI1/ud70fk7jymRwqM6AAGOAsIEb8Yx+P3qs2zH1YEGiimojXlMTk1wuEga9j8q6z28Y Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg8k1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 18:49:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FIkqiU023782;
        Fri, 15 Jul 2022 18:49:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h704754e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 18:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzlQ+LamGhKfeAiTqF1ZxRf4Edg4DFNZUqOuLDAMolvEik/N9zyIPlcpOe0WMO1oA5KXwOiGenB3pHlwfQlBDujh4bezna4+SuqTvoBy17P+O2DxqVnjBXDW/x2hJrB5MYCmQaevnJQT7YkslFCrUPblbm7gcV18Qv0OzyYW3TYG2cM/pO/yBf+rXTQ3uqt1sdfFGyjr8znvYV+RdpfavzIv9dlXX7KWVfkpXmpyben3oPX7bFjvtiyft2YCZjc4UhdW5XyJgsXo4wpgpTKycZXrPDdIhrD95569Qfy9wBA3cIgLSYsvsZq2WkE3pk0GYVDhJHvOKwhLk53BN3KYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/1z4NRR+GSpNZ/ZGaeDSVxk6ILrCQb/pAhsH3WbK44=;
 b=m1L+E6vWzs9+bJOBbiGR3LJ2K8BCVSAxg1f9DJnPK5FACg34DrC3Sjiqn0LTUfBkch4Z11CEXv29HpMLJPenlNUBXvtqgtEJ7mKVvuVJK9ObodT5sb56jXbGKtVdbAIkTFvJYSQ7Oxiyw6ieJx9bew9j/nGM4H580suH7C59S4SbOQeunxFBuKhxPiH6PXjTcGO1Zcu76ZSL64BivVGjw39GagNes+xiBmchSxvEbloTrR2BeYBPhpA/GjFcuHO8ro1ePz4sl6RyUh106IeR8lGkVlUxg4KjbdYG7HCSo3F+Sj6L3YjALYLAQu2P1JSyphALkmNjklMceCwBmRA1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/1z4NRR+GSpNZ/ZGaeDSVxk6ILrCQb/pAhsH3WbK44=;
 b=xxKuZSJfzrEf+UD0jqFmz8B52MzWYCjDAxY3CMcMzUDVEnZf/BCQ2R4tdqR+fgcne8EsD/MPAmOwGLUBKNgYAbsoW/km/FK/RFwwwPVTYLhBqX55CzBOfuc1IvdvopeSQKVGcllCYdyfQ7auAoK7Y7pE+NtN7xmlagvukRSBGPI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1366.namprd10.prod.outlook.com (2603:10b6:903:27::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Fri, 15 Jul
 2022 18:49:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 18:49:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/mmap: Fix locking issues in vma_expand()
Thread-Topic: [PATCH] mm/mmap: Fix locking issues in vma_expand()
Thread-Index: AQHYlf6fdQQFbDqKqEWjS3P5pOojn61/yymA
Date:   Fri, 15 Jul 2022 18:49:21 +0000
Message-ID: <20220715184913.v75xv2na4dgz3ayb@revolver>
References: <20220712144926.4190769-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220712144926.4190769-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 923004b8-18bb-4e84-6db7-08da6692baff
x-ms-traffictypediagnostic: CY4PR10MB1366:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2m5A8tdaYYOx70+E19u5dDGjblfayNh0aobpTd1rJK8ZPJkGaVl6ZZhwYCROb2OYn1JkXjbsI5zXz4Y3N/h8j/t0GEutfgrUjWwx6HQ78TyIsqmnu9fDpeJq73rXJZ7i8PuZHBliclpyY9qoYEVybqUWejjcks0Pv/DcCKD/YxVu8Nixu/IpIY6vcWWkOzuj7MUdPsJlKKue5zArpo9sK0PZzySOrljEi/fW0EoOVAOCerF1yReim9ho4NCs4mw3x8MD0B5A1O0TT/Hdu9HlsOBp3pxAe3wKqvzMJvEvlpxIGE3fbdUqxvDDlzseT4HrvHaFcH3md/SRfnHsLW8VBCvXH67Z8YXL6YXPc9MYoUuSXqn2WtVJiY/D0EBJjyyh2Kd61goDh7RqncpIynh9Tn0XZbEbJBfGmug0WLKODoMi6jlHlO0Vpkb//CshyAmwB2REYUPWN1oQCWJrCGJtOgsIiBqdEjS2vVQj28rFRbYuE4QtN8B5mXnngDHnaz7SaBRjEKfEfF0ksdsgKx5U3x91h5bXEbbb3oLeKKqAMsP1BEJcJRhv+dcdp35nxoGB0NRYTGyAcn1+kpSi25U2RCJtaA4J7f+IaOsqUqvbDrEMrI0tLbPl9p5VPyQIA0qnZnIwY3+XRR7ctBisqRgQgEzbJKGo7vm2ryW0PEMpDNj9sRnEBb84HWIatNDF5Xxdb/7KO4TT6daD5pmwApaTkuFQ5rfUamjgOHNGIAFqq8cWTaCini+foLBv//43gi+hem1qSgFIzlZDxAU7bZcbWYMjlF2xZsm6zAUvsgq5zQeN8Y1P03VpIkxV623AmWNu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(346002)(396003)(366004)(39860400002)(316002)(44832011)(5660300002)(6506007)(9686003)(8936002)(6486002)(186003)(38100700002)(38070700005)(91956017)(2906002)(26005)(41300700001)(6512007)(110136005)(478600001)(66556008)(83380400001)(66476007)(122000001)(86362001)(8676002)(71200400001)(66946007)(33716001)(66446008)(64756008)(1076003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aIFu1kzBP9B8YniH/amDWv6r2vH3XCGc1a01G7kdqwZeKAqmAGtgEEYOXw/D?=
 =?us-ascii?Q?XpO7UoM/YcWMTUGvI0GDGEUKRS/GxX3xUNcSuWuLRZds8+ipkAhT9SOyz3d4?=
 =?us-ascii?Q?XeHinnKulXywVO4slFCR41+hbLB9Pbytj6+zwJKKkljM5zbgbkDR9Bk2kyEH?=
 =?us-ascii?Q?GRTzClN0N2O0woQ2hWM2vEUVrfZOn9m2LOS38fJlyvJPHR++IzNRZJ9PiR7C?=
 =?us-ascii?Q?Rz1jwC+T93FF66P/kd6zXjVdnenLGcWRWzqAsxFJqwo5XKdx3iqlVJm7Pjif?=
 =?us-ascii?Q?4//lPWAmGwjIoV9OoA6m1HaukdcatP+8/6I/+FU9gz3N5GtFdMeIta12Rge7?=
 =?us-ascii?Q?8Yem+zg8fKlF5aaG8JovIrNjfzCqIRcsI/QDoF0vK+PN131s/O1vegJcsXZF?=
 =?us-ascii?Q?XxnriUmOODaiHh+1vBu9OKAl+FlEnr/8Yo7smROhK+HZ2ewsMEpUryjN2V92?=
 =?us-ascii?Q?p74yPE53xlF0ADpBX61YLIBjMqgWLrpEeWLz9DSXIuwmmP75m63hVdxcD5sJ?=
 =?us-ascii?Q?k0MHzoVKgV/4s1aIoCyMjwBxH1811UtgSrJ6q8vaE0fjqm+Ban+YaIj/LAh8?=
 =?us-ascii?Q?0a2gedFl8+70LC/e0KDFyxXAuuuTtjBTYAzuURVK5gqKKAcwB0id5GGf3jmU?=
 =?us-ascii?Q?EikKvs51l4JR4LF0m71yEFOGW/F+fB8Fpv/zrgk2097mTVVczMEZAQYui4va?=
 =?us-ascii?Q?dkJ7N66xU5UULwrRmm4OYunYtMFTbvbLcOp1bzhbGvBJxyg+lfzoxNTUfBag?=
 =?us-ascii?Q?0Y5Wp3hFt4tLdbgyUQFOIpnYoenXKT6XtH8yEK+/964B3DYkxzOs+XWZIuKs?=
 =?us-ascii?Q?1mA6w4RGlnEfou5jQpwfaUuShReOUE6vbCUuS3TuGIvN9G0cLsDe5OAwfCn+?=
 =?us-ascii?Q?x6ACShW7mw9GtU4EcWrhRBXhChjJsjiz93dPJuDV6gysdhk067AGvzjFhWiI?=
 =?us-ascii?Q?QU9v79AgbPNLRlCQGRql5quK1wR1c7GM3I7XBttVI9UWQfzpS8IwDlm3fuNI?=
 =?us-ascii?Q?OmiYhPQeqUjBsss5ltO6msnDL9M17QFDSg/qffBEveMAGMOReqAiqTjXO9It?=
 =?us-ascii?Q?xm8tqpm2+3TxhcQZ/tiiFza//TgIV7jBvNQJ9b3sQIFQNWWOiCexGiACC74V?=
 =?us-ascii?Q?1aDKsuAiNVJemv/coTddMVGEsefUxTsYpWvXxKkd8LLOcO6ojbqNAT4bsVo3?=
 =?us-ascii?Q?9/NSTWuTFK71KjSBwQE9sWJbwambnwSEZEIwlfGo+fC6Yg/rdc0U/vvuMPOf?=
 =?us-ascii?Q?imTR64dkyeRDuqpRnXBK3vl7gfj/uqUULssDWKAWFpyHOn6D2h4IBvDiE4V+?=
 =?us-ascii?Q?bBenZ0q63oORr3OahjAxxwFn36CIdIrCklYP7STXA8AibhOH8Ri8haaMYjIB?=
 =?us-ascii?Q?zWbqFI2V0DFgHTx+PD674iuYiYXnbx94KP8ZxHZUxxF2MDGxQKEcfZvDHD7W?=
 =?us-ascii?Q?AvmQoCJzdGoyzlwF2r0cB+rujRcAIpJZSsUY0tAewg9OJvWxwPYPUqoiZRez?=
 =?us-ascii?Q?HVunIkhvgf3A7OR7pAWYcB0wVaK7/bsJB/wWA8kMUYxweGxGhNGnEWQomcNe?=
 =?us-ascii?Q?rXhn8YC/SvV4sKqYNqMYXjI9vWe89eMUrV8RJyS07WqIZNWYfPKgRZg9dr/V?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50A8F0DA2BD74242B2DF4A221E7961BC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923004b8-18bb-4e84-6db7-08da6692baff
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 18:49:21.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXKq5QYwOcCavbtu7g8EDOOalcnkAR8andw7Gr9hKOnCvWd4f28OgpWe+9Y8yLLVkNNhyxMSmFlnu1qtxzkRbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1366
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_10:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=767 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150084
X-Proofpoint-GUID: szQGBlqFVAV31ZBKw0HUvMNH3ap6a--k
X-Proofpoint-ORIG-GUID: szQGBlqFVAV31ZBKw0HUvMNH3ap6a--k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

I think in my confusing post about ignoring the previous version of this
patch, you may have missed this completed solution?

Thanks,
Liam

* Liam R. Howlett <Liam.Howlett@oracle.com> [220712 10:49]:
> Hugh noted that the locking was mixed up in vma_expand(), revert to the
> correct order.
>=20
> Fixes: b2c87578e0ea (mm/mmap: use advanced maple tree API for mmap_region=
())
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9eb663cde5c7..9a07bc18e6aa 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -574,7 +574,8 @@ inline int vma_expand(struct ma_state *mas, struct vm=
_area_struct *vma,
>  		if (next->anon_vma && !vma->anon_vma) {
>  			int error;
> =20
> -			vma->anon_vma =3D next->anon_vma;
> +			anon_vma =3D next->anon_vma;
> +			vma->anon_vma =3D anon_vma;
>  			error =3D anon_vma_clone(vma, next);
>  			if (error)
>  				return error;
> @@ -592,16 +593,19 @@ inline int vma_expand(struct ma_state *mas, struct =
vm_area_struct *vma,
> =20
>  	vma_adjust_trans_huge(vma, start, end, 0);
> =20
> +	if (file) {
> +		mapping =3D file->f_mapping;
> +		root =3D &mapping->i_mmap;
> +		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
> +		i_mmap_lock_write(mapping);
> +	}
> +
>  	if (anon_vma) {
>  		anon_vma_lock_write(anon_vma);
>  		anon_vma_interval_tree_pre_update_vma(vma);
>  	}
> =20
>  	if (file) {
> -		mapping =3D file->f_mapping;
> -		root =3D &mapping->i_mmap;
> -		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
> -		i_mmap_lock_write(mapping);
>  		flush_dcache_mmap_lock(mapping);
>  		vma_interval_tree_remove(vma, root);
>  	}
> @@ -622,16 +626,15 @@ inline int vma_expand(struct ma_state *mas, struct =
vm_area_struct *vma,
>  		__remove_shared_vm_struct(next, file, mapping);
>  	}
> =20
> -	if (file) {
> -		i_mmap_unlock_write(mapping);
> -		uprobe_mmap(vma);
> -	}
> -
>  	if (anon_vma) {
>  		anon_vma_interval_tree_post_update_vma(vma);
>  		anon_vma_unlock_write(anon_vma);
>  	}
> =20
> +	if (file) {
> +		i_mmap_unlock_write(mapping);
> +		uprobe_mmap(vma);
> +	}
> =20
>  	if (remove_next) {
>  		if (file) {
> --=20
> 2.35.1=
