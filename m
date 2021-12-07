Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E346B329
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhLGGtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhLGGta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:49:30 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CED3C061746;
        Mon,  6 Dec 2021 22:46:01 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id t6so13791183qkg.1;
        Mon, 06 Dec 2021 22:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zbba/UkaBqT6lJeesV5XnDR8ly5tsCHkshlo7j8jGmI=;
        b=Q+yWS6IouAezP2RtXT7wfG4/tNxdp9ZXLR+wW9lKJBMyDsJlbJ5H3xZ0rKJ6fVBHbG
         dSSqWRMXnedRWTkImMBJ02GzPEnNeRFyXRgjK0GwRALs2WOZh06MkTmzmmR7igDS3WRT
         n9cK0g2H5P2BlLtjlmxoUtb2D+/i7e+uibXPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zbba/UkaBqT6lJeesV5XnDR8ly5tsCHkshlo7j8jGmI=;
        b=PhdEVnI6dYg00PJuLWCH4y5EPtMAWlnBMK+HS90cks0zUYxf0c+2OEqIOXlT6TazA6
         quf9bdlAGZFGsNJCgaYlUdWjrwT4XlqcvoOAWGzgsxu3LioqzvrHaQ0kFpYJREfmsPPW
         WNIoi4Ig4REY6cM0d57zLHEcKcxaxFnGD4aGMgIiaacCIIwBjCqxytsbdjHwEP/1Vu5l
         vpCfJHyVjbz19+Z4+kYrXcfcgdb7L/Louf45bKbQDNjqOSqc5fp+uJSdeGFEPUS3Lv2W
         q6XH/0woghnTs32D9l2bPVSZ+aURWXXQ7yQQ8azK6cBX6gxSMr4qs73LVGu8dh8EyS+n
         yusA==
X-Gm-Message-State: AOAM5335po9MDdykn8MXnDfsFc325PhaBygqT/CcUaFvTOtTL4znnAAN
        nqlNPmBnSo+g7cnh1WUsrmOaHZfVKaXwGwnSE74=
X-Google-Smtp-Source: ABdhPJwMyI+isbOcD9jb1sDe2P/kVRSvemDmcx2g+X8998rktI8XFF6NjHYwG35zn7OuoJyPRSFLT3eZWu86DISifLQ=
X-Received: by 2002:a05:620a:1004:: with SMTP id z4mr37420042qkj.243.1638859560150;
 Mon, 06 Dec 2021 22:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20211130055933.32708-1-billy_tsai@aspeedtech.com>
In-Reply-To: <20211130055933.32708-1-billy_tsai@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 7 Dec 2021 06:45:47 +0000
Message-ID: <CACPK8XfM4C7v3keXaxMs9SkqNzb8XWbZ6QvcZXWcy3ZKJCrvWQ@mail.gmail.com>
Subject: Re: [v14 0/2] Support pwm driver for aspeed ast26xx
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Andrew Jeffery <andrew@aj.id.au>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Billy,

On Tue, 30 Nov 2021 at 05:58, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> The legacy driver of aspeed pwm is binding with tach controller and it
> doesn't follow the pwm framworks usage. In addition, the pwm register
> usage of the 6th generation of ast26xx has drastic change. So these
> patch serials add the new aspeed pwm driver to fix up the problem above.

Sorry for not taking a look earlier. Well done on making it this far.

There's a few things that need to be addressed before merging this.

Firstly, the bindings need fixing up. I think these should be the one
file. The device tree bindings are supposed to describe the hardware,
and it doesn't make sense to separate them out just because we plan on
using two subsystems to implement the functionality.

Rob, please chime in if you would prefer something different.

Secondly, we need to clarify why this is a pwm driver and not a hwmon
driver like we had for the 2500 hardware, and that you're planning on
submitting a hwmon driver for the other half of the registers.

Finally, do you really need to use regmap? It's lots of overhead for a
mmio driver, and I like to see it avoided where possible. I know the
regions are shared, but are there any individual registers shared?

Cheers,

Joel



