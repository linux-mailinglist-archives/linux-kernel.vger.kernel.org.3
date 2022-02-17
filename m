Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B7C4BA42E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbiBQPWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:22:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiBQPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:22:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332352B27C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:21:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m7so5925192pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xvrtpuEdChu4zmY5pxDKJcpytgU8SZKtEI7T38tIF1Q=;
        b=HIqawdTnzu9QWVZv9D//pXWPonRKf1EG345n+o4AAbsIAVSazocVTjTpqhrCWdbfQp
         DHwzx/yLcNPiOgVbbFndi8wVnrz9kb/v3EwdiKDJm8ZTT5nMqA5FfFeJ5USyTW8X4L3Z
         jJVZDR2ZB/QRCg+gc31BqRllbsLdp1NQogSYQNv2EHcdA9c+Lbv9g5c36T3NAUPTynxc
         r1EhTVlYcJ0TrC8xpEkXna1LHMs4NKEEku27D1wEN51ccfbbFlEaI/08racYuDPtIM/r
         IHiIrwuhkCBy+cGqMX8gsubOUl0jVDRiw206ud3DInJLZ/I7PBZitEjOP/P9kpv5pMX+
         rfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xvrtpuEdChu4zmY5pxDKJcpytgU8SZKtEI7T38tIF1Q=;
        b=SSXa9Kown9DHrgSlEZBQbYjasRN1UvtwJijFnXZ8Sjlk6NavsjNJWPsBBsHHy12v2v
         0R/49zCEFPXAY7lLj9lN3ePnUU+O3Oay9zhUl1jUSSTJfmHBfJV1os9Wf4AISWDcX2T7
         s/HYgdHda8RV2J893fYqKUQVW+Tt1wCAKBaAsXYiuUVXlNXMBQDaBy799sAQxA/9XKrf
         FDfeWsOOGdU2Jv71TYUqntenxeubbi3qHsGUzQULcnkXZSrz52KcjdKBiGUFYwa7YxMc
         lRSaOpDZqMatb8i9G+8neYWAGsMRkNoGZpqdgaVKaQSHdzMgknsj8y9zzIfE/Yob8Guk
         uqZg==
X-Gm-Message-State: AOAM530PuS0q6F6ZbDPWgBcvY5PphGHnZFD7Q7BvW7b4ewm7V3+avCsT
        gQ/t9k8d4yRtA6FhwW0KCiB9K4gaYKX00ni6jig=
X-Google-Smtp-Source: ABdhPJwgTincad1Z9DWJsoJtLClxg+LYoprDDkmagiAeLI5l0iLhdEyh4vxPBUb0k3agP0z6YIIOzWd7H78Sq1kagZ8=
X-Received: by 2002:a17:90b:4ad2:b0:1b8:e050:c7e3 with SMTP id
 mh18-20020a17090b4ad200b001b8e050c7e3mr7828327pjb.83.1645111308686; Thu, 17
 Feb 2022 07:21:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:6796:0:0:0:0 with HTTP; Thu, 17 Feb 2022 07:21:48
 -0800 (PST)
Reply-To: bettyrawlings3@gmail.com
From:   "Mrs. Betty Rawlings" <unitedbankforafricau7@gmail.com>
Date:   Thu, 17 Feb 2022 07:21:48 -0800
Message-ID: <CA+9JZ9+1K6ObVkvkTq7iQbwgAJ6hyOf0LHW=OSBAx08zgRBi6A@mail.gmail.com>
Subject: =?UTF-8?Q?DOBRE_WIE=C5=9ACI?=
To:     ikechukwu4125 <ikechukwu4125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRZECZYTAJ I ZROZUM PRAWD=C4=98 O SWOICH FUNDUSZACH.

Dzie=C5=84 dobry Szanowny Panie/Szanowna Pani.
Jestem pani Betty Rawlings, jestem obywatelk=C4=85 USA, mam 48 lat.
Mieszkam tutaj, w New Braunfels w Teksasie. M=C3=B3j adres zamieszkania
jest nast=C4=99puj=C4=85cy. 108 S=C4=85d Crocketta. Mieszkanie 303, Chicago=
, Stany
Zjednoczone. My=C5=9Bl=C4=99 o przeprowadzce, poniewa=C5=BC jestem teraz bo=
gata.
Jestem jednym z tych, kt=C3=B3rzy przed laty brali udzia=C5=82 w odszkodowa=
niu w
Afryce i odm=C3=B3wiono mi wyp=C5=82aty, zap=C5=82aci=C5=82em ponad 52 000 =
dolar=C3=B3w podczas
pobytu w Stanach Zjednoczonych, pr=C3=B3buj=C4=85c uzyska=C4=87 moj=C4=85 w=
yp=C5=82at=C4=99,
wszystko bezskutecznie.

