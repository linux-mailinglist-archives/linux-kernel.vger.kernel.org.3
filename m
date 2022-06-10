Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D546545E37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbiFJIKI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Jun 2022 04:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347141AbiFJIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:09:59 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B259BB3;
        Fri, 10 Jun 2022 01:09:57 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id a184so15838197qkg.5;
        Fri, 10 Jun 2022 01:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMvWBoJ3lf0+yvRO7v5FIYeENQCaUYUcamzcDsgiV+A=;
        b=tT9SiF60nx5E66OKnYPm8d+ZECZCZq2AM3hDNGCpCPdkz2C3lkoRMS8PbyKXQdfNDR
         U6GI9Ua7HLflzBr4raS1o+oNjR/MAaqlnmXVDX/hK3OHwgje0ZMGc94YKyFFDe1ccTBl
         1VOHo2pUrNo1M29aQD/kouE5Lp23Q4d/mQyTQZceNXBwt+LTfp1kNPSq2BorFr3Fflsa
         Vr9DJ3N3dp8y4p31j3AImqhIISz17pzeTWaM7PVlIsUt7oUQoD4upadc9vLnnWItUkdu
         UkXISOpAnnBoHdbuEOS9M9MmElaS+1XMV2BH2WEhM+92YNa5J2fs68WkyRY90HtqVO0p
         93xQ==
X-Gm-Message-State: AOAM531wG+pLdRDqxrm5Wo7gbjxKJ2OWtbkPjI1xXTdbEHcJ/zRjL6AN
        FQOjy2n9NugxJWpGTM6h95olZfQms+m9gQ==
X-Google-Smtp-Source: ABdhPJx5TLebrySpOgXAMezPm3AuyOEPQSSGbYRLGo5/TYZehTlxuyu5fVTo+DJKG3R5bDT1+9H2nA==
X-Received: by 2002:a05:620a:d83:b0:6a6:5fde:2325 with SMTP id q3-20020a05620a0d8300b006a65fde2325mr29603452qkl.407.1654848596579;
        Fri, 10 Jun 2022 01:09:56 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id u4-20020a05622a17c400b003051ba1f8bcsm939371qtk.15.2022.06.10.01.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 01:09:56 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-30c143c41e5so264767647b3.3;
        Fri, 10 Jun 2022 01:09:55 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr47131061ywa.47.1654848595616; Fri, 10
 Jun 2022 01:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220609194154.12829-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220609194154.12829-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Jun 2022 10:09:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXg3rC++RBp+aZM1Q_EkYyTxot-9LZnMfJFRz7cp0NLoQ@mail.gmail.com>
Message-ID: <CAMuHMdXg3rC++RBp+aZM1Q_EkYyTxot-9LZnMfJFRz7cp0NLoQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: thermal: rcar-gen3-thermal: Add r8a779f0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, Jun 9, 2022 at 10:04 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Add support for R-Car S4. The S4 IP differs a bit from its siblings in
> such way that it has 3 out of 4 TSC nodes for Linux and the interrupts
> are not routed to the INTC-AP but to the ECM.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v1:
>
> * Describe that this SoC does not require interrupts (Thanks, Geert!)
>
> I hope dtbs_check is happy now. I can't test it because I get tons of
> python install errors when trying to update my dtschema :(

Unfortunately not:

arch/arm64/boot/dts/renesas/r8a779f0-spider.dtb: thermal@e6198000:
reg: [[0, 3860430848, 0, 512], [0, 3860463616, 0, 512], [0,
3860496384, 0, 512]] is too short

> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> @@ -8,9 +8,10 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Renesas R-Car Gen3 Thermal Sensor
>
>  description:
> -  On R-Car Gen3 SoCs, the thermal sensor controllers (TSC) control the thermal
> -  sensors (THS) which are the analog circuits for measuring temperature (Tj)
> -  inside the LSI.
> +
> +  On most R-Car Gen3 and later SoCs, the thermal sensor controllers (TSC)
> +  control the thermal sensors (THS) which are the analog circuits for
> +  measuring temperature (Tj) inside the LSI.
>
>  maintainers:
>    - Niklas Söderlund <niklas.soderlund@ragnatech.se>
> @@ -27,6 +28,7 @@ properties:
>        - renesas,r8a77965-thermal # R-Car M3-N
>        - renesas,r8a77980-thermal # R-Car V3H
>        - renesas,r8a779a0-thermal # R-Car V3U
> +      - renesas,r8a779f0-thermal # R-Car S4
>
>    reg: true
>
> @@ -63,6 +65,7 @@ if:
>          contains:
>            enum:
>              - renesas,r8a779a0-thermal
> +            - renesas,r8a779f0-thermal

As this controls both the presence of interrupts and the number of regs.

>  then:
>    properties:
>      reg:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
