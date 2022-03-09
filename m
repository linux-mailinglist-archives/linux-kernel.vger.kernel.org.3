Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2C14D2C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiCIJfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiCIJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:35:31 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940B17004B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:34:32 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9831A3F1FC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646818469;
        bh=S6D+Jxwx9oQJfCitKNvGiSNhxjD326sJadhtw3SVqMU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=LSDoZue8+Xj9wg7iTc7Kl1u1lDqalkcZ0lRypsv1N6OH/QljMx/m8/UncUMCr657c
         fQf3g3H6DPkqw3U75/dX3mL5hU/SpVVDn7MOiN+coAyk1eWr4aIh9Jxat3iWHLjqZV
         ZOSItpOvVWanddPdPQwmh2Bw+XDLsocQrDLycTvEy82b0yM8OnSRxwzDvdn2fENt8y
         kCRUgOd2ca/m7fi3w5k+kf0jkGMqZrCBce9Ni4Hh6G5/OclKsZjtszetrogjbqroS4
         GWNymMKzB7DmOl9R+vnNI0Kgq0vEkIElKkd8lhNBmvT11cFryeXc/Xg0gcDJo6f7pS
         RmXgc9wMFGkbg==
Received: by mail-ej1-f69.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso985627ejs.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S6D+Jxwx9oQJfCitKNvGiSNhxjD326sJadhtw3SVqMU=;
        b=Zl2J1drCZ37RJX9VWezQu3tu4NHkCqzBeqIxRKelA3YSde5Jf1vupk1AuoXqDHPOTb
         54/bDNT0W9fmDnPuj633KFmaQqkpMUeXvswFNmGFZ1vDHuHl6xOY2YccQJrgrsRhFsgv
         zEQYxr/lmp/fEEJzmXmR4sM3zQAn44IWumJWaFYtcyqqXJfGTzX5JrJRDpSK6yuwL6SC
         nn8y2rSR2soAnkFmApkP/CbwzxqN0HLp+Tq+VoAzSKurmmsmAYUPeBLThnjl8NK7Cp/i
         dNYAtXp7H+U7cdb9tF/fTmTCUer75dVacDSH4bVy7nmRyUNuh+mFA0reVLu2dmhyTRBN
         jUaA==
X-Gm-Message-State: AOAM531L1B2KdzJrf+zjHY3S+GR7H7YP0zvgdCcF843UbLhHCwQQgmNb
        fqxEodsft7Ib5NXZfik7hnkYsH4AMEwMrjfdpQOdY2OFF7oCzQcgP1Dwi4wKvJIUzfb3mi5ZyaU
        /NvBBfqBz6rWfDNbG2s/jO/9IK0EsaMaWq1cSjtOMwQ==
X-Received: by 2002:a17:907:7815:b0:6ce:5242:1280 with SMTP id la21-20020a170907781500b006ce52421280mr16604629ejc.217.1646818469156;
        Wed, 09 Mar 2022 01:34:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJBwFDEI5sp3k042uTjXHZy93eWqTa5ABGASxo2gwT/EKB/jU2Sf2/c7jQShucPz75BXludA==
X-Received: by 2002:a17:907:7815:b0:6ce:5242:1280 with SMTP id la21-20020a170907781500b006ce52421280mr16604610ejc.217.1646818468954;
        Wed, 09 Mar 2022 01:34:28 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id er12-20020a056402448c00b00413d03ac4a2sm520468edb.69.2022.03.09.01.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 01:34:28 -0800 (PST)
Message-ID: <bfec6388-bb84-f053-18b3-a0ef556b5f97@canonical.com>
Date:   Wed, 9 Mar 2022 10:34:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 01/15] dt-bindings: devfreq: rk3399_dmc: Convert to
 YAML
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20220308190901.3144566-1-briannorris@chromium.org>
 <20220308110825.v4.1.I875ab8f28c5155a7d2f103316191954d4b07ac13@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220308110825.v4.1.I875ab8f28c5155a7d2f103316191954d4b07ac13@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 20:08, Brian Norris wrote:
> I want to add, deprecate, and bugfix some properties, as well as add the
> first users. This is easier with a proper schema.
> 
> The transformation is mostly straightforward, plus a few notable tweaks:
> 
>  * Renamed rockchip,dram_speed_bin to rockchip,ddr3_speed_bin. The
>    driver code and the example matched, but the description was
>    different. I went with the implementation. Note that this property is
>    also slated for deprecation/deletion in the subsequent patches.
> 
>  * Drop upthreshold and downdifferential properties from the example.
>    These were undocumented (so, wouldn't pass validation), but were
>    representing software properties (governor tweaks). I drop them from
>    the driver in subsequent patches.
> 
>  * Rename clock from pclk_ddr_mon to dmc_clk. The driver, DT example,
>    and all downstream users matched -- the binding definition was the
>    exception. Anyway, "dmc_clk" is a more appropriately generic name.
> 
>  * Choose a better filename and location (this is a memory controller).
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> Changes in v4:
>  * Update .yaml to use more "default" entries, instead of free-form text
>  * s/phandle-array/phandle/
>  * Move to .../memory-controllers, update filename
> 
> Changes in v3:
>  * Add |maxItems| for devfreq-events
>  * Improve deprecation notes
> 
> Changes in v2:
>  * rename to 'memory-controller' in example
>  * place 'required' after properties
>  * drop superluous free-form references and repetitions of other
>    bindings
>  * fix for yamllint
> 
>  .../bindings/devfreq/rk3399_dmc.txt           | 212 ------------
>  .../rockchip,rk3399-dmc.yaml                  | 306 ++++++++++++++++++
>  2 files changed, 306 insertions(+), 212 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
