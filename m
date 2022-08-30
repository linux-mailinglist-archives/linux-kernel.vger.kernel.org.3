Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B75A6343
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiH3MYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH3MYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:24:10 -0400
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E39F5CDC;
        Tue, 30 Aug 2022 05:24:09 -0700 (PDT)
Date:   Tue, 30 Aug 2022 13:56:41 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH] leds: MAINTAINERS: include dt-bindings headers
Message-ID: <Yw36+cOL7alcIwQs@ada.ifak-system.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
References: <20220830083625.281462-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830083625.281462-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei hei,

Am Tue, Aug 30, 2022 at 11:36:25AM +0300 schrieb Krzysztof Kozlowski:
> Include the Devicetree binding headers in LED SUBSYSTEM entry.

Looks like a follow-up to my yesterday's mail? ;-)

Acked-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fd6a1721e69..ebc140e71b49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11458,6 +11458,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git
>  F:	Documentation/devicetree/bindings/leds/
>  F:	drivers/leds/
> +F:	include/dt-bindings/leds/
>  F:	include/linux/leds.h
>  
>  LEGACY EEPROM DRIVER
> -- 
> 2.34.1
> 
