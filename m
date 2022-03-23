Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDB84E5515
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbiCWPXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiCWPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:23:35 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75229710CA;
        Wed, 23 Mar 2022 08:22:05 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a8so3510910ejc.8;
        Wed, 23 Mar 2022 08:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=4yRaJTJTJWC7egeZTEjtbpjIpIsJvGgOeze8pkExlkw=;
        b=weMJwevWL74GqexQcFHixi72twtwkmCzqzbOLTcYntIsQmGamXcgLHtY7F6U/y3F7u
         2xtxdT/wMuNiWdPtsmY/gpcoeIWxUKapaSm3Fh4SWuVZp63hsM73bu8t2GATr/nahIGY
         TgF5sDbqvuPXONe9a3VpZuHcs5aW6Zynumj1AC8DlCCg9h7GxSu+ZEehl6AGZHR6HhOh
         7s3Qv5wz3oAjCSYSc/yVLZZ5H4/6baKVklTO+6ShZ+8sCLUjvs49p+EQigNeqQ48Pcqn
         vG7muT9I3rUyb+s92c+VJ8p0vWajwXbPz6rhsKfSQsz2jHxQR/0Y1iRenFweQQJasBJd
         zEWg==
X-Gm-Message-State: AOAM5327ZNh3yWuP9aKHec/VHsD7ESp0Km8Y37i0G0ZbM1jp4rMyijEQ
        fBrVmSMoVVbXBiAChlVJOBE=
X-Google-Smtp-Source: ABdhPJxb9C5g3fqWHmMP2bawf1nNODS7AALIQ8bbXnF1MmkvBiQVxKxI3ZydkGxtuBE/i2RVGqEZNw==
X-Received: by 2002:a17:907:97c9:b0:6db:ab53:1fdf with SMTP id js9-20020a17090797c900b006dbab531fdfmr544178ejc.406.1648048923977;
        Wed, 23 Mar 2022 08:22:03 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm105423edj.49.2022.03.23.08.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 08:22:03 -0700 (PDT)
Message-ID: <3d3048d2-7233-5534-f9f6-285fabe2a10c@kernel.org>
Date:   Wed, 23 Mar 2022 16:22:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 4/7] ARM: dts: s5pv210: Remove spi-cs-high on panel in
 Aries
Content-Language: en-US
To:     Jonathan Bakker <xc-racer2@live.ca>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220323150311.26699-1-xc-racer2@live.ca>
 <CY4PR04MB0567F7814A3B72824E324702CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB0567F7814A3B72824E324702CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 16:03, Jonathan Bakker wrote:
> Since commit 766c6b63aa04 ("spi: fix client driver breakages when using
> GPIO descriptors"), the panel has been blank due to an inverted CS GPIO.
> In order to correct this, drop the spi-cs-high from the panel SPI device.
> 
> Fixes: 766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 

+CC stable please.

Such fixes should be either a separate patchset or put them first in the
series.

Best regards,
Krzysztof
