Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E293457159F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiGLJWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiGLJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:22:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22914AA748;
        Tue, 12 Jul 2022 02:22:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bf9so12887292lfb.13;
        Tue, 12 Jul 2022 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DEs6NWZw58P+arlNCP/UdbyP1Orfku464NH2oPKbJs8=;
        b=GJxSdL9YXxEyOlKm5cW43+Jtc7kndVctHIj9g+gxYmJ48BwX7naKTuHLUUH2Z/k1bS
         TGL0ZvgnLSPVbwR+UI7KzXoMfvdz9s7Iwq6PzoEDqloZmMZ42GIZ9ua5MZfnbJG2vTR6
         uBNqfY2FeFQk+sLY3LRF5PSl16IsFIBcYUA2r/J8gcyNPtNGUtQXU692jm0Iw5pNhs4r
         DMF6Q1qb2z44Vz6sOmVKqwTbwlOHaTYHPmCNqkNpphyTl3U8IR4TsuP26uY7/G/gaEl+
         Yj5ye+9Zc3F498XAsPz1MOwL4VKICrXMOsMKSebCK/pUwvAf8vJHWlQLK6uuZGZokIYo
         90xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DEs6NWZw58P+arlNCP/UdbyP1Orfku464NH2oPKbJs8=;
        b=c79/NVEqjYhf949uQHsm2xBuVIxG0sY7BUOVep8Zp3pyH1asHBsdHL6CE0AOOwCSdG
         b8FQyhSU0VdPQwrARVNq3Hm7+BYkIoXtAiGR4kE4JNWEMZXdczsnINhH5mMPJeWxCbH1
         npyZmnadyvwANvOYFNhq7FHwmopJ0kAsYDuw0sSvbpV+LykkRV2ycz6z4tv0MajwYk6L
         y6dEsQiFboOcq3y2Uyt7oaKbenOE7jDg5ArbbETNbiYPsr0jsQW5fJC//37+qb7XqbEX
         cEDgmYFTPmJA62inuM/brl8Mc00VJKJl0u4P4wpgmZcA3e3BXNCmq14pWiCBIJF7Km5C
         3JlA==
X-Gm-Message-State: AJIora8eRSCy//F4DSiietQbA3XTsdDKQOT2g1235oqlfo7V1NkYKA4z
        4Cl2lYqHbdDWXhOmAOIaI3nBwBQaJGcGGM+wR2g=
X-Google-Smtp-Source: AGRyM1spJ4EpYOrE7LEL1xtBNfn9OIyAbDROAt/wQG/iEoIjTBgZACk8zCj0KzBQdj98Ded1/ALMSfI91AXVhWlQvak=
X-Received: by 2002:a05:6512:3f18:b0:47f:797b:4d6 with SMTP id
 y24-20020a0565123f1800b0047f797b04d6mr15617907lfa.356.1657617755443; Tue, 12
 Jul 2022 02:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220707073054.3954-1-mimi05633@gmail.com> <20220707073054.3954-2-mimi05633@gmail.com>
 <20220708221417.GA1573219-robh@kernel.org>
In-Reply-To: <20220708221417.GA1573219-robh@kernel.org>
From:   Minying Lin <mimi05633@gmail.com>
Date:   Tue, 12 Jul 2022 17:22:23 +0800
Message-ID: <CAL3ZnpzTMRBZ5+QsSe+THMiaxOi31qEvQ+8Xavi1QtGzYjPfWg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
To:     Rob Herring <robh@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nancy Yuen <yuenn@google.com>, KFTING <KFTING@nuvoton.com>,
        Patrick Venture <venture@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, YSCHU@nuvoton.com,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        Benjamin Fair <benjaminfair@google.com>,
        CS20 MYLin1 <mylin1@nuvoton.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>, KWLIU@nuvoton.com,
        JJLIU0@nuvoton.com, a.zummo@towertech.it, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob Herring,

Thank you for your response.
I'm new to upstream that I didn't add the review tag to v5 patch.
I will add the review tag in the v6 patch.

Thanks.
Best regards,
Mia

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=889=E6=97=A5 =
=E9=80=B1=E5=85=AD =E6=B8=85=E6=99=A86:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 07 Jul 2022 15:30:52 +0800, Mia Lin wrote:
> > Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.
> >
> > Signed-off-by: Mia Lin <mimi05633@gmail.com>
> > ---
> >  .../bindings/rtc/nuvoton,nct3018y.yaml        | 45 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct30=
18y.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
