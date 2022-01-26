Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218EA49C34E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiAZFfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:35:01 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:19056 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiAZFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:34:58 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220126053456epoutp039b1d8e354c5d6f69a73fb26edbb9d084~Nuznd-9Hk2001120011epoutp03D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:34:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220126053456epoutp039b1d8e354c5d6f69a73fb26edbb9d084~Nuznd-9Hk2001120011epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643175296;
        bh=I6Ypg3bdP+YBC9mR/Bne14uXTQjDRacF0gcOjhA373g=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HO6LKQjkSZwfU4Cm8nHGQpVsiLHVYO3wSWhXX0yT3Yzva5FwwkerysEZYgjIcFKjP
         Nh6IzEt9cXpXmsntj2+Nh0EtJ3sxSrlPWBJMpsgW5Ve7jmB4RsetMvxZGZ1fXT7EAv
         hCyLyUn0YHRL8/onpyF4voFJ3x5j3nNdAFo9h/MQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220126053455epcas2p1e1066bf32f46c026f7cefff6ea9b541b~Nuzm2nWOb0308903089epcas2p1A;
        Wed, 26 Jan 2022 05:34:55 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JkC8r1Whfz4x9Pp; Wed, 26 Jan
        2022 05:34:52 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.C5.10014.DDBD0F16; Wed, 26 Jan 2022 14:27:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220126053451epcas2p18e63b25fa31cb3d8e2a8c0491868729c~Nuzjbd-Ri2319123191epcas2p1U;
        Wed, 26 Jan 2022 05:34:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220126053451epsmtrp27cc00128aec8b838b49ae16117e0741a~NuzjTxile1137911379epsmtrp2a;
        Wed, 26 Jan 2022 05:34:51 +0000 (GMT)
