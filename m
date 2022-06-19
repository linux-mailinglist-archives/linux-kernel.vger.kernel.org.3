Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2528955091A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiFSHPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiFSHPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:15:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63DEEE24
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50742B801B9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FCEC34114;
        Sun, 19 Jun 2022 07:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655622907;
        bh=gLKgXQjQ7jAHQe6U9XNXMBf7aX8Uc+afJujgdXysOdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RpPwAFXB6arS3ReUXvmYWtMN46/F9vWzu44Z2cY3OWt+TKBzEgjfjv3cjCFWzwq7i
         KyqDu7/tOMkZ6azwZh6RuCiTFhy9NoYMbE2dhunD7DmPPZ2jV6Q6SaXLRgRxxX9wqN
         2aX2AgAhmRHLxkDU08AOaEGuiYfIZEzVDPuynLhHj4c3gIKrRonCBHqcIznkX39OYA
         v6ZZYqHWRaySOsqa3A4SSQOskWe7NzpxbJzYkbG6jML0vMEXnCeyAA7m9OVq9UBZDD
         t01BfGBKyEGPI3rJZ4xqDBdwLfB3UU5dxd672++i+/qhhEZ6vsOKrPUomNaR64oqF7
         hq6Rg9x6diWcg==
Date:   Sun, 19 Jun 2022 15:15:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        kernel@puri.sm, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: imx: gpcv2: print errno for regulator errors
Message-ID: <20220619071500.GG254723@dragon>
References: <20220609111707.2216036-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609111707.2216036-1-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 01:17:07PM +0200, Martin Kepplinger wrote:
> Make debugging of power management issues easier by printing the reason
> why a regulator fails to be enabled or disabled.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Applied, thanks!
