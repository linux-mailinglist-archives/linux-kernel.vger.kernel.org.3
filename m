Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9923F56B228
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiGHFNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGHFNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47001EAEF;
        Thu,  7 Jul 2022 22:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 603AA6245D;
        Fri,  8 Jul 2022 05:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0490FC341C0;
        Fri,  8 Jul 2022 05:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657257216;
        bh=TVxw4f3c6BxDVpwVJ2VA4stLowfR6hRCJ/QSqBXWbfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gI8kZorh+G7XF1ljBnBwvt3aav+Bxm7g1qZ3ZH0crR+KJWra0Rno4bkXdOXSgQYzA
         SMz0J5cB/rEWg3rUBSxE8clZfHD/teBjVJZOTv44vkZayMH5lXCKUfdOO2jFqxBKMW
         rXD9WK0emqkQrhdFQ6TfbZHx7SdYXWQBlR0Uqki0sP7tl22VG/UygvyEc/uR9ex4gu
         u3KvKm8FA1bONqs45NUIlH3/p/c4m1tdQN36FBPCI6njFl+B2yLg0eyheicuLvTuUY
         fSUPTsHjzyl5Z3ZQeKfRV1mxpNbA26Me6dijkMUl7sZ2gVLhOR6s1aKlh1IcgJe67J
         p7oy1ZtunEetg==
Date:   Fri, 8 Jul 2022 10:43:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 0/3] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Message-ID: <Yse8/MjjmShPpltv@matsya>
References: <20220706034810.2352641-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706034810.2352641-1-victor.liu@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-22, 11:48, Liu Ying wrote:
> Hi,
> 
> This series aims to add Freescale i.MX8qm LVDS PHY driver and dt-binding
> support.
> 
> The PHY IP is from Mixel, Inc.
> The PHY IP supports two LVDS PHYs, thus two LVDS channels.
> 
> Each LVDS PHY may work by itself to support a LVDS display device.
> 
> When two LVDS PHYs are enabled simultaneously, PHY configurations and reference
> clock rate have to be the same since there is only one set of PHY registers.
> In this case, the two LVDS PHYs are usually used to support a dual LVDS link
> display device, one as master PHY and the other as slave PHY.

Applied, thanks

-- 
~Vinod
