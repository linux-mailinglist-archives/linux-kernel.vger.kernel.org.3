Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0A59B753
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiHVB4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiHVB4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:56:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73B21275;
        Sun, 21 Aug 2022 18:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFBA660ED9;
        Mon, 22 Aug 2022 01:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72459C433D6;
        Mon, 22 Aug 2022 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661133361;
        bh=T059SpFikatAQPavbk/b8RUTHmR7/7WII6tgYENSA2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5TyOZrHISWxehces3ddt7KOEEaw57sj+ZOu2rZCHSWuSdzRl7N/M9C8e8m1ds//n
         eslQcKkqhxcjSI274GCC9q0+1hzogb4ygEwg5/gNlrdZTymwMxyFvF3155QPASTiBl
         BiE4pvmDCgLKZANhMbqDtIOwBiLJ0rfiZLuvlH4+NrIuTtYTm/tvaoAzlCX41BCZE3
         8JVdD9KAEN+6xAPsXO02qXKJ0O8t0N2IisIBCWHy5jPPvaXW11VCw+/FvdLFCTcOt0
         0Olsvd7YKrkmfEK2nehUp6y85SK7jHW9bLsj6RW4bq4mfuE118NF3HRpS1FTh/7bsb
         38FRU8s9dGu9g==
Date:   Mon, 22 Aug 2022 09:55:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7903: add digital I/O ctl
 gpios
Message-ID: <20220822015555.GJ149610@dragon>
References: <20220812172334.14171-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812172334.14171-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:23:34AM -0700, Tim Harvey wrote:
> The GW7903-C revision introduced two additional GPIO's for controlling
> the digital I/O direction. Add them.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