>
> Change since v13:
> - pwm-aspeed-ast2600.c
>   - Fix the usage of the braces to meet the coding-style.rst
>   - Use min function to reduce the times of division.
>
> Change since v12:
> - pwm-aspeed-ast2600.c
>   - Fix the comment about the duty cycle and period of the PWM.
>   - Configured to max period when request period > max period.
>   - Remove unnecessary curly braces.
>
> Change since v11:
> - pwm-aspeed-ast2600.c
>   - Request reset controller before clock enable.
>
> Change since v10:
> - pwm-aspeed-ast2600.c
>   - Add more comment to explain the feature of PWM
>   - Fix the naming of some parameters.
>   - Set pin_enable and clk_enable at the same time.
>   - Always set fixed divisor to hw register when apply.
>
> Change since v9:
> - dt-bindings:
>   - Change the naming of tach subnode channel setting property to
>   aspeed,tach-ch.
> - pwm-aspeed-ast2600.c
>   - Fix the naming of some parameters.
>   - Capitalise error messages.
>   - Handling potentially mult overflow when .apply
>
> Change since v8:
> - pwm-aspeed-ast2600.c
>   - Replace "* _BITULL(div_h)" to "<< div_h"
>   - Fix duty_cycle precision problem.
>   - Add the comment about the formula of duty_cycle.
>
> Change since v7:
> - pwm-aspeed-g6.c
>   - Rename the driver: pwm-aspeed-g6.c -> pwm-aspeed-ast2600.c.
>   - Macro remove "_CH" part of the register name.
>   - Unroll the aspeed_pwm_get_period and remove it.
>   - Simplify the formula to get duty_pt
>   - Reduce the number of writing register. Organize all the fields and
>     write them at once.
>
> Change since v6:
> - dt-bindings:
>   - Add blank line between each DT property.
>   - Change the sub-node name from fan to tach-ch.
> - pwm-aspeed-g6.c
>   - Merge aspeed_pwm_set_period and aspeed_pwm_set_duty into .apply.
>   - Convert the factor type to u64 when calculating the period value.
>   - Using ROUND_UP strategy to calculate div_h for finer resolution.
>
> Change since v5:
> - pwm-aspeed-g6.c suggested by Uwe Kleine-K=C3=B6nig
>   - Move the divide at the end of the calculation.
>   - Unified the prefix of the function name.
>   - Use div64_u64 to calculate the divider of frequency.
>
> Change since v4:
> - dt_binding:
>   - pwm/tach yaml: Replace child-node with additionalProperties
>   - pwm-tach yaml: Replace child-node with patternProperties
> - pwm-aspeed-g6.c suggested by Uwe Kleine-K=C3=B6nig
>   - The bit definitions contained the name of the register.
>   - Remove single caller function and fold it to the caller.
>   - Avoid to divide by the result of a division.
>   - Remove unnecessary condition in .apply().
>   - Use goto for error handling
>
> Changes since v3:
> - Add the dt_binding for aspeed,ast2600-tach.
> - Describe the pwm/tach as child-node of pwm-tach mfd.
> - Complete the properties of pwm node.
>
> Changes since v2:
> - Remove the tach node, #address-cells and #size-cells from pwm-tach.yaml
> - Add clocks and reset properties to pwm-tach.yaml
> - Kconfig/Makfile sorted alphabetically
> - pwm-aspeed-g6.c suggested by Uwe Kleine-K=C3=B6nig
>   - Add more hardware descriptions at top of the driver.
>   - Remove unused api request and free
>   - Move the initialize settings of all pwm channel to probe.
>   - Change the method of getting the approximate period.
>   - Read the hardware register values to fill the state for .get_state()
>
> Changes since v1:
> - Fix the dt_binding_check fail suggested by Rob Herring
> - Add depends to PWM_ASPEED_G6 configure suggested by Uwe Kleine-Konig
> - pwm-aspeed-g6.c suggested by Uwe Kleine-K=C3=B6nig
>   - Fix license header
>   - Use bitfiled.h macro to define register fields
>   - Implement .remove device function
>   - Implement .get_state pwm api
>
> Billy Tsai (2):
>   dt-bindings: Add bindings for aspeed pwm-tach.
>   pwm: Add Aspeed ast2600 PWM support
>
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   |  68 ++++
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  76 ++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  64 ++++
>  drivers/pwm/Kconfig                           |  10 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-aspeed-ast2600.c              | 325 ++++++++++++++++++
>  6 files changed, 544 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast260=
0-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-=
pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-=
pwm.yaml
>  create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c
>
> --
> 2.25.1
>
