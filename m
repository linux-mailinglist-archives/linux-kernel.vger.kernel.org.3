Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90624A7F74
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbiBCGuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:50:54 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31079 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346168AbiBCGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:50:52 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220203065051epoutp03e440e4a1da4fd1c71c33b1e39028dea8~QNALuJhF_1986719867epoutp03Z
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:50:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220203065051epoutp03e440e4a1da4fd1c71c33b1e39028dea8~QNALuJhF_1986719867epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643871051;
        bh=GFCY1tZ1AIJ8hE+w2hnX+TfdMOn7RoV+7kO+jFiS83g=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=txoBtIo54o1hN9BAtB2mArFVm9F76Ry3z9SOcTMANEIng6oxDT4Zt2vd3VT4KhAMU
         23cDRvFviqAsAPWp3WIax9S3tg/kwarrwdFRMAj7538GH71q8SMo9KM5r7PvPayq5O
         IOgjzecL2MFqKtdqs6HeGdO3cHgwnzMfshDTmSKk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220203065050epcas5p32dca94e6b4ba0f994efb2bed0753debd~QNALFZBXL0397203972epcas5p3O;
        Thu,  3 Feb 2022 06:50:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jq8Sj0zLmz4x9Pv; Thu,  3 Feb
        2022 06:50:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.5D.05590.44B7BF16; Thu,  3 Feb 2022 15:50:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220203065044epcas5p24fa5e0ab1fea2ed1ac4c9f9d59f6a1ef~QNAFdHFni2015920159epcas5p2U;
        Thu,  3 Feb 2022 06:50:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220203065044epsmtrp2abf5c3db5927ad31a0515b4f730f6a78~QNAFbVB3P1092710927epsmtrp2R;
        Thu,  3 Feb 2022 06:50:44 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-c6-61fb7b440b9e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.2F.08738.44B7BF16; Thu,  3 Feb 2022 15:50:44 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220203065041epsmtip13dab49a01e94489e44568515c6147826~QNACdyyIN1013310133epsmtip1m;
        Thu,  3 Feb 2022 06:50:41 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Hoyoung SEO'" <hy50.seo@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <bvanassche@acm.org>, <bhoon95.kim@samsung.com>,
        <kwmad.kim@samsung.com>
Cc:     "'kernel test robot'" <lkp@intel.com>
In-Reply-To: <12a201d81892$c8123d40$5836b7c0$@samsung.com>
Subject: RE: [PATCH v2] scsi: ufs: disable auto hibern8 while entering
 suspend
