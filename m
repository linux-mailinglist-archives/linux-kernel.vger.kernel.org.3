Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883C654F6BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381687AbiFQLb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381579AbiFQLb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:31:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434886CAB2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:31:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m25so4406601lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mWux+0gJphiwF8KCaiCCCt9JPC6LCZLv9vW6WHHnpaA=;
        b=mI6suv6HnTW5DWLB7uE/DKZf/yQ9NsOTNNn3ioRb+7f0tiWLXv4vjKcrakH2Z9bvfR
         qN89VKabq7q59hA2hUZxk+76IOBm3XmLxAau2zFXK9U1Y7bRn5GqXTV7dtQLKTfhNHou
         Y3JNRyQ1OaoJSJwCyuVQji2j6tufEZ62S6rWqbohOAuL/DvXdwCAFDZHhpZXXol6CE4N
         +6QRuPswJjms17HoJSzx54Yb09wphW2yHMdlyXx16yz5F2h1rdO8vECQamy71geYdgk2
         hK7nM7lQ5cWW420Ky8DM7SWIpxIW5nofKrbm1UsRRI02500Wh1xJZx5Apk+XFbfw1wwQ
         J4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mWux+0gJphiwF8KCaiCCCt9JPC6LCZLv9vW6WHHnpaA=;
        b=hSa9ztjIGeeMFbRMexyCjj1Ly5Fc7tCEnrSaz4rvQ7bA+zYJK5czPDp3gKX9BmXpns
         erY51HUx5zEliRRm6bf2CRDs0kpL0rmdcYH9p1lzOesAeHG+MmvJBwzVoeHMV6ZdfgNX
         JUXx5ED9IqM8vRJCVIXV7U5ngedlEolXLshKGUwvdIlic8IgpUKn4fTDWSowsiaFrAQr
         ggbf9ZHyTbwDG8MsNoLK7Skq7Z8St1PVChk08rNjC/WfygyazKg8GZsONpc5DiksJfg/
         fc/n9TIouTRG/zSVqwBTBgMUQx/vYyJNcaeo6522zBRnzz0WNNkAXM883tPzVi1Mj0a3
         /pSg==
X-Gm-Message-State: AJIora9rmYMVtxa65o0yoA+cyWRspgcUWCbn2e9DM4+JrjQ9u6qNU0Le
        bBcyEghyly+4pKMI79Fvie9YkZvFOeSLgxHXpL4=
X-Google-Smtp-Source: AGRyM1uRwWQhPU4Q5gMaI5zTd0CM5WvYB8FojdEzn5yIqF1al0e8u9tJoTo2zDVhjfMFV/bMNP9EpbrB3vY9+f3gNjE=
X-Received: by 2002:a05:651c:545:b0:25a:45d1:4086 with SMTP id
 q5-20020a05651c054500b0025a45d14086mr4641125ljp.307.1655465484598; Fri, 17
 Jun 2022 04:31:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:3e07:0:0:0:0 with HTTP; Fri, 17 Jun 2022 04:31:24
 -0700 (PDT)
Reply-To: orlandomoris56@gmail.com
From:   Orlando Moris <gracepapa918@gmail.com>
Date:   Fri, 17 Jun 2022 11:31:24 +0000
Message-ID: <CAGTt_XV8OyV53oF=MC-NAzKCK2tq4dJsz==f2e8PqE_eb7jp=g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [orlandomoris56[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gracepapa918[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gracepapa918[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ol=C3=A1, Informamos que este e-mail que chegou =C3=A0 sua caixa de correio=
 n=C3=A3o
=C3=A9 um erro, mas foi especificamente endere=C3=A7ado a voc=C3=AA para su=
a
considera=C3=A7=C3=A3o. Tenho uma proposta de ($7.500.000.00) deixada pelo =
meu
falecido cliente Engenheiro Carlos que tem o mesmo nome que voc=C3=AA, ele
trabalhou e morou aqui em (Lom=C3=A9 Togo) antes de sua infeliz morte em um
acidente de carro com sua fam=C3=ADlia, estou entrando em contato voc=C3=AA=
 como
o parente mais pr=C3=B3ximo dele para que possa receber os fundos mediante
reclama=C3=A7=C3=B5es.
execu=C3=A7=C3=A3o deste conv=C3=AAnio., entre em contato comigo neste e-ma=
il
(orlandomoris56@gmail.com)
