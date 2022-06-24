Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64455A1E4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiFXT0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiFXT0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:26:42 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370DC81C4F;
        Fri, 24 Jun 2022 12:26:39 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4C0AC100007;
        Fri, 24 Jun 2022 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656098798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCsyFgTXZ2+6MS9SQR2SFiEyjV3pfsnA6bTV48U0IZQ=;
        b=GfoV+du9giy0BapImzO9HFE0YVlIMyChKTbjNuc7pBxFyj+9l6w8AxdB6Mt4/jyVV8Mexw
        PX4+27+/I2oRrV3zeBht9Aua1ip/TMlFSlZINpetguPCwzWZ6QOzLLDjDZpgqZMluXmz44
        S/QqA8a0noIXMRjvTZiSdRRTPmlEs0L9JbrXbA6pwpMuy/uLkeRdkzleeCxKUF8Av3PP8e
        hPheVbb9jfteazjHQ62d5TCbUGkWHzhM4XKTPq/I/Z2qK6PLW9ACKATqPY7sfYHVO9CceF
        zgCrLolU/CGjjqoyMXVw8EGO2kKfqTrLkF+VVWHvl458LY2ZpoOs0ellhdzm7g==
Date:   Fri, 24 Jun 2022 21:26:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, conor.dooley@microchip.com
Cc:     daire.mcnamara@microchip.com, linux-rtc@vger.kernel.org,
        linux-riscv@lists.infradead.org, lewis.hanly@microchip.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] rtc: microchip: Add driver for PolarFire SoC
Message-ID: <165609877582.32831.3964876505949828769.b4-ty@bootlin.com>
References: <20220601123320.2861043-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601123320.2861043-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 13:33:19 +0100, Conor Dooley wrote:
> Hey all,
> This is technically a v5 of [0], although a fair bit of time has
> passed since then. In the meantime I upstreamed the dt-binding, which
> was in the v1, and this patch depends on the fixes to the dt-binding
> and device tree etc which landed in v5.18-rc5.
> 
> The driver is quite substantially rewritten from the v1, as you wanted
> it to be switched to "binary" rather than calendar mode - so hopefully I
> have satisfied your concerns with the original driver. Specifically you
> had an significant issue with the counter being reset on startup & that
> is no longer the case.
> 
> [...]

Applied, thanks!

[1/2] rtc: Add driver for Microchip PolarFire SoC
      commit: 0b31d703598dc1993867597bbd45e87d824fc427
[2/2] MAINTAINERS: add PolarFire SoC's RTC
      commit: 1bdb08c180e8556d3d4cef844ea0f0bae79bb95d

Best regards,
-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
