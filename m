Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A05A53CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiH2SNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH2SN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:13:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F858C475
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:13:27 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j5so11309015oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=TrYLNmHMfL2YwnKDzOCdO7Jrlbbexw6rsutI3mWrjc8=;
        b=eNGGfSi8g6pwIAqFGncp3Ohk/s3H+LPxlKZ0cCDk2/1ubI3DnsYecBZRH9qoffo2zD
         hjutIQJIm0ZLp7VHWwvlnCBZcorWs2M0igzZhulIDX9bSGW7hBH+MAKzX+MVkPQtRXh9
         nfoJxx5K+LCRsSv/hUNxNXhbHK7YNbppIHnx8o35/aeJpc4GxBNNz1nnVpH8EbFtxvXI
         D2HOBgDDMRwFGvYZtiV1Kp1mIkmiIaRgPBGP6TyJtzSUUU5ETcB/tIF0bp7DZGMdzo0U
         rTNjUyARCDHB18+amXKd4AlX5mKFa4DAxFx9Wqlqrp3utcO2TjDEqotqsv8CGpW2ihT3
         Ta1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TrYLNmHMfL2YwnKDzOCdO7Jrlbbexw6rsutI3mWrjc8=;
        b=X4SBZrJeva+hkhvkHGimmZxBjjazqtNqigzaYwM0z4FuMEQB4KHO8QbPbCiys4Pf4W
         hkHz0Iwf8wDsYDnXSodaam966JL1zb1iPWes+yXrrQSOG2Ld68Ct51OB/IvXs2kFGTA9
         8vWf5vryefyza+orN2c5UV7rz6s+2+uo631C0XK8ncEXZ2S/WhbQVLk6v36FuwNUqX9/
         YX994K4vtPmrncoRh9iSTJ5Dn3/h2aL06xoOHn/UHE5NtYJxKWHZVq+lGz3arhT4q31A
         G+zEh4XaZg+NRydlTF0Lw9wJ43xXZhXUxThMkXSi1nJYPRSW2u5wC+4oqCPg1IZGszHH
         SueQ==
X-Gm-Message-State: ACgBeo3EQsS8JS1jl6IVjjlhze3SO2lbF27NOF4J28+txJ7FoHn9I++a
        RFRfUGlK7U3qSPwOEvfSQc7pMzpOch0IHa1cOBo=
X-Google-Smtp-Source: AA6agR50MJWkNr/4WR3vx8m1Kcdw7lHSnejqF9cJWeVQAm+USzme3gydRbZSrOjY/vd2nT6WYazoViJJbI4aDVG9dvM=
X-Received: by 2002:a54:4116:0:b0:343:bcd:88d4 with SMTP id
 l22-20020a544116000000b003430bcd88d4mr7840975oic.47.1661796807071; Mon, 29
 Aug 2022 11:13:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:128f:0:0:0:0:0 with HTTP; Mon, 29 Aug 2022 11:13:26
 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <georgemike70300@gmail.com>
Date:   Mon, 29 Aug 2022 20:13:26 +0200
Message-ID: <CAFx-DcGNbLHnV2+vN7Xvv7OoKk-nh1ciCuDUFYsHe1gBNLOtFw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj

Jmenuji se George Brown, povol=C3=A1n=C3=ADm jsem pr=C3=A1vn=C3=ADk. Chci v=
=C3=A1m nab=C3=ADdnout
nejbli=C5=BE=C5=A1=C3=AD p=C5=99=C3=ADbuzn=C3=BD m=C3=A9ho klienta. Zd=C4=
=9Bd=C3=ADte =C4=8D=C3=A1stku (8,5 milionu $)
dolar=C5=AF, kter=C3=A9 m=C5=AFj klient nechal v bance p=C5=99ed svou smrt=
=C3=AD.

M=C5=AFj klient je ob=C4=8Dan va=C5=A1=C3=AD zem=C4=9B, kter=C3=BD zem=C5=
=99el p=C5=99i autonehod=C4=9B se svou =C5=BEenou
a jedin=C3=BD syn. Budu m=C3=ADt n=C3=A1rok na 50 % z celkov=C3=A9ho fondu,=
 zat=C3=ADmco 50 % ano
b=C3=BDt pro tebe.
Pro v=C3=ADce informac=C3=AD pros=C3=ADm kontaktujte m=C5=AFj soukrom=C3=BD=
 e-mail zde:
georgebrown0004@gmail.com

P=C5=99edem d=C4=9Bkuji,
pane George Browne,
