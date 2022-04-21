Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D25509F68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383237AbiDUMOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiDUMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:13:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485852ED69
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:11:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g19so8357527lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qh1sP8uzQryeVgDtsc75uouxg8rbCQSDajPwRRmCQo=;
        b=Z0INWc9lxyV6HU2uh2mPeBqK0yli23uZv/u24ByX5vg6Pu4bhQ7AzrEPCeUdwAodwC
         pC+3TIzpU57+5m5qC3ebKzY93Rycc2+gHYqhtruCTqoWutODQzVzIEOhd2YfqeK6yqIF
         Xu6b4XHkcJ32Hm1srnlpzDf1g2t+aZDF2WSNHDuPjSJZbdfU1LuzRzn0LYl8gaxoraZ/
         gVFgo5J3mpWveMo2GKV02uNZfN3GI7ia3OBZjgXqrR8oRDkqaHkPNZ/XW+zCLqPWsFg9
         Wz/2JXeM+6hz5hvpyqD6hZJqcc7QVRa76tne8gXABci2GCSjRBFoRffN6oTU6BDV/wBP
         dmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qh1sP8uzQryeVgDtsc75uouxg8rbCQSDajPwRRmCQo=;
        b=PS9iV0RtpEp34tRwRF1lULX13Qk/e1bGSnSEnve4kXwo0aSqsQtQb2WJOd2hBYw/Za
         /7tjSR8X+poke5xjD0mSV0r4C9fxBJDzoDC4xdNbH+nLQLO3poH0f0ihJ8FRodzB11Az
         Tz8jChj3uYoNBI4e0pmukyL0c7gJQYE+043qzcLmZbIsGE46BpKJZBfQNyU4I9B64mTa
         E8ieKMnx+cPT1h7OWNBNwUVIMxPfV49c/0TPr8BVVGrfPSX3mPeiaXpvVzM/RG/N3ePR
         W7SbsCcpwUSu975+fla32QuTIoCjZ2iDsM/dInup4C6SuBNBM5RTuBr+4sL6s9K7BAwt
         cM4w==
X-Gm-Message-State: AOAM533+ji+DiiIpBUV3haIeeGCXozX9SvuA4CcJe7M3yH1f6sBgVWJP
        IXylxlbumYNJwv1rreKX5hHOWE9BaJezsD1Q2cd3vA==
X-Google-Smtp-Source: ABdhPJxiF6HE3qtyySBVgBeLZFZb4229Fdfv3WYeASID+W6jtiE1O7ThlV69sO3NVsaNvqCnkYIoYFyNgU7zcMkUyh0=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr19385452lfr.233.1650543063540; Thu, 21
 Apr 2022 05:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220418102040.4993-1-a-govindraju@ti.com> <20220418102040.4993-2-a-govindraju@ti.com>
In-Reply-To: <20220418102040.4993-2-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 14:10:27 +0200
Message-ID: <CAPDyKFrHi3-7FMfwRP5rtjSbTOnw73FvU5ZAz=eC8-XqQZYpsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-am654: Add flag to force
 setting to TESTCD bit
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 at 12:21, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> The ARASAN MMC controller on Keystone 3 class of devices needs the SDCD
> line to be connected for proper functioning. Similar to the issue pointed
> out in sdhci-of-arasan.c driver, commit 3794c542641f ("mmc:
> sdhci-of-arasan: Set controller to test mode when no CD bit").
>
> In cases where SDCD line is not connected, driver support has been added to
> force the controller into test mode and set the TESTCD bit. In order to
> implement this quirk the driver uses "ti,fails-without-test-cd" flag from
> the device tree node. Therefore, update the bindings to document the above.

Would you mind rephrasing this a bit. DT bindings is about describing
the HW, not about what the software should do.

Otherwise, this looks good to me.

Kind regards
Uffe

>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 0566493c4def..0ab07759b472 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -186,6 +186,13 @@ properties:
>      description: Clock Delay Buffer Select
>      $ref: "/schemas/types.yaml#/definitions/uint32"
>
> +  ti,fails-without-test-cd:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      When present, indicates that the CD line is not connected
> +      and the controller is required to be forced into Test mode
> +      to set the TESTCD bit.
> +
>  required:
>    - compatible
>    - reg
> --
> 2.17.1
>
