Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63150545F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347971AbiFJIjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347990AbiFJIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:38:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9DD522EE;
        Fri, 10 Jun 2022 01:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184AF60A6F;
        Fri, 10 Jun 2022 08:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72744C34114;
        Fri, 10 Jun 2022 08:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654850134;
        bh=vHA0GSZYm/e0+DVO3ttXPQjemQMxUKpTXpDny8590u0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7aryy7peTZlb/H9sjlJQPhKxAtdg752MN1XWO23rifV5Zdw2MiYeZniXLl2kgbO/
         LQvI5qsglOsaDYYvB2vsO/R+WBD4qw9eURc6FOJpNBvcLB+9jicca3Fecsv2eBxBg0
         GlqthlrOyOy1fCyXVHpZgC4ON1/jHKyPvHfVlA8IeFZiBEetEbJVa7yMeX82V7Ph6C
         iR83YzubN9YuRWsdC/sspyD/PVWCh4YGfzwS9plm/TciASmOi0K0mj3oiManuVMJfF
         Aaiu6EEavEIKEDmz2ECNrs2t5BMvufx/jVjP17LY9mMyfY4z+IwpKZSw9Mr+YrqzUi
         NUsYW7W+VSAOQ==
Date:   Fri, 10 Jun 2022 16:35:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8ulp: address build warning
Message-ID: <20220610083528.GD254723@dragon>
References: <20220510124236.399407-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510124236.399407-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 08:42:36PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Fix warnings such as:
>  Warning (simple_bus_reg): /soc@0/gpio@2e200000: simple-bus unit address
>  format error, expected "2e200080"
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
