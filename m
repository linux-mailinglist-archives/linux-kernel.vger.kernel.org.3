Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846AB5AB58D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiIBPox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiIBPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:44:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D6B1D8;
        Fri,  2 Sep 2022 08:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8938B82C7A;
        Fri,  2 Sep 2022 15:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9A7C433C1;
        Fri,  2 Sep 2022 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662132754;
        bh=TMf3BdVjVegUTft/oEa9DfSLI5AQyabpvORb5mYeuGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eiM20zqheXI9sFvq5bgtdWwDfp4rt6e0mQSxFwywe8XpgD7Y3g9HtJWbfPksR2CzN
         mDZyJtOPhHhcZyTSat9lGgf1gHm0fVPMR2GJJwXuEXSn8UXMu7UZAzmGtDegHD7NB1
         QiOQajBMDlB4RhnU5MIxTKdddgZIkNLoBsgXnBrpPXrQHSr3g72p1O2vjEmAP1ZwOz
         DuWGDaLwnI4YeYcYXz06N495w84STz6dGowwLhiU8Sr85AZ0Eqy3AiLvkiJMJOYbLr
         I/AVQcjE4WSRfZ3lom/1jChAzLHcXTSgdOXCAbieMPxxBerMeTpirUGz2JQv3CFouK
         QMACQUMkcUHYw==
Date:   Fri, 2 Sep 2022 21:02:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     kishon@ti.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Subject: Re: [PATCH v5 0/2] Add USB2.0 phy driver for Sunplus SP7021
Message-ID: <YxIiDfNWnT7vfKb6@matsya>
References: <1658717052-26142-1-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658717052-26142-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-22, 10:44, Vincent Shih wrote:
> This is a patch series for USB2.0 phy driver for Sunplus SP7021 SoC.
> 
> Sunplus SP7021 is an ARM Coretex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
> etc.) into a single chip. It is designed for industrial control.

Applied, thanks

-- 
~Vinod
