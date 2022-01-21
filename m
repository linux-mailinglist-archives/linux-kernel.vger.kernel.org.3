Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2A496078
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380962AbiAUOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350747AbiAUOI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:08:27 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B29C061574;
        Fri, 21 Jan 2022 06:08:27 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id v8-20020a9d6048000000b005960952c694so11872494otj.12;
        Fri, 21 Jan 2022 06:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LoaGohGGL9r6RCSTBBZR21QKRe1IVFLPVcbUAfgKqH4=;
        b=Vx0qOUrDVlsl4z3fZYnN3dVtU48K9pui2wZT2pVvyIGCnA+aIOVPLNFrRgw5rfTFEK
         xZ9NzQRAlswqnfPZhl1XJgvhiwbr5aX3ufj8Tbn5gtNZt7WVOAP4POWW+XjSmQJObEx2
         +uiMxpiiTaQSj9wiX+8B65g9F1PMJgyXgTsVv8IRVkv3k8ZoXQCrXA6yWnAGae61Kv0y
         on/FS3i5dikSUUP+S8Jjof07VCPMiR+r2xZr1bCIyCxhm4aNRvl95/sBB812txL3+kqx
         TUPSQui2+Oj7+bKXZcq0zn4FjnGYnYGC01/dSUPxdbcAi0UCp3wM7smkFZCrR+e6H68R
         Pfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LoaGohGGL9r6RCSTBBZR21QKRe1IVFLPVcbUAfgKqH4=;
        b=I7HQWmVgPXvlZEZf7hZ4CraN7JLUgOLQZv4L2Hwvn2M3HrNqpQ88D8IRBRnkdhnT79
         A1quMylYkajFLS7fMzA8k528sqe0ug+KLh0aMNlcUmOYppVRHlMQuAEDVvUfp1B9LGqH
         ddIioNER2cZDsSCyphUaZqER5Mz/7xE9t+3d24rQEMV6sEVIqAb+5tUJxZYZPSMA/wgj
         8MGQ9iloxGSlE5s9M9x41cWZSIHBOmPNh1LXC72giLnl2GFmxL5Ehji2BF9q19l0Rxwq
         YqXQjx9hYbA7t8+muDch1BLwSVbFWzDU7FIWJxtwQye5D+BFkHrTYUhgAGZ+3oxrZwNd
         K0dg==
X-Gm-Message-State: AOAM533noLHGC3E/9cPuH17zHTd9mqYxvA6n1vvcEZFYeFaAsYYI9Aaq
        rYI5Hd0B4I0/JjbdXE9DeRU=
X-Google-Smtp-Source: ABdhPJzvQ76ubAUo4fgMsDcwKvGy/4AO7ODgxXkkiMTMH/0lUrxf38WIvmd7+r26Kjyi7EpJWJ/SFg==
X-Received: by 2002:a05:6830:314e:: with SMTP id c14mr2908166ots.338.1642774107105;
        Fri, 21 Jan 2022 06:08:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v27sm1059085ots.62.2022.01.21.06.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 06:08:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Jan 2022 06:08:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: lm90: Drop Tegra specifics from
 example
Message-ID: <20220121140825.GA307914@roeck-us.net>
References: <20220119015514.2441231-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119015514.2441231-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 07:55:13PM -0600, Rob Herring wrote:
> There's no need to complicate examples with a platform specific macro.
> It also complicates example parsing to figure out the number of
> interrupt cells in examples (based on bracketing).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/national,lm90.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> index 6e1d54ff5d5b..30db92977937 100644
> --- a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> @@ -60,7 +60,6 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/gpio/tegra-gpio.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>  
>      i2c {
> @@ -71,8 +70,7 @@ examples:
>              compatible = "onnn,nct1008";
>              reg = <0x4c>;
>              vcc-supply = <&palmas_ldo6_reg>;
> -            interrupt-parent = <&gpio>;
> -            interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
> +            interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
>              #thermal-sensor-cells = <1>;
>          };
>      };
