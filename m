Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43845B1536
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiIHGzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiIHGzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:55:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2A796A9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FAE6B81FCE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F99DC433D6;
        Thu,  8 Sep 2022 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662620139;
        bh=bWDm0/BKT6ALzNkWQOWPN+cykWxcvMalF9SwFfwz4mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mt8cEkjUmvzn6ZRSFOsNDCRDTWpE7T8uAEAJjeEcHNdxxENpeF1MFqQiJjp6pwPjg
         ZDTzfIg8http6LWN36QRSzahw81RuPVW2qMByL+qF31fk2gKvPbA/yf1ADIPbRX+eJ
         OWH80E1rE2zIk1+F/LD8jv2UTKjLet1fj14TX2f12SHCsVaVcHM9EjqgdD+cR3Ae/A
         /JDeB+qZ+50x356f3vH4o6zQMCHopR5R8WI2DVxhGuMovTK9+H6GQS5OR6pNmZvKoc
         UQdY27riVaO9bh1b6QopvwG7tU71IZhdeWKo2gl68M0Vi8A6ilziRYJHggmoLDORYI
         FtPpMPKBgwUug==
Date:   Thu, 8 Sep 2022 07:55:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        maijianzhang <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio: adaptation interrupt number
Message-ID: <YxmR5SPPY18O7LaG@google.com>
References: <YwdhTlk+7h+FMrwm@scg>
 <5595575.DvuYhMxLoT@kista>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5595575.DvuYhMxLoT@kista>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022, Jernej Škrabec wrote:

> Dne četrtek, 25. avgust 2022 ob 13:47:26 CEST je fuyao napisal(a):
> > __platform_get_irq_byname determinies whether the interrupt
> > number is 0 and returns EINVAL.
> > 
> > Signed-off-by: fuyao <fuyao1697@cyg.com>
> 
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

This patch does not appear to be in my inbox.

Please [RESEND], with Jernej's Ack applied, thanks.

-- 
Lee Jones [李琼斯]