Zdecydowa=C5=82em si=C4=99 pojecha=C4=87 do Afryki, Togo ze wszystkimi doku=
mentami
odszkodowawczymi i zosta=C5=82em poinstruowany, aby spotka=C4=87 si=C4=99 z
prawnikiem Oscarem Luisem (obywatel Wielkiej Brytanii), kt=C3=B3ry jest
przewodnicz=C4=85cym KOMITETU DS. ODSZKODOWANIA, skontaktowa=C5=82em si=C4=
=99 z nim i
wszystko mi wyja=C5=9Bni=C5=82. Powiedzia=C5=82, =C5=BCe ci, kt=C3=B3rzy sk=
ontaktowali si=C4=99 ze
mn=C4=85 przez e-mail, s=C4=85 fa=C5=82szywi, poniewa=C5=BC ustawa o dziedz=
iczeniu /
odszkodowaniu wyra=C5=BAnie stanowi, =C5=BCe
beneficjent/odbiorca jest zwolniony z ponoszenia jakichkolwiek op=C5=82at
lub prowizji z w=C5=82asnej kieszeni w celu otrzymania takich =C5=9Brodk=C3=
=B3w.

Prawnik Oscar Louis zabra=C5=82 mnie do Banku P=C5=82atniczego, gdzie
przedstawi=C5=82 wszystkie dokumenty, kt=C3=B3re mi odpowiada=C5=82y. W tej=
 chwili
jestem najszcz=C4=99=C5=9Bliwsz=C4=85 kobiet=C4=85 na =C5=9Bwiecie, poniewa=
=C5=BC otrzyma=C5=82em =C5=9Brodki
kompensacyjne w wysoko=C5=9Bci (950 000 USD) Dodatkowo prawnik Oscar Luis
pokaza=C5=82 mi pe=C5=82ne informacje o tych, kt=C3=B3rzy jeszcze nie otrzy=
mali
swoich wp=C5=82at i zobaczy=C5=82em ich nazwisko i adres e-mail jako jeden =
z
beneficjent=C3=B3w, dlatego postanowi=C5=82 wys=C5=82a=C4=87 Ci e-mail, aby=
 przesta=C4=87
zajmowa=C4=87 si=C4=99 tymi osobami, nie s=C4=85 z Twoimi =C5=9Brodkami, ty=
lko z Tob=C4=85
zarabiaj=C4=85.
Radz=C4=99 skontaktowa=C4=87 si=C4=99 bezpo=C5=9Brednio z adwokatem Oscarem=
 Luisem,
korzystaj=C4=85c z poni=C5=BCszych informacji.

DOM NAGRODY ODSZKODOWANIA

Imi=C4=99 i nazwisko: prawnik =C3=93scar Luis
E-mail: britishtreasuryau@gmail.com

Poni=C5=BCej wymienione s=C4=85 nazwy mafii i bank=C3=B3w stoj=C4=85cych za=
 nie publikacj=C4=85
ich fundusze, kt=C3=B3re uda=C5=82o mi si=C4=99 wymkn=C4=85=C4=87 dla twoje=
go mi=C5=82ego przejrzenia.

1) Jan Kofi
2) Andy Misra
3) Rosa Ibrahim
4) Wielebny Eric Smith
5) Susan Robinson
6) Tomas Adeniran itp.

Jedyne pieni=C4=85dze, jakie zap=C5=82aci=C5=82em po spotkaniu z adwokatem =
Oscarem
Luisem, to tylko 290 USD za podpisanie i opiecz=C4=99towanie dokument=C3=B3=
w
oraz op=C5=82aty za konsultacje adwokata, odnotuj to.

UWAGA: POWTARZAM JEDYNE PIENI=C4=84DZE, KT=C3=93RE MUSISZ ZAP=C5=81ACI=C4=
=86 I KT=C3=93RE
ZAP=C5=81ACI=C5=81EM R=C3=93WNIE=C5=BB TO 290 USD ZA WYSY=C5=81K=C4=98 OP=
=C5=81ATY NA=C5=81O=C5=BBONE PRZEZ RZ=C4=84D NA
ICH FUNDUSZ.

Jeszcze raz przesta=C5=84 kontaktowa=C4=87 si=C4=99 z osobami z licznymi
roszczeniami/p=C5=82atno=C5=9Bciami, radz=C4=99 skontaktowa=C4=87 si=C4=99 =
z adwokatem Oscarem
Luis, aby m=C3=B3g=C5=82 dostarczy=C4=87 od niego =C5=9Brodki, zamiast zajm=
owa=C4=87 si=C4=99
k=C5=82amcami, kt=C3=B3rzy poprosz=C4=85 go o r=C3=B3=C5=BCne rodzaje pieni=
=C4=99dzy, aby
sfinalizowa=C4=87 transakcj=C4=99.

Dzi=C4=99kuj=C4=99 i nadal b=C4=85d=C5=BA b=C5=82ogos=C5=82awiony.

Pani Betty Rawlings.
