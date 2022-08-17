Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30132597497
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiHQQyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbiHQQyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:54:49 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856DB6DAF7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:54:46 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id a4so10800653qto.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9JEtfRcdd/zdjduYlRibqgKJC5F9JLPtm8Bi0FyLjvc=;
        b=lSU+grdIINoOt+nw5+wcniP2wH2wcab/Wusu6v56KSpWOws8W1JbVjp2hYLtXYco56
         tfyEvYlVs5g1ABB0dPNbAaCa5nhBZhogP0+YcY/RggOGa2ZtAZy6dyFMs2iAVvyvQ2q0
         83SOLYK1xoBPeYA/OudkrZcEn5GywMoYFB8MD0SXdtTRtYlCEDOn8SfLdrhNY7T+8nSr
         2P151viFJ+LrvMfU3evnJnlCyVgbArzvExSQs+gh99mVTYjplm2sKCe+SWawQRRuTcDg
         t4yOyU8HTRZDAZNGTNsDmU6ykV8AgH/Xh8Mgcp2ejCctTnKf1ITHInI9pBEnkrQXJ3P4
         Uj6w==
X-Gm-Message-State: ACgBeo1Qo1wBgl3ZfxVnOXwMBXWrRpvM1PI04THek7P4/z/vaY34SmYu
        OdN6LDi8pmfs08/WnJmUM6oQCqQBaKdCHA==
X-Google-Smtp-Source: AA6agR5ElgTiVv+hvc1TCf6VoFb79XKPcALNwBTPMMSzfSl1owVCqoofmCJOw5hu5AILiBeymUr64g==
X-Received: by 2002:ac8:5892:0:b0:344:5655:b8d9 with SMTP id t18-20020ac85892000000b003445655b8d9mr15454094qta.450.1660755285339;
        Wed, 17 Aug 2022 09:54:45 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id bj25-20020a05620a191900b006b93ef659c3sm7882707qkb.39.2022.08.17.09.54.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 09:54:45 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3246910dac3so246860927b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:54:44 -0700 (PDT)
X-Received: by 2002:a81:f47:0:b0:31f:434b:5ee with SMTP id 68-20020a810f47000000b0031f434b05eemr22552484ywp.383.1660755284656;
 Wed, 17 Aug 2022 09:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <edc5763d90054df7977ae24976e80533c7a1bff9.1660663653.git.geert+renesas@glider.be>
 <20220816112522.05aac832@kernel.org> <CAMuHMdU=xtnPCAd8SF+MyeFNHfsVE17++CcsBtDA3veZ0wo74w@mail.gmail.com>
 <20220817090204.5a9c81ad@kernel.org>
In-Reply-To: <20220817090204.5a9c81ad@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 18:54:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVyAtjA7-GxO_BCtJcWQXB+6rt5rOW8DvBqm1C5SVmk5A@mail.gmail.com>
Message-ID: <CAMuHMdVyAtjA7-GxO_BCtJcWQXB+6rt5rOW8DvBqm1C5SVmk5A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix incorrect "the the" corrections
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Slark Xiao <slark_xiao@163.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, linux-arm-msm
        <linux-arm-msm@vger.kernel.org>, Linux-Renesas
        <linux-renesas-soc@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On Wed, Aug 17, 2022 at 6:02 PM Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 17 Aug 2022 09:33:12 +0200 Geert Uytterhoeven wrote:
> > On Tue, Aug 16, 2022 at 8:25 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Tue, 16 Aug 2022 17:30:33 +0200 Geert Uytterhoeven wrote:
> > > > Lots of double occurrences of "the" were replaced by single occurrences,
> > > > but some of them should become "to the" instead.
> > > >
> > > > Fixes: 12e5bde18d7f6ca4 ("dt-bindings: Fix typo in comment")
> > >
> > > No empty lines between tags.
> >
> > Ooops, thanks. Shall I resend?
>
> Depends who takes it :S In presence of uncertainty resend may be the
> best option.
>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > > Documentation/devicetree/bindings/net/qcom-emac.txt         | 2 +-
> > > > Documentation/devicetree/bindings/thermal/rcar-thermal.yaml | 2 +-
> > >
> > > Who takes it then? :S
> >
> > The tree that took 12e5bde18d7f6ca4, i.e. the DT tree?

Doh, I even missed CCing Rob ;-)

> Yes. It was one of those "the merge window is here so it doesn't
> matter where it goes" cases. We'll send a PR to Linus tomorrow, so
> perhaps most expedient if we take it as a fix via net. (Objections?)

OK, resending...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
