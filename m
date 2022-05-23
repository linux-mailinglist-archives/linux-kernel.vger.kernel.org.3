Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4045313A8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiEWOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbiEWO35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:29:57 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A713D53E26
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:29:55 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id m2so15191468vsr.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Lve1mxsIRFBHyA8U6h+dTcHz5C3XHO+Q/UM9b7xJHFY=;
        b=Op1t9Tk680y2YhfNsHaeFwzUzboggGrIV7Eibm2TZ7T7Jy4PyRvYWBoO2A5wEsseGN
         1vAD1RRYtUVbDz8z3SYW6Vh8QzpfnWtjjPByUL/QVFdZa9HD30KsPwj9+sJnEo0fzXUK
         uDRC3HGpiefG//QjCTqmHmgH5WjaVA4xwt1oD1HWWGLdb2FPLdku2grziqgpV1kuAH5V
         WWApuJamtwDHkQw1lzstAD6H4GnCNSM4Wl/SaepcPjPLo4aHpRMfERwcCMyJGRpPRk2u
         TqQoCjy9R2dw3c4YcVWyUUprtv7jQeWmYclMp9VGejsuIoDypHbCcuNepR7OZUn71ImB
         2Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Lve1mxsIRFBHyA8U6h+dTcHz5C3XHO+Q/UM9b7xJHFY=;
        b=BZ7DimKSb2j1tEq05OHIM/TbiokwWRbvyNV2x6pM700sU71Mt52nFOQLG/D8m006+I
         PqtIDuSSfnTxnMoviAbVu7QzLJk5bEhz76uUK6NZ1pzOndhPAAtPzlKdUoX3ag+J6Ab5
         sr2Tk0IKmAGaOf5+OfoW+fjwTcptxhB74SfknUBO22Z7x7jwlSzdnvFroXPaPdNvcyGe
         5vujvCKJmJDkfT17qE7Hm/HeHd3og8rRJnseVkXBAgpjBT1dzQoy00IDSnqYfH79pGE8
         e1dXLNnb9MR0f+Fj1uAOJpdlKNfePieSWK++vn+OqDHLPbTsN6DgwpyLddmU4Ij/QK/x
         AzNw==
X-Gm-Message-State: AOAM5327BJ858BVzKbFLRCbYFLIBZ/0Vc105BLblieOMmMFPGERS8U0H
        V0xqK4igSY1Dzbx5gxKI/3cNJUi59AgPp/L07Xo=
X-Google-Smtp-Source: ABdhPJydTAz5C3LQgoKFcM5GlShKKV8rFkgzfu2heKufwledlR1gydnPADOatmCU1hEYV6ArxogJnanaOR+hpzn7azE=
X-Received: by 2002:a05:6102:1629:b0:337:b70a:8b43 with SMTP id
 cu41-20020a056102162900b00337b70a8b43mr1773410vsb.24.1653316194688; Mon, 23
 May 2022 07:29:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:686:b0:2ba:8f9:b803 with HTTP; Mon, 23 May 2022
 07:29:54 -0700 (PDT)
Reply-To: benitasaira1994@gmail.com
From:   MICHAEL EDWARD <evenamejoice@gmail.com>
Date:   Mon, 23 May 2022 14:29:54 +0000
Message-ID: <CAO80g7ii1UueKbWv6Qoyw0xmeRAZt9GHpB7t4jgjbF5JjunoBQ@mail.gmail.com>
Subject: ATM CARD
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [benitasaira1994[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [evenamejoice[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.7 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Min kj=C3=A6re venn,

God dag min kj=C3=A6re venn hvordan har du det Lengst. jeg er glad for
for =C3=A5 informere deg om at jeg lykkes med =C3=A5 f=C3=A5 denne arven

fondsoverf=C3=B8ring i samarbeid med en ny partner.
Jeg drikker n=C3=A5 min andel av totalen av INDIAs utenlandske investeringe=
r

prosjekter.
Forresten, jeg har ikke glemt din tidligere innsats og innsats

=C3=A5 hjelpe.
sviktet meg i =C3=A5 overf=C3=B8re disse arvemidlene p=C3=A5 en eller annen=
 m=C3=A5te.
Ta n=C3=A5 kontakt med sekret=C3=A6ren min i Lome Togo Vest-Afrika, hun het=
er

BENITA SAIRA p=C3=A5 e-post (benitasaira1994@gmail.com)
be ham sende deg det totale bel=C3=B8pet ($900.000,00),NI HUNDRE

TUSEN.US dollar jeg har spart for kompensasjonen din hele fortiden

innsats og fors=C3=B8k p=C3=A5 =C3=A5 hjelpe meg i transaksjonen.
Da satte jeg stor pris p=C3=A5 innsatsen din. S=C3=A5 gjerne og

Kontakt sekret=C3=A6ren min, BENITA SAIRA, og fortell henne hvor hun skal s=
ende

den. gir deg minibankkortet for det totale bel=C3=B8pet (US

$9 000 000,00). Gi meg beskjed slik at vi kan dele gleden

umiddelbart n=C3=A5r du mottar det s=C3=A5 smerte.
Jeg har det veldig travelt her i disse dager.p=C3=A5 grunn av
investeringsprosjektene jeg

har med mitt nye hus husk, partner, at jeg endelig bestod

mine instruksjoner til meg selv. Sekret=C3=A6r p=C3=A5 dine vegne for =C3=
=A5 f=C3=A5 minibank

KORT, s=C3=A5 ikke n=C3=B8l med =C3=A5 ta det n=C3=A5r du kontakter Benita

Saira hun vil sende deg bel=C3=B8pet.
enhver forsinkelse.

Med vennlig hilsen,

Mr. MICHAEL EDWARD