Date:   Thu, 3 Feb 2022 12:20:38 +0530
Message-ID: <066101d818ca$5dba71f0$192f55d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIlzz+JKCbQP4e9lbbSHSqpu8nHvgHyie3oAmFa8EUCXuTdUKuwXzjw
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc25vb1uTzrsK41DdVhpNgI3SjhYvjOKyMXcV4xqN/OG2sBt6
        V7DPtcVtjC1EwmMgKCbDrFOBthTpltUAIVhsRF6CnZmAbMgjQRQXOiVAmQTZ2Foubvz3Ob/z
        /f4e58FlCfyYkJtnsNJmA6UTY9vQ9p64+IR3v1yjpJNPWYSvdIBDzK2OYsSN+9+gxJ+Nj9hE
        7cIqi1jyuNjED45plLCPtSPEvbY+lBjxXsCIyt86MCJQPIMRTTfXkbf45MjdTHKkugohHdfm
        EPKsvQuQK55yjFycHUfJ6jY3IIMtr5BlXZWIindcm5ZLU2raLKINOUZ1nkGjFGcezX4nW5Es
        lSXIUoi9YpGB0tNKccYhVcL+PF2ob7HoJKXLD4VUlMUiTkxPMxvzrbQo12ixKsW0Sa0zyU0S
        C6W35Bs0EgNtTZVJpW8oQsKPtbntyy2IqV/5+cUnA6AItL5ZAXhciMvhr4t+dgXYxhXgnQB2
        TnVjzGIJwJLzfiysEuBBAKeu6J87umZnUUbkBXBi6AGLWcwB2BSYBWEVhifADkfpRqoI/DYC
        76/+yApvsPA4WG97jIaZh6fCR39dZod5B66C9YGRDTOK74bVd/7e0PDxFFj0pB8w/CIc/O4h
        yuR5Dboa/mAxLYng6qxrI08Evh9O2IKbmig419fLCTcB8TEubB57gDGGDDj9LLDJO2DgZhuH
        YSEMzvtCcW6ItfC0N4kJF8LGS/0ow/tg190LaFgSnsXjTWRKvQCr1h4ijJMPy0sFjHoPLJ4f
        3XTuhDWVlWyGSfhTkRc9C2JsWwazbRnMtmUA2//F6gHqBtG0yaLX0BaFKclAf/bffecY9S1g
        41XHZ3aAmekFSTdAuKAbQC5LHMH3NaxQAr6a+qKANhuzzfk62tINFKHTrmEJI3OMoW9hsGbL
        5ClSeXJysjwlKVkmjuLf0lyhBLiGstJamjbR5uc+hMsTFiGlruUzK2CRd9S9+P5S/XDr5FSt
        LzL94j+OT89EdpRw+cHltdhi59JL239OOWY8eCDD6VGsNRt8g/7E8/6PjuxLb+j0v42fTI3N
        0j6OyGhqVBRGRxzzxookQuV68/z1wTxTnbuqyfX6J4WTvaqhPbflJXkcH/9W33DLVwPfDt8p
        Gws6ya+1T2XRkzsPXrXLY4qjcn+xIQucivyYlZdPlfTu1q4df/XqjQLBiYHGyzUf9PlKxj50
        XasV6Na/L8YrXey46z1qT1bNCXf9eLZjJmv8XpbPXXqI7cQLeOfK644s2N/rSdt+eBctGXqW
        Xuatm7A7FaNBhJN56dTeXerW308HxKgll5LFs8wW6l+9Dc+BXgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSnK5L9e9Eg7dThC32tp1gt3j58yqb
        xcGHnSwWX5c+Y7WY9uEns8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i1fNj9gs
        lh//x+TA63H5irfH5b5eJo/Fe14yeUxYdIDR4/v6DjaPj09vsXj0bVnF6PF5k5xH+4FupgDO
        KC6blNSczLLUIn27BK6Ml63TGQtW6FTMvfKGqYHxiEoXIyeHhICJxIGnT1m6GLk4hAR2MEpc
        vXufHSIhLXF94wQoW1hi5b/n7BBFzxkljk1exQqSYBPQldixuI0NJCEicJtJ4kPbZ7AEs4Cm
        xIJZb6DG/mSUmP9jHwtIglPASuLZnxVgRcICfhJtXx+CxVkEVCT6LvwFs3kFLCUa3h5jhLAF
        JU7OfMICMVRb4unNp3D2soWvmSHOU5D4+XQZ2EwRATeJ27M+Q9WIS7w8eoR9AqPwLCSjZiEZ
        NQvJqFlIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOWi2tHYx7Vn3QO8TI
        xMF4iFGCg1lJhHfvwu+JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgt
        gskycXBKNTC5RD/0vy9fa+UeHxNv76jj8kfy3wW3sgmT2nYu6jrHqPbA7q9/U3JVHutd0c+f
        P/xZNVnSeP5NlZNBfe2akfxyq05ffZrwnaGlOnirQWGi/P1Zgcu8hTOdfwk9vV4nNd9dQ/tF
        2aGvy/6FXY0IsftQLqjAZyYtOu/ZIdaEZY4Ty6bHW1xdW+DlofOufpVDosuJufOtjx9m0OP/
        ciVRv27j0vLnmcsmpmpu9j24em5IuxuzxsHr/1769go0+jxOUmt2OxE07fhSyTPHjz85raY2
        K9ix7uS7xKidPSL7H0kwris3TVGdVyPz4d2ze565+ZeUFmbOn/Mjt8zgVdy609tdInjVJAub
        tTJ2Tpq3+L8SS3FGoqEWc1FxIgA3Q0oHSQMAAA==
X-CMS-MailID: 20220203065044epcas5p24fa5e0ab1fea2ed1ac4c9f9d59f6a1ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b
References: <CGME20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b@epcas2p1.samsung.com>
        <20220124180637.160524-1-hy50.seo@samsung.com>
        <40986ecb6c81812a1e1ab24d93e46eda75974c4e.camel@mediatek.com> 
        <12a201d81892$c8123d40$5836b7c0$@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hoyoung

