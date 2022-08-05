Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C358ADF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbiHEQQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiHEQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:16:13 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34D919009
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:16:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso2225176otv.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=npxCWy2DywcBQq9OCNxxK3fUiVjXtjApy10t54oASAI=;
        b=QD9jxvcRtMkPIoFQ+exYKNhms4w3hMDDiVDy9a4iu/LjGZjXnshubXy2efJDu9/1AF
         H1bAlvBmDJP2QDDq3ablYyb1DfUsJOWK37ZMhlIZapF7d5yfa1DsxUQriWr/6kyI6L0G
         BgRDSXus/xCZ88eWmasJyqOock7KD+tsYhH0/dZYAp6Pgt80ELyzucy7w3Gkyi25601T
         zCHJAVzJ9Uw6F/OJ3h3r+Z9uwVm5oTniDpW8qzwPTMfmb6tNnOxpqq+rNy+F/PJMcu9S
         +AOCpFp8zxubYMmKVXYIOlChkDn1xW8Aid4fxKrqJjmyKYu71lmVQaJNw/OmNrCF4et7
         uLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=npxCWy2DywcBQq9OCNxxK3fUiVjXtjApy10t54oASAI=;
        b=oSeSbJEBZKRP1POQTa19eFBOanY+IcMjJS0s1UoatJHdlyxKswxgpmqcmbsPWt6spi
         JijQRBO8FfAPVA5iknAccVjbOauZsQbFsWUFdt0TwBJ7Q0OoyGaSQu3hZN/RraSjOA8R
         0SFFn69UXtCpHkYD5PTv/1IOnerKgTwovNoGayMubL3ibLOv00J9WzCbUx2bdjWH/VLL
         pbE+Eg0dyzuLqLyeaekFA48rodxlug9Fl/FSk69uCoeEf+Pr7PKLkbwtmSPFJZLIjXY0
         r6SMP64B4gIqJxnaqzl4D6COlTzcwO7HY7MRbvHTRcmBdh3h4pYTkP0pHdBIo47CU/tF
         +dyg==
X-Gm-Message-State: ACgBeo09AzQvKTTYrxAhB8R5wChdu5SP2Br4OaaYAG4AEnmUUHNpYL8v
        pOWLpikvZBkeYq166JP/qAd6D58N9/Gps/1msho=
X-Google-Smtp-Source: AA6agR5x2opsVFkfAUCf07eN0+lauWtlsaPhRoDs+YM/iQDA5UVHFu3abHEGvrNUn98KQR4MJTP5NS1zvdtjEwyAM6U=
X-Received: by 2002:a05:6830:110f:b0:636:a2c2:518f with SMTP id
 w15-20020a056830110f00b00636a2c2518fmr2818861otq.86.1659716171288; Fri, 05
 Aug 2022 09:16:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6808:1521:0:0:0:0 with HTTP; Fri, 5 Aug 2022 09:16:10
 -0700 (PDT)
Reply-To: abraaahammorrison1980@gmail.com
From:   Abraham Morrison <drjameswilliams1924@gmail.com>
Date:   Fri, 5 Aug 2022 09:16:10 -0700
Message-ID: <CAPBADDEvSYyx4czdeNKhPwBo2q-MU-TfeqLtT0RmOnds+GPdcw@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:32e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5012]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drjameswilliams1924[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drjameswilliams1924[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abraaahammorrison1980[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
