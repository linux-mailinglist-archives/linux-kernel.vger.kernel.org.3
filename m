Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254714C2E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiBXOp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiBXOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:45:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB016DAF3;
        Thu, 24 Feb 2022 06:44:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D939B82617;
        Thu, 24 Feb 2022 14:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D17C340EC;
        Thu, 24 Feb 2022 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645713893;
        bh=lNcn+IdlDT0iCnlen6PL4o30r4n4CSddgB+J+wXxOLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TK6Vxvi0EBCwHTKwRiPp6/edCM35nF6hBq75phj0/eXIw+gO0sJjFeGiA8b9T2VhH
         +8d2zeMM/IbLMzvQKmCZyAkH8MDzPWYKQTJeI13rM5ASifrcTrpUQClRZWmpfdu6Ij
         pjqT4niJ7FqnBsaetRaV+bYrsgclP6aMEf9msZ07BjP6PKnn/D9adTBpRsFVcuUIwP
         ec66WQu3SqVkc+N9uJSPFgLvTgZUoXmKVrq9VdOSzDgvcFrPujebY99ypVRIoSJMsN
         Obnd81v0zLeMY5FsFZ+6qw4qc5qdUqzEnaEZspEyqGFue5P3LGfNaq+qs46O/GdLEm
         URvXoFT8GqVTw==
Date:   Thu, 24 Feb 2022 20:14:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, jbx6244@gmail.com,
        devicetree@vger.kernel.org, michael.riesch@wolfvision.net,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com,
        kever.yang@rock-chips.com, lee.jones@linaro.org,
        wulf@rock-chips.com, david.wu@rock-chips.com
Subject: Re: [PATCH v8 0/4] Add Naneng combo PHY support for RK3568
Message-ID: <YheZ4XDX9kG8CocF@matsya>
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-22, 17:13, Yifeng Zhao wrote:
> 
> This phy can be used as pcie-phy, usb3-phy, sata-phy or sgmii-phy.

Applied 1-3, thanks

-- 
~Vinod
