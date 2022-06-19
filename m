Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF0D5509FC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiFSLEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFSLEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:04:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE57BCBE;
        Sun, 19 Jun 2022 04:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4C80B80D04;
        Sun, 19 Jun 2022 11:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24563C3411D;
        Sun, 19 Jun 2022 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655636639;
        bh=NyJ9oyPNTS80bztKxBL5sptjF53mN0YaU+jzJib7WFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K70C/KAJIrkBixxWyU16KDS7uQRP01BsI/4Nc9NLVKR8pjAx1E8Zjgu3/FOheifBX
         4XSRYcoy1mDX98KBQcBVIhiLoFE7J/Al0VNLFKiKf8X5IdNdPUP/3IsX5333W3R6hs
         Ihqkpn8t2I4hArbOjD9HOJRKcy2qJvFE8Lv/P6fmfzWpPdZ/4ikbX0uRgG931flREp
         WMUkUQssbuv3S3G1OiZq0jg9oPvwMGrQ7+p+GUXZP4SXVKPlVr2enI09fExQNTexMn
         Wk3PnDFWCpM5bE4o+v7dkfR2S8Z5xUjQ3cY0PIjT9ZWgR1lI6OSdizT6oGi7ocUI7y
         OuS/cKzzgjSig==
Date:   Sun, 19 Jun 2022 12:13:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 11/16] iio: adc: axp20x_adc: Add support for AXP192
Message-ID: <20220619121315.203a709b@jic23-huawei>
In-Reply-To: <20220618214009.2178567-12-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
        <20220618214009.2178567-12-aidanmacdonald.0x0@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2022 22:40:04 +0100
Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

> The AXP192 is identical to the AXP20x, except for the addition of
> two more GPIO ADC channels.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Hi Aidan,

Looking at this again, I'd have a slight preference for doing the switch to
adc_en2_mask as a precursor patch.

Still, not a big thing (and I should have raised it earlier!) so up to you.
Either way

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

