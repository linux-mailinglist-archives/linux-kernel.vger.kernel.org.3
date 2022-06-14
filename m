Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720F54AA80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354556AbiFNHYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354497AbiFNHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:24:09 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0E23CFF8;
        Tue, 14 Jun 2022 00:24:03 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id k18so5516945qtm.9;
        Tue, 14 Jun 2022 00:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiAvQvUwNZC8349lDrXjWRNqtecYyT5lBSmoXU6X950=;
        b=W+nw622mbQ+PV9ugfcczqXjFEO19ZF0XPDHLa2tusPuSCzZRhImFAwQiwH5sjsuidK
         hT7EyfSAYE8gtihwwAqpZJp2drJs1GcFXrRXj+xitEuqPUMeZvQM8WTO83aTiqlZmwlD
         1dl8+25j2SqHapv7ZVzdKNzpHL2JAtEmnX8W2GP1Rq/pxML3T+Hnlme7B6ptaK2Q1PMo
         Pou7KUxXeRzRO1FeRoYISppdeA5tjKzRgPuiDcTIEihLA7P+tKIVtpROlpeMt8tccWYJ
         7EX3mOWTic4h9QolmIiXsLmZmNECTjQ6eeBeF+A6EAMAQibRhT0FSwLBm90QxgrORh17
         nL7g==
X-Gm-Message-State: AOAM530m7NL+fuANYG8u0zApUZgDwulCp2j5ahJL0WDvcmnDPcjXpyjS
        7vCMcQ69ptUjJ0dYhoKT4e3U96CMnIPC+w==
X-Google-Smtp-Source: ABdhPJzpx3QkJ7zKQfbk0OAzcjnvqNauK0gsSzML3rnackjnVpf702Ju3X4RaZ0YAqWa2YrSd+L8Ow==
X-Received: by 2002:a05:622a:44c:b0:304:e4a2:3db7 with SMTP id o12-20020a05622a044c00b00304e4a23db7mr2992925qtx.162.1655191442195;
        Tue, 14 Jun 2022 00:24:02 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a24c400b006a098381abcsm8705486qkn.114.2022.06.14.00.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 00:24:01 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3137eb64b67so20291157b3.12;
        Tue, 14 Jun 2022 00:24:01 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr4090852ywa.47.1655191441536; Tue, 14
 Jun 2022 00:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <20220609150851.23084-2-max.oss.09@gmail.com>
In-Reply-To: <20220609150851.23084-2-max.oss.09@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jun 2022 09:23:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWm5WV7L=HJnysw76ObG_QPWicSH1kGg4k-GL8nNHd_SQ@mail.gmail.com>
Message-ID: <CAMuHMdWm5WV7L=HJnysw76ObG_QPWicSH1kGg4k-GL8nNHd_SQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: power: Add bindings for a power
 domain controlled by a regulator
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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

Hi Max,

On Thu, Jun 9, 2022 at 5:16 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> Adds binding for a power domain provider which uses a regulator to control
> the power domain.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/regulator-power-domain.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/regulator-power-domain.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Power domain controlled by a regulator
> +
> +maintainers:
> +  - Max Krummenacher <max.krummenacher@toradex.com>
> +
> +description: |+
> +  Power domain provider which uses a regulator to control
> +  the power domain.
> +
> +allOf:
> +  - $ref: "power-domain.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - regulator-pm-pd
> +
> +  power-supply:
> +    description: The regulator used to control the power domain.

I guess there can be more than one?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