X-AuditID: b6c32a47-473ff7000000271e-e0-61f0dbdd7d58
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.6C.29871.B7DD0F16; Wed, 26 Jan 2022 14:34:51 +0900 (KST)
Received: from KORDO040863 (unknown [12.36.185.126]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220126053451epsmtip20dc5f2b02d43e0e877f92167c08c4a52~NuzjJ9OwM2106721067epsmtip2Y;
        Wed, 26 Jan 2022 05:34:51 +0000 (GMT)
From:   =?UTF-8?B?7ISc7Zi47JiB?= <hy50.seo@samsung.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <bvanassche@acm.org>,
        <bhoon95.kim@samsung.com>, <kwmad.kim@samsung.com>
Cc:     "'kernel test robot'" <lkp@intel.com>
In-Reply-To: <40986ecb6c81812a1e1ab24d93e46eda75974c4e.camel@mediatek.com>
Subject: RE: [PATCH v2] scsi: ufs: disable auto hibern8 while entering
 suspend
Date:   Wed, 26 Jan 2022 14:34:51 +0900
Message-ID: <101901d81276$70d9ea40$528dbec0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIlzz+JKCbQP4e9lbbSHSqpu8nHvgHyie3oAmFa8EWrtq73AA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmhe7d2x8SDf78tLZ4MG8bm8XethPs
        Fi9/XmWzOPiwk8Xi69JnrBbTPvxktvi0fhmrxaIb25gsbm45ymJxedccNovu6zvYLF41P2Kz
        WH78H5MDr8flK94el/t6mTwW73nJ5DFh0QFGj+/rO9g8Pj69xeLRt2UVo8fnTXIe7Qe6mQI4
        o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DuVlIo
        S8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZk
        Z5zfPpGpYLN8Rce232wNjD8luxg5OSQETCROTLzC1sXIxSEksINRYt+TFhYI5xOjxOUvj1kh
        nG+MEjv/XmbqYuQAazmz1gUivpdRYu7S0+wQzktGiSnTprKBzGUTMJXo27YCrFtE4ACTRMuc
        gywgCWYBTYkFs96A2ZwCXhKTTnxjB7GFBQIkFry6zAhiswioSvxe1Q8W5xWwlJgw5wgThC0o
        cXLmE6g52hLLFr5mhnhCQWLH2ddgvSICThL/ln9jhKgRkZjd2cYMcoSEwA0OiSc7zjNBNLhI
        LHsxnx3CFpZ4dXwLlC0l8fndXjaIhmZGifUz5zBBOFOAHn32lBWiylhi1rN2RlBggLyzfpc+
        JFyUJY7cgjqOT6Lj8F92iDCvREebEESjksSZubehwhISB2fnTGBUmoXks1lIPpuF5INZCKsW
        MLKsYhRLLSjOTU8tNiowhsd2cn7uJkZwmtZy38E44+0HvUOMTByMhxglOJiVRHj/e79PFOJN
        SaysSi3Kjy8qzUktPsRoCgzricxSosn5wEyRVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2x
        JDU7NbUgtQimj4mDU6qBKVU0dMLaeXqqbff1NktO2aQoIp4l5DHDKDOsarm9gUJdzD+RZ667
        WN0Xd37tzA4Wy5yyPn/eUa7SshK1n6FOxV7a5fWlVnO+/v37oJLNqljINsua7cf0ZRMl16Xx
        TPhmW16+Q2C9kFqnpgz73f6Hdw7G7FzGZsb5f5PimiznMD2RXfOrL+rteO2/btJBsXPSlm4c
        oTt5s6PefpeSuCl1nHNTz64NguuXqcWVJ/HodRfm6q/6YWOyn32bq7Gcs9C5G7U8Wo4XtEuL
        jRbuPvRshbHRa6MlU7J7Xtet+Rlx74r/xfW+U5I2pEfcZdXc9KBj6/0r//bMFVry/e6FCVcY
        Y5LVfmczLdDdHilpVmqrxFKckWioxVxUnAgAe8vzuVwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvG713Q+JBg+7dCwezNvGZrG37QS7
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsejGNiaLm1uOslhc3jWHzaL7+g42i1fNj9gs
        lh//x+TA63H5irfH5b5eJo/Fe14yeUxYdIDR4/v6DjaPj09vsXj0bVnF6PF5k5xH+4FupgDO
        KC6blNSczLLUIn27BK6MT1t72AoeyFW0tFY0MC6R7GLk4JAQMJE4s9ali5GLQ0hgN6PEo80f
        2LsYOYHiEhL/FzcxQdjCEvdbjrBCFD1nlOjsOg9WxCZgKtG3bQVYQkTgHJPEhgPbGEESzAKa
        EgtmvWGB6DjFKHFjXQNYglPAS2LSiW9g3cICfhJtXx+ygNgsAqoSv1f1g8V5BSwlJsw5wgRh
        C0qcnPmEBWKotkTvw1ZGGHvZwtfMEOcpSOw4+xosLiLgJPFv+TeoGhGJ2Z1tzBMYhWchGTUL
        yahZSEbNQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcMRqae5g3L7qg94h
        RiYOxkOMEhzMSiK8/73fJwrxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUg
        tQgmy8TBKdXAFLVF8wSX2N0N1yprg121WCctv3N5g6Y+46TKG3eu2GXtOhJ84bleg9gpp2XH
        ph98cUqdveVmZsOUJ38dfBM/7CxrCXTf6sm/KdNDWLaxs/vTqbtrUzKML7xNXf+wZoN5UdxT
        z90SMScrVjbMeej+cM262V9tpmzP6k9eJVMvGKAf7aoRbMvLMNvnxRKl6tbAjCe1Yc3/GFmd
        rnTY8EZE3m6eFnjt/2RenedfwreK6OSdsU14GR9RM/Xz+z3dE/2Ltj7cK+ecW7k/fu6doyrh
        t9ZVGn9el/86Zu3eh1v4fn+5E1MZdnXK+zk8x5Vstsl6Jut+N+f1m9iW8F/H7/FHrd7D+nxF
        D95r87xSW/NrrhJLcUaioRZzUXEiANVFCyJHAwAA
X-CMS-MailID: 20220126053451epcas2p18e63b25fa31cb3d8e2a8c0491868729c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b
References: <CGME20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b@epcas2p1.samsung.com>
        <20220124180637.160524-1-hy50.seo@samsung.com>
        <40986ecb6c81812a1e1ab24d93e46eda75974c4e.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I think content is lacking in the UFSHCI spec.
In the process, AH8 is in operation, and it seems that sending the command
hibern8 by manual has a defeat.
I don't know what the all hci vendor's hardware design will be, but there i=
s a possibility that ah8 and manual hibern8 may overlap.
So if is operating in ah8, it is thought that it will be safer to disable a=
h8 before sending hibern8 command.

> -----Original Message-----
> From: Stanley Chu =5Bmailto:stanley.chu=40mediatek.com=5D
> Sent: Wednesday, January 26, 2022 10:22 AM
> To: SEO HOYOUNG; linux-scsi=40vger.kernel.org; linux-kernel=40vger.kernel=
.org;
> alim.akhtar=40samsung.com; avri.altman=40wdc.com; jejb=40linux.ibm.com;
> martin.petersen=40oracle.com; beanhuo=40micron.com; asutoshd=40codeaurora=
.org;
> cang=40codeaurora.org; bvanassche=40acm.org; bhoon95.kim=40samsung.com;
> kwmad.kim=40samsung.com
> Cc: kernel test robot; peter.wang=40mediatek.com
> Subject: Re: =5BPATCH v2=5D scsi: ufs: disable auto hibern8 while enterin=
g
> suspend
>=20
> Hi Hoyoung,
>=20
> On Tue, 2022-01-25 at 03:06 +0900, SEO HOYOUNG wrote:
> > v1-> v2: fixed no previous prototype warning
> > Reported-by: kernel test robot <lkp=40intel.com>
> >
> > All warnings (new ones prefixed by >>):
> > > > drivers/scsi/ufs/ufshcd.c:4207:6: warning: no previous prototype
> >
> > for 'ufshcd_auto_hibern8_disable' =5B-Wmissing-prototypes=5D
> > 4207 =7C void ufshcd_auto_hibern8_disable(struct ufs_hba *hba)
> >
> > If using auto hibern8 mode, need to disable auto hibern8 while
> > entering suspend.
> > When using auto hibern8 mode, it does not seem right to send a uic
> > command
>=20
> The UFSHCI spec does not mention the above rule.
> Why would you need to disable AH8 before using UIC command to enter H8?
>=20
> > for entry into hibern8 in the next
> > line(ufshcd_lik_state_transition(..))
> > It seem right to send after disable auto hibern8.
> >
> > In addition, if the auto hibern8 mode supported, it is enabled in
> > resume.
> > So it seems that it will be paired only when auto hibern8 is disabled
> > while entering suspend.
> >
> > Signed-off-by: SEO HOYOUNG <hy50.seo=40samsung.com>
> > ---
> >  drivers/scsi/ufs/ufshcd.c =7C 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index 460d2b440d2e..a6edbbd8ca2c 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > =40=40 -254,6 +254,7 =40=40 static void
> > ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set);
> > static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool
> > enable);  static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
> > static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
> > +static void ufshcd_auto_hibern8_disable(struct ufs_hba *hba);
> >
> >  static inline void ufshcd_enable_irq(struct ufs_hba *hba)  =7B =40=40
> > -4204,6 +4205,18 =40=40 void ufshcd_auto_hibern8_update(struct ufs_hba
> > *hba, u32 ahit)  =7D  EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);
> >
> > +static void ufshcd_auto_hibern8_disable(struct ufs_hba *hba) =7B
> > +	unsigned long flags;
> > +
> > +	if (=21ufshcd_is_auto_hibern8_supported(hba))
> > +		return;
> > +
> > +	spin_lock_irqsave(hba->host->host_lock, flags);
> > +	ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER);
> > +	spin_unlock_irqrestore(hba->host->host_lock, flags); =7D
> > +
> >  void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)  =7B
> >  	unsigned long flags;
> > =40=40 -8925,6 +8938,7 =40=40 static int __ufshcd_wl_suspend(struct ufs=
_hba
> > *hba, enum ufs_pm_op pm_op)
> >  	 * with the link off, so do not check for bkops.
> >  	 */
> >  	check_for_bkops =3D =21ufshcd_is_ufs_dev_deepsleep(hba);
> > +	ufshcd_auto_hibern8_disable(hba);
> >  	ret =3D ufshcd_link_state_transition(hba, req_link_state,
> > check_for_bkops);
> >  	if (ret)
> >  		goto set_dev_active;


