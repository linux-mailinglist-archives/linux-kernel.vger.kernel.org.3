Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD36571D40
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiGLOtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiGLOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:49:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491C27B0D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:49:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtanj016690;
        Tue, 12 Jul 2022 14:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rUP2AdsE6rXTcpMguCpgMt8PuLh8IBXWmVPZZ0/F+GA=;
 b=FUoo4STxVXdU+10Wflv+MHW9+YkYpc2M4uRnLlhPJHS4bD+ezbP9Ev2IoBK1OHm4yP3O
 WC7DRW0NN44vhaodusB/FZ8r9AXQ1rmdJvdn1dOK+xqcfMWg7ZqmvC7BPzsEeeA/HKyX
 xDvoUU5yuDJNpkkL6JOIJ2ZjJ/34Lpxb78bacqN8MkVnee22sZXUl9/s0xCc/Tt8FFiy
 mJAdPYW+p/3O1VdmVKFqGUuUJhXbUEB05MB3746fIx7MMYBx1TzizISq4eA7vS1KtCLX
 rllA4AMJ9zCS9zcul7Q/LbxoQNa2OtKX9ZIQlzTYwo6Z+TQgUuUPU5SEWYxwTlkea3ij ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgps09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:48:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CEalim014135;
        Tue, 12 Jul 2022 14:48:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043d48v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:48:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgLNgXGSrHIu7x6vBfovCk4X0T9eHYscSPcKjb+Esl7/kmaDMmaUk9Y9MYQyrqunOlBHK496JTlDanpwqxAh2I5zQzrLMsTSzzFLZNkAdm+dkNdSttavoh5FYaQeLYuQbNy1sq/tRo+ylT58CRgzNtKBC0kV58hqgm7lC0f3I29LK5ps+9uK1ULVpPAyQO+3trO5BGGUEgXufk72Sj+FjjKoHxzPzlKPwa+yHBLpApYgjYanLcGK7cVIfXtpHZrmY8/MpLTqEExOx010td/b9taURD8d0yNxHAKHEoG0tRYHT4CjntG1VrrwjIUMUQ0XmYgnGNfQkJZ3979f9hZV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUP2AdsE6rXTcpMguCpgMt8PuLh8IBXWmVPZZ0/F+GA=;
 b=Cpl0o5GkrMbTG0LcQbHuu5u2xAwh9ccHKEKtwSjG6he7GamiWEaoAFhlAkvqnIC2f2niVXQwOXYQUbsA7HNSyC1PDbGorijmRYuSe4gE1d5Oujb5xYhYnHPooMikQK76QbWThtmc4GdxSJkxSxBDypinLWxL9Jip04YatDiY0AlNFeRnwgxCW9HH6XFxA7DmUM1nq1HPLy6bX8tBlcOQHhEjV13jjdQHgn2eCYoEvh6l6Y+MwLE+UIuvCco2O8MQ1LhE4EisstErYBVeWPuZc2WdwGZsUf6CzjR+LeVJ+NSsEwauq3eqHo8eEMapbvzZvtC5fQNlwYII1kxXgxSwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUP2AdsE6rXTcpMguCpgMt8PuLh8IBXWmVPZZ0/F+GA=;
 b=fEuDSXX05A1DAd3qiAtN7Bzpi6hhFJG5+6sQCpqIOQvSLyIzeEBw8UEr6/OTacMzzuqVGmfrO8j/vfNTzvBy9v37Ctjavm8zULDExWlBWKvOHgRFk+2h1Y0aDUE5a+pHdprWILb0K2OI2FJ0JC/O7R7IsCDu8aeQaRtUwVfuwnQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6054.namprd10.prod.outlook.com (2603:10b6:8:cd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Tue, 12 Jul 2022 14:48:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:48:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/mmap: Fix locking issues in vma_expand()
Thread-Topic: [PATCH] mm/mmap: Fix locking issues in vma_expand()
Thread-Index: AQHYlf11DPLJIcHrkU2C5BuTh11k/6160O2A
Date:   Tue, 12 Jul 2022 14:48:39 +0000
Message-ID: <20220712144831.7nmppo5p5jd2k34b@revolver>
References: <20220712144112.4189027-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220712144112.4189027-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acff106d-2d1c-4a53-c8d7-08da64159bf1
x-ms-traffictypediagnostic: DS0PR10MB6054:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YqSHVBdQjLhTH8R6QAtFcmwwCbUm7hI03vniKnurPT5vuBSqHlEFCMuiGrX9gPzuFcEwLrnkKn31WI6zrLW5dfGtc83QFEXqd10HDZNR/+fs9ZDLgPMz06d7zVxt3GTc9B1KlrwCy5hTskVpd1MKfGd1ZjDcKWBeJsBnPpiYwOJLCAZY1mfD7FjNqEUWEHdNWesiD/qCYmnIqWv5ocPttiBeEZqxrmw72FWEeYN36O9YdDu9Jrc5QDlFubwFK2pgfRyJvz4jdcS0YJOwaALiHJpa/rsJXWIEezeaVGG5HjRberoqouvVEyTKgB1J2DUb5zJ6EXJIAWIyroJYj5Re2Zzohgu+i3oz6w5O9bdkirxKHfLM2rseM4pHTTK57TUvsIV11GBnrYJPHiRdB9YNUJuWnnmyMfD1T0AyO76iuR0duqAdL9Xj9kAiV0mWnccErLX6Hyu+sdsuFq7TcvQsrxMjhFb8l/ddx5bzRgiU9sYeRSf31rExIOpOZhylJwQndDwXW/QlyjV6kEMNawBgwISxGJ4Gq1r9hrGyAt96VAMZ3RvkrcevogvSs0IF/7Yzir8pYDqFOYDJSleFsQgQw8yOvj8TP3DZz2LGsdaJ8xu0QFHBdial9mHE/img1E2dhEnVAjHCild/xyp1695LeXEOhQn1NTk8RNDFCTVAsMksgf3eJId1pkowJTzZHSoADUbTnzHk5AhlEo5tMSHbqJSnD/X0FvGSx1zowwUCFXQFgPPW6DSN1GKFT5XyUJ9tU3BsVCfzhRn94Hvokpp8/hNYBot8ouqozYw+F2rGM5CzKoSiveP1iK2ajoVcP+Gv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(376002)(136003)(39860400002)(366004)(38100700002)(64756008)(66946007)(66556008)(76116006)(110136005)(5660300002)(8676002)(66476007)(38070700005)(83380400001)(66446008)(316002)(41300700001)(86362001)(8936002)(91956017)(44832011)(6486002)(26005)(186003)(9686003)(1076003)(33716001)(6506007)(122000001)(478600001)(2906002)(71200400001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CsyHgZgKuamvhT7Ab4GUcebOX8lann1QIAKapn+3n0JKSeNTUNTAsgxIMLs4?=
 =?us-ascii?Q?hePxhrCXMutIJDicOyhhrRXKmx/JPOpClVK1ujsM5xmdY5V3woSp5rYO5ZC4?=
 =?us-ascii?Q?aW30UyUGzCgMigpdRANIzs+l0Xzj5xhP0M6k7b8ZvGtwWfZIbn8mfLDenV+/?=
 =?us-ascii?Q?YZe5vwgrDQQsjWWjbdipS0GJpdRmm4ViAPl5HBO1q3PYDNvRReBilHBxjTXa?=
 =?us-ascii?Q?RMKL1gb0odWyY/pbOf5w3NrQxHyVHpaD+gWuDV7pfsHnoKcmIBZYw1/1FqGO?=
 =?us-ascii?Q?TGdEmEg4brqBR1f953ajiuDmw9XsZ6m1SDnPKDG+s/riupUpNr+zJJP9mg9R?=
 =?us-ascii?Q?kNF0aQgblEwUAbG593LvNJU4T5D5DNhVCwwScegGgtWu6HWRJ6fFHAmGbaAj?=
 =?us-ascii?Q?RdNkvY2RCOmBIl6AnQrL4yU+e5IkSZlBgsAXk26pTaFmgi2GgXnGgPazJnkX?=
 =?us-ascii?Q?FF0AQ4T/KLtFgSUg13rp6ZCbGscyGQ+F6jK+ghaSk1QtM4IBL7E8aSUtRqg4?=
 =?us-ascii?Q?XfmgMPrzjzaqCgn5ehLuAFiZn44G7J1d8gMsaKaQqKYOEuOAEp/srtCmKIWh?=
 =?us-ascii?Q?gzOHc+Qser/mXqvdGYWRUQenYQ4XStxvCl8ZXlMNqmmz22tG/WVdU/mcdLie?=
 =?us-ascii?Q?VyXVaZeBZkO29ClyW/NY0QOLt+6Qgc4U8futj39yVGzvHZ05j6LSuGX/empN?=
 =?us-ascii?Q?iUGavpD/ofkC4GMgvuQJ2dj55KZZn/EEz3bpCTumZUiZGX0ZovX47N3VqUzg?=
 =?us-ascii?Q?ZHKpQL985QcQst70xoYP0ABSLUgK74fsdetitU8n7wC9udr3GB1Dwcgmgz3J?=
 =?us-ascii?Q?bem3cCiHD6Gbl6S4QBWb4KInBVknX+EQEdBGeuUVXqHw9k4f2A2j01QkA6oZ?=
 =?us-ascii?Q?EO6riijJIFho3FoLOSf5XsxxKhutMtstxH+fLeRD71qB+wSOt6Yz14Q33iT8?=
 =?us-ascii?Q?eElz01SuT19EqLUiOI/yYk0KfknumLPa5sOFtpFUOLo/3kW09VM9laUSPxcV?=
 =?us-ascii?Q?A3jZvN8bqHcZppp56P1ztp56IlCvtOtEefmlx9twsyd+/PX+mTgz8XZ3AZD9?=
 =?us-ascii?Q?7e7Dqw/yTV9XHXSaIohG7JMALKPRtzO1N6OMZO5ETa1Unw9c+DHSLiVCKRjK?=
 =?us-ascii?Q?GhyuM69MRb78N/JaBVR60ZX+Sri6c1QHi6WbkuATKo7VGLjJznfP1PctA1km?=
 =?us-ascii?Q?C1jkq0+MXFMhuzvpr4gEyhylb4qyFiudKMQEX2GEOrx6nU9yEcp59Acs9wX7?=
 =?us-ascii?Q?9ml+VGgNMQlc5aPiAOSPDUGNbsU7r44drlCpVCnUL2iqDc0oWjRdoBLdW0iR?=
 =?us-ascii?Q?/ja9XheebpA2EWQr5eR5Zj38KLqLzvswasqUGXNQ5q00+rVkxD1w8r6o/q19?=
 =?us-ascii?Q?uPKYbq+IhEEyACsHPGbWctljoT9ovjaoRJU8iDs7RVpSMg6cmTC011dAoUrC?=
 =?us-ascii?Q?E3URx8aAkt9i3HOSi4CV60p64BG7w4m5lUY70nL6s42g/pvMXpAhhvT4eJfs?=
 =?us-ascii?Q?0EiR7en36aYJfZLwIjRsyz0PrJVnEsMY12p/vy7POEM/sw8jCIlaEh6bb98U?=
 =?us-ascii?Q?KEPBKVDq9m8YFGfMMhbzCpWH6kHM+8N81w37bsPLyG54FY6It8Ioowyvbuen?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <521932C596488547B9EBA8107CC15D36@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acff106d-2d1c-4a53-c8d7-08da64159bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 14:48:39.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2KlOAzxwCi4GQ6tPwSW6xFYwcdp2g8XyRy7Ooj5auha4wbZ+vBIzyOws3UhkDMI2NsPwvrQsWOqbyGQR2eF6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=739 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120057
X-Proofpoint-GUID: Wa418g69o-NO3HKkZbEoSNMkhRL-6FTe
X-Proofpoint-ORIG-GUID: Wa418g69o-NO3HKkZbEoSNMkhRL-6FTe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please disregard this patch, it is missing 1/2 the fix and the fixes tag
in the log message.  The proper fix will be arriving shortly.

Sorry about the noise.

* Liam R. Howlett <Liam.Howlett@oracle.com> [220712 10:41]:
> Hugh noted that the locking was mixed up in vma_expand(), revert to the
> correct order.
>=20
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9eb663cde5c7..001b54fe19b4 100644
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
> --=20
> 2.35.1=
