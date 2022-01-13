Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA9148D821
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiAMMkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiAMMkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:40:19 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6F3C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:40:18 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id w188so7396749oiw.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oWW6ORNyIaqSSB1YUh/ULmMzj9/DL4c8sVdQpgJj44s=;
        b=no7OQO4QWJe7+Gvt/fbnMJdbR4U/5AOphWxsTgKjYX0rmphyVPhpltHl2CEVgkoX4x
         hhLB0SaocG7b4Dq/SJRxuKkb7Dk770SPF6bdMKmNu6oRmeKATZJ/WFmehtc/KgZp4B0O
         qZticmR3dDOnRpPhBfBy1xz+yBiaYC52ewpAh8YKktw1Oh+yEGsupYlA9XATDDYGVKW+
         hv4PSg7gOrYLQ5/fbiYpxT4TYnTGaFggUWK08/v8IKv7atqXrMndPrhT4MPejHOrKcBF
         xMewhDPR2L7s+EIkHXQDJzP1ocSDGuwlBDM0xA7vj4JBBfVpD0dBDLbL7y8Z73jB0T1U
         h12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=oWW6ORNyIaqSSB1YUh/ULmMzj9/DL4c8sVdQpgJj44s=;
        b=R9LRPSV8JLBfDRb8yBzx0nBD/lZthU+wIoUfLN4kWYK8nTeZAmlfo5ZTsxJ++miyW7
         oKp+6006+Hdhkg6EljocaKcxvxP7phvw9M50ND9dMO2sQGrKdB3AwJtfJMlle1AyTDyL
         pyRzfVETh5ownNa8Q4XiERCyjlMNGGd3GTKw7/tqHM5aqoFPwNLO3r8P6l2uNMC6aKmv
         GmjOozCUrxB6mLSisuFxEARhUqglClO0CHO0zylCNfk06KyQQG4rV7dRSlY/o5Z+nH2/
         G28P0zlc4MaT+vGR+fsmGeD4nNBnkpYcQVjZCLQpgBPg34/L+21SZzqxhsFL/GG5Su9/
         umGg==
X-Gm-Message-State: AOAM533W5vYinXCdBzOfGrKny0EMBJaIa1E8t/AxRFGTIKKIXOY/Xk1i
        tbJiUFDwQ2xK36eUZMaaIxhfM7FIzGaUGvtWWRM=
X-Google-Smtp-Source: ABdhPJz3+lRLpl2AXk2JaeZYoyHWKMqyDL5xCy4GWtbOUzot3ynarfILMpNtre5m42scYjheywWj3AnfMVa7eRht0P4=
X-Received: by 2002:aca:b342:: with SMTP id c63mr8629081oif.121.1642077618159;
 Thu, 13 Jan 2022 04:40:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6838:3032:0:0:0:0 with HTTP; Thu, 13 Jan 2022 04:40:17
 -0800 (PST)
Reply-To: barr.christiankossi10@gmail.com
From:   Christian Kossi <barr.christiankossi7@gmail.com>
Date:   Thu, 13 Jan 2022 04:40:17 -0800
Message-ID: <CAGyGehdXeX9YwyspFtZ=j7CuuKb0CF1c3r+BBBAwmK=zhH0U=g@mail.gmail.com>
Subject: =?UTF-8?B?TMWrZHp1LCBzYXppbmlldGllcyBhciBtYW5pLCBsYWkgaWVnxat0dSBzxKtrxIFrdSBpbg==?=
        =?UTF-8?B?Zm9ybcSBY2lqdS4uLi4=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sveika laba diena
Divreiz nos=C5=ABt=C4=ABju jums neatbild=C4=93tu e-pastu. Ar =C5=A1o p=C4=
=81rliec=C4=ABbu un
sirsn=C4=ABba sazin=C4=81ties ar jums, l=C5=ABdzu, pie=C5=86emiet atvaino=
=C5=A1anos, ja mans e-pasts
p=C4=81rk=C4=81pj j=C5=ABsu person=C4=ABgo mor=C4=81li. Mani sauc Kristians=
 Kosi, es esmu kalpone
