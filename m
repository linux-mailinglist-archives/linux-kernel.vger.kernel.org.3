Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2FC4EBBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbiC3HWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbiC3HWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:22:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF6C74B7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:20:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o10so39678805ejd.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nKyHhk1aCz3J+2WnVPDV/+yanuQHnJSxGVVBQGJ8Rs0=;
        b=NCO6etGLHHH6X38b34SknmLRrdfqnVMnkOiwd6ElkxYMj0ZtzGitFZAWeAEUC+RiKL
         Y5VUnHoGBWI499BseoXn4wlzJ+AG2OFx0p4ToGNPiz3mBOQK/oasn2YUB/XI1PtGU265
         qO35Ck89razjDnmf0jUqCDsEP4/G+KzYN8cbC2eI4q0GiL+CIb9kniGAetaS0FiOB/TY
         uiRhVN7zE7sEtBMYF5v1q3JEEhCadWwAqzbjNP/O+yjiOL5AH+6R3me/+7my60Gee0kr
         5Lzq9RafruSougdsQXGFaDGiZ9sunNDowIDXiMaZH7t5kCw3JhG0z7AeH5bo1M2rE3wh
         SbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nKyHhk1aCz3J+2WnVPDV/+yanuQHnJSxGVVBQGJ8Rs0=;
        b=e8cb8YYe8HAIlrGcyrW3ZDARrtgg819guN8vIkBqHw5VN3Sv5kLDHhDNZEAw5eYxiQ
         ZbSJ+oES9i4JOaLC7X49Y9vGRzUAxtLKwXSl4z0fGjuFXxG1ca916ocZ+fYyTXpFGbNj
         nBKm68LAacRO8FFCmMicrzneE4CvUabXk6xZ48DejEyzi5kUTfA9ztfb0Pr2EGxFNqFQ
         6ckPPgI6sIZ8Q6mKNXgko27kt0q1G0we20JqyLn3LmpQ72VHP0oZMy5MZTYK1L9Ll7gy
         6lbVmbLqO8FPkTrDiecVFrMNlvugPkceUJQpdd2HNjoM+DpDh8YVOnH8fqGGavat9wt1
         XyYg==
X-Gm-Message-State: AOAM531flQ3+3ClaqXYMPRMDO1iYohClVsd9+HWMKubl4U5J9VUxXytf
        G4nnybN2KhUs/UXvudnSvZF7Cg==
X-Google-Smtp-Source: ABdhPJwFtTZFPPpNR5frMHkyY3jbV3DBMwyHz0XMeIyP61bIXNX5XnuJ+DaCpjWN14Z9IW8C3GcYJw==
X-Received: by 2002:a17:907:da6:b0:6e0:c59:f3ad with SMTP id go38-20020a1709070da600b006e00c59f3admr38699777ejc.85.1648624844736;
        Wed, 30 Mar 2022 00:20:44 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bm5-20020a170906c04500b006ce6f8892a5sm7862579ejb.7.2022.03.30.00.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 00:20:44 -0700 (PDT)
Message-ID: <ad213f38-f0a2-6420-cfa0-a9ba7cb362d5@linaro.org>
Date:   Wed, 30 Mar 2022 09:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        huziji@marvell.com, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220329220544.2132135-1-chris.packham@alliedtelesis.co.nz>
 <20220329220544.2132135-3-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329220544.2132135-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 00:05, Chris Packham wrote:
> Convert the marvell,xenon-sdhci binding to JSON schema. Currently the
> in-tree dts files don't validate because they use sdhci@ instead of mmc@
> as required by the generic mmc-controller schema.
> 
> The compatible "marvell,sdhci-xenon" was not documented in the old
> binding but it accompanies the of "marvell,armada-3700-sdhci" in the
> armada-37xx SoC dtsi so this combination is added to the new binding
> document.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> 
> Notes:
>     Changes in v5:
>     - Fix silly error in examples
>     Changes in v4:
>     - Add review from Krzysztof
>     - Squash in addition of marvell,sdhci-xenon with an explanation in the
>       commit message
>     Changes in v3:
>     - Don't accept ap807 without ap806
>     - Add ref: string for pad-type
>     Changes in v2:
>     - Update MAINTAINERS entry
>     - Incorporate feedback from Krzysztof
> 
>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 275 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 276 insertions(+), 174 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
