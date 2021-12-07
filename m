Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE4746B5F9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhLGIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:32:25 -0500
Received: from mail-sgaapc01lp2109.outbound.protection.outlook.com ([104.47.26.109]:35149
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229523AbhLGIcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:32:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUd4doxuPt75V8khswpep/HPSGXrLCtUtzT/p1WcH9HCmxR4dhxW7W+3AlSihYSRWoJc2uqi9rguOUtdxZfSf8YtLZAVUJCcClwd/CMqRAYtm2Ttu/4rExxqTtCDGDUnbuuZS9NrOk7V+iQNlysxODKfmwTbClmFj4yJAHFJrx25tTRJQqdKBHgYvQtLMBoFct8IafJ6PJ5h7ukUVL7o9LFaV8UV3WNlwXkjCGRRJjdfHaQMwySwp4bCDQX+F51C6v2hR0WMkQY+cKOc0DjjdJHUdYpRhI7wfej84xYGFZKk+1HujLNmN4hYn6PleGzY/1IpfLft+SiaIbgMspUiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmRxB5zzSKqitXojIaodfoGdlVoX7Bmp4SX14hs+pc4=;
 b=N/gfHTP0ej39v5DV+O5Q91g4zvVD2yVQgJmTbE7arEgIRDYOuQ+w3eguev55lBcbEj8xEFQqCZNDeMS+1sDEKqPK73pz08qUTWjWNMZK1PeD+lKprAgUS3xehjRdfFsO7QAqYOOZWGv846hey2g73rM2liPbVxkMl2pf/Q1/Boq4G1oSPDDypCtvXKUtzuLer4SdXPZuQCTf6LdGYMmTql2y4Wl4IlxYT8Rr/RvqZIU1lHxE2NwgYd/I4FuVE/RKrlWF4YuKOqRzUJMPF97fRg2zlD1+Wswr/cAa4IWlswhivmP38dspbC2AMu6RRzvyJ+YiMeiawLnBzdmihaQqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmRxB5zzSKqitXojIaodfoGdlVoX7Bmp4SX14hs+pc4=;
 b=db5o9CISmKuvmYcrTlppexRZdOJYcGqehxvghmNFq5F0Ay0vE2I5Ujkwx8YQxGe8MmcX3PnjHKsd9mKPNEJuHfHDUpS7seoWBMxyPilZuvq1tSmbxbPGALbeiqYHwzgDrEJpI0HrMDDOhaUDkrZuUzvRnIiHpYn1ZZu3uOwQ4hY=
Received: from SG2P153MB0350.APCP153.PROD.OUTLOOK.COM (2603:1096:4:d4::21) by
 SG2P15301MB0094.APCP153.PROD.OUTLOOK.COM (2603:1096:3:11::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.0; Tue, 7 Dec 2021 08:28:34 +0000
Received: from SG2P153MB0350.APCP153.PROD.OUTLOOK.COM
 ([fe80::ec14:2180:4bca:d72a]) by SG2P153MB0350.APCP153.PROD.OUTLOOK.COM
 ([fe80::ec14:2180:4bca:d72a%4]) with mapi id 15.20.4801.004; Tue, 7 Dec 2021
 08:28:34 +0000
From:   Shyam Prasad <Shyam.Prasad@microsoft.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>
CC:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steven French <Steven.French@microsoft.com>
Subject: RE: [EXTERNAL] Re: linux-next: manual merge of the cifs tree with the
 fscache tree
Thread-Topic: [EXTERNAL] Re: linux-next: manual merge of the cifs tree with
 the fscache tree
Thread-Index: AQHX6iMJjAAr791qnkWktkXVKBIv7qwmsU/Q
Date:   Tue, 7 Dec 2021 08:28:34 +0000
Message-ID: <SG2P153MB03504A773C5F7B6C75E410F5946E9@SG2P153MB0350.APCP153.PROD.OUTLOOK.COM>
References: <20211203094139.059541cd@canb.auug.org.au>
 <20211206085650.09dcb11e@canb.auug.org.au>
In-Reply-To: <20211206085650.09dcb11e@canb.auug.org.au>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d5c690c8-1e88-4907-beb0-caf2185f5fcc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-07T08:16:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b044a25-4c85-426c-3792-08d9b95b8f3f
x-ms-traffictypediagnostic: SG2P15301MB0094:EE_
x-microsoft-antispam-prvs: <SG2P15301MB0094632D47D6E23E91947E00946E9@SG2P15301MB0094.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41NTTiOWO3jkYMJ9idc0LvN4yd7Y94ZNnQeL5XoNLTkuLX46fIa/+83+9dBkQtUq854EXyiz6Vuw2KfetKyTt6EdPTvUNGux9KJq4T53pKt0ZVsBit+qTFFY441j2jNDxDJQnkDS6Nk5eXRo76mRm0440Proa/eDEHsSNGApzowvwxNJaPf1RWVKA0ioIX1T8BjcCVzmAuaZeV5By5U468ex41x4s9KHCI4X2I821EBSXCcIFYMII2W4UnPU+Uyyzstkxj3VwJeS3G0+paJlef6fa8HYKbM0F7wEZPxIX4GOTuwHJHPXWxWJlc/rpKy1momjrJG0oXVnkAb/bH2gFI0YdcuNczlBDlqUMte0VWzcWQU2xwGofaSwqFfwYHzq8vxlbG74y3dJsA3BaWUYOCyIaRCshv+y92ZU4dAdge+d/M0EpeXNmB9xYoGEo8D/EY8/kWalCxFpQf8gI+q4ayuiAqs8QQY4s0w6PMAnfgvh3IpsCJsEVVMK4qihDb62i1liP1ae1evtnsNSUeVH7IVdIbJeEPT/XiiY7pFLuT84zaXkn+HJqPiam98STvSJ1/DB7Bs68/CAVY9p/zwm+q6sVT9V+lfrlIGUbEksVuHsZpOd/3CpNiJmreXk0YexGzH5Pp94LKGhLw5YNFYQuGbJ6wrrsuACi6el54KsXLmnSGFUdu7PENhNvdeVhkqpbwIS9U7XuxBSdqFSDxan3+39zMxH1NRB2N59RTp3TR/a6cXvQbvP55QwBlWKX8jD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0350.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(5660300002)(76116006)(64756008)(54906003)(66446008)(38100700002)(66476007)(110136005)(10290500003)(316002)(66556008)(4326008)(8936002)(122000001)(38070700005)(86362001)(71200400001)(508600001)(66946007)(8990500004)(52536014)(53546011)(55016003)(107886003)(82960400001)(82950400001)(8676002)(186003)(9686003)(7696005)(6506007)(33656002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/7ft3uCAgeFaulMFMxsjqAlSxP9yHpcuGrBlAgY9wTPRIt9R+vo9jPuSqlJy?=
 =?us-ascii?Q?FIj5762w2K23g86uG+WCNqCoLiO6I4ekjOjxWocYUuOiL1/4sqAG4dXC0tmh?=
 =?us-ascii?Q?sU4DqeGOQNICEUxzu1cXApZdKA0Yk9xvogGvE9bgu4PxoDWQ2IxfBRf2U7mF?=
 =?us-ascii?Q?cjKdL/QPOKKa23TBwHVZrBJkLxEiURkiQ5K+jn0cx+qQrwHXd0VGJ029Dfzd?=
 =?us-ascii?Q?MzGpbCeLBCoE/ETo9wNzeKfXImunYhXPmzvpm2U5sfduoSV2rztRbEIJaK3E?=
 =?us-ascii?Q?r9cAFoFjhLnj02f7P4sOCRVxGBt6LDlPs62fTSNT6GZzNoZm50NZOfKiF4dH?=
 =?us-ascii?Q?Wos8QTYb3fjxOB6do+z+M4wIG4rMuTY5L3FiRVgy2+uKOKDi1xJNPGgNluO5?=
 =?us-ascii?Q?GzwON+EOcdo6//zoaSm1B5IoFkYFPntAfU1Q+CIdDBzLNspi3wbpUFpmOkuP?=
 =?us-ascii?Q?sOf8h5sVIvsqjCv9Ecx6T3EOXCsl/otMFRf8A91XqLZGRhL2W3jonGBNKjMs?=
 =?us-ascii?Q?BTkvf3mtnrA8pUePw0kLwAJzoSUyLw1Ogvfb1e76f5ivN7VobXea8NvZ1DUY?=
 =?us-ascii?Q?YH1Hiu68H0sXgKsomkUjHaCaKtZypTxLwall/6W1lqMBIFfcAcBfF16u2IxH?=
 =?us-ascii?Q?+UyKxtTzn7MZeuXIZn2uH/7mw7Hsw/3PrhSY7VJHBXiwpncWYA3T09lz9Efc?=
 =?us-ascii?Q?KPIUovu5TXuML6rUOyJcE0D+eKoOb4HVEKK14gZJwS2WQ8j5awSYzLaZnUQu?=
 =?us-ascii?Q?Aq9AXTBarqYnn4uINoaKaBXUq8+nPqhFuOuLcjIqea1KH0LqripmY6wqVi0w?=
 =?us-ascii?Q?Tv0l9n08Wtic5cVL6bSxtqU+DDtk0dDjVvBVuGfpZbdzThfkg6k9P6UGSGcg?=
 =?us-ascii?Q?LAgMuyut/mNCkVuSsa/KJrdGMxtu6AcBq/Yn5l3dT2dzeKzBx8/dh3evWJ08?=
 =?us-ascii?Q?TbT1wZymx54U7cBReYjJVVelg9AlZjPtFwgLliQHIDJDlfjbNT1Jz/ShpN5b?=
 =?us-ascii?Q?0OO4h6UMao2FHj7is8JJ5fIVcylWy3eWCI/UbVrUniTtBiQ2x2BkycRt0kzB?=
 =?us-ascii?Q?zv+JESDHGpOiByY0H0PeoORfjG53XfOJ24me0MwkJGSONiIhYeKWfadCST7n?=
 =?us-ascii?Q?/ij+AtxbJ4Hf7NLHCpsQD2TZFi8n4XorCS16JyrK9ThnCNdYo74Ja60TQ+KU?=
 =?us-ascii?Q?64mB5xoqcOhGnGqc1Qnp5/EZQsmxoqGFDsl6QZ2f2XPImqBo/d+u3qDORyxE?=
 =?us-ascii?Q?aMGYXDArmp/g57ShoYyXdYs81ZANdoY3py5O/6N7CqnpHh6YfvRIzck2Bi8L?=
 =?us-ascii?Q?+Ao1bb0WLiVlC+8Rc9bvEWme5ksMc3CiLgme7i7OdSnRG1su/eNI/OWqRkfW?=
 =?us-ascii?Q?11wJawKONxGd947lJEYa4T6Kz9dDOLkuAsu7XI84b9r8zXHU6g5AXTyRAnQi?=
 =?us-ascii?Q?EArQdVJ5kHSdbFmvIAGczvIReBSa/uYzMWNQX0oMdmutEyJTB1QVk135Ye63?=
 =?us-ascii?Q?sWfdjP0FQhFBnDwPoHlpuPVB3bjXS/LS7SyQ+7HWlWkA7jcl7Px+ZeXett8c?=
 =?us-ascii?Q?yZdwW2y8Ewq5ZTJTEqEpn5/TIqoToEqiEo8Mx5U2uFMA5SXZ4detLL9JBaWl?=
 =?us-ascii?Q?awJ0XdWBfun3GXB0RMo9MJ718nFbzgnAPoijCDY4myI5aoYUad4Re1hgwRik?=
 =?us-ascii?Q?eiQlGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0350.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b044a25-4c85-426c-3792-08d9b95b8f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 08:28:34.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IslXCKlZRF+eju/dKdQE94T8aF0Hfkx965jWqCueSeRjHaZuxu6BoSWC0r/9iUYTumExC+8KdBSKWqpYmJ/Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>=20
Sent: Monday, December 6, 2021 3:27 AM
To: David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>; CIFS <linux-cifs@vger.kernel.org>; L=
inux Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux Next Mailing=
 List <linux-next@vger.kernel.org>; Shyam Prasad <Shyam.Prasad@microsoft.co=
m>; Steven French <Steven.French@microsoft.com>
Subject: [EXTERNAL] Re: linux-next: manual merge of the cifs tree with the =
fscache tree

Hi all,

On Fri, 3 Dec 2021 09:41:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> Today's linux-next merge of the cifs tree got conflicts in:
>=20
>   fs/cifs/connect.c
>   fs/cifs/fscache.c
>=20
> between commit:
>=20
>   935b45107a80 ("cifs: Support fscache indexing rewrite (untested)")
>=20
> from the fscache tree and commits:
>=20
>   9d0245fc6a2e ("cifs: wait for tcon resource_id before getting fscache s=
uper")
>   c148f8eb032f ("cifs: add server conn_id to fscache client cookie")
>   b1f962ba272b ("cifs: avoid use of dstaddr as key for fscache client=20
> cookie")
>=20
> from the cifs tree.
>=20
> I fixed it up (I just used the former versions) and can carry the fix=20
> as necessary. This is now fixed as far as linux-next is concerned, but=20
> any non trivial conflicts should be mentioned to your upstream=20
> maintainer when your tree is submitted for merging.  You may also want=20
> to consider cooperating with the maintainer of the conflicting tree to=20
> minimise any particularly complex conflicts.

These are now conflict between the fscache tree and Linus' tree.

--
Cheers,
Stephen Rothwell
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Hi David,

As we discussed offline, I will test out the fscache rewrite integration in=
 cifs.ko later this week and submit the final patch to linux-cifs mailing l=
ist.
As a part of this, I will fix all the conflicts that arise.
Is this okay with you?
I hope this will eliminate the conflicts between the two trees for now?

Regards,
Shyam
