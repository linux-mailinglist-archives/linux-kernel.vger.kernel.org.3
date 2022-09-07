Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5712E5B0B47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiIGRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiIGRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:15:33 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0113915FA;
        Wed,  7 Sep 2022 10:15:28 -0700 (PDT)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C0A7020003;
        Wed,  7 Sep 2022 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662570925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tuNHhg0d7wCXZkWQB2aVNJEW/obWsRINPAZ/CInV8Ek=;
        b=POTBoVtrj3ImsMtFfmWL/bMKfwwXr1NizxFJd5pb/vOiZR9jjG8ArBndIJb0IZ70lj0rf2
        HTKO7fkRwXqfZCv9fzxTGmKVk7avMQNe/ErxQ5/OGneWSDmRd3YM2srqLx3fNJGFQxaFqc
        pekgI6081tOP14+iM8qeMK0I4KvfXB2FiaJA9mMUpw31FfDLDJaKEMtsJmsasyYTFS9j3p
        GPMjfTwmo8Q0sJ3jwWte3RhVBLaDr2c8onzgseLvYV71E8p/OuqiUHkY89JB09SVVFklcS
        s0u5bVCkrLfRc4iqs470lrIUkbHzWFXpYjDsvg570T1yOuQqLajdG6D9ArzMoQ==
Date:   Wed, 7 Sep 2022 19:15:21 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 0/8] Add support for the internal RK3308 audio codec
Message-ID: <20220907191521.1ce081c8@booty>
In-Reply-To: <Yxi7uD6RKeR3uHcF@sirena.org.uk>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
        <Yxi7uD6RKeR3uHcF@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

thanks for the quick feedback!

On Wed, 7 Sep 2022 16:41:44 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Sep 07, 2022 at 04:21:16PM +0200, luca.ceresoli@bootlin.com wrote:
> 
> > Luca Ceresoli (8):
> >   ASoC: rockchip: rk3308: add internal audio codec bindings
> >   ASoC: rockchip: rk3308: add audio card bindings
> >   arm64: dts: rockchip: add i2s_8ch_2 and i2s_8ch_3
> >   arm64: dts: rockchip: add the internal audio codec
> >   ASoC: rockchip: i2s-tdm: Fix clk_id usage in .set_sysclk()
> >   ASoC: audio-graph: let dai_link->init be overridable
> >   ASoC: codecs: Add RK3308 internal audio codec driver
> >   ASoC: rockchip: add new RK3308 sound card  
> 
> Please pay attention to the ordering of your serieses when posting:
> generally any bug fixes should come first so that they can be easily
> sent as fixes, and normally DTS updates are at the very end of the
> series rather than mixed in the middle since they go via the platform
> maintainer tree normally rather than with everything else.

Sorry about that. I've reordered the patches in my branch for the next
iteration.

Best regards,
Luca
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
