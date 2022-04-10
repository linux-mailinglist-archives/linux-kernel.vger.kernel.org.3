Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912C04FAC99
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 09:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiDJHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiDJHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 03:49:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABD231DFD;
        Sun, 10 Apr 2022 00:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 630A7B80AE8;
        Sun, 10 Apr 2022 07:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E88C385A1;
        Sun, 10 Apr 2022 07:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649576815;
        bh=G98UwNbuP+q+/Kp7/+lircYNVc/Gi9CAJbaUmr8GGbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raroZEv1UtNpB22Z1hBBuOn+bRJwhXnSqNZRY5t5Gt0nqWcOG3M9MFWBcTeWzsoGq
         oVXsGGLM/5U55ynNYxQTeJ45v/XO/n+5ompqKTIMqtLUKiBu9efLFayqZT2JUksFcE
         ZwDkJQ67tSspSqWTxBFHG7nwAeBWdL488TTgDdNs8qnpZenDk7fYbc/vIOWkM09fZ3
         Idyo7s/wnSW9iw47rGUVWcz4PU3eaT4KnEehyqjVFdvdHBTwnlXh6CytkaE7ji6rlf
         cCRNqnMB8VyeLDqO6cDuMQwvXGHjDPMT4IJUK+5lHjPnZJM7gcOgUIBxOziKbH0/xH
         S+DlfUwr6oAQw==
Date:   Sun, 10 Apr 2022 15:46:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] arm64: dts: imx8mm-verdin: minor updates
Message-ID: <20220410074647.GO129381@dragon>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:56:39PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> This patch set brings some minor updates including some cosmetic
> improvements like comments, names and node and pinctrl group
> re-orderings plus functional improvements like an SD1 sleep pinctrl and
> an updated fully validated IOMUX configuration.
> 
> 
> Marcel Ziswiler (10):
>   arm64: dts: imx8mm-verdin: update regulator names
>   arm64: dts: imx8mm-verdin: multi-line comment style
>   arm64: dts: imx8mm-verdin: alphabetically re-order nodes
>   arm64: dts: imx8mm-verdin: only dashes in node names
>   arm64: dts: imx8mm-verdin: comment about i2c level shifter
>   arm64: dts: imx8mm-verdin: update iomux configuration
>   arm64: dts: imx8mm-verdin: re-order pinctrl groups
>   arm64: dts: imx8mm-verdin: capitalisation of verdin comments
>   arm64: dts: imx8mm-verdin: note about disabled sd1 pull-ups
>   arm64: dts: imx8mm-verdin: add sd1 sleep pinctrl

Applied all, thanks!
