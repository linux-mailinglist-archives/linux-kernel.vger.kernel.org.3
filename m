Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58A551344
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbiFTIti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiFTItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:49:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4014812D09;
        Mon, 20 Jun 2022 01:49:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w9so2074993lji.4;
        Mon, 20 Jun 2022 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlSfxRd2Xk2SeDc5uvX/PiiwHMy5mVFkHrE6RfQz+u0=;
        b=d9Kcc342xMbGWPyrQMls4I1iCrtiOhC+X57JVG39P6uK14Bl2lRfSGdl6Y4Byhq0zH
         nJTipKFc4tTkLhwmg9942xF4Cc40/tVepjCmlhj+mPAgjbmEyQH/A24l5A+jjH7+6H5M
         ZyCHjcTohfdcVHiFHcxKy4fAE/+PKKEH0+gP5zegmf9/ChX3X11UVlTDk8/RfYWyV0HU
         mBDgwqh4VTwrtUc9V0y2qQ5XG4B1RxECuQvlleWwXShfJWc2B2Khw8O1WPraYGvNI8To
         XL5tGWKOF8vcw80e0Tgq/I4YyrmQkdw4bnFWt8CNgBTpOVG+1EctiKVfnee9iclMTovi
         3bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlSfxRd2Xk2SeDc5uvX/PiiwHMy5mVFkHrE6RfQz+u0=;
        b=O5oePGAxd0gZppbzyE5YeEM59nQHIcdzBkaVHcJh7fWj2qp7ifvnt7ci74+Rm1uRO0
         wVHpWEpQ4HWs/89GrmvdAz2nWl0T50Ww1jMgjaaykfL1l6PW7bRDeq+NhIa/ASN0nAaN
         1TbPb7TdFmYUT5LKLs1DnB+DSUJgiVo1NBuyazfXLaAzMjVx2SvBlz0QlyGUdU3Hh6a6
         pkN4mOnWLJ3LktycWyngGAbubf+sUS3e4yRkXFlBW5+oU9pMwbRlH2Rgqj9eUAvOW2M3
         QYw6uqfNKFmFnxCq0G3ESggrtBnaT7Z1anq4pU66tWSSyiNtQ4hixzP5AiPCtZrbWkJb
         0/zw==
X-Gm-Message-State: AJIora9YgfZp+3sZOg18ordJNS6w7ugVKb1k/SZQ/b7XKnVWfy54bV0K
        RYv6At1TXTB0Lhfk9bWDBHDkE99Vx5ZblJVIMiLVKd4p
X-Google-Smtp-Source: AGRyM1uxeEzp6Qa/xu2QrohXZxMWMEgcFsJzBfa65ZTYCS5D4yF+rdF2IA0ZatrTmNq8mu617DMiTP3ragMom0zLfBQ=
X-Received: by 2002:a05:651c:506:b0:255:bc1f:80b5 with SMTP id
 o6-20020a05651c050600b00255bc1f80b5mr11152798ljp.391.1655714973639; Mon, 20
 Jun 2022 01:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220619151225.209029-1-tmaimon77@gmail.com> <20220619151225.209029-8-tmaimon77@gmail.com>
 <36b12f00-a7cb-9f94-d1c3-e04f7861b08e@linaro.org>
In-Reply-To: <36b12f00-a7cb-9f94-d1c3-e04f7861b08e@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 20 Jun 2022 11:49:22 +0300
Message-ID: <CAP6Zq1gaxdc6MHuVhQucr84GFtkO8c5k=fAmmJLHg9k8HiJ3pA@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] dt-bindings: reset: npcm: add GCR syscon property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, 20 Jun 2022 at 11:22, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/06/2022 17:12, Tomer Maimon wrote:
> > Describe syscon property that handles general control registers (GCR) in
> > Nuvoton BMC NPCM reset driver.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../devicetree/bindings/reset/nuvoton,npcm750-reset.yaml     | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> > index fa5e4ea6400e..7ba3a6ff82ed 100644
> > --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> > +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> > @@ -19,6 +19,9 @@ properties:
> >    '#reset-cells':
> >      const: 2
> >
> > +  nuvoton,sysgcr:
> > +    description: a phandle to access GCR registers.
>
> That's not valid. You miss here ref. My comment was to skip quotes and
> you removed entire ref.
Will add the ref next version.
>
> Best regards,
> Krzysztof

Best regards,

Tomer
