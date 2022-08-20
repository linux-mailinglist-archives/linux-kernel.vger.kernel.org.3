Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBB659AEAC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbiHTOXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 10:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346217AbiHTOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 10:23:32 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B7413D26
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:23:31 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id m21so2744734uab.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=s3WwiOFU4Cx25TV2VhuX+55GvPSt92ikN3uNkO5ZYHI=;
        b=HNvCH5+aD1kqILurnYempphOknweSCuZbJtiWsmHfK50GiXR2jvzpV95UKBEVl4udd
         fJTaE6XzKvvhJJiIfcRno70U2q2BUtJ7q7Eu33HjPdn9VVAe02YIp1khpbbxm9kRWBVq
         /dEqZuHyiUY5mcj3BofBGk+MEDRsdBih0ruozMe82adoSidoN2EPnNWDo6nclvtantgL
         Td8K1tXXf4i+/adfallyKlSmdiCSRYfMkRUX7k1wOZ66lS1hS18xcxxHZd8L5ZFrZ3SQ
         uSWghHuQDGPVhYM8eOFWbnyt+Mwb+AIV1t1/koN0Mf6pZt939w6G8BkEvG2Eh37MjV/n
         OrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=s3WwiOFU4Cx25TV2VhuX+55GvPSt92ikN3uNkO5ZYHI=;
        b=uFE9YUqZX1uqtdTXitPZXfx6YduCufrHaGdbZFX8+Y5t/fg4XsT+UMzVPXRr7UKAut
         6oCAu3XyQHmwuBpzBAn9FyFlktfnjpYhCnQj/tTosZyJiv2GFJ/VbUvPoAu0VbFGOIzI
         c9mHwJIvcZ117Rx/YC9XI1JLTV511ywtAwot/7II1jGZgiMqFyy0uoQkFnJpWtSjDs1H
         BA4F2ch3cUb+lWMJ9fHkEsasFZiSxsh84kPO0WcQbMUMnLvXn3JMp+xv30G+DfOLqaZO
         kEt9mY2ER6PHkH6qmbuqz9leWtgA5gyDN4fmcjFG/5Yj212rpeej2pHMCh6meZFhG0nm
         eeYg==
X-Gm-Message-State: ACgBeo0XjSJYpfDKY4mPXBsv184dcCOLp7CKIMneRYUFu1zgKREZaRkV
        M5J+G+Xl9xpYuXEnmFvfn7iU1SrnS6WXjE/rsTw=
X-Google-Smtp-Source: AA6agR63ONSuD+1j15VdQYXmbFc0A68q9VCDQi3Q/WIqd+X0Iu/Q9krKxzAbLPJVBYkF5kqvSZ5IRdsKhWmgP9apSwQ=
X-Received: by 2002:ab0:24cc:0:b0:391:c681:7b7 with SMTP id
 k12-20020ab024cc000000b00391c68107b7mr4439545uan.16.1661005410564; Sat, 20
 Aug 2022 07:23:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6122:911:0:0:0:0 with HTTP; Sat, 20 Aug 2022 07:23:29
 -0700 (PDT)
Reply-To: uchennailobitenone@gmail.com
From:   uchenna <okeyyoyopa7@gmail.com>
Date:   Sat, 20 Aug 2022 14:23:29 +0000
Message-ID: <CAH8nkvZ5bj-qWeWt+L5KiL3=Ke=qZuDs4MLhf=60G42_zJfnFg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:933 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [okeyyoyopa7[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [okeyyoyopa7[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gratulacje!

Organizacja Narod=C3=B3w Zjednoczonych dosz=C5=82a do wniosku, =C5=BCe z po=
moc=C4=85 nowo
wybranego prezydenta z powodu Covid-19 (koronawirusa), kt=C3=B3ry
spowodowa=C5=82 za=C5=82amanie gospodarcze w r=C3=B3=C5=BCne kraje i global=
ne zagro=C5=BCenie
dla tak wielu istnie=C5=84 ludzkich.

 Organizacja Narod=C3=B3w Zjednoczonych zleci=C5=82a szwajcarskiemu bankowi
=C5=9Bwiatowemu uwolnienie p=C5=82atno=C5=9Bci funduszu kompensacyjnego we =
wsp=C3=B3=C5=82pracy
z bankiem IBE w Wielkiej Brytanii.

P=C5=82atno=C5=9B=C4=87 zostanie przekazana na kart=C4=99 bankomatow=C4=85 =
Visa i wys=C5=82ana do
szcz=C4=99=C5=9Bliwego beneficjenta, kt=C3=B3ry z=C5=82o=C5=BCy wniosek za =
po=C5=9Brednictwem banku
IBE w Wielkiej Brytanii za po=C5=9Brednictwem dyplomatycznej firmy
kurierskiej znajduj=C4=85cej si=C4=99 w pobli=C5=BCu kraju beneficjenta.

S=C4=85 to informacje wymagane przez kierownictwo Zjednoczonego Kr=C3=B3les=
twa w
celu dostarczenia p=C5=82atno=C5=9Bci z funduszu kompensacyjnego do progu k=
raju
beneficjenta.

1. Twoje imi=C4=99 i nazwisko:
2. Adres domowy:
3. Miasto:
4. Kraj:
5. Zaw=C3=B3d:
6. P=C5=82e=C4=87:
7. Stan cywilny:
8. Wiek:
9. Paszport / dow=C3=B3d osobisty / prawo jazdy
10. Numer telefonu:
Skontaktuj si=C4=99 z naszym identyfikatorem e-mail agenta:
nazwa solomo brandy

ADRES EMIL (solomonbrandyfiveone@gmail.com ) dla Twojej p=C5=82atno=C5=9Bci=
 bez zw=C5=82oki,

Pozdrowienia
Pani Mary J. Robertson.
