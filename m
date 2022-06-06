Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9463553EA51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiFFKLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiFFKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:09:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C566B8E1A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:07:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so9733838wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nOdX0D6gI2vCvbiULKuWgUb1+R1FUwAgBHWxoQ6Py84=;
        b=guyZnUPLasgYuxVbgLOK9dpahGdVKH4NsfUbmPs/vb7FJJJj68IShyjYpn6sZyZJ0e
         CJdMAENAxn4qYtdlkc9UXXnKyWJ0t1E3R7GYaFgTI8PaZmxcYOBGZZpcF2iw+WH7DmKg
         mM8Y5sbIZlSXK/Nn0DOTfrI6HZxdAr4CgZW4PoiOnDDm154XAmGP+Tu90lnYsztVMii9
         yGfhkljKx2jZ5+vxx0gkfBCjjbnG7A8Q5RVv4SDu4TtIRvik3u2R4lhOwM+zBkmkcc7G
         oU/nrIgSUmiE5VechEJ/ececXdGNuWy96/NAMSHHO02pjOLPr21N2OpuCmZ7X0tDhz/8
         YOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nOdX0D6gI2vCvbiULKuWgUb1+R1FUwAgBHWxoQ6Py84=;
        b=0skuNAihwNZEjp9+waOMXfLnG0iaYJNQO8P5+w54IzWpzTafcjXE0rshOPP36E2AVJ
         enXsrc0+yMKPeTtGDcXNtJ2QgSKO5qOnBdSxu4pai9fbcfzEAqyN/kUj/rECfQ6d9fPV
         6SzR+PquQ+pE9/b1jMN9zBc9TXhMi7NWW6mdGD88LfOzCdekYI23+zO07K2WyzroALBO
         huEX/sh1a6uJQH0kC0xL+QH/7Xz5U+dYVE4ANpl3sUCJMM8gGZjWRE8L0gmsZQ29jz5R
         FO+o5BaExuy2i6VKlZO0m01tQv6XHboL4/RNWXfAwFbH9e5bvjB3KZ8+RKolUWZRyQJt
         nAaA==
X-Gm-Message-State: AOAM531lgBw5s3R4c+e7yIiVtszNl8L0BUrj0PDVnj9osZX/GcB0Lzlm
        DBcYhopz4w9FXDELUWnZpAqEsg==
X-Google-Smtp-Source: ABdhPJy4egwo2K5fCw/QlI1TFJAwj0Zsy/iIpzW5zgtq0cHrBtthrjUvAfu4jigGx7vmLovqd/wOfQ==
X-Received: by 2002:a05:600c:35d4:b0:39a:5b65:2b66 with SMTP id r20-20020a05600c35d400b0039a5b652b66mr41825733wmq.112.1654510061622;
        Mon, 06 Jun 2022 03:07:41 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id h13-20020a05600c2cad00b00397623ff335sm18510131wmc.10.2022.06.06.03.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 03:07:40 -0700 (PDT)
Message-ID: <090a5802-d2de-682f-4f12-f7a475ee9339@linaro.org>
Date:   Mon, 6 Jun 2022 11:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 0/2] nvmem: add Microchip OTP controller
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220518115129.908787-1-claudiu.beznea@microchip.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220518115129.908787-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2022 12:51, Claudiu Beznea wrote:
> Hi,
> 
> This series adds support for Microchip OTP controller available on
> SAMA7G5. The driver gives access to a non-volatile memory which
> keeps (at the moment) information like booting media and temperature
> calibration data used for thermal measurements.
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v3:
> - fixed Documentation and binding files names
> - used __maybe_unused for mchp_otpc_ids
> 
> Changes in v2:
> - updated the bindings (patch 1/2) as follows:
> 	- included the device name in files names and updated binding
> 	  content accordingly
> 	- updated the description
> 	- removed address-cells, size-cells
> 	- removed clock include
> 	- use GPL-2.0 OR BSD-2-Clause license
> 	- removed OTP_PKT_SAMA7G5_TEMP_CALIB_LEN and keep hardcoded
> 	  value in examples
> 	
> - updated MAINTAINERS file with new naming of bindings
> 
> Claudiu Beznea (2):
>    dt-bindings: microchip-otpc: document Microchip OTPC
>    nvmem: microchip-otpc: add support

Applied thanks,

--srini
> 
>   .../nvmem/microchip,sama7g5-otpc.yaml         |  50 +++
>   MAINTAINERS                                   |   8 +
>   drivers/nvmem/Kconfig                         |   7 +
>   drivers/nvmem/Makefile                        |   2 +
>   drivers/nvmem/microchip-otpc.c                | 288 ++++++++++++++++++
>   .../nvmem/microchip,sama7g5-otpc.h            |  12 +
>   6 files changed, 367 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
>   create mode 100644 drivers/nvmem/microchip-otpc.c
>   create mode 040000 include/dt-bindings/nvmem
>   create mode 100644 include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
> 
