Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D1E55050B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiFRNRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiFRNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:17:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38976CE29
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 06:17:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m1so1136018wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BweNV+yqpNjs9/E4V7pTvgz9qI4vyJk4MvqY4EwytKA=;
        b=mQKHIDqXEvIJIdVaJfcFs+nLjIHM5y4qF/VeiNXUAnhdW8e31PwVInCO6a+7CWjkMN
         fqGmE0Dv4gIvy8gpjk8O3a2Sln/bJRRwnHqjN2cLifrquQRb8x1Jt1d9RU2//jYezUKO
         CHH/dwMve26C8Sk90U7fdA1ob7xPjfluGt4QUEsfBgtr0vuLGCym2fB1yezIZDRf8xn8
         O6NdB6F0HXjw9cxHQvPAbeIDXnrLjEuCv/ratTiSN5U5q26FXOJCc2/1ArqDJ61sAXhj
         Q/7LYu69FYnh1sYXyAfNniTTGBKH//kjmnVqbU7Us/r9F3OJLRDGL9Qx07zXG0Bx/aZ6
         nUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=BweNV+yqpNjs9/E4V7pTvgz9qI4vyJk4MvqY4EwytKA=;
        b=U4UZ0qxQK4UOFPGnxULTJmzfWGiXYZn6pSHrsJT0SK4EEKcSThlSACt/Oe5+J/O6G+
         YMZm7mZbQIHQq3FqBGwwlFIeeX36b5N956eu1NcPoLBbVlsPoAfI/K9VrdcHzFYFlkab
         apcxuPMhhoeeuMtHPv4/dX+jIvS4XK7T8C8VYFQVGbeGKkoQnZcVmKEhRxwX7A6oiMmk
         3jWE9jbxrXIP42Z2w1v9C+TczK1cPzIiA9ma50mNu7t1vgrTjmJlIv3G3x+hKZ3jWwQR
         PpTAZcdFjfzCPKa8fhKh56qSV4Hgc0zfqZyrco3eNckobi5bjjXw0u8gd5uDwiOxG6eI
         JiUg==
X-Gm-Message-State: AJIora8YRu16uVLmyWJlKhWTlvGA4R3t/bEm8q+Ktg67ClKAbgPz7/th
        dnO29ci8/zEjxDQPNlKxWtucrJjshddNw/1NHpo=
X-Google-Smtp-Source: AGRyM1vjQIQGzYwiwr9qBEP+g/r7ksNB8SMu/uDu112urtfUJ/8yW3Xn6+WBQR7dO1C7HWXCFaPRZ785vW00tuIWymM=
X-Received: by 2002:a5d:6f07:0:b0:20f:e7b6:60e9 with SMTP id
 ay7-20020a5d6f07000000b0020fe7b660e9mr13361248wrb.452.1655558234847; Sat, 18
 Jun 2022 06:17:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f3c3:0:0:0:0:0 with HTTP; Sat, 18 Jun 2022 06:17:14
 -0700 (PDT)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <barristermorrrrison@gmail.com>
Date:   Sat, 18 Jun 2022 06:17:14 -0700
Message-ID: <CAKF=Er++=X4-h6Td3NQNCj-10PX9OBWJ0W4qcozt3dHiCcGbUw@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:431 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abrahammorrison443[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barristermorrrrison[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Opm=C3=A6rksomhed, tak!

Hvordan har du det? Jeg h=C3=A5ber du har det godt og sundt? Dette er for
at informere dig om, at jeg har afsluttet transaktionen med succes med
hj=C3=A6lp fra en ny partner. I mellemtiden har jeg besluttet at kompensere
dig med et bel=C3=B8b p=C3=A5 =E2=82=AC500.000,00 p=C3=A5 grund af din tidl=
igere indsats,
selvom du skuffede mig langs linjen.

Jeg r=C3=A5der dig til at kontakte min sekret=C3=A6r for ATM KORT p=C3=A5
=E2=82=AC500.000,00, som jeg opbevarede for dig.

Kontakt hende med nedenst=C3=A5ende oplysninger.
Navn: Linda Koffi
E-mail: koffilinda785@gmail.com

Bed hende om at sende dig det samlede bel=C3=B8b p=C3=A5 (=E2=82=AC500.000,=
00 )
ATM-KORT, som jeg opbevarede til dig.

Mr. Abraham Morrison
