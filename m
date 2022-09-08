Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AAC5B21E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiIHPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiIHPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:20:30 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44689564CD;
        Thu,  8 Sep 2022 08:20:25 -0700 (PDT)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 49192E0008;
        Thu,  8 Sep 2022 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662650422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OaycjTCUtVL0XC/TXiHrCS9tTq4CU4MjnzsvbA4dKO4=;
        b=VIWvkQc2rLTZkRlB9Caja28dMM3gG2XlRofkwI6AWfSSz/kNwH9bBu5kYOe2dhlaUX6AUr
        i0zh5Hupq8g2tAOoEIgXWAGNC6fNDVOpBHIsqHe3D+pNeF5DYgLbQjZ3fjb5OZKomKIwzH
        o+LLDo2w8HoVJzR2NgTDT3/s7i2PbSm59OayUUbmD6V5YUkwefuyjr8Y0AVtfNDJ1H52il
        2tao+VNyOicFrt3Ina7RBvn3rx62qM8sFk4gczmzLz8HOqDP6AMKVsnTzIJe+R7GCXTl1V
        ckAUtcllF0oofsFKMSXc1eMv2fvadLHH9kzV26ap8xmDhgcd1YSQwdPb95B4tQ==
Date:   Thu, 8 Sep 2022 17:20:16 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/8] ASoC: rockchip: rk3308: add audio card bindings
Message-ID: <20220908172016.6e23df8c@booty>
In-Reply-To: <aeabc681-9416-d25d-693a-30ba99f1796d@linaro.org>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
        <20220907142124.2532620-3-luca.ceresoli@bootlin.com>
        <aeabc681-9416-d25d-693a-30ba99f1796d@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

thank you for reviewing my patches.

On Thu, 8 Sep 2022 13:49:34 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 07/09/2022 16:21, luca.ceresoli@bootlin.com wrote:
> > From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[...]

> > +properties:
> > +  compatible:
> > +    const: rockchip,rk3308-audio-graph-card  
> 
> Is "graph" part of device name or you just put it there because of other
> schema?

Indeed this comes from the "audio-graph-card" compatible string.

> The compatible should reflect the device name, not some other
> pieces in Linux or in bindings.

Would it be OK to rename it to rockchip,rk3308-audio-card (i.e. drop
the "graph-" infix)?

Fixes for the other comments you made to this and the other patches are
already queued for v2.

Best regards,
Luca
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
