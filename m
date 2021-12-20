Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2447A41F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 05:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhLTEbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 23:31:41 -0500
Received: from mail-hk2apc01lp2053.outbound.protection.outlook.com ([104.47.124.53]:17158
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234032AbhLTEbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 23:31:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR2t3yFEf9ZyLwJbkeSChkBDzt6OJ/KQUVDSisbXu8m9QF8YsjCHRLWCQgNmqnIohfOyV+BPTTCuAC0JXVfUGipVLSgwTCrnr+52+yR4HJltcsuKnfJn/XOX236sHMtvlK9PE+f6vmF0AK6Vkit/+GSobwgH0o3zw1PLSZUGA1DDjHaY1r5OZ4+NGPqhbMXAbriNR3p1x1blCvl2xiDyDVs8Wa/9wKgjecT2LiGQNv5bqA4clGHmNqfpUIw4cuVFkQFrlpwiELjKejZHdIeXc7yT+wmKH/pNPVYtGq8HoXOUBKf1rx2Kaz8dSs05vjmfNJuxV3dGK7BAcuqLN/7UZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obqvwouy1Y4hNxH9wksRgxrrDVlpd1whIdbTau+fQlI=;
 b=Ppp3DToQ3/0EJ7ytiGnaV4hgNuN48gIbhVa0kgMSh+nQp3xFIfqHhTVH34F0R88zc/Njb0wMMzsuNYsL6meVGbTRkSMqHHTqN0EKIkW3C2nSczYI7kHmcYBELswJCKuBVRZAyF4pN54FhbUZLbWsWiLbabq5g4xCs+/x1zKZgMMbOTzmlJNL0FEWzEb4wTSJbpoeTSLueOLFJGEmk6jplQzDBc0FAdmBiQL3dYoTceMMn7iTAPz+EOA7dB+CGgMdkDDAWI3VeY+2cjA0nQ3GQs+8BByKAE/WOFRwES+O5ZJLldTlkzRVVQRMfIiRiAzO7uxadLBZIePGW8M2liDXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obqvwouy1Y4hNxH9wksRgxrrDVlpd1whIdbTau+fQlI=;
 b=I6oSuYi1nZf2LIVFos9l5VfyADDZVV+e7RZLdkXh2M8N2SbDooXGK1MA6EUfkx0+TjskNwA7dtLg0YIHilXspxXP+kxia3Xl1CUyINvjRKkIAh8sA2Fzf3Twues3mGBhqE4d4ciOnCWi9xtlL9INHk+0cPYnTxZFc5ia5A/0Lcc=
Received: from KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM (2603:1096:820:17::13)
 by SG2P153MB0128.APCP153.PROD.OUTLOOK.COM (2603:1096:3:19::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.7; Mon, 20 Dec 2021 04:31:28 +0000
Received: from KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM
 ([fe80::7d3f:25dc:6a3a:abec]) by KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM
 ([fe80::7d3f:25dc:6a3a:abec%8]) with mapi id 15.20.4844.003; Mon, 20 Dec 2021
 04:31:27 +0000
From:   Shyam Prasad <Shyam.Prasad@microsoft.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steven French <Steven.French@microsoft.com>
Subject: RE: [EXTERNAL] Re: linux-next: manual merge of the cifs tree with the
 fscache tree
Thread-Topic: [EXTERNAL] Re: linux-next: manual merge of the cifs tree with
 the fscache tree
Thread-Index: AQHX9TKhye1qL/QcOUyrdzVobsjS86w6yIEQ
Date:   Mon, 20 Dec 2021 04:31:27 +0000
Message-ID: <KL1P15301MB034331969F371B30AAD6642D947B9@KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM>
References: <20211216124317.4143405-1-broonie@kernel.org>
 <20211220104610.5f074aec@canb.auug.org.au>
In-Reply-To: <20211220104610.5f074aec@canb.auug.org.au>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ea113c83-9174-49a1-a88a-6c3325a211e4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-20T04:24:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c9ad012-950b-4f70-ce43-08d9c37196d9
x-ms-traffictypediagnostic: SG2P153MB0128:EE_
x-microsoft-antispam-prvs: <SG2P153MB01286C4D4FC1239887A3E3A5947B9@SG2P153MB0128.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w/BLAwMlJExAPxspCDWBes6D9/ITpkE+LGdyAMMmXwypAv1sDGUD6I+hh4mHxzH5HHHfmEwX5Q+qZaLLbAGc6v9nVDWBWUmdd3H9Lv6nFefro0Ph+Zo5QTr7WobwNS2hxvkKqIQMvyg4FTcUGoe5nwZdAthmjMw7Qw6ZjPkV1donJk/gdp7UfZu3fLaDKkdkhu0dU15BOQWPyY708bA/MlrWSVZzh+XtP06+Yci5OX/CZaD3nPUx2erHHXWE1KKQ7HtKVkedt1NbE11cvGbdi9jiUVPob/pn5k0gIZ38VSC8iXnciyhxv+xBHk4JNDPoYwaXNV95DFnQa5bUZRG4zb4T13eKRxjqYlJ/VKWc4qW3u590tLbw1tvwf8UCSOc9If3bp6YMUlV9uu7v7V9Rksy1V9cYqb3Q7BVyfxY6AIsgoBgZTeXHdtjNe+OoMoND9NCMK4mvdIpZagoPnjPAO10dJL3SMb8yzBMvlbIVWfoOwxnNC8OiN7TnKZwQtM3fqU5p910u+cwhLiD5UlP/2yO+CDuxKLx8DHrmc0Ei7TfOqxqifiKUGItRclinJTFOL3boJxOeMGrjNOrbtvHBOaTVs5v/4JXX9TxH/6OHxPsNKQTyHLL2gRqyqogO/KLnyzg28fwuPMYoDP5bcjHKEFfRr6iJ+Bc5dg5zywtKuxZRnhuRFe3a2dnes8OPVfxY8lQL6zks92+EWf4TH7wSLsUCDvgxvgBHUXDejIBkH3iLlpYBkrk5vibF745oacaA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(71200400001)(186003)(86362001)(8990500004)(38070700005)(316002)(7696005)(83380400001)(53546011)(9686003)(10290500003)(26005)(122000001)(2906002)(38100700002)(82950400001)(508600001)(55016003)(76116006)(66946007)(107886003)(54906003)(52536014)(33656002)(110136005)(4326008)(82960400001)(66476007)(8936002)(66556008)(66446008)(55236004)(64756008)(8676002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/vFk3dMN4aH7F1TZQ0Rzr8z8GNEHULLGeiq2mEH8lkUjBihQdw6S8nH5GBOb?=
 =?us-ascii?Q?0ZcBRzWhkXOB6+y94PlA0dsG7KBNHo3dT2lHNrbRh8tLV0mNAx6sszX5HSMN?=
 =?us-ascii?Q?0pagN358mpKNN05/YS2ME15TGopMzFrq4VRGiZM98q/JiURPIOItPmH3656W?=
 =?us-ascii?Q?KMYSgo12Q7RlRHNU1HyQRTeFAKTzpFC1oO71nfglf+SKgA90nemzy10cBv8M?=
 =?us-ascii?Q?VDHcRelDHbxoY3lkIDUdtDB+P7gMqZLtdhuQfNGc4i6lVPXzLkkXhld5ZwOz?=
 =?us-ascii?Q?M3vXOlAH4sO47LbuB6QZC3Q7AhyKaomV5YDiN1bc+rqMg2FKnxAJCIvzDY3v?=
 =?us-ascii?Q?NXSsfUvxOZyzlVmu++WLVtjLzfJu2MTZv2tIh05RCSymqA8KUYC61LMtGUwJ?=
 =?us-ascii?Q?g/kwjxxdcYnpI0QQG8wqokAAYHFseUXwPiAeRHtCaF8SZrNmdVuIkftB8zx8?=
 =?us-ascii?Q?B2+kl1C69SxRkzfoSQ1zTMgX4fOMbBErFT40GSeOMO8RUVmpvsR55cJLcvcv?=
 =?us-ascii?Q?92w1jOMLIBoQIZZI1jKFmfEnRPSVN9DZmCt62F1k3OP/DIHWL0Bmy6K+7+50?=
 =?us-ascii?Q?9hLLL1XejB/Ayimfq1uMXfE36o6T3oayS8Zc3gqL3h3jSxKFi3Dksf4CPU7M?=
 =?us-ascii?Q?ZTzVRs/W6Y3mxwBDmqzW6qCwF7C4BmsdOpDzQmZq5Aell/iPsYSK/VNqgL6U?=
 =?us-ascii?Q?M/pf+ZPeO63q/tSIfvctxMPS7LzJRcUzIM7xzXKsP/8wp90wJvrC4jP5S+vi?=
 =?us-ascii?Q?oVl8Ole0HCzTWNHHXcKyNu0PouiprpRLDF02+eRe/n4lCXjCwOkiv1EuWsbC?=
 =?us-ascii?Q?mnVtZ3pNsq97KQ+oBxA6c0/FY4qMxSdWE0ZFcubi4ZfudTC3YFaN2XdK2cq3?=
 =?us-ascii?Q?R8IQfuv9CqGwzx1oQH9QplBpgBhmXrf7KW/imXnCmSlbe5eRqz77bexPb/VW?=
 =?us-ascii?Q?+vdaq98M1/uqH8CSOJgrGgHrR+3x5SOEveIHyo9NbbKfz/Mw3fg7KHHg9BQN?=
 =?us-ascii?Q?12qPfOjCN7Rr69KZEivBNxXEcW4oeY/3mMq6BUY1qFLzrUE12Crv17tQOwfs?=
 =?us-ascii?Q?wiHJ2FRRXj54A1yt/XcP+IeYES/OFSzIm08jlKDjrO10XtoGv9ylJPy1vP0q?=
 =?us-ascii?Q?JA9j3XFp5AYte38+nK6TWacy7kRgRQQOP7v9I09KZ6zv919Cdh3XQNKQQAkK?=
 =?us-ascii?Q?rGm1s9ZmXX2qSTYOniIKERcmTjwk/q5Y/PA4jVOPWXfrbIv41o1p4oW0vj4Z?=
 =?us-ascii?Q?e/5E+G+qinxX3Ie6aUzrZZj96TdDNN3cQmDqPgrjhxtbH/nwAT48kaDPD11E?=
 =?us-ascii?Q?AJDveyMrIgVlBrxUvj9Io2kFLujdM2I19NkDkbjktTVhQrPNC4kSFopJgXNw?=
 =?us-ascii?Q?tlUtwOyb0Pq3Y/f5dxRv3eBwc0CzaA+5WrEKhflZVQZduUz8RHw17fzRxlRZ?=
 =?us-ascii?Q?15+f9ghZGbQMBpjScJB6PpHuQ5Zz5CQQHP0iSEdQh59YldEJIxrmyjkfCah6?=
 =?us-ascii?Q?ZJeE4eETxO4m94rT5EjYgjLWXEwiAcdX0pcvgPy7Cm0qV3Ddxl5V3f/qPw3R?=
 =?us-ascii?Q?1M8rIa2hXKgHkuUGQ9vQLwwLlHHU1LMuPbU/ZmUc1eX2EO17N//4Cv8iBP/X?=
 =?us-ascii?Q?9sSYr08fcp+DyF4PqVmLYzE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9ad012-950b-4f70-ce43-08d9c37196d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 04:31:27.6013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sh2to00FtKizG9M3WV4mgrdlyYR03Hrv2lDE/Y3U2AEkvNCf7bjrCEvCMN7jet6gis+u17nZs0NlGiy8IhJhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>=20
Sent: Monday, December 20, 2021 5:16 AM
To: David Howells <dhowells@redhat.com>
Cc: broonie@kernel.org; Steve French <smfrench@gmail.com>; CIFS <linux-cifs=
@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>=
; Linux Next Mailing List <linux-next@vger.kernel.org>; Shyam Prasad <Shyam=
.Prasad@microsoft.com>; Steven French <Steven.French@microsoft.com>
Subject: [EXTERNAL] Re: linux-next: manual merge of the cifs tree with the =
fscache tree

Hi all,

On Thu, 16 Dec 2021 12:43:17 +0000 broonie@kernel.org wrote:
>
> Today's linux-next merge of the cifs tree got a conflict in:
>=20
>   fs/cifs/inode.c
>=20
> between commit:
>=20
>   830c476f5eb82 ("cifs: Support fscache indexing rewrite (untested)")
>=20
> from the fscache tree and commit:
>=20
>   68f87ec9c1ce3 ("cifs: ignore resource_id while getting fscache super co=
okie")

This is now commit

  b774302e8856 ("cifs: ignore resource_id while getting fscache super cooki=
e")

in Linus' tree.

> from the cifs tree.
>=20
> diff --cc fs/cifs/inode.c
> index dc2fe76450b96,279622e4eb1c2..0000000000000
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@@ -1372,20 -1370,6 +1367,7 @@@ iget_no_retry
>   		iget_failed(inode);
>   		inode =3D ERR_PTR(rc);
>   	}
>  +
> - 	if (!rc) {
> - 		/*
> - 		 * The cookie is initialized from volume info returned above.
> - 		 * Inside cifs_fscache_get_super_cookie it checks
> - 		 * that we do not get super cookie twice.
> - 		 */
> - 		rc =3D cifs_fscache_get_super_cookie(tcon);
> - 		if (rc < 0) {
> - 			iget_failed(inode);
> - 			inode =3D ERR_PTR(rc);
> - 		}
> - 	}
> -=20
>   out:
>   	kfree(path);
>   	free_xid(xid);

so this is now a conflict between the fscache tree and Linus's tree.

--=20
Cheers,
Stephen Rothwell

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> so this is now a conflict between the fscache tree and Linus's tree.

Hi David and Steve,

I think one of these two branches need to be rebased. Can one of you please=
 do it?

Regards,
Shyam
