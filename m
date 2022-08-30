Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73DF5A5B04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiH3FNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiH3FNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA52AE9F8;
        Mon, 29 Aug 2022 22:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618AD61286;
        Tue, 30 Aug 2022 05:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA73C433D6;
        Tue, 30 Aug 2022 05:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661836422;
        bh=75LehKyfg/TMPpwAfNi4DyQ4TNo6iyN0d+FUfBzGa+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMzo0MkmqRBfQPGtXsosqLcP7p5VHih/9Q3XnhajUMs0P0JizUEv5OmJ0eWmdjF15
         hyGw76aYuNqtaVvcdFjZLKsWbWqMOdQyGD49gQ2z+ikm9taaT65meDox687jjcfixG
         d8TPr/NFWJ/qjG8Oe47Nf5pzKo2rPlgpB6ofZ1K2WWslIoPWnjGnBNNdArg1EWqQ3h
         WdMjC4GHZnc3cimpMGwPAI/vX8joJIR3b21/GzDMgH8v3qHJaJ9HlLhMA9UrYRfkLX
         MqBCXyUaEBzXjz1PwbNWAe78yMQ3LBSIIQNUDOd+2vkhVWmebUcVqozNYD3dWagvW0
         PUtGIAOpCjg+w==
Date:   Tue, 30 Aug 2022 10:43:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     kishon@ti.com, vigneshr@ti.com, t-patil@ti.com,
        sjakhade@cadence.com, s-vadapalli@ti.com,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] phy: ti: phy-j721e-wiz: Add support for j7200-wiz-10g
Message-ID: <Yw2cgthIiLONb/+Y@matsya>
References: <20220628122255.24265-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628122255.24265-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-22, 15:22, Roger Quadros wrote:
> Hi,
> 
> The SERDES in J7200 SR2.0 supports 2 reference clocks.
> The second reference clock (core_ref1_clk) is hardwired to
> MAIN_PLL3_HSDIV4_CLKOUT (100/125/156.25 MHz).
> 
> Add a new compatible "j7200-wiz-10g" for this device.
> 
> The external clocks to SERDES PLL refclock mapping is now
> controlled by a special register in System Control Module
> (SCM) space. Add a property "ti,scm" to reference it and
> configure it in the driver.

Applied, thanks

-- 
~Vinod
