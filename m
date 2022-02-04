Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EDA4A94DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiBDIIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiBDIIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:08:14 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E43C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:08:14 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e8so9853485wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 00:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F1g4OTxFW0XMQzsgv95JcbZmhOfVmDYbCrlN2Y/w884=;
        b=OqhxBsujr0GLQ94fpAOgRSvHN6suDw97MDwnCJEI1rAYYfRSkMPjvKP6SOn+2jXbs/
         PSf7VhG0K/yW9Iz1d0AnLftnLSW+eVs0iv7Gqg/ksSiQogdfS1khZxFQGxb5MPeCss7g
         PUHQF59EW3/3gYC2S+BiTSNh23LhY/IOXO6F2NH9JgYx47IkCz+c3DQRLWrgx38hErKY
         M7aZKKgrwBE/9xpYO9ZvjRrNbOSlTHsSuuVyKouw8gm59+F2F1CA02p9a5iBtKj07aEi
         /CGAygeu4K7fYxH0JELpL8ioq+Nc43AMWM32oQIP3ofdJewJ3B5viAUzrBG4nOOVZApY
         XTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F1g4OTxFW0XMQzsgv95JcbZmhOfVmDYbCrlN2Y/w884=;
        b=ZVXjHFVR5206zVDEBnNrIX0QoN8nu2C69WgoqfceF2wTAgc8otzu8oKu8Xq4gdbpqb
         1Jc8uKpgORsY+be11eSQx7sM7DLCRGh558Vx+GuWJZY3wRNywtsuS2m6zU5qq4WsV+xk
         PUb1s4Mn5g0kkCvBUs2KE1BMzJWcYtB4pc6ttT3Dmrpe4HtudxzunhsNXJh8F5RsqYcG
         v8j6X4nr2CBj0dT1iIx6XOng7ZGGY+4n1QvkxXnNFCAYy2qpwkyD2KCXo876F2tqRvDi
         6neQ+UisASOMitgpxerf+2+w8QJrtCCzxC9nLz8RgGZkvh2Pr29vPCJuU7Q3hVIAbGNv
         5cQw==
X-Gm-Message-State: AOAM530NHWHh5wluvcGjehBtZMudOqT3z/Rd6BKom2+wmGnJcavC6wmN
        Fs54UwTTDsbULQJ77Oc8f3CLTQ==
X-Google-Smtp-Source: ABdhPJwxcYWYJrBDOz5mjR+skEcwR7oqY2SM/eZ6qDb/vOvdh3NGygqKqF5ku7DqOeqNP9ADWhJGFw==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr81645wro.411.1643962092739;
        Fri, 04 Feb 2022 00:08:12 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:e349:6e3c:93e:6c2c? ([2a01:e34:ed2f:f020:e349:6e3c:93e:6c2c])
        by smtp.googlemail.com with ESMTPSA id o14sm1284854wry.104.2022.02.04.00.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 00:08:11 -0800 (PST)
Message-ID: <59897307-042e-932e-6b02-257cabacaaa4@linaro.org>
Date:   Fri, 4 Feb 2022 09:08:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 RESEND 1/2] dt-bindings: Add DT bindings for the
 DT-based virtual sensor driver
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20220111103346.2660639-1-abailon@baylibre.com>
 <20220111103346.2660639-2-abailon@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220111103346.2660639-2-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 11:33, Alexandre Bailon wrote:
> This adds the DT bindings for the DT-based virtual sensor driver.
> This driver provides a way, using DT, to aggregate the temperature
> of multiple thermal zones and get some useful data from it.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---

[ ... ]

> +description: |
> +  The virtual thermal sensor device provides a way to aggregate the temperature
> +  from multiple thermal zones. Basically, this could be used to get the
> +  maximum, minimum or average temperature.
> +
> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +properties:
> +  compatible:
> +    const: virtual,thermal-sensor
> +
> +  aggregation-function:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Used to select the operations to perform on the sensors to get the virtual
> +      sensor temperature.
> +    enum:
> +      - VIRTUAL_THERMAL_SENSOR_MIN_VAL
> +      - VIRTUAL_THERMAL_SENSOR_MAX_VAL
> +      - VIRTUAL_THERMAL_SENSOR_AVG_VAL
> +
> +  thermal-sensors:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      The names of the thermal zone to aggregate.

IMO this is not correct. We are dealing with virtual sensor in order to 
aggregate a group of sensors in a thermal zone. But actually this 
description aggregates the thermal zones.

I recalled a detail about the binding from the old 'txt' format from [1].

"- thermal-sensors: A list of thermal sensor phandles and sensor specifier

    Type: list of phandles + sensor specifier used while monitoring the 
thermal zone."

This information was lost in the conversion to yaml with commit 
1202a442a31fd

In addition, the "coefficients" property tells the 'thermal-sensors' 
property can have multiple sensors.

So actually, the bindings should be fixed as part of the information was 
lost during of the txt -> yaml conversion.

And the multiple sensors per thermal zone could be implemented as that 
was something planned since a while.

I realize we initially asked to create a virtual sensor but that is not 
the most adequate ATM. Doing the multiple sensors support makes more 
sense to me, especially it does not require any extra binding except an 
attribute tell what kind of temperature aggregation we do. Defaulting to 
max should suffice when no aggregation method is set.

   -- Daniel

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/thermal/thermal.txt?h=v4.5#n147



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