>-----Original Message-----
>From: Hoyoung SEO =5Bmailto:hy50.seo=40samsung.com=5D
>Sent: Thursday, February 3, 2022 5:43 AM
>To: linux-scsi=40vger.kernel.org; linux-kernel=40vger.kernel.org;
>alim.akhtar=40samsung.com; avri.altman=40wdc.com; jejb=40linux.ibm.com;
>martin.petersen=40oracle.com; beanhuo=40micron.com;
>asutoshd=40codeaurora.org; cang=40codeaurora.org; bvanassche=40acm.org;
>bhoon95.kim=40samsung.com; kwmad.kim=40samsung.com
>Cc: 'kernel test robot' <lkp=40intel.com>
>Subject: RE: =5BPATCH v2=5D scsi: ufs: disable auto hibern8 while entering=
 suspend
>
>Hi,
>Please check this patch.
>If there is any other opinion, please give me comments Thanks
>
>> -----Original Message-----
>> From: =EC=84=9C=ED=98=B8=EC=98=81=20=5Bmailto:hy50.seo=40samsung.com=5D=
=0D=0A>>=20Sent:=20Wednesday,=20January=2026,=202022=202:35=20PM=0D=0A>>=20=
To:=20'linux-scsi=40vger.kernel.org';=20'linux-kernel=40vger.kernel.org';=
=0D=0A>>=20'alim.akhtar=40samsung.com';=20'avri.altman=40wdc.com';=0D=0A>>=
=20'jejb=40linux.ibm.com';=20'martin.petersen=40oracle.com';=0D=0A>>=20'bea=
nhuo=40micron.com';=20'asutoshd=40codeaurora.org';=0D=0A>>=20'cang=40codeau=
rora.org';=20'bvanassche=40acm.org';=0D=0A>'bhoon95.kim=40samsung.com';=20'=
kwmad.kim=40samsung.com'=0D=0A>>=20Cc:=20'kernel=20test=20robot'=0D=0A>>=20=
Subject:=20RE:=20=5BPATCH=20v2=5D=20scsi:=20ufs:=20disable=20auto=20hibern8=
=20while=20entering=0D=0A>>=20suspend=0D=0A>>=0D=0A>>=20Hi,=0D=0A>>=20I=20t=
hink=20content=20is=20lacking=20in=20the=20UFSHCI=20spec.=0D=0A>>=20In=20th=
e=20process,=20AH8=20is=20in=20operation,=20and=20it=20seems=20that=20sendi=
ng=20the=0D=0A>>=20command=0D=0A>>=20hibern8=20by=20manual=20has=20a=20defe=
at.=0D=0A>>=20I=20don't=20know=20what=20the=20all=20hci=20vendor's=20hardwa=
re=20design=20will=20be,=20but=0D=0A>>=20there=20is=20a=20possibility=20tha=
t=20ah8=20and=20manual=20hibern8=20may=20overlap.=0D=0A>>=20So=20if=20is=20=
operating=20in=20ah8,=20it=20is=20thought=20that=20it=20will=20be=20safer=
=20to=0D=0A>>=20disable=0D=0A>>=20ah8=20before=20sending=20hibern8=20comman=
d.=0D=0A>>=0D=0AI=20am=20not=20sure,=20if=20this=20problem=20is=20generic=
=20and=20faced=20by=20all=20other=20UFS=20vendors.=0D=0AIf=20not,=20how=20a=
bout=20having=20a=20vendor=20specific=20call=20back=20for=20your=20platform=
=20only?=0D=0AJust=20a=20thought.=0D=0A=0D=0A>>=20>=20-----Original=20Messa=
ge-----=0D=0A>>=20>=20From:=20Stanley=20Chu=20=5Bmailto:stanley.chu=40media=
tek.com=5D=0D=0A>>=20>=20Sent:=20Wednesday,=20January=2026,=202022=2010:22=
=20AM=0D=0A>>=20>=20To:=20SEO=20HOYOUNG;=20linux-scsi=40vger.kernel.org;=0D=
=0A>>=20>=20linux-kernel=40vger.kernel.org;=20alim.akhtar=40samsung.com;=0D=
=0A>>=20>=20avri.altman=40wdc.com;=20jejb=40linux.ibm.com;=0D=0A>martin.pet=
ersen=40oracle.com;=0D=0A>>=20>=20beanhuo=40micron.com;=20asutoshd=40codeau=
rora.org;=0D=0A>cang=40codeaurora.org;=0D=0A>>=20>=20bvanassche=40acm.org;=
=20bhoon95.kim=40samsung.com;=0D=0A>kwmad.kim=40samsung.com=0D=0A>>=20>=20C=
c:=20kernel=20test=20robot;=20peter.wang=40mediatek.com=0D=0A>>=20>=20Subje=
ct:=20Re:=20=5BPATCH=20v2=5D=20scsi:=20ufs:=20disable=20auto=20hibern8=20wh=
ile=0D=0A>>=20>=20entering=20suspend=0D=0A>>=20>=0D=0A>>=20>=20Hi=20Hoyoung=
,=0D=0A>>=20>=0D=0A>>=20>=20On=20Tue,=202022-01-25=20at=2003:06=20+0900,=20=
SEO=20HOYOUNG=20wrote:=0D=0A>>=20>=20>=20v1->=20v2:=20fixed=20no=20previous=
=20prototype=20warning=0D=0A>>=20>=20>=20Reported-by:=20kernel=20test=20rob=
ot=20<lkp=40intel.com>=0D=0A>>=20>=20>=0D=0A>>=20>=20>=20All=20warnings=20(=
new=20ones=20prefixed=20by=20>>):=0D=0A>>=20>=20>=20>=20>=20drivers/scsi/uf=
s/ufshcd.c:4207:6:=20warning:=20no=20previous=0D=0A>>=20>=20>=20>=20>=20pro=
totype=0D=0A>>=20>=20>=0D=0A>>=20>=20>=20for=20'ufshcd_auto_hibern8_disable=
'=20=5B-Wmissing-prototypes=5D=0D=0A>>=20>=20>=204207=20=7C=20void=20ufshcd=
_auto_hibern8_disable(struct=20ufs_hba=20*hba)=0D=0A>>=20>=20>=0D=0A>>=20>=
=20>=20If=20using=20auto=20hibern8=20mode,=20need=20to=20disable=20auto=20h=
ibern8=20while=0D=0A>>=20>=20>=20entering=20suspend.=0D=0A>>=20>=20>=20When=
=20using=20auto=20hibern8=20mode,=20it=20does=20not=20seem=20right=20to=20s=
end=20a=20uic=0D=0A>>=20>=20>=20command=0D=0A>>=20>=0D=0A>>=20>=20The=20UFS=
HCI=20spec=20does=20not=20mention=20the=20above=20rule.=0D=0A>>=20>=20Why=
=20would=20you=20need=20to=20disable=20AH8=20before=20using=20UIC=20command=
=20to=20enter=0D=0A>H8?=0D=0A>>=20>=0D=0A>>=20>=20>=20for=20entry=20into=20=
hibern8=20in=20the=20next=0D=0A>>=20>=20>=20line(ufshcd_lik_state_transitio=
n(..))=0D=0A>>=20>=20>=20It=20seem=20right=20to=20send=20after=20disable=20=
auto=20hibern8.=0D=0A>>=20>=20>=0D=0A>>=20>=20>=20In=20addition,=20if=20the=
=20auto=20hibern8=20mode=20supported,=20it=20is=20enabled=20in=0D=0A>>=20>=
=20>=20resume.=0D=0A>>=20>=20>=20So=20it=20seems=20that=20it=20will=20be=20=
paired=20only=20when=20auto=20hibern8=20is=0D=0A>>=20>=20>=20disabled=20whi=
le=20entering=20suspend.=0D=0A>>=20>=20>=0D=0A>>=20>=20>=20Signed-off-by:=
=20SEO=20HOYOUNG=20<hy50.seo=40samsung.com>=0D=0A>>=20>=20>=20---=0D=0A>>=
=20>=20>=20=20drivers/scsi/ufs/ufshcd.c=20=7C=2014=20++++++++++++++=0D=0A>>=
=20>=20>=20=201=20file=20changed,=2014=20insertions(+)=0D=0A>>=20>=20>=0D=
=0A>>=20>=20>=20diff=20--git=20a/drivers/scsi/ufs/ufshcd.c=20b/drivers/scsi=
/ufs/ufshcd.c=0D=0A>>=20>=20>=20index=20460d2b440d2e..a6edbbd8ca2c=20100644=
=0D=0A>>=20>=20>=20---=20a/drivers/scsi/ufs/ufshcd.c=0D=0A>>=20>=20>=20+++=
=20b/drivers/scsi/ufs/ufshcd.c=0D=0A>>=20>=20>=20=40=40=20-254,6=20+254,7=
=20=40=40=20static=20void=0D=0A>>=20>=20>=20ufshcd_wb_toggle_flush_during_h=
8(struct=20ufs_hba=20*hba,=20bool=20set);=0D=0A>>=20>=20>=20static=20inline=
=20void=20ufshcd_wb_toggle_flush(struct=20ufs_hba=20*hba,=0D=0A>>=20>=20>=
=20bool=20enable);=20=20static=20void=20ufshcd_hba_vreg_set_lpm(struct=20uf=
s_hba=0D=0A>>=20>=20>=20*hba);=20static=20void=20ufshcd_hba_vreg_set_hpm(st=
ruct=20ufs_hba=20*hba);=0D=0A>>=20>=20>=20+static=20void=20ufshcd_auto_hibe=
rn8_disable(struct=20ufs_hba=20*hba);=0D=0A>>=20>=20>=0D=0A>>=20>=20>=20=20=
static=20inline=20void=20ufshcd_enable_irq(struct=20ufs_hba=20*hba)=20=20=
=7B=20=40=40=0D=0A>>=20>=20>=20-4204,6=20+4205,18=20=40=40=20void=20ufshcd_=
auto_hibern8_update(struct=20ufs_hba=0D=0A>>=20>=20>=20*hba,=20u32=20ahit)=
=20=20=7D=0D=0A>EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);=0D=0A>>=20>=
=20>=0D=0A>>=20>=20>=20+static=20void=20ufshcd_auto_hibern8_disable(struct=
=20ufs_hba=20*hba)=20=7B=0D=0A>>=20>=20>=20+=09unsigned=20long=20flags;=0D=
=0A>>=20>=20>=20+=0D=0A>>=20>=20>=20+=09if=20(=21ufshcd_is_auto_hibern8_sup=
ported(hba))=0D=0A>>=20>=20>=20+=09=09return;=0D=0A>>=20>=20>=20+=0D=0A>>=
=20>=20>=20+=09spin_lock_irqsave(hba->host->host_lock,=20flags);=0D=0A>>=20=
>=20>=20+=09ufshcd_writel(hba,=200,=20REG_AUTO_HIBERNATE_IDLE_TIMER);=0D=0A=
>>=20>=20>=20+=09spin_unlock_irqrestore(hba->host->host_lock,=20flags);=20=
=7D=0D=0A>>=20>=20>=20+=0D=0A>>=20>=20>=20=20void=20ufshcd_auto_hibern8_ena=
ble(struct=20ufs_hba=20*hba)=20=20=7B=0D=0A>>=20>=20>=20=20=09unsigned=20lo=
ng=20flags;=0D=0A>>=20>=20>=20=40=40=20-8925,6=20+8938,7=20=40=40=20static=
=20int=20__ufshcd_wl_suspend(struct=0D=0A>>=20>=20>=20ufs_hba=20*hba,=20enu=
m=20ufs_pm_op=20pm_op)=0D=0A>>=20>=20>=20=20=09=20*=20with=20the=20link=20o=
ff,=20so=20do=20not=20check=20for=20bkops.=0D=0A>>=20>=20>=20=20=09=20*/=0D=
=0A>>=20>=20>=20=20=09check_for_bkops=20=3D=20=21ufshcd_is_ufs_dev_deepslee=
p(hba);=0D=0A>>=20>=20>=20+=09ufshcd_auto_hibern8_disable(hba);=0D=0A>>=20>=
=20>=20=20=09ret=20=3D=20ufshcd_link_state_transition(hba,=20req_link_state=
,=0D=0A>>=20>=20>=20check_for_bkops);=0D=0A>>=20>=20>=20=20=09if=20(ret)=0D=
=0A>>=20>=20>=20=20=09=09goto=20set_dev_active;=0D=0A>=0D=0A>=0D=0A=0D=0A=
=0D=0A
