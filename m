Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476E4548BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbiFMPtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiFMPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:48:09 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBDE179947
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:25:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id j20so6171392ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zXYzaYM+MH6bQYEtMJikPf8JokCGUGXGDdjWTBEEWDQ=;
        b=dgK3ftwBWoh2255c8PIURNKpgXKChTnlKkjWgEuBdG9//gqdDQL8ol3ateTZTeeaxX
         kSgZiPw2BcFAtYLAqRwewoopZnE9rmjU8OnuaHp8Ois9ym7w1m1PSbwfkZFjknXjRuoE
         CWLyC/DqQA1CprvXN5XXQBhSvQKaqKdAuWrg5pqjX72OUS8A+hQ2bO+3kChs/ujSLmBh
         gRLw6uiTm5Kewng/SqqZJmQGEkvRvSsaMzUGL/2JaNXqGepoFeJ0n/xvFSRnfnNCqB68
         Or2PDsvFDtdRZph9gbC+j44SPr0rGp1RAFOOzti/NtVzIAl4uw4r/RuNBJ8/B9cgpH4v
         qlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=zXYzaYM+MH6bQYEtMJikPf8JokCGUGXGDdjWTBEEWDQ=;
        b=27rJwZN/qiyBGBlfupnK2bH1UHtq2XmmT9nDETaZTo7qGNciIY6SCmaNeE5sKWgKrD
         /ptuoXXgqdUjrW1Lcj4go3Sfdl4sU2GJqJmecdOfg7jh0nM32wAojf9olhJK8DfiJIs7
         Tlbt+rm1/QPuo6ad2Py90QzM+1I6y1dbLOTffuMYHbkhtsZvCct7JohS0pTt+uCWQaW/
         2zuOTzkbyiXdzAiQw86FtvtidS2cBqliLcIbX/q3Gyrsv3MTn8Fh5ZBMqUgK64FCxo9b
         BzpQLBebNkwu/HMnXbLhwoFAHZmYHwsXkvGDycYMLLTY91/82J0dcrn/X66DQtQSUdOU
         E6Bw==
X-Gm-Message-State: AOAM531r1eik0w75j78GqPF0QTcIMdxdj5JQX+oKBsI5ZpZm8uZeaKMr
        9E90KOn4U3T9YVDI0dyUS0CBM4GRfl8Rh9/QGP4=
X-Google-Smtp-Source: ABdhPJwUs2NIu7N/KkUEMmOlkf3FuWOlW2LvnHcTJ1I+lMILeD5lT8v+WxKL51G3XWcsSTjFah0NywVVBIESoCPwZk0=
X-Received: by 2002:a2e:bd15:0:b0:255:3768:9999 with SMTP id
 n21-20020a2ebd15000000b0025537689999mr45730036ljq.20.1655126718954; Mon, 13
 Jun 2022 06:25:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:21a2:b0:142:5559:4fec with HTTP; Mon, 13 Jun 2022
 06:25:18 -0700 (PDT)
Reply-To: marija.sterbenc@aol.com
From:   Marija Sterbenc <marijasterbenc21@gmail.com>
Date:   Mon, 13 Jun 2022 14:25:18 +0100
Message-ID: <CALEkHnNpX9E4-PD2OucwJgOBx0-qxEjcQ_jku-iPMrn26AtLHg@mail.gmail.com>
Subject: Pani Marija Sterbenc
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drah=C3=A1 milovan=C3=A1,

Pozdravujem =C5=A5a v mene Bo=C5=BEom; je pravda, =C5=BEe tento list v=C3=
=A1s mo=C5=BEno
prekvap=C3=AD, ale napriek tomu v=C3=A1s pokorne =C5=BEiadam, aby ste mi ve=
novali
pozornos=C5=A5 a dobre ma po=C4=8Duli. Vol=C3=A1m sa pani Marija Sterbenc .=
 M=C3=A1m 63
rokov a som vydat=C3=A1 za p=C3=A1na Rodrigueza Sterbenca a pred jeho smr=
=C5=A5ou v
roku 2012 sme boli man=C5=BEelmi 32 rokov.

