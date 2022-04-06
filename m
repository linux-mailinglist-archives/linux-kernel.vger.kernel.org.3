Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF564F5B66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356205AbiDFJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582881AbiDFJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:22:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186A3A1423;
        Tue,  5 Apr 2022 20:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAEA7B8200E;
        Wed,  6 Apr 2022 03:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3483C385A0;
        Wed,  6 Apr 2022 03:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649214467;
        bh=eIlEQwsG6t17hOwXn8NqVS/jaWXyCYIUFSVCEzvWWTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOXe812cr3deZum/nx2E3cPdah6SKXLSX202QJbEA0BFO0C0dM7kZUCV9iZzGu5G+
         Z4ApptDbZKcbz8T33brz3W9nG8hQzYIUby9aTTYnz94ENwVrhzOqjwfBY5D4Y0SyIW
         7yUtF8b3ubaYN+5mA5jsvFU7TarTIRdRAotSSTL0cy7vUVn7pYEsUexvA0dpfHjSiU
         TWT7AnpkI6ZsZHqFaUeNvNsWqcVHvzX+aZeFurWMxQtzvkqj1oiIBO2c5Y2jksyejQ
         xfxM1fsMs8FOZ6iZ9ip/ZssmeNzIPvYkvfyPwZJ7gJaNOS353H6GwkGCl98jXsv9a9
         IzRgad6jFe11w==
Date:   Wed, 6 Apr 2022 03:07:43 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drivers: pwm: pwm-cros-ec: add channel type
 support
Message-ID: <Yk0D/4vzOfR8H+YD@google.com>
References: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
 <20220331125818.3776912-3-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331125818.3776912-3-fabiobaltieri@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:58:16PM +0000, Fabio Baltieri wrote:
> Add support for EC_PWM_TYPE_DISPLAY_LIGHT and EC_PWM_TYPE_KB_LIGHT pwm
> types to the PWM cros_ec_pwm driver. This allows specifying one of these
> PWM channel by functionality, and let the EC firmware pick the correct
> channel, thus abstracting the hardware implementation from the kernel
> driver.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>

Taking `git log --oneline drivers/pwm/pwm-cros-ec.c` as examples, suggest to
remove "drivers: " prefix from the commit title.

Otherwise,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
