Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2F488E91
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 03:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiAJCFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 21:05:35 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38975 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiAJCFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 21:05:31 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220110020528epoutp0354d1a34819591db27ddce8cceb5a0280~IxoK6vKVJ0483904839epoutp03j
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:05:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220110020528epoutp0354d1a34819591db27ddce8cceb5a0280~IxoK6vKVJ0483904839epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641780328;
        bh=zNXUGQ2tuUM1GeexQGYxYdVoXMlQO/tYPjm37Z6s7xw=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=HRccBuu2NzOhzb2YyQWlouOTaBNosq0ppM0ivgrhgPiC7bjthM6s7WnQPal+N92w8
         konxy0ptc4kd6eEtNfDW9iowVNxNOsSO1kUHczDJCdGmi+T3tVfNgYYOwlcvi23TPH
         8Ko64hUYJ+GJI0Di7lX5pGnUfBvCVH2SdRdKFNSI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220110020528epcas2p1ea8b8c39d2912eb84819653fba7475fb~IxoKMMrhT1788117881epcas2p1_;
        Mon, 10 Jan 2022 02:05:28 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JXHGV5v9Vz4x9Qd; Mon, 10 Jan
        2022 02:05:22 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.20.51767.D549BD16; Mon, 10 Jan 2022 11:05:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220110020517epcas2p351eb1e0b96a4b9955cf92a4327a82d56~IxoABXgNS1731717317epcas2p3a;
        Mon, 10 Jan 2022 02:05:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220110020517epsmtrp19f61cfff8233bf72cbc264231ff1bc57~IxoAADLY51631416314epsmtrp1G;
        Mon, 10 Jan 2022 02:05:17 +0000 (GMT)
