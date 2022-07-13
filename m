Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9550257376A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiGMNa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiGMNaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:30:55 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1F61C6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:30:54 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-31caffa4a45so112708767b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vvtS89Fk2u1S3Szl4rrCs3KSXNS797GmNVbZS9fGKtQ=;
        b=YV/nbq5Eho+tDEKLMGeJG7iWrue3/HyrfYRLfUs6Ie73XjMCNX23YFIK4L5hfuINas
         eGZf+70rjdQmbGVslWcpbbYUKY9q4wvCeaAir91/EEoXv1cCNUGZRPHh8Msboy/1X2ZS
         embWyfrbh8wJDOMvxBHz4zBdQzI3k6ZVX48dy62c6zRuD01EojimyM2UofhtxYxco1ZU
         bM3/CGiJduX1GRUNHQGs7CvyuUO+tk1rTWFHc3EpzySVtP3W14j/YDvmeoklTqnk/ibD
         Ks0Y9UKzL/XD7EI7PVMVWxKa1rFM8cJtnnFwYGN0M0sRTyEUB0WKKp64h1TN6mzm8RdF
         pYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=vvtS89Fk2u1S3Szl4rrCs3KSXNS797GmNVbZS9fGKtQ=;
        b=myA53MSgrLaLBbTdgMEkiPI9yTePJipck+1g1zVs2Pfqi5vSU5wcMgWpiE2+Jhm47a
         VNo6Hh2QzdNtR4ZBPaW27ARdYUlkZRpXK9pl0eIblJC1qF4A81TiBk4PMU1tQglL8FY9
         RcrsU4QeGimcGNUzNJiiHCH9DJlRKd+6tVGLWr5vd7mpcXmfXw720FVI90SrFxzYlsrT
         b6tqkVCGxDij1jmv5ae/ia1YaD84saBkJfhUdjM0lVDhOD8HdRUz1/nukcF8bQzaBrIp
         3WerhTL+kmlVUWIqlAScfLpbZe9wbQsqsBCXHGf3DRycYwq5wUPSLn1IEH8cTaXzox8o
         Tjkw==
X-Gm-Message-State: AJIora9sukK+cwT7EgX3VHH/0iJujxbjx9aJhaDEQ0XuRMSzl8ZKoEf+
        4DN9AL9nbjSuyMGPTVxmnP8zLIcrbTMYksIvQk8=
X-Google-Smtp-Source: AGRyM1vB6W44BVeJ9oJ0JzFuySF2TuoQplsrQiu4RlD9Fio82QdvRAHVKc1fRA7pqHGMDDqrr+3N++BKTGcpGRu1v6A=
X-Received: by 2002:a81:5211:0:b0:31c:89a8:b63 with SMTP id
 g17-20020a815211000000b0031c89a80b63mr4311001ywb.104.1657719053498; Wed, 13
 Jul 2022 06:30:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:7499:b0:2e5:4edb:11f3 with HTTP; Wed, 13 Jul 2022
 06:30:53 -0700 (PDT)
Reply-To: cfc.ubagroup09@gmail.com
From:   Kristalina Georgieva <georgiamila084@gmail.com>
Date:   Wed, 13 Jul 2022 06:30:53 -0700
Message-ID: <CAGydNXHRJ0i_ia0-_jaSD9XQukSrPE4RPV0ciVR6wsAzBg6czw@mail.gmail.com>
Subject: HEAD UUDISED
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTTO_DEPT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1144 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [georgiamila084[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [cfc.ubagroup09[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [georgiamila084[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 LOTTO_DEPT Claims Department
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lugupeetud abisaaja!
Saatsin sulle selle kirja kuu aega tagasi, aga ma pole sinust midagi kuulnu=
d, ei
Olen kindel, et saite selle k=C3=A4tte ja sellep=C3=A4rast saatsin selle te=
ile uuesti.
Esiteks olen pr Kristalina Georgieva, tegevdirektor ja
Rahvusvahelise Valuutafondi president.

Tegelikult oleme l=C3=A4bi vaadanud k=C3=B5ik =C3=BCmbritsevad takistused j=
a probleemid
teie mittet=C3=A4ielik tehing ja teie suutmatus tasuda
=C3=BClekandetasud, mida v=C3=B5etakse teie vastu j=C3=A4rgmiste v=C3=B5ima=
luste eest
varasemate =C3=BClekannete kohta k=C3=BClastage kinnituse saamiseks meie sa=
iti 38
=C2=B0 53=E2=80=B256 =E2=80=B3 N 77 =C2=B0 2 =E2=80=B2 39 =E2=80=B3 W

Oleme direktorite n=C3=B5ukogu, Maailmapank ja Valuutafond
Washingtoni Rahvusvaheline (IMF) koos osakonnaga
Ameerika =C3=9Chendriikide riigikassa ja m=C3=B5ned teised uurimisasutused
asjakohane siin Ameerika =C3=9Chendriikides. on tellinud
meie Overseas Payment Remittance Unit, United Bank of
Africa Lome Togo, et v=C3=A4ljastada teile VISA kaart, kus $
1,5 miljonit teie fondist, et oma fondist rohkem v=C3=A4lja v=C3=B5tta.

Uurimise k=C3=A4igus avastasime koos
kardab, et teie makse on hilinenud korrumpeerunud ametnike poolt
pangast, kes =C3=BCritavad teie raha teie kontodele suunata
privaatne.

Ja t=C3=A4na anname teile teada, et teie raha on kaardile kantud
UBA panga VISA ja see on ka kohaletoimetamiseks valmis. N=C3=BC=C3=BCd
v=C3=B5tke =C3=BChendust UBA panga direktoriga, tema nimi on hr Tony
Elumelu, e-post: (cfc.ubagroup09@gmail.com)
et =C3=B6elda, kuidas ATM VISA kaarti k=C3=A4tte saada.

Lugupidamisega

Proua Kristalina Georgieva
