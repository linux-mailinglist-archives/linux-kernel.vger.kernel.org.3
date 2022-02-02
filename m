Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0294A6E21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbiBBJxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:53:21 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31390 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiBBJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:53:15 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220202095314epoutp03db48d397de7f9877de409e7829b7d216~P72I3VwNc1065010650epoutp03x
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 09:53:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220202095314epoutp03db48d397de7f9877de409e7829b7d216~P72I3VwNc1065010650epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643795594;
        bh=IRg0tmKr6sCE9jpi9L2MR10MQYPkKy8Hhn/HrSD4heo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=bXV2JFehdHDSTLPQNcUcNhVsxJhgpIG/x/PzqbMrmn8GGa1+kqAIytDS/fP+Kbpcd
         xvyimb/vRMwN8IplDXOgCCBAatrNnG2jW89aSDgU2sLqZerfS0bA39mdfsSf2lhsDR
         +FZUDveuJ0hsuSxF+M+lKsBus7+PDIZ4HOYAqQx4=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220202095313epcas5p2c4774fc4974334047aeefa4958de38f1~P72IXMUXF2510525105epcas5p2A;
        Wed,  2 Feb 2022 09:53:13 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-38-61fa5489394b
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.60.05590.9845AF16; Wed,  2 Feb 2022 18:53:13 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH RESEND v2] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Joe Perches <joe@perches.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <4ee87d70d5348949787b2d747f90ecffa3119d0b.camel@perches.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220202095225epcms5p271da4783d86cb7c51d12d80f097aea44@epcms5p2>
Date:   Wed, 02 Feb 2022 15:22:25 +0530
X-CMS-MailID: 20220202095225epcms5p271da4783d86cb7c51d12d80f097aea44
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZdlhTXbcz5Feiwbtj4hYf1mpYrF+4jNli
        9v3HLBaXd81hs2g52s5icejkXEYHNo9ZDb1sHjtn3WX3+LLqGrNH35ZVjB6fN8kFsEZx2aSk
        5mSWpRbp2yVwZRy5OImp4K1oxcFNd5kbGOeLdjFyckgImEjc3LyJvYuRi0NIYDejxKRT/4Ac
        Dg5eAUGJvzuEQWqEBTIl1h86xwJiCwkoSlyYsYYRpERYwEDi11YNkDCbgJ7Eql17WEDGiAjs
        YJT43LScCSTBDNQ7u/M8G8QuXokZ7U9ZIGxpie3LtzKC2JwCnhInenezQsRFJW6ufssOY78/
        Np8RwhaRaL13lhnCFpR48HM3VFxGYvXmXrDFEgLdjBLr3+2FcmYwSvQ8mgbVYS6xfskqsKm8
        Ar4Sk54dBouzCKhKPPv7DmqSi8TDD2dZIa7Wlli28DUzyJfMApoS63fpQ5TISkw9tQ7qMT6J
        3t9PmGAe2zEPxlaVaLm5gRXmyc8fP0I97CGxpX0DGySgjzJKbJnRyDKBUWEWIqxnIdk8C2Hz
        AkbmVYySqQXFuempxaYFxnmp5XrFibnFpXnpesn5uZsYwelFy3sH46MHH/QOMTJxMB5ilOBg
        VhLh3bvwe6IQb0piZVVqUX58UWlOavEhRmkOFiVx3lPpGxKFBNITS1KzU1MLUotgskwcnFIN
        TFZ/Ly1Y5uIpKqr06YPN9lW6Vpuecmtv/KVYn7w5JuQs+ztXBcMZhQrK/CZKmp8KJzzheH7j
        96n1Sr8nO3fuZloo3TzDjWF+eVih8Zm7pQzzzmk90fh2arr7pB9NEkxO/nkV/SasZyJzVl/e
        dk9sYgLXvBkT09Jcp8p4l3q8vXHD+tDy51JBvtxNeyZM1nGXOfVWb8amO1Upyu7uO09WMVRN
        ur/HpeZP/vHe3aYFmvMeSc6cpsla9a+jSc9owuPoU78abyRMZtm+YP+Hnt5IhWzrbZ4JEyb4
        7qsUtHD7/FzofWqoU2SwU+ANew75kvf1FYerlpxIzLl9+8qiCSt7t19iYZwixBa18Ph1940B
        hkosxRmJhlrMRcWJAPf6odyeAwAA
