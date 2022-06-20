Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4A550DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiFTA2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiFTA2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:28:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07529641B;
        Sun, 19 Jun 2022 17:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C80E2B80E04;
        Mon, 20 Jun 2022 00:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F70C34114;
        Mon, 20 Jun 2022 00:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655684927;
        bh=KxftNYMBD54ZuKuGNBb92Lo0KSc+JPT/70EVwyP3hVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tc+owNgeMZJP9/vRV9MwDAjj/eK0/TgykYBFF8EAITe8rnW/4opYbitS3swMRBjpv
         PCB7hRB8tcMVsYaVHtj+mhQ6X0jlyO4MaPAJaPSHfiTwUFUk+cQzZXejT/HtA7+9/4
         kaB+4ImuOeps9w0tAXfetS3QrAmgZNcSx+eQmbFbw1I2CWBYR0oOYG2Sp+Jk/k2k3C
         i17V5T2h0yTjcociZEVkwR17S5kXvBcBs7uUCiswvlrNgim27sCjN0qJEAJkXDA8Oj
         QgCDJwiD2tLAMtbPFVT6H5voWkgy3p8HBQU+947dhLE7Z9B5teBZWx070TJXVDq7zo
         T3uklEUwHZcdg==
Date:   Mon, 20 Jun 2022 08:28:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7902: fix UART1 CTS
Message-ID: <20220620002841.GL254723@dragon>
References: <20220613190818.5386-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613190818.5386-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 12:08:18PM -0700, Tim Harvey wrote:
> Configure the correct GPIO for UART1 CTS.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
