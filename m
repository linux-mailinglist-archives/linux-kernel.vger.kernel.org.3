Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8774E5435
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiCWO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiCWO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:28:15 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B38DF2C;
        Wed, 23 Mar 2022 07:26:44 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id t7so1234978qta.10;
        Wed, 23 Mar 2022 07:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgaVbTc6NIAbgS2wEZfzTz0EIf+0SLB19R8ha1w5Zmc=;
        b=6yh7OkIoFpKFL3aPJ7SSm/F4hrHx85q6Ka0r12r0MXCDIuKsUseKrtkxutPWaOBqFR
         DsWng2xiiJYyaQuFoKxrWH/gZtgpZXuEyj01WrK0XuLQcWyChNzW5KbKPyBca37a+i8d
         Mxc40PYPJXFpaHz46kIHmtEEiFLwO+URSI1aBIB9PjMVKxompgXlBsd6XhwKxrUHZfnJ
         84QOYmLQo6FE8XiHp4qedljX5H2HGCGDzJ2lk/5XSOLzgKoG2cqIQlbu4ErJO/X7qG/u
         yNjFmsOwd+OowWNLgVHTL9hLFyFOSVcBPnToBZJP/YRb/VIq/KmTErDqWKDx/pixMIGU
         XAqQ==
X-Gm-Message-State: AOAM533tbJpw0/aOGCa5UG78a9EZUN8hpq3xlmtzzQCl+J2jFkkRYEWE
        yKJRwP8gmpXcFHHLlPA9CZOlNAhT1k0rqquj
X-Google-Smtp-Source: ABdhPJzPnzoyNIrd1y1A1+ahUJOehAFamtMkh/kPgcBS1SG4dLj9mcGF3yn2if79yS8zlNzQ6JvmxQ==
X-Received: by 2002:ac8:57ca:0:b0:2e2:131b:6f0e with SMTP id w10-20020ac857ca000000b002e2131b6f0emr11994094qta.664.1648045602739;
        Wed, 23 Mar 2022 07:26:42 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id b21-20020a05620a04f500b0067b4895472esm75201qkh.5.2022.03.23.07.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 07:26:42 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id z8so2989358ybh.7;
        Wed, 23 Mar 2022 07:26:42 -0700 (PDT)
X-Received: by 2002:a5b:a8f:0:b0:633:fd57:f587 with SMTP id
 h15-20020a5b0a8f000000b00633fd57f587mr190730ybq.506.1648045601981; Wed, 23
 Mar 2022 07:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220301190400.1644150-1-robh@kernel.org> <CAMuHMdXqsvQy_6+6w8DVCtqNiFERPV29xd3HRqtyz9RY3KXOYw@mail.gmail.com>
 <CAL_JsqKX7XrSS1OktT6OfPgyxte6_+AcGh4uV0Abdf2Wi4eCFg@mail.gmail.com>
 <CAMuHMdXzNpjSjhT3crdN3XzcFNXd8Uojqo8gA7Y=Qtz8utH6Mw@mail.gmail.com> <CAL_Jsq+=2oibXA1otjaVoGY0GWdLZg2bmw1C9BACga5P99X35A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+=2oibXA1otjaVoGY0GWdLZg2bmw1C9BACga5P99X35A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Mar 2022 15:26:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHUqCccnUa2WaAm=7s8EcumwJoZ22Wyy1=hosOu1kVuQ@mail.gmail.com>
Message-ID: <CAMuHMdUHUqCccnUa2WaAm=7s8EcumwJoZ22Wyy1=hosOu1kVuQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: renesas: Make example 'clocks' parsable
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Rob,

On Wed, Mar 23, 2022 at 3:07 PM Rob Herring <robh@kernel.org> wrote:
> On Tue, Mar 8, 2022 at 3:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Mar 4, 2022 at 2:28 PM Rob Herring <robh@kernel.org> wrote:
> > > On Fri, Mar 4, 2022 at 3:09 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, Mar 1, 2022 at 8:04 PM Rob Herring <robh@kernel.org> wrote:
> > > > > 'clocks' in the example is not parsable with the 0 phandle value
> > > > > because the number of #clock-cells is unknown in the previous entry.
> > > > > Solve this by adding the clock provider node. Only 'cpg_clocks' is
> > > > > needed as the examples are built with fixups which can be used to
> > > > > identify phandles.
> > > > >
> > > > > This is in preparation to support schema validation on .dtb files.
> > > > >
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > Do you want me to queue this in renesas-clk-for-v5.19, or do you
> > > > want to take it yourself, together with the validation patches?
> > > > Please let me know.
> > >
> > > You can take it.
> >
> > Thanks, queuing in renesas-clk-for-v5.19.
>
> This needs to go in 5.18, not 5.19.

Mike/Stephen: can you please take this directly?
Thanks!

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