X-CMS-RootMailID: 20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919
References: <4ee87d70d5348949787b2d747f90ecffa3119d0b.camel@perches.com>
        <20220202071405.1872044-1-maninder1.s@samsung.com>
        <CGME20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919@epcms5p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


>>=C2=A0printk_deferred=C2=A0and=C2=A0printk_deferred_once=C2=A0requires=C2=
=A0LOGLEVEL=C2=A0in=C2=A0argument,=0D=0A>>=C2=A0but=C2=A0checkpatch.pl=C2=
=A0reports=C2=A0it=C2=A0as=C2=A0warning:=0D=0A=C2=A0=0D=0A>=20When=C2=A0did=
=C2=A0that=C2=A0occur?=C2=A0=C2=A0Please=C2=A0reference=C2=A0the=C2=A0speci=
fic=C2=A0commit.=0D=0A>=20When=C2=A0printk_sched=C2=A0(now=C2=A0printk_defe=
rred)=C2=A0was=C2=A0created=C2=A0it=C2=A0did=C2=A0not=0D=0A>=20allow=C2=A0K=
ERN_<LEVEL>.=0D=0A=C2=A0=0D=0A>=20see=C2=A0commit=C2=A03ccf3e830615=C2=A0(=
=22printk/sched:=C2=A0Introduce=C2=A0special=C2=A0printk_sched()=C2=A0for=
=C2=A0those=C2=A0awkward=C2=A0moments=22)=0D=0A=C2=A0=0D=0AI=20think=20with=
=20below=20commit:=0D=0A=0D=0A98e35f5894cf208084688ec0c7bb7b713efc997f=20(p=
rintk:=20git=20rid=20of=20=5Bsched_delayed=5D=20message=20for=20printk_defe=
rred)=0D=0A=0D=0Aearlier=20it=20was=20passing=20hardcoded=20KERN_WARNING=20=
to=20all=20printk_deferred=20messages,=20but=20now=20it=20switched=0D=0Ato=
=20normal=20printk=20behavior.=0D=0A=0D=0A-=20=20=20=20=20=20=20if=20(in_sc=
hed)=0D=0A-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20text_len=20=3D=20sc=
nprintf(text,=20sizeof(textbuf),=0D=0A-=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20KER=
N_WARNING=20=22=5Bsched_delayed=5D=20=22);=0D=0A-=0D=0A-=20=20=20=20=20=20=
=20text_len=20+=3D=20vscnprintf(text=20+=20text_len,=0D=0A-=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
sizeof(textbuf)=20-=20text_len,=20fmt,=20args);=0D=0A+=20=20=20=20=20=20=20=
text_len=20=3D=20vscnprintf(text,=20sizeof(textbuf),=20fmt,=20args);=0D=0A=
=0D=0A=0D=0AI=20did=20not=20search=20that=20earlier,=20because=20we=20were=
=20fixing=20some=20issue=20in=20our=20local=20module=20code=20with=20printk=
_deferred=0D=0Aand=20then=20checkatch=20reported=20the=20issues,=20so=20tho=
ught=20of=20fixing=20it,=20becaue=20without=20level=0D=0Apritk_deferred=20m=
essages=20was=20shifted=20to=20default=20loglevel=20as=20done=20by=20normal=
=20printk.=0D=0A=0D=0ASo=20I=20thought=20it=20was=20designed=20to=20pass=20=
loglevel=20from=20starting=20stage=20and=20checjpatch=20reports=20falsely.=
=0D=0Abut=20seems=20checkpatch=20needs=20to=20fixed=20with=20that=20commit=
=20itself,=20because=20earlier=20it=20was=20not=20required=20to=20pass=20lo=
glevel.=0D=0A=0D=0A=0D=0A>=20There=C2=A0are=C2=A0many=C2=A0existing=C2=A0pr=
intk_deferred=C2=A0uses=C2=A0without=C2=A0KERN_<LEVEL>.=0D=0A=0D=0AEither=
=20that=20needs=20to=20be=20fixed=20after=20that=20commit(98e35f5894cf)=20o=
r=20their=20purpose=20is=20to=0D=0Ause=20KERN_DEFAULT=20log=20level=20i=20t=
hink.=0D=0A=0D=0AThanks,=0D=0AManinder=20Singh=0D=0A=C2=A0=0D=0A=C2=A0
