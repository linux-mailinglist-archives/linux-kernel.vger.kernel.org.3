Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B40528778
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbiEPOt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244668AbiEPOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:49:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBAE2EA20
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:49:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id n23so3720476edy.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=leJMhhCxM592OrQKvNZxLDLx73jd3Sy6dJLBcOyI06Q=;
        b=JRNdJtXRqSNoenywdKatWCAptGM4u7BK4MRrYdEh1UXXQFIubVB4ZdyLsTfos3+QHZ
         2wKDxmg7OBDAr5a3yv/hfDtDbl28KRQe6KPmVrfTVu/pmkF811+GZyVUUXri7/x/Zmlt
         iNLUnUZKKEvXQawNlND919VNpzkUrNgqT2716JYfY1Jak23P2Cu0ApfMplC3EgocP6Ac
         1YMhgsyxtoPmc15HsU99x+Lm2JJuG/MapvEZBujGImWKx9ba4N+nDk5lNstob6K46q8m
         O7ucQgou8h3SDSCmOwuXj9rgmveeOa217T2bJyt7fX+uMfjKi/nnwljWFCuWTUv3RSMM
         5yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=leJMhhCxM592OrQKvNZxLDLx73jd3Sy6dJLBcOyI06Q=;
        b=Sb8DWl2OgsoqMEfWxVSOJSF4HDUT51FE/GB0xNXZS7LU0lq6OzcZ1vJX0o5sutmvmM
         6gy/NbXlxPZ+Hq0qum0iBRZXd/v1VsPxFHliTKDfnzUAT3pN52vSO8XqCKWLDC98nuR3
         Q6lovp6/i7L2kBPgpz3W4Ydl7xfGmvn29+gWZtXLjT/fV06gFNImKbmYY2obs43awx1t
         VBfK+/UZQApKhn2gC23QmD/afyVAoIWTSX1hcxWMnU7MjR0ARBweRLoA6rH2K43ucYGG
         ZG5D/xszFL/5wiKJGY6Mk8uuRntPTxrc80Xr87jPkPQR5WgiAaeYJry4LDGyRCZ89d4G
         Qv1g==
X-Gm-Message-State: AOAM532sFmCXf4JCvGmci60paTi1NDpFqS1iDXRG6wlxi+h1W4KDUsWd
        mL5k08UN4Kuc9Ip8XosEp2hMJgICuUC3kR/yJ9A=
X-Google-Smtp-Source: ABdhPJwgt6WMF/YMBkNQvvGjcUz2nxNHec01M9pwi2+NHiXDQ1GwfJcSHyCQ6ozNnoPJ5p397LJuvLYmWago2MoJZ2w=
X-Received: by 2002:a05:6402:3488:b0:427:b4ec:991b with SMTP id
 v8-20020a056402348800b00427b4ec991bmr13535792edc.319.1652712561711; Mon, 16
 May 2022 07:49:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:240f:0:0:0:0:0 with HTTP; Mon, 16 May 2022 07:49:21
 -0700 (PDT)
Reply-To: abraaahammorrison1980@gmail.com
From:   Abraham Morrison <abrahamabrahammorrison@gmail.com>
Date:   Mon, 16 May 2022 07:49:21 -0700
Message-ID: <CAC1R54ZKe9s7cPLdSkM4yKK90Xt9i=A9+1FgPLOmd2MUVpgzTg@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:529 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abrahamabrahammorrison[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abraaahammorrison1980[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
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

Ihren vollst=C3=A4ndigen Namen:........
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
