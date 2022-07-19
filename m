Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C545792E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiGSF6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiGSF5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:57:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58137FBB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:57:48 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oDgEl-0004Rb-QY; Tue, 19 Jul 2022 07:57:39 +0200
Message-ID: <d346f18a-d82c-4408-98d7-f5295f51907a@pengutronix.de>
Date:   Tue, 19 Jul 2022 07:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/6] arm64: dts: imx8mn-beacon: Enable Digitial Microphone
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <20220717181000.1186373-1-aford173@gmail.com>
 <20220717181000.1186373-2-aford173@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220717181000.1186373-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adam,

On 17.07.22 20:09, Adam Ford wrote:
> +
> +	sound-micfil {
> +		compatible = "fsl,imx-audio-card";
> +		model = "imx-audio-micfil";
> +		pri-dai-link {
> +			link-name = "micfil hifi";
> +			format = "i2s";

Given that MICFIL and mic speak PDM with each other,
is i2s the correct format here?

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
