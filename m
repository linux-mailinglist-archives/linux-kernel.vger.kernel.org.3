Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBAB4F7DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbiDGLRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbiDGLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:16:57 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C2E127E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 04:14:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q14so6956930ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NJXP07FsEA0ScYgIf1VCSlAppDSOdadONWaUl6HRFr4=;
        b=OYwqbUbfHoU4CRDov2z5SHPtu28NVKkUM8CjlItt0tgEXfIXAkOZtWQGfllAH0+RON
         gKecVxINxRGphYLMg9cgp3MMGmOQ2KJ/RKFAHlevE2OxuVscaUlOL2oj39aI+iiKxQFJ
         8Laeo/nWur7rsA1TEX2egjpDGvVVqv/V5+k/i071v9RQbcE8FGhyzqAYuM8uabJWNjZF
         ozrEXHeSUKS6rPjF8wcFRpMa43/Usz4ugZl7NglIwfdYdxAPgjSox2b7Zh1+k+B5Ns/F
         FtfWjsf2G0AtrlI1gbPZu94O1PeS1d+jgsw8S/1P/jcjcV2UP8tQRWZkCYeQRpro6a+0
         w0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=NJXP07FsEA0ScYgIf1VCSlAppDSOdadONWaUl6HRFr4=;
        b=AOmXEA67Yce7R2wcU2ew7wUIu4aL6wKJv7AoqIn7Jp1X/34wjGB2XKRIoOgM6NU4+E
         E26Crnyxvkh5D0nuZg9etZMjGgxTXFXF4H8cbWkLwZw2xMAcguB81hq3vJ9eEW6szKqD
         mU9SIzB14D7KfCDlnlMojEu9bmWhnsVeDcA645+77OCbb6HVtMrxmyUh/OEWFnlY/4DA
         yawh6iNot3HNA9cooZfcnmfqoyhW0akHmI6TIEJk6IJxuYPShuQ2/JSOJN2LzRJHiqp5
         jAH+TvuhA5v1e2kZEDR/G64k+ZS9GtICvtfSdnieonPdB3VeBq2gPds7EcCAtS+hKjcI
         2YVw==
X-Gm-Message-State: AOAM531CCe6UsjZJqCAHlAXI69LphXE7wpUdFrkPL1WemlQuVsUnClqH
        E7aarMNEFTBdTbal7vbPqQqqekQgx//NT/UlUjw=
X-Google-Smtp-Source: ABdhPJzwUdyaVSLi9FWmaZtopqEiFQMzx6ogUdc3u9ia+KuSicTUELTAyp/r+i5keAfxq0E/NHfhZ2cgv8xkmecLLfg=
X-Received: by 2002:a2e:bf05:0:b0:247:b233:cfba with SMTP id
 c5-20020a2ebf05000000b00247b233cfbamr8149320ljr.131.1649330095338; Thu, 07
 Apr 2022 04:14:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:148f:b0:134:b59e:fa06 with HTTP; Thu, 7 Apr 2022
 04:14:54 -0700 (PDT)
Reply-To: www.info.united.bankofafrica3.tg@gmail.com
From:   Geoge mogan <mogangeoge977@gmail.com>
Date:   Thu, 7 Apr 2022 12:14:54 +0100
Message-ID: <CABt6z7fgAkGFWCN22paaWwr_31P4S_WPLLGkuvCY299moCoWmA@mail.gmail.com>
Subject: POZDRAV
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mogangeoge977[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mogangeoge977[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pozornost upravi=C4=8Denca,
To e-po=C5=A1tno obvestilo prejmete neposredno iz urada
Ekipa odbora za boj proti goljufijam Afri=C5=A1ke unije (AU) Republike Togo=
 v
sodelovanje z delovno postajo Zdru=C5=BEenih narodov (ZN) Lome-Togo,
=C5=A1tevilka P-4 Post-AF /RP/RDBCPN/SHS/0001.v zvezi z obse=C5=BEnim zbira=
njem
(aretacijami) internetnih prevarantov. Zaradi visoke stopnje prito=C5=BEb,
ki jih prejemamo s strani Organizacije zdru=C5=BEenih narodov (ZN) na ravni
goljufov/goljufov afri=C5=A1ke narodnosti. Vsi ponudniki internetnih
storitev so opazili pove=C4=8Danje e-po=C5=A1tnega prometa iz Afrike na dru=
ge
celine.

V tem napadu je bilo doslej aretiranih tristo =C5=A1est (306) prevarantov
in ta racija =C5=A1e traja. Od njih smo izterjali celotno vsoto 857
milijonov dolarjev, tako v gotovini kot v premo=C5=BEenju, za katerega je
bilo potrjeno, da prihaja od njihovih =C5=BErtev. Ker smo iz njihovih
imenikov na=C5=A1li na stotine tiso=C4=8D e-po=C5=A1tnih naslovov =C5=BErte=
v. V tem =C4=8Dasu
vas kontaktiramo.

Ve=C4=8Dkrat smo brezuspe=C5=A1no posku=C5=A1ali stopiti v stik z vami, zat=
o vam =C5=A1e
zadnji=C4=8D po=C5=A1iljamo ta opomnik, po katerem od=C5=A1kodninska komisi=
ja
Zdru=C5=BEenih narodov ne bo imela druge izbire, kot da prekli=C4=8De va=C5=
=A1o
od=C5=A1kodnino v vi=C5=A1ini 750.000,00 $ in vas ozna=C4=8Di. ker ni zahte=
vano, zato
prosimo, da nemudoma odgovorite na to pismo, da pojasnite svoje
stali=C5=A1=C4=8De o tej zadevi, preden bo prepozno, ukrepajte hitro in
upo=C5=A1tevajte navodila v svoje dobro. Ve=C4=8D podrobnosti bo na voljo, =
ko se
obrnete na United Bank of Africa Lome, Togo

=C2=BBDanes vas obve=C5=A1=C4=8Damo, da je Banco UBA va=C5=A1 denar nakazal=
 na kartico
VISA in je tudi pripravljen za dostavo.
Zdaj se obrnite na generalnega direktorja Banco UBA
Ime................. G. Tony Elumelu
Elektronski naslov ........ www.info.united.bankofafrica3.tg@gmail.com

Njegove podrobnosti je omenil eden od Sindikatov, ki so ga aretirali
kot eno od njihovih =C5=BErtev operacij. S tem ste opozorjeni, da jim tega
sporo=C4=8Dila iz kakr=C5=A1nega koli razloga ne posredujte ali podvajate, =
saj
na=C5=A1 agent tajne slu=C5=BEbe ZDA =C5=BEe sledi drugim kriminalcem.

Po=C5=A1ljite naslednje podatke za dostavo va=C5=A1e akreditirane kartice V=
ISA
ATM na va=C5=A1 naslov.

Va=C5=A1e polno ime=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Va=C5=A1a dr=C5=BEava izvora=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Va=C5=A1 naslov =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
E-po=C5=A1tni naslov =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Va=C5=A1a telefonska =C5=A1tevilka =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Va=C5=A1a starost =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Va=C5=A1 spol =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Va=C5=A1 poklic =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Opomba; Zato vas prosim, da me nemudoma kontaktirate =C5=A1e danes, da
lahko nemudoma spro=C5=BEimo vse potrebne postopke in protokole za
sprostitev va=C5=A1ega sklada za od=C5=A1kodnino. Lep pozdrav, ekipa odbora=
 za
boj proti goljufijam Afri=C5=A1ke unije (AU) Podru=C5=BEnica Republike Togo
