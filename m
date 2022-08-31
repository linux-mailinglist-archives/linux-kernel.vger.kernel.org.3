Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BFA5A78A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiHaIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiHaIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:15:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4F022B23
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:15:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oTIs1-0004bv-Ab; Wed, 31 Aug 2022 10:14:45 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oTIs0-0002sI-CE; Wed, 31 Aug 2022 10:14:44 +0200
Date:   Wed, 31 Aug 2022 10:14:44 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org, kishon@ti.com,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        jacopo@jmondi.org, laurent.pinchart+renesas@ideasonboard.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 0/4] Add support for Toshiba TC358746
Message-ID: <20220831081444.foupf6nfhqrk63ej@pengutronix.de>
References: <20220818143307.967150-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818143307.967150-1-m.felsch@pengutronix.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

gentle ping on this series.

On 22-08-18, Marco Felsch wrote:
> Hi,
> 
> this small series adds the support for the Toshiba TC358746 MIPI-CSI to
> Parallel converter chip. After a long period I finally had the time to
> include Sakaris points made on my v2 [1]. Since [1] is long time ago
> and I reworked the driver a lot, I don't add a v3 on this series. Also
> all already provided RB tags are dropped.
> 
> Regards,
>   Marco
> 
> [1] https://www.mail-archive.com/linux-media@vger.kernel.org/msg147901.html
> 
> Marco Felsch (4):
>   phy: dphy: refactor get_default_config
>   phy: dphy: add support to calculate the timing based on hs_clk_rate
>   media: dt-bindings: add bindings for Toshiba TC358746
>   media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver
> 
>  .../bindings/media/i2c/toshiba,tc358746.yaml  |  157 ++
>  drivers/media/i2c/Kconfig                     |   17 +
>  drivers/media/i2c/Makefile                    |    1 +
>  drivers/media/i2c/tc358746.c                  | 1645 +++++++++++++++++
>  drivers/phy/phy-core-mipi-dphy.c              |   31 +-
>  include/linux/phy/phy-mipi-dphy.h             |    3 +
>  6 files changed, 1850 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
>  create mode 100644 drivers/media/i2c/tc358746.c
> 
> -- 
> 2.30.2
> 
> 
> 
