Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0753BA86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiFBOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiFBOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:16:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057EB2F398
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:16:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u23so8061221lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=npxCWy2DywcBQq9OCNxxK3fUiVjXtjApy10t54oASAI=;
        b=cMiaNG68sod44nYMSYE1PYDg4sXkJJfuid9JmXHfCbonyrl8uec6rYUgUgyaJ7ucKJ
         HkI5MFxBpqcUkzXhJ9yHBjxl56Fn8vaDUURM/PLkszhTXaq1w6f/6zBdqPMwcQr4peog
         iZTSS5yR6PtP6SS070VYZTMR+8KzxFsjkW4nl2j5j3v1IpYdxkdH1Nu5ydDLWauSmu8c
         vMAHCG63gPqFRZPVFkB5bfLM3cXNjvwtAZ35jNQ38k/avpdRahT4atgq+EIXoM880pwk
         tRzk6j9Zdr3s8iWDyPX39D1SCaWQfazIPRn6Py7ETCJYjhn23MbLNnmB4eBgtTIXxh3z
         ngBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=npxCWy2DywcBQq9OCNxxK3fUiVjXtjApy10t54oASAI=;
        b=o/CUadoI+Blh6YCT7YAlZkQHhI4V6MyV+uv17chzg9UizZmmFbzXOAqB5ydY6WNVh7
         7S8h2SzaP+8tBJg7Fmu3KC2UGa0fhpVuUo/8wcClERXPu6fxMbYU4lcjZXFysyIb5ACC
         qXD80tO7eNoWIXy+iGGOSSOhqeaiaZwu+hEbqJQqBxNaX/pqPwSCIEFBqB5xF6SACeUV
         8sHlz8RwDsjxs/iTarJ/66JFDjwvv43/qkW90Q5827E13M33nfY5p41GtBs4rjw0fMDZ
         IK16CYfiLv6Ls38v3agUolkUnRBARLdTqMtMbpY7zrAf0QgfTMHXnN7fw4YELXGQ4Dk3
         Qg5w==
X-Gm-Message-State: AOAM532ff7r+kTm3BkdKQaIedecKFpYHB0LIB3rpHVmhty0RDlnweBi7
        yf6ZMvOrAjiLjYqXSx9d8X6t9ML4abxTecmcvIs=
X-Google-Smtp-Source: ABdhPJy4BqCfMkBWGYu0QJhfLKK8g8bfFtP2DkPQRxiBYZPLhR8tjxPymtaGPE8Ge/+9RKszZtG/IX0fZL51OwG/kC4=
X-Received: by 2002:ac2:490d:0:b0:479:1568:ed46 with SMTP id
 n13-20020ac2490d000000b004791568ed46mr736902lfi.569.1654179393236; Thu, 02
 Jun 2022 07:16:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:760a:0:0:0:0:0 with HTTP; Thu, 2 Jun 2022 07:16:32 -0700 (PDT)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <lawyerrfirm01@gmail.com>
Date:   Thu, 2 Jun 2022 07:16:32 -0700
Message-ID: <CAJnhBAskpKAx+mNO2sDKggGegvA895qcCd8=2LhGekh+E08FtQ@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Aufmerksamkeit bitte,

Ich bin Mr. Abraham Morrison, wie geht es Ihnen, ich hoffe, Sie sind
wohlauf und gesund? Hiermit m=C3=B6chte ich Sie dar=C3=BCber informieren, d=
ass
ich die Transaktion mit Hilfe eines neuen Partners aus Indien
erfolgreich abgeschlossen habe und nun der Fonds nach Indien auf das
Bankkonto des neuen Partners =C3=BCberwiesen wurde.

Inzwischen habe ich mich entschieden, Sie mit der Summe von 500.000,00
=E2=82=AC (nur f=C3=BCnfhunderttausend Euro) f=C3=BCr Ihre bisherigen Bem=
=C3=BChungen zu
entsch=C3=A4digen, obwohl Sie mich auf der ganzen Linie entt=C3=A4uscht hab=
en.
Aber trotzdem freue ich mich sehr =C3=BCber den reibungslosen und
erfolgreichen Abschluss der Transaktion und habe mich daher
entschieden, Sie mit der Summe von 500.000,00 =E2=82=AC zu entsch=C3=A4dige=
n, damit
Sie die Freude mit mir teilen.

Ich rate Ihnen, sich an meine Sekret=C3=A4rin zu wenden, um eine
Bankomatkarte =C3=BCber 500.000,00 =E2=82=AC zu erhalten, die ich f=C3=BCr =
Sie
aufbewahrt habe. Kontaktieren Sie sie jetzt ohne Verz=C3=B6gerung.

Name: Linda Kofi
E-Mail: koffilinda785@gmail.com


Bitte best=C3=A4tigen Sie ihr die folgenden Informationen:

Ihr vollst=C3=A4ndiger Name:........
Deine Adresse:..........
Dein Land:..........
Ihr Alter: .........
Ihr Beruf:..........
Ihre Handynummer: ...........
Ihr Reisepass oder F=C3=BChrerschein:.........

Beachten Sie, dass, wenn Sie ihr die oben genannten Informationen
nicht vollst=C3=A4ndig gesendet haben, sie die Bankomatkarte nicht an Sie
herausgeben wird, da sie sicher sein muss, dass Sie es sind. Bitten
Sie sie, Ihnen den Gesamtbetrag (=E2=82=AC 500.000,00) der Bankomatkarte zu
schicken, die ich f=C3=BCr Sie aufbewahrt habe.

Mit freundlichen Gr=C3=BC=C3=9Fen,

Herr Abraham Morrison
