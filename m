Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618BF4BA497
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbiBQPkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:40:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiBQPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:40:19 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993C2B2E2B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:40:03 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id o6so13947ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKaf8T6bwo43/+sxm31m52Fuq6JfePQe5wLfdK/sZ50=;
        b=KPzAxecZid6LlUo+0wXILBlFXqEIIMlQhrTqEj6z4UqIp9jIQF/gbYiCxGu81gLFpJ
         /pIGlLeDUvdHwupl4nghICsruLArh0hORXmoOtKaH6HpqNuBvjs+4ihA3oAWbqhEwkDd
         T5ThBdpMxq1FEOb1fMDz2mAoWunpfky3vnZyTBNmJjqtuwuMvexR2rTKaztVVD9Y7mFT
         pSkdWAYemi7Dg2p/PAZ6kUQyJizRwmSoZPO3SN8oNgMcOWtjdFb59gSvTJlmKxV3ebyO
         swvV57on6z9k7ex4uQZNZiEhi7wpsexsYfo+YGjAX6eu4VmlQXo9PvDl66YhEpV8QHuQ
         vYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKaf8T6bwo43/+sxm31m52Fuq6JfePQe5wLfdK/sZ50=;
        b=ya04x53lv2hr6asoadGglihuWcKrMkLQ+CrxY6Uu+0JDJT+OUPTim9ovx87zOY83Ml
         8qtOu4BaGfX07T5isVXBKA2ntsyWLvxVDqQ1BzEx+3nFaj3yFSfQrJUV+1cvfGkk9rZ3
         lCdFPGRABrRgdgr0AHIebFIiQK41zIM/8E6LLN9+vMX58zOezsBS1g1SRg7EZJjYnPYz
         KZVGEOO5y1bNR1Z7+n8dnM6ZPVnjE/nkyg/bq9NV6Eu50wkQR993QsiUaoW6XjwfFLPE
         XFLi9tNDOAaoIM6iSn6zMNGX2X4ipv9vmvt0kkqy9u3e7dUrvc14TkguIiNonZDq1FGM
         tEeg==
X-Gm-Message-State: AOAM532I71Pj6nYnL9M9ohpR825CBvdBSiZD4P4q04Ulex/aGS6AVfB4
        oCPICwY8ixViNnuVEn/vrLlt41g4EZLG+Si1w7ipBQ==
X-Google-Smtp-Source: ABdhPJy3TfM6nshThKhOgFc73bYv1Dg2ra93FL9Fw7hGDmnU8ExqI9gSmyeqSR0lzf7QncPN+wOHbziKZqL/5WQjZ/s=
X-Received: by 2002:a05:651c:50f:b0:239:3332:2a1e with SMTP id
 o15-20020a05651c050f00b0023933322a1emr2636574ljp.16.1645112401967; Thu, 17
 Feb 2022 07:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20220216134346.11029-1-a-govindraju@ti.com>
In-Reply-To: <20220216134346.11029-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:39:25 +0100
Message-ID: <CAPDyKFqORZ-8aGQvfm8bSVLUzDGK-wWDRr+ABFLpH0q+D92EYg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Add compatible string for
 AM62 SoC
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 14:43, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Add compatible string for AM62 SoC in device tree binding of AM654
> SDHCI module as the same IP is used.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 9fbf16b3bc8d..0566493c4def 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -21,6 +21,7 @@ properties:
>        - const: ti,j721e-sdhci-4bit
>        - const: ti,am64-sdhci-8bit
>        - const: ti,am64-sdhci-4bit
> +      - const: ti,am62-sdhci
>        - items:
>            - const: ti,j7200-sdhci-8bit
>            - const: ti,j721e-sdhci-8bit
> --
> 2.17.1
>
