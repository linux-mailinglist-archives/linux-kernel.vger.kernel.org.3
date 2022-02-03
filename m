Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0864A7C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348365AbiBCANF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:13:05 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:36800 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348351AbiBCANC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:13:02 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220203001300epoutp0400c46b51f0c7a7efd164a5dd7f3e31e8~QHk0fOYCR1828818288epoutp048
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 00:13:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220203001300epoutp0400c46b51f0c7a7efd164a5dd7f3e31e8~QHk0fOYCR1828818288epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643847180;
        bh=lHVUgtbRtmSNLKrAgtdPwXWfNwbXKBGujat1tRTUK8g=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=l1tNHBT8evVK9wTPZ78kQbLXVpfTnhjh4+JZ297nB7fFD6HsxntCne0m+/+T3OTL5
         M6d/X6ZhSj9PApv4RYluF6g3I8sfoxa7jcbzQd8/MpM46y6CqmqIp9OGgYbItPpq9/
         YOeOxKfQ5+QacZtZL2xJZZmUzjbdPMO9gT3+S2v8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220203001300epcas2p333ec4ff4e047348d006464cdbca6e80f~QHkz-XnvE0672406724epcas2p37;
        Thu,  3 Feb 2022 00:13:00 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jpzdd12SLz4x9Q8; Thu,  3 Feb
        2022 00:12:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.D8.12141.30E1BF16; Thu,  3 Feb 2022 09:12:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220203001251epcas2p439251f1867ca8848046c1046826d74db~QHkrmSWxV0103401034epcas2p4P;
        Thu,  3 Feb 2022 00:12:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220203001251epsmtrp124ca4b6eb69cba33fe73c78a5cb63cc8~QHkrlMxSR2779427794epsmtrp16;
        Thu,  3 Feb 2022 00:12:51 +0000 (GMT)
