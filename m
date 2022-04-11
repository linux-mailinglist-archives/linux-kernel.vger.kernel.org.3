Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12854FB725
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiDKJQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiDKJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:16:51 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7D312759;
        Mon, 11 Apr 2022 02:14:37 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id 10so15672309qtz.11;
        Mon, 11 Apr 2022 02:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1A09GWjhbeERq4BfjM2T1+KKpyEI7+/x9EtzCaW3UdQ=;
        b=51O6B8zX3oRWwEDRtLKMhMHVmiRvpXcuafUSYr66fYz3YpA1nmbl98mu5YvQcqoFc5
         CnXqIweRrTQn1PZZ8i2z1xE6u7pzLp4BNzk/qhmAYhC8/QkjHNfFeHAfGlRYaFKkQU8/
         o4roKQPKDMThIPdzv4dzyqdMIy8k3t3zu8l5VOMpKQwcmKTjAFjmndv1R9jns8xIrQKG
         h2twv5gy5r41qswTispPaGBfU6/4OAfvqIdWaZMAAOz13/rojeEcPiAJF6hFv5+xpKVP
         nMujpjsXpIBBRw3css1OwNWhKFkIs0a9RpcmGI7xs2hACnzz70/7oLbZyhgxwIgqKPfh
         BNfg==
X-Gm-Message-State: AOAM533dhzdTDpJB0ZPxiwuLQ9TbFjl7mcnkVNtG4JfcjuYmV56TMNO5
        YZlnBA09w9QZOf2/rkQrv2PSor1uzcQZRQ==
X-Google-Smtp-Source: ABdhPJz93Swv1VzUHOXCVA3JYyMm5K3cGJvRv28UmpZVX05z6QH+aiIODJb4oG9mHTpjh83UFbY/Rg==
X-Received: by 2002:ac8:674c:0:b0:2eb:dd80:6442 with SMTP id n12-20020ac8674c000000b002ebdd806442mr13538941qtp.458.1649668477010;
        Mon, 11 Apr 2022 02:14:37 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id bp40-20020a05622a1ba800b002ed0e8e7e03sm6469430qtb.66.2022.04.11.02.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 02:14:36 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ebf3746f87so62698117b3.6;
        Mon, 11 Apr 2022 02:14:36 -0700 (PDT)
X-Received: by 2002:a81:3d81:0:b0:2eb:8069:5132 with SMTP id
 k123-20020a813d81000000b002eb80695132mr25080083ywa.438.1649668476257; Mon, 11
 Apr 2022 02:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220407193542.17230-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407193542.17230-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 11:14:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXLiTKDpXydKQh-fmyHOHb8WpCe9oetNrs2GGNGZqRCg@mail.gmail.com>
Message-ID: <CAMuHMdWXLiTKDpXydKQh-fmyHOHb8WpCe9oetNrs2GGNGZqRCg@mail.gmail.com>
Subject: Re: [RESEND PATCH] dt-bindings: power: renesas,rcar-sysc: drop
 useless consumer example
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Apr 7, 2022 at 9:35 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Consumer examples in the bindings of resource providers are trivial,
> useless and duplication of code.  Remove the example code for consumer.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch, which is now commit 981a340540381532
("dt-bindings: power: renesas,rcar-sysc: drop useless consumer
example") in dt-rh/for-next.

> --- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> +++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> @@ -10,9 +10,11 @@ maintainers:
>    - Geert Uytterhoeven <geert+renesas@glider.be>
>    - Magnus Damm <magnus.damm@gmail.com>
>
> -description:
> +description: |
>    The R-Car (RZ/G) System Controller provides power management for the CPU
>    cores and various coprocessors.
> +  The power domain IDs for consumers are defined in header files::
> +  include.dt-bindings/power/r8*-sysc.h

include/dt-bindings/power/r8*-sysc.h?

Or does the period have a special meaning here?

>
>  properties:
>    compatible:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
