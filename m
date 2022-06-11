Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F5D547308
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiFKIv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiFKIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:51:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB1120B1;
        Sat, 11 Jun 2022 01:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68B5EB80189;
        Sat, 11 Jun 2022 08:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7A9C34116;
        Sat, 11 Jun 2022 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654937511;
        bh=6cVnM3jL3+Wjh7umIggE5qH5P/NfQTWKA57hAMxeO2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErYuLnYpV3iLO1kJU621y2ZZQ3MoHBJlOoJBp9NFDx6Cltj7T5QBxXm6rlQla3CI5
         0vjpeN4Je/11Egp1kNIIvA2Mx6rEzyL20jT7poDFfEsBafUlp5cK6V3U6PHPgp0gc5
         j6WLXYc4yU2P3pLiYesYS+PvS3DL5rAPl289iZsKVL0yjM3vve+BBiardujfF1dmA2
         2IlwCFjkYAXUt033y5GCFrRZwGhLKLEU7tQkIfWCmFWaRWj2GEJpWU16b5m47WNHUF
         MNBHVn+v9rztqW/42R+DPQSdVuLIqPSwfBxrGKAXCXZCsVJ6sHZhRvNZMlHNuPRFEb
         KP6jD1bNkBpaQ==
Date:   Sat, 11 Jun 2022 16:51:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com, Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] ARM: dts: imx6dl-colibri: Unify with changes to
 Apalis iMX6 device trees.
Message-ID: <20220611085145.GF254723@dragon>
References: <20220513102616.48040-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513102616.48040-1-max.oss.09@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 12:26:11PM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> 
> - Follows a change to the SGTL5000 MCLK handling fixed for Apalis iMX6 by
>   Fabio.
> - Simplify handling of inverted PWM backlight
> - Fixes a regression for the capacitive touch introduced with
>   https://lore.kernel.org/all/20220411152234.12678-1-max.oss.09@gmail.com/
> 
> 
> Changes in v3:
> - add reviewed-by tags
> - Extend commit comment of "ARM: dts: imx6qdl-colibri: backlight pwm: Simplify inverted backlight"
> 
> Changes in v2:
> - add reviewed-by tags
> - Split the Backlight PWM patch into two patches, a) #pwm-cells 3, b) adapt brightness steps
> 
> Max Krummenacher (4):
>   ARM: dts: imx6qdl-colibri: Fix capacitive touch reset polarity
>   ARM: dts: imx6qdl-colibri: Mux mclk for sgtl5000 with the codec node
>   ARM: dts: imx6qdl-colibri: backlight pwm: Simplify inverted backlight
>   ARM: dts: imx6qdl-colibri: backlight pwm: Adapt brightness steps

Applied, thanks!