Boli sme man=C5=BEelmi 32 rokov bez die=C5=A5a=C5=A5a a on zomrel po kr=C3=
=A1tkej chorobe
a po jeho smrti som sa rozhodol, =C5=BEe sa kv=C3=B4li svojmu n=C3=A1bo=C5=
=BEensk=C3=A9mu
presved=C4=8Deniu a vysok=C3=A9mu veku znova neo=C5=BEen=C3=ADm. Ke=C4=8F b=
ol m=C3=B4j zosnul=C3=BD
man=C5=BEel na=C5=BEive, ulo=C5=BEil tu v banke sumu 4 500 000,00 (=C5=A1ty=
ri mili=C3=B3ny,
p=C3=A4=C5=A5stotis=C3=ADc eur). V s=C3=BA=C4=8Dasnosti s=C3=BA tieto penia=
ze st=C3=A1le v =C3=BAschove banky.
Ned=C3=A1vno mi m=C3=B4j doktor povedal, =C5=BEe nasleduj=C3=BAce =C5=A1tyr=
i mesiace nevydr=C5=BE=C3=ADm
kv=C3=B4li rakovine.

Ke=C4=8F=C5=BEe som poznal svoj stav, rozhodol som sa tieto peniaze darova=
=C5=A5
cirkv=C3=A1m, organiz=C3=A1ci=C3=A1m alebo dobr=C3=BDm =C4=BEu=C4=8Fom, kto=
r=C3=AD bud=C3=BA tento fond
vyu=C5=BE=C3=ADva=C5=A5 tak, ako v=C3=A1m d=C3=A1m n=C3=A1vod na spr=C3=A1v=
nu predstavu o vyu=C5=BEit=C3=AD tohto
fondu.

Chcem, aby ste tieto peniaze pou=C5=BEili pre charitat=C3=ADvne organiz=C3=
=A1cie,
sirotince, vdovy a in=C3=BDch =C4=BEud=C3=AD, ktor=C3=AD s=C3=BA v n=C3=BAd=
zi. Rozhodol som sa tak,
preto=C5=BEe nem=C3=A1m =C5=BEiadne die=C5=A5a, ktor=C3=A9 by tieto peniaze=
 zdedilo. Navy=C5=A1e,
pr=C3=ADbuzn=C3=AD m=C3=B4jho man=C5=BEela mi nie s=C3=BA bl=C3=ADzki, ke=
=C4=8F=C5=BEe som ochorela na
rakovinu a chceli ma vidie=C5=A5 m=C5=95tvu, aby mohli zdedi=C5=A5 jeho boh=
atstvo, a
preto nem=C3=A1me =C5=BEiadne die=C5=A5a. T=C3=ADto =C4=BEudia nie s=C3=BA =
hodn=C3=AD tohto dedi=C4=8Dstva. To
je d=C3=B4vod, pre=C4=8Do som sa rozhodol kontaktova=C5=A5 v=C3=A1s a darov=
a=C5=A5 v=C3=A1m tento
fond na charitat=C3=ADvne pr=C3=A1ce.

Hne=C4=8F ako dostanem va=C5=A1u odpove=C4=8F, d=C3=A1m v=C3=A1m kontakt na=
 banku, kde je tento
fond ulo=C5=BEen=C3=BD moj=C3=ADm zosnul=C3=BDm man=C5=BEelom pred jeho n=
=C3=A1hlou smr=C5=A5ou, a tie=C5=BE
pover=C3=ADm n=C3=A1=C5=A1ho rodinn=C3=A9ho pr=C3=A1vnika, aby banke vydal =
splnomocnenie, ktor=C3=A9
predlo=C5=BE=C3=AD ste pr=C3=ADjemcom tohto fondu a tie=C5=BE chcem, aby st=
e ma v=C5=BEdy
zap=C3=A1jali do svojej ka=C5=BEdodennej modlitby.

Ak=C3=A9ko=C4=BEvek oneskorenie vo va=C5=A1ej odpovedi mi m=C3=B4=C5=BEe po=
skytn=C3=BA=C5=A5 priestor na
h=C4=BEadanie in=C3=A9ho dobr=C3=A9ho =C4=8Dloveka na rovnak=C3=BD =C3=BA=
=C4=8Del.

=C4=8Eakujem a zosta=C5=88 po=C5=BEehnan=C3=BD.

va=C5=A1a sestra
Pani Marija Sterbenc
