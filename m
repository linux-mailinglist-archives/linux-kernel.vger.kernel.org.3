Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF955265F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381942AbiEMPX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380657AbiEMPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:23:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C365C678
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:23:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q23so11902724wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9tJIBbJChc1BxjbWcZb0lFSvKfg3R8y5golyZaz5kgY=;
        b=UVMUNYtz8kUg8ygLmutkb/YFC0tdIZtktwLiNRKvND0PirxaVCpmooNpyO0iV1ET5L
         wUT/oSFJYlyMMNkqSufI08KVrcYv7nNfIL/7up1f7lWubQRzXaDhLVN39mNCMkxHSp09
         57Ao21IdLfcor/UhEvPgXvIGDS2sTSDz70ft6G3luDJb8RBQCxEVWknG8KJTpUS+mt6C
         yE/1sfyddvWiT2hYJs/IywkSVDataF/skf7Ic5Hi5y2cIXt3/go/Wy9oSB2sFBa8aN+p
         /8IiFf3FE14rNuUNiRsL5JqLm7rBdnrI9J/v+bfimUIFPDJHNu7jYS7V68px1+WHfGLR
         DWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=9tJIBbJChc1BxjbWcZb0lFSvKfg3R8y5golyZaz5kgY=;
        b=5TfTjPPlMW9OJLzGpaHPSAsEsCrfBqT990EW4rULyvSDIfZSGa8TXRJ7STzvsoDNHS
         TH6gqkOZtsR7vzlrXX2lRjwf3+8zKo3PZD+KmU+aMarsGbfl/YhZshNEt+seojYFPVop
         D2/lKV4Cdk2VC+OmrLwN568MnYun6/jYeyS9ukLmYNuu2dxxA29KoRYXLI55/scdIK+J
         F9kCTG7s3ZD8+PQe5dihQ8xbBi8149iI7jmEC94V9JAg+vjcL2SxbBz0MoBEB2djz4x3
         sv5zGvfzaYe2qCl+W5UYG5xdaaq1hsju2Y3ZSWT9GXaLABw9FhGJ2+EJjrnTSmAIsSN3
         7rWQ==
X-Gm-Message-State: AOAM532NuKST6MzPxmhKl+2zvh3fRqT5/Hvdyyyt68CcrdgpHgPm50PG
        1uWq6PiQFiHYRwY5ekxJEtX3GyCqIlbiMdxbrT4=
X-Google-Smtp-Source: ABdhPJwzGHEiYDsBH2vsqDr5PyvC3emzuWIoBLJCBKL+uEo8EyFPbhD/rDmPJv6ZiNZFpE99iymHUZc7mvaRVrl47Uw=
X-Received: by 2002:adf:e488:0:b0:20c:e4bf:d0e1 with SMTP id
 i8-20020adfe488000000b0020ce4bfd0e1mr4428505wrm.579.1652455401612; Fri, 13
 May 2022 08:23:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:6da3:0:b0:20c:7e23:c59 with HTTP; Fri, 13 May 2022
 08:23:18 -0700 (PDT)
Reply-To: abraaahammorrison1980@gmail.com
From:   Abraham Morrison <mrsnancymorrison01@gmail.com>
Date:   Fri, 13 May 2022 08:23:18 -0700
Message-ID: <CAHm7iqjcip5Qs+UUYBo_r99ni+q5LPySu9NGq4c0FcjFObghcw@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:435 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6074]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsnancymorrison01[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrsnancymorrison01[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abraaahammorrison1980[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aufmerksamkeit bitte!

Wie geht es Ihnen? Ich hoffe, es geht dir gut und du bist gesund?
Hiermit m=C3=B6chte ich Sie dar=C3=BCber informieren, dass ich die Transakt=
ion
mit Hilfe eines neuen Partners erfolgreich abgeschlossen habe.
Inzwischen habe ich mich entschieden, Sie aufgrund Ihrer bisherigen
Bem=C3=BChungen mit der Summe von 500.000,00 =E2=82=AC zu entsch=C3=A4digen=
, obwohl Sie
mich auf der ganzen Linie entt=C3=A4uscht haben.

Ich rate Ihnen, sich an meine Sekret=C3=A4rin zu wenden, um eine ATM-KARTE
in H=C3=B6he von 500.000,00 =E2=82=AC zu erhalten, die ich f=C3=BCr Sie auf=
bewahrt habe.

Kontaktieren Sie sie mit den folgenden Informationen.
Name: Linda Kofi
E-Mail: koffilinda785@gmail.com

Bitten Sie sie, Ihnen den Gesamtbetrag von (500.000,00 =E2=82=AC) ATM-KARTE=
 zu
schicken, die ich f=C3=BCr Sie aufbewahrt habe.

Herr Abraham Morrison
