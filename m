Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CAE55A1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiFXTgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXTgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:36:37 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DA481D8C;
        Fri, 24 Jun 2022 12:36:35 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 390E1E0003;
        Fri, 24 Jun 2022 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656099394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gn38J0/acl2kOuqtLJoK7NFueOpNaEXUwlW0/5tfV8I=;
        b=DwkGdEG4cpTELBeBcdmoCaiN2UoB6kbQ8wHBtCAvTbRI1uKlF8CpaTPKwZyytAxGz6+nGK
        L2s7wbQXvhEi425qbNyTRY/15DLXN2C725Wxg1ydfb4o2NZLhOjMvzcZ66h0pWYhqJqvSu
        h4ZHI6Mq74wLGXpv3fktc/oeEJtSEkbidGU7Wl3WxK2yV/hwCnuGtTcGkiLiKWHm1+77Up
        6eu1zBag8YVL0TEULBR6zyYBgS0bbca/sTbq0dNc1SfkY4rjPrUVFpwXnmLFr7KSsBN8le
        wwTt/G/dNOi8t62/+3MRBMUVVqV/Ipt52e3OD5vxHHBR5//xUIKgJVEAEoqwWA==
Date:   Fri, 24 Jun 2022 21:36:31 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, nm@ti.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Cc:     afd@ti.com, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
Subject: Re: [PATCH V4 0/2] rtc: Introduce rtc-ti-k3
Message-ID: <165609935670.33848.14304179629453424484.b4-ty@bootlin.com>
References: <20220623170808.20998-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623170808.20998-1-nm@ti.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 12:08:06 -0500, Nishanth Menon wrote:
> One more round..
> 
> This series adds support for TI K3 RTC as instantiated on TI's AM625
> SoC.
> 
> Documentation in the current early release version of Technical
> Reference Manual is incomplete at the moment, but due to be updated
> later this year.
> https://www.ti.com/lit/pdf/spruiv7
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: rtc: Add TI K3 RTC description
      commit: 5e665cf1f0c52163de5517bfb9258390e63772b2
[2/2] rtc: Introduce ti-k3-rtc
      commit: b09d633575e54e98e1362bd5c36cd9571cb71d8a

Best regards,
-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