X-AuditID: b6c32a48-d5dff70000002f6d-a3-61fb1e03323f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.BB.08738.20E1BF16; Thu,  3 Feb 2022 09:12:50 +0900 (KST)
Received: from KORDO040863 (unknown [12.36.185.126]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220203001250epsmtip207c6521382e6efb90b6676f056c4105e~QHkrasSWA3130431304epsmtip2P;
        Thu,  3 Feb 2022 00:12:50 +0000 (GMT)
From:   "Hoyoung SEO" <hy50.seo@samsung.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <bvanassche@acm.org>,
        <bhoon95.kim@samsung.com>, <kwmad.kim@samsung.com>
Cc:     "'kernel test robot'" <lkp@intel.com>
In-Reply-To: 
Subject: RE: [PATCH v2] scsi: ufs: disable auto hibern8 while entering
 suspend
Date:   Thu, 3 Feb 2022 09:12:50 +0900
Message-ID: <12a201d81892$c8123d40$5836b7c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIlzz+JKCbQP4e9lbbSHSqpu8nHvgHyie3oAmFa8EWrtq73AIAMOI6w
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmuS6z3O9Eg/Xn5C0ezNvGZrG37QS7
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsejGNiaLm1uOslhc3jWHzaL7+g42i1fNj9gs
        lh//x+TA63H5irfH5b5eJo/Fe14yeUxYdIDR4/v6DjaPj09vsXj0bVnF6PF5k5xH+4FupgDO
        qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKC7lRTK
        EnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZ
        GZcvrWIp2GBa8XzVXNYGxmfGXYycHBICJhJHF6xh6WLk4hAS2MEoMXPZAWYI5xOjxOIZPVCZ
        z4wSl869ZoNpeXNpCVRiF6PEl0mHWUASQgIvGSXmr1MGsdkEtCSuT3wLNkpE4ACTRMucg2BF
        zAKaEgtmvQGyOTg4BXglJvyzBgkLCwRILHh1mREkzCKgIvHxcBpImFfAUuLvrZOMELagxMmZ
        T6CmaEssW/iaGeIeBYkdZ1+D1YgIuEnMO/yFEaJGRGJ2ZxtUzR0OifNffUDGSwi4SOw7WAAR
        FpZ4dXwLO4QtJfGyvw3KLpb48WY1E8j1EgINjBJL249BzTGWmPWsHexMkE/W79KHGKksceQW
        1GV8Eh2H/7JDhHklOtqEIBqVJM7MvQ0VlpA4ODtnAqPSLCRvzULy1iwk589CWLWAkWUVo1hq
        QXFuemqxUYEJPKKT83M3MYKTs5bHDsbZbz/oHWJk4mA8xCjBwawkwrt34fdEId6UxMqq1KL8
        +KLSnNTiQ4ymwHCeyCwlmpwPzA95JfGGJpYGJmZmhuZGpgbmSuK8XikbEoUE0hNLUrNTUwtS
        i2D6mDg4pRqYgrKfifEsVE3eGyrqJHXpl8n7zNTCNKfcXW6TX5ql3pv8TbUx4f7x3AWC6Tdk
        9Hcu3v846PyM1bEc3y8kz/v/+Y3R5Vvnfl6Wjqu8u8ro884EtRut5vMccl/aTT/MpbRivsya
        2rryTEGOVefXzfrCaXAzQHPToRiJdZ/8jP5Gpz8Md+eWV8zmC85rZmXasNGiJWDD6okTu9i4
        PgXpvFzrqnfn271Qlfe9KQI9h5n7OU7/fvZLMiZwTicTt86+B3bHM/61ZvJkvko5paDT69bk
        qLt4FbNOfNHdZ61PvIUKV01ni7c5EFe75NaNN/1HdaLNc/7cClj/KeabVJfgJsFJGy2/XY4O
        E01bv7VY4pGyEktxRqKhFnNRcSIAVYIL71cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvC6T3O9EgyUzLSwezNvGZrG37QS7
        xcufV9ksDj7sZLH4uvQZq8W0Dz+ZLT6tX8ZqsejGNiaLm1uOslhc3jWHzaL7+g42i1fNj9gs
        lh//x+TA63H5irfH5b5eJo/Fe14yeUxYdIDR4/v6DjaPj09vsXj0bVnF6PF5k5xH+4FupgDO
        KC6blNSczLLUIn27BK6MuWcusxacVK3Yv/cUWwPjRbkuRk4OCQETiTeXlrB0MXJxCAnsYJT4
        3HacFSIhIfF/cRMThC0scb/lCCtE0XNGiROds9hBEmwCWhLXJ75lBkmICJxjkthwYBsjSIJZ
        QFNiwaw3UGNPM0q0nusDquLg4BTglZjwzxqkRljAT6Lt60MWkDCLgIrEx8NpIGFeAUuJv7dO
        MkLYghInZz5hgRipLdH7sJURxl628DUzxHEKEjvOvgaLiwi4Scw7/AWqRkRidmcb8wRG4VlI
        Rs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHLFaWjsY96z6
        oHeIkYmD8RCjBAezkgjv3oXfE4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5Ykpqd
        mlqQWgSTZeLglGpgyk3c88Va3EJin4/8irPrTuulOyxO607UTdu69zhrI9fW1SrbdF8pKji/
        OmImOfnDSoP3LNn+npUqlfMf5Ev1LLhn/dTpgd4qrwnCRsl159ak7Z/+TbncXM/Q207aNqri
        XYCSVGbS0xk/5t+Q6V2jq9l3pVJ51jntmStLGmZOWHCT9daeJTKfPfIU6gQX7LPUu3P47bxZ
        J7/GRn0vNvohtUy85md/7u5rShHn4v5slNaebp/jM+e7zpxd89bnmbQEvm5g+ShofuPwtG7D
        64eiT1vteB70Q+v64tznk2c76Oj6frxZucvJpVQ0PXhNMMeiWuXXKftV266nl8YH/i99VHdZ
        VGfBEcHAn2Hvb0RJKrEUZyQaajEXFScCAFfkmJRHAwAA
X-CMS-MailID: 20220203001251epcas2p439251f1867ca8848046c1046826d74db
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
Please check this patch.
If there is any other opinion, please give me comments
Thanks

> -----Original Message-----
> From: =EC=84=9C=ED=98=B8=EC=98=81=20=5Bmailto:hy50.seo=40samsung.com=5D=
=0D=0A>=20Sent:=20Wednesday,=20January=2026,=202022=202:35=20PM=0D=0A>=20To=
:=20'linux-scsi=40vger.kernel.org';=20'linux-kernel=40vger.kernel.org';=0D=
=0A>=20'alim.akhtar=40samsung.com';=20'avri.altman=40wdc.com';=20'jejb=40li=
nux.ibm.com';=0D=0A>=20'martin.petersen=40oracle.com';=20'beanhuo=40micron.=
com';=0D=0A>=20'asutoshd=40codeaurora.org';=20'cang=40codeaurora.org';=20'b=
vanassche=40acm.org';=0D=0A>=20'bhoon95.kim=40samsung.com';=20'kwmad.kim=40=
samsung.com'=0D=0A>=20Cc:=20'kernel=20test=20robot'=0D=0A>=20Subject:=20RE:=
=20=5BPATCH=20v2=5D=20scsi:=20ufs:=20disable=20auto=20hibern8=20while=20ent=
ering=0D=0A>=20suspend=0D=0A>=20=0D=0A>=20Hi,=0D=0A>=20I=20think=20content=
=20is=20lacking=20in=20the=20UFSHCI=20spec.=0D=0A>=20In=20the=20process,=20=
AH8=20is=20in=20operation,=20and=20it=20seems=20that=20sending=20the=20comm=
and=0D=0A>=20hibern8=20by=20manual=20has=20a=20defeat.=0D=0A>=20I=20don't=
=20know=20what=20the=20all=20hci=20vendor's=20hardware=20design=20will=20be=
,=20but=20there=0D=0A>=20is=20a=20possibility=20that=20ah8=20and=20manual=
=20hibern8=20may=20overlap.=0D=0A>=20So=20if=20is=20operating=20in=20ah8,=
=20it=20is=20thought=20that=20it=20will=20be=20safer=20to=20disable=0D=0A>=
=20ah8=20before=20sending=20hibern8=20command.=0D=0A>=20=0D=0A>=20>=20-----=
Original=20Message-----=0D=0A>=20>=20From:=20Stanley=20Chu=20=5Bmailto:stan=
ley.chu=40mediatek.com=5D=0D=0A>=20>=20Sent:=20Wednesday,=20January=2026,=
=202022=2010:22=20AM=0D=0A>=20>=20To:=20SEO=20HOYOUNG;=20linux-scsi=40vger.=
kernel.org;=0D=0A>=20>=20linux-kernel=40vger.kernel.org;=20alim.akhtar=40sa=
msung.com;=0D=0A>=20>=20avri.altman=40wdc.com;=20jejb=40linux.ibm.com;=20ma=
rtin.petersen=40oracle.com;=0D=0A>=20>=20beanhuo=40micron.com;=20asutoshd=
=40codeaurora.org;=20cang=40codeaurora.org;=0D=0A>=20>=20bvanassche=40acm.o=
rg;=20bhoon95.kim=40samsung.com;=20kwmad.kim=40samsung.com=0D=0A>=20>=20Cc:=
=20kernel=20test=20robot;=20peter.wang=40mediatek.com=0D=0A>=20>=20Subject:=
=20Re:=20=5BPATCH=20v2=5D=20scsi:=20ufs:=20disable=20auto=20hibern8=20while=
=20entering=0D=0A>=20>=20suspend=0D=0A>=20>=0D=0A>=20>=20Hi=20Hoyoung,=0D=
=0A>=20>=0D=0A>=20>=20On=20Tue,=202022-01-25=20at=2003:06=20+0900,=20SEO=20=
HOYOUNG=20wrote:=0D=0A>=20>=20>=20v1->=20v2:=20fixed=20no=20previous=20prot=
otype=20warning=0D=0A>=20>=20>=20Reported-by:=20kernel=20test=20robot=20<lk=
p=40intel.com>=0D=0A>=20>=20>=0D=0A>=20>=20>=20All=20warnings=20(new=20ones=
=20prefixed=20by=20>>):=0D=0A>=20>=20>=20>=20>=20drivers/scsi/ufs/ufshcd.c:=
4207:6:=20warning:=20no=20previous=20prototype=0D=0A>=20>=20>=0D=0A>=20>=20=
>=20for=20'ufshcd_auto_hibern8_disable'=20=5B-Wmissing-prototypes=5D=0D=0A>=
=20>=20>=204207=20=7C=20void=20ufshcd_auto_hibern8_disable(struct=20ufs_hba=
=20*hba)=0D=0A>=20>=20>=0D=0A>=20>=20>=20If=20using=20auto=20hibern8=20mode=
,=20need=20to=20disable=20auto=20hibern8=20while=0D=0A>=20>=20>=20entering=
=20suspend.=0D=0A>=20>=20>=20When=20using=20auto=20hibern8=20mode,=20it=20d=
oes=20not=20seem=20right=20to=20send=20a=20uic=0D=0A>=20>=20>=20command=0D=
=0A>=20>=0D=0A>=20>=20The=20UFSHCI=20spec=20does=20not=20mention=20the=20ab=
ove=20rule.=0D=0A>=20>=20Why=20would=20you=20need=20to=20disable=20AH8=20be=
fore=20using=20UIC=20command=20to=20enter=20H8?=0D=0A>=20>=0D=0A>=20>=20>=
=20for=20entry=20into=20hibern8=20in=20the=20next=0D=0A>=20>=20>=20line(ufs=
hcd_lik_state_transition(..))=0D=0A>=20>=20>=20It=20seem=20right=20to=20sen=
d=20after=20disable=20auto=20hibern8.=0D=0A>=20>=20>=0D=0A>=20>=20>=20In=20=
addition,=20if=20the=20auto=20hibern8=20mode=20supported,=20it=20is=20enabl=
ed=20in=0D=0A>=20>=20>=20resume.=0D=0A>=20>=20>=20So=20it=20seems=20that=20=
it=20will=20be=20paired=20only=20when=20auto=20hibern8=20is=0D=0A>=20>=20>=
=20disabled=20while=20entering=20suspend.=0D=0A>=20>=20>=0D=0A>=20>=20>=20S=
igned-off-by:=20SEO=20HOYOUNG=20<hy50.seo=40samsung.com>=0D=0A>=20>=20>=20-=
--=0D=0A>=20>=20>=20=20drivers/scsi/ufs/ufshcd.c=20=7C=2014=20+++++++++++++=
+=0D=0A>=20>=20>=20=201=20file=20changed,=2014=20insertions(+)=0D=0A>=20>=
=20>=0D=0A>=20>=20>=20diff=20--git=20a/drivers/scsi/ufs/ufshcd.c=20b/driver=
s/scsi/ufs/ufshcd.c=0D=0A>=20>=20>=20index=20460d2b440d2e..a6edbbd8ca2c=201=
00644=0D=0A>=20>=20>=20---=20a/drivers/scsi/ufs/ufshcd.c=0D=0A>=20>=20>=20+=
++=20b/drivers/scsi/ufs/ufshcd.c=0D=0A>=20>=20>=20=40=40=20-254,6=20+254,7=
=20=40=40=20static=20void=0D=0A>=20>=20>=20ufshcd_wb_toggle_flush_during_h8=
(struct=20ufs_hba=20*hba,=20bool=20set);=0D=0A>=20>=20>=20static=20inline=
=20void=20ufshcd_wb_toggle_flush(struct=20ufs_hba=20*hba,=20bool=0D=0A>=20>=
=20>=20enable);=20=20static=20void=20ufshcd_hba_vreg_set_lpm(struct=20ufs_h=
ba=20*hba);=0D=0A>=20>=20>=20static=20void=20ufshcd_hba_vreg_set_hpm(struct=
=20ufs_hba=20*hba);=0D=0A>=20>=20>=20+static=20void=20ufshcd_auto_hibern8_d=
isable(struct=20ufs_hba=20*hba);=0D=0A>=20>=20>=0D=0A>=20>=20>=20=20static=
=20inline=20void=20ufshcd_enable_irq(struct=20ufs_hba=20*hba)=20=20=7B=20=
=40=40=0D=0A>=20>=20>=20-4204,6=20+4205,18=20=40=40=20void=20ufshcd_auto_hi=
bern8_update(struct=20ufs_hba=0D=0A>=20>=20>=20*hba,=20u32=20ahit)=20=20=7D=
=20=20EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);=0D=0A>=20>=20>=0D=0A>=
=20>=20>=20+static=20void=20ufshcd_auto_hibern8_disable(struct=20ufs_hba=20=
*hba)=20=7B=0D=0A>=20>=20>=20+=09unsigned=20long=20flags;=0D=0A>=20>=20>=20=
+=0D=0A>=20>=20>=20+=09if=20(=21ufshcd_is_auto_hibern8_supported(hba))=0D=
=0A>=20>=20>=20+=09=09return;=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=09spin_=
lock_irqsave(hba->host->host_lock,=20flags);=0D=0A>=20>=20>=20+=09ufshcd_wr=
itel(hba,=200,=20REG_AUTO_HIBERNATE_IDLE_TIMER);=0D=0A>=20>=20>=20+=09spin_=
unlock_irqrestore(hba->host->host_lock,=20flags);=20=7D=0D=0A>=20>=20>=20+=
=0D=0A>=20>=20>=20=20void=20ufshcd_auto_hibern8_enable(struct=20ufs_hba=20*=
hba)=20=20=7B=0D=0A>=20>=20>=20=20=09unsigned=20long=20flags;=0D=0A>=20>=20=
>=20=40=40=20-8925,6=20+8938,7=20=40=40=20static=20int=20__ufshcd_wl_suspen=
d(struct=20ufs_hba=0D=0A>=20>=20>=20*hba,=20enum=20ufs_pm_op=20pm_op)=0D=0A=
>=20>=20>=20=20=09=20*=20with=20the=20link=20off,=20so=20do=20not=20check=
=20for=20bkops.=0D=0A>=20>=20>=20=20=09=20*/=0D=0A>=20>=20>=20=20=09check_f=
or_bkops=20=3D=20=21ufshcd_is_ufs_dev_deepsleep(hba);=0D=0A>=20>=20>=20+=09=
ufshcd_auto_hibern8_disable(hba);=0D=0A>=20>=20>=20=20=09ret=20=3D=20ufshcd=
_link_state_transition(hba,=20req_link_state,=0D=0A>=20>=20>=20check_for_bk=
ops);=0D=0A>=20>=20>=20=20=09if=20(ret)=0D=0A>=20>=20>=20=20=09=09goto=20se=
t_dev_active;=0D=0A=0D=0A=0D=0A
