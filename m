Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1465357861E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiGRPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiGRPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB5A26AEA;
        Mon, 18 Jul 2022 08:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BABE5612DD;
        Mon, 18 Jul 2022 15:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F0CC341CF;
        Mon, 18 Jul 2022 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658157500;
        bh=fS3JIwyGns7i79HfYwRxvlzkJBx4UPKOk1rnz8gjF/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rE6MPaYA9jDQhhTfnFV8uE3F/TWVIiFe9JTPIQu6gwLyutvho1fG53u9Y1G0CdCLV
         gZyj1P2RQ+2ttJX1jraHEz4M0DNzWDL/7ZEdmtNY1+9Kj7JLTie7QrRQjULuSUzeA9
         Jp/wjXRpgNcPcPOiLI4d4Kr0qT0ZrUysWpjnkwKcejs6Fqj7C5k88mrsgDaVrQovT9
         NVsXv+DbZctv39K8Hl6I0Uka2Y4f6tPi/dzyiy2tmKBawiks9j3ZMwDk6WEarjnGn0
         J2Y61jiy1jBdbbZIFHKfhfR9q1sh6UySqu2WDM9Lyq6d1yjDH4ACsUXZBHKrMXZ4jI
         7S1CdcOEYzuWw==
Received: by mail-vk1-f170.google.com with SMTP id c185so4470602vkh.12;
        Mon, 18 Jul 2022 08:18:19 -0700 (PDT)
X-Gm-Message-State: AJIora/vO6x+Q5pW36wy0KRDlQSHcPhgmqFlZp59pDrPaQW0VrdqnIto
        LJ2UJH2+MeuuRNy3L2eEF5e055N2YU20oQksWw==
X-Google-Smtp-Source: AGRyM1tEjgdtAkSBzJAfryPxqYha/qC7WNu+ptkZfjRlYpx7O2eXyrTO4QciZlnhnDo9upOUQov+it/yDVLzU7bVIfs=
X-Received: by 2002:a1f:1ec8:0:b0:36c:643a:e985 with SMTP id
 e191-20020a1f1ec8000000b0036c643ae985mr9537772vke.14.1658157498917; Mon, 18
 Jul 2022 08:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220624111325.96478-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624111325.96478-1-krzysztof.kozlowski@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 Jul 2022 09:18:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHviWcynOu5AYJxtJ5xbQU6cU+r6tHy=ao+Wt4mE1aVQ@mail.gmail.com>
Message-ID: <CAL_JsqKHviWcynOu5AYJxtJ5xbQU6cU+r6tHy=ao+Wt4mE1aVQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: lp50xx: fix LED children names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 5:13 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The lp50xx LEDs expects to have single-color LED children with unit
> addresses.  This is required by the driver and provided by existing
> DTSes.  Fix the binding to match actual usage.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Fixes: dce1452301e7 ("dt: bindings: lp50xx: Introduce the lp50xx family of RGB drivers")
> ---
>  Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> index f12fe5b53f30..c274a10bbde6 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> @@ -65,8 +65,14 @@ patternProperties:
>            for the child node.  The LED modules can either be used stand alone
>            or grouped into a module bank.
>
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
>      patternProperties:
> -      "(^led-[0-9a-f]$|led)":
> +      "^led@[0-9a-f]+$":

Looks like you forgot to update the example. Now failing with
'unevaluatedProperties' fixed:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/leds/leds-lp50xx.example.dtb:
led-controller@14: multi-led@1: Unevaluated properties are not allowed
('led-0', 'led-1', 'led-2' were unexpected)
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/leds/leds-lp50xx.example.dtb:
led-controller@14: multi-led@2: Unevaluated properties are not allowed
('#size-cells', 'led-6', 'led-7', 'led-8' were unexpected)
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/leds/leds-lp50xx.example.dtb:
led-controller@14: multi-led@2:#size-cells:0:0: 0 was expected
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml

Rob