Advok=C4=81ts atrodas Lom=C4=93, Togo.

Sazinos ar jums uzv=C4=81rda l=C4=ABdz=C4=ABbas d=C4=93=C4=BC
dal=C4=ABties ar manu miru=C5=A1o klientu, kur=C5=A1 ir j=C5=ABsu valsts pi=
lsonis
$9,600,000,00 banku noguld=C4=ABjumi Togo Republik=C4=81. V=C4=ABrietis
Boj=C4=81g=C4=81ju=C5=A1ais klients g=C4=81ja boj=C4=81 ce=C4=BCu satiksmes=
 negad=C4=ABjum=C4=81 2011.gada 21.apr=C4=ABl=C4=AB.
Tuvi radinieki nav re=C4=A3istr=C4=93ti. Tika veikti da=C5=BE=C4=81di m=C4=
=93=C4=A3in=C4=81jumi vi=C5=86u atrast.
Papildu =C4=A3imene caur neaugl=C4=ABgu v=C4=93stniec=C4=ABbu.

Sa=C5=86=C4=93mu ofici=C4=81lu v=C4=93stuli no bankas, kur=C4=81 ieteikts =
=C5=A1=C4=81ds variants
Proced=C5=ABra konta padar=C4=AB=C5=A1anai nelietojama un ie=C4=B7=C4=ABl=
=C4=81=C5=A1anai Fonda ietvaros
saska=C5=86=C4=81 ar piem=C4=93rojamajiem ties=C4=ABbu aktiem banka, kur=C4=
=81 mans klients
noguld=C4=ABja naudu
Summa ir 9,6 miljoni ASV dol=C4=81ru. =C5=A0eit p=C4=93c vald=C4=ABbas liku=
miem, tad
P=C4=93c 10 gadu perioda beig=C4=81m fonds atgriez=C4=ABsies uz=C5=86=C4=93=
muma =C4=ABpa=C5=A1um=C4=81.
Togo vald=C4=ABba. 10 gadu termi=C5=86=C5=A1 beidz=C4=81s pag=C4=81ju=C5=A1=
=C4=81 gada apr=C4=ABl=C4=AB.
2021, un neviens nav veicis dar=C4=ABjumus vai piepras=C4=ABjis j=C5=ABsu k=
ontu
fonds, kapit=C4=81ls.

Mans ieteikums jums ir iepaz=C4=ABstin=C4=81t j=C5=ABs ar tuv=C4=81ko banku=
.
mana miru=C5=A1=C4=81 klienta radinieks samaks=C4=81ja bankai =C5=A1os 9,6 =
USD
miljoniem jums k=C4=81 pirc=C4=93jiem. Kad p=C4=81rs=C5=ABt=C4=AB=C5=A1ana =
ir pabeigta,
Es ierosinu fondu sadal=C4=ABt ar saska=C5=86otu procentu.
apmierinot abas puses un ar=C4=AB ziedot labdar=C4=ABbai.

Es iesnieg=C5=A1u visus juridiskos dokumentus, kas pamato j=C5=ABsu pras=C4=
=ABbu. Viss
Lai m=C4=93s to paveiktu, man ir nepiecie=C5=A1ama j=C5=ABsu god=C4=ABg=C4=
=81 sadarb=C4=ABba.
process. Es ar=C4=AB garant=C4=93ju, ka tas tiks dar=C4=ABts saska=C5=86=C4=
=81 ar noteikumiem.
juridisks l=C4=ABgums, kas pasarg=C4=81s j=C5=ABs no jebk=C4=81diem p=C4=81=
rk=C4=81pumiem
likumu =C5=A1eit vai j=C5=ABsu valst=C4=AB.

L=C5=ABdzu, sazinieties ar mani, lai varu sniegt visu inform=C4=81ciju.

Sveiki
Kristians Kossi, jurists,
Galvenais padomnieks: Kossi & Co Associates