X-AuditID: b6c32a45-c69bba800000ca37-7f-61db945d92a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.21.29871.C549BD16; Mon, 10 Jan 2022 11:05:17 +0900 (KST)
Received: from KORDO040863 (unknown [12.36.185.126]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220110020517epsmtip22e2f707b7f8696e522809bb01875b060~Ixn-zNN_c2155621556epsmtip2b;
        Mon, 10 Jan 2022 02:05:17 +0000 (GMT)
From:   =?UTF-8?B?7ISc7Zi47JiB?= <hy50.seo@samsung.com>
To:     "'Avri Altman'" <Avri.Altman@wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB657535F7CC817A0E2893F668FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
Subject: RE: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
Date:   Mon, 10 Jan 2022 11:05:16 +0900
Message-ID: <000401d805c6$8329ae40$897d0ac0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQF2Kk2TqRw63Mnhf/Wn1AdBL3QQDAKhhYJeAZr8dqys/UWZMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmhW7slNuJBm/fy1g8mLeNzWJv2wl2
        i5c/r7JZHHzYyWIx7cNPZotP65exWiy6sY3J4vKuOWwW3dd3sFksP/6PyYHL4/IVb4/Lfb1M
        HhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfRfqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7
        ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hGJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+
        cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2Rs/61WwFr8Uqjq49z9jAuFGwi5GT
        Q0LARGLF2amsXYxcHEICOxglXi/aAeV8YpRY/nAXC0iVkMA3Ron9XdEwHf+bPkAV7WWU2LXq
        HTtE0UtGiX/na0BsNgFTib5tK1hBbBGBWUwS8xs9QWxOgViJxcs+MYHYwgKeEvePH2DsYuTg
        YBFQlTh+vhgkzCtgKbHp83VWCFtQ4uTMJ2A3MAtoSyxb+JoZ4gYFiR1nX4O1igg4SSx9qQdR
        IiIxu7ONGeQ0CYEtHBI7p+5ihKh3kfg4eS8rhC0s8er4FnYIW0riZX8bO0RDM6PE+plzmCCc
        KYwSc589heowlpj1rB1sG7OApsT6XfogpoSAssSRW1C38Ul0HP7LDhHmlehoE4JoVJI4M/c2
        VFhC4uDsHIiwh8SUObtZJzAqzkLy5CwkT85C8s0shLULGFlWMYqlFhTnpqcWGxUYwmM6OT93
        EyM47Wq57mCc/PaD3iFGJg7GQ4wSHMxKIrx7L9xKFOJNSaysSi3Kjy8qzUktPsRoCgz1icxS
        osn5wMSfVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qBybsh4Hvs
        f1F5xUX3lt18u1VfN2GWgErb7/sB69PFVzQVLT785hKrxy1H1kjtB2LPciSeFrwNmbz6xvGq
        1Vd67UN6JRjTb33LVtls9Cuu26f12tKfHz5+Kv/lKHF6auTyvYcfnm8XPcHUO329IOvLGv+0
        qTcCf9c/5mbf2l82OSHkG5+u3Rzex1LtGqsSxQrCpz9r4bzJocs77dSPQHOp9RNPMcbdreau
        Ypq3N1KKOcg3ybyL67eOdDdbw5FVXYwflu8xY1GfaSWo8vSG7kTHdx9Df8ued08K/9b690hf
        /dVLqQc1535nj1+UE751j4HLGRnn2PagvyFN1sfnmGs2ibfcqF3zYs2JJTZTdd60KLEUZyQa
        ajEXFScCALwolO5EBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvG7slNuJBuuXMFk8mLeNzWJv2wl2
        i5c/r7JZHHzYyWIx7cNPZotP65exWiy6sY3J4vKuOWwW3dd3sFksP/6PyYHL4/IVb4/Lfb1M
        HhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfRfqCbKYAjissmJTUnsyy1SN8ugSvj4Nmr7AXr
        xCre3z/A2sD4SaCLkZNDQsBE4n/TB9YuRi4OIYHdjBK7uvYyQSQkJP4vboKyhSXutxyBKnrO
        KNG38i8bSIJNwFSib9sKsISIwDImiQ8nz0BV3WWU6HlyEKyKUyBWYvGyT2CjhAU8Je4fP8DY
        xcjBwSKgKnH8fDFImFfAUmLT5+usELagxMmZT1hAbGYBbYneh62MMPayha+ZIS5SkNhx9jXY
        GBEBJ4mlL/UgSkQkZne2MU9gFJqFZNIsJJNmIZk0C0nLAkaWVYySqQXFuem5xYYFhnmp5XrF
        ibnFpXnpesn5uZsYwRGnpbmDcfuqD3qHGJk4GA8xSnAwK4nw7r1wK1GINyWxsiq1KD++qDQn
        tfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJqW3N9/WFT77nPHWff4fO47Mf4aZ
        ic+zDV8997Lf+n3aLYWoS0lrv5/529HIc2TztCWtKkHzjx373xxT9ke1RHfZhwWXj32yLJlo
        v/P37OhTTumfpL4cOhWjGc71tvHTu7s/zxzI33qycLIys4zKTr6yhE+PGLkb33O0ez/4VXf2
        gHTrQtnmSi2mpWGrT9+oaPV/Z7F5rrXPNpXGdIl49tOvJ1x8U7zfaf6Rqfe0X0TY8GUf+bRj
        mtvcvnsaKX+Ci5tOpq0SMbV4//p5nrJnzf49+1WtbtSkO5VN//hPz9ColzFbe2ljhF8k95eC
        /Qpss+cKrMhqUKtvy5oT+liSsXjDZs6H3Bvvunz7flniIpsSS3FGoqEWc1FxIgBt+KGlJwMA
        AA==
X-CMS-MailID: 20220110020517epcas2p351eb1e0b96a4b9955cf92a4327a82d56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912
References: <CGME20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912@epcas2p2.samsung.com>
        <20220106213924.186263-1-hy50.seo@samsung.com>
        <DM6PR04MB657535F7CC817A0E2893F668FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
If register =22UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE=22 quirk,
using this Tact time function.
And I mean all Samsung device use UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE quirk =
below this. so I told that.
static struct ufs_dev_fix ufs_fixups=5B=5D =3D =7B                   =20
         /* UFS cards deviations table */                     =20
         UFS_FIX(UFS_VENDOR_MICRON, UFS_ANY_MODEL,            =20
                 UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM =7C          =20
                 UFS_DEVICE_QUIRK_SWAP_L2P_ENTRY_FOR_HPB_READ),
         UFS_FIX(UFS_VENDOR_SAMSUNG, UFS_ANY_MODEL,           =20
                 UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM =7C          =20
                 UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE =7C

Other vendors can use it if necessary.
And for stability, the device tact time must be longer than host tact time.
(I already check Major device vendors)
That's reason why use this function.
But the Host tact time and Device tact time same, stability may not be sati=
sfied.
So I changed this way

Thanks,
HOYOUNG.

> -----Original Message-----
> From: Avri Altman =5Bmailto:Avri.Altman=40wdc.com=5D
> Sent: Friday, January 7, 2022 7:57 PM
> To: SEO HOYOUNG; linux-scsi=40vger.kernel.org; linux-kernel=40vger.kernel=
.org;
> alim.akhtar=40samsung.com; jejb=40linux.ibm.com; martin.petersen=40oracle=
.com;
> beanhuo=40micron.com; asutoshd=40codeaurora.org; cang=40codeaurora.org;
> bvanassche=40acm.org
> Subject: RE: =5BPATCH v2=5D scsi: ufs: modify Tactive time setting condit=
ions
>=20
> > The Tactive time determine the waiting time before burst at hibern8
> > exit and is determined by H/W at linkup state However, in the case of
> > samsung devices, guided host's Tactive time
> > +100us for stability.
> > If the HCI's Tactive time is equal or greater than the device,
> > +100us should be set.
> This way you are changing this for everyone - not just for Samsung.
> e.g. Qualcomm are using this quirk as well for WDC devices.
>=20
> Thanks,
> Avri
>=20
> >
> > Signed-off-by: SEO HOYOUNG <hy50.seo=40samsung.com>
> > ---
> >  drivers/scsi/ufs/ufshcd.c =7C 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index 1049e41abd5b..460d2b440d2e 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > =40=40 -7815,7 +7815,7 =40=40 static int
> > ufshcd_quirk_tune_host_pa_tactivate(struct
> > ufs_hba *hba)
> >         peer_pa_tactivate_us =3D peer_pa_tactivate *
> >                              gran_to_us_table=5Bpeer_granularity - 1=5D=
;
> >
> > -       if (pa_tactivate_us > peer_pa_tactivate_us) =7B
> > +       if (pa_tactivate_us >=3D peer_pa_tactivate_us) =7B
> >                 u32 new_peer_pa_tactivate;
> >
> >                 new_peer_pa_tactivate =3D pa_tactivate_us /
> > --
> > 2.26.0


