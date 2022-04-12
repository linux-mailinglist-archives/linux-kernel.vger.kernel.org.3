Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF94FDFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352607AbiDLMMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354697AbiDLMKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:10:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF48231A;
        Tue, 12 Apr 2022 04:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9021CB81CBE;
        Tue, 12 Apr 2022 11:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD212C385A1;
        Tue, 12 Apr 2022 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649761884;
        bh=rxkqqddj2wf2wpr9MG7q5XqAbvwAmdG114YomNsJoo0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OfXeYIbotUzNK7AcLLwOpWG0vO94hKXXiWHJIpTppGfzws/zl2noLezWD7gVwIVUZ
         8DxVcuOWVIZSGZs0s4b/VyQSrQ7O1RwxYVwpVMY6RG9DmgDw3TxkK3hnthDKdA2d4Y
         LoXUw0n2Jls3N+gfLwkDAeZTj27b94Ml9SagtAoKMXNHG0QRQYMAu/Z1SSR5Vk5Y9e
         EimEZjk05JQjnKBCW4rEo6pcHrh8GHn9bTGT6FfnBG0A+kBhGlGCM0LyaYVpnC7aF9
         wFpxlaY6lmD1CAg7ZLqLeAj/xToek+bvAXmIAkEh55Lx65/ZrQ/zkVmYIiAtTkPS0+
         ldHCAeqLX32PQ==
Message-ID: <9f8b1586-d0ad-5aac-455a-85f09587ce2f@kernel.org>
Date:   Tue, 12 Apr 2022 13:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] arm: dts: Add device tree for bosch acc board
Content-Language: en-US
To:     Philip Oberfichtner <pro@denx.de>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Winker Matthias <Matthias.Winker@de.bosch.com>
References: <20220412101905.514310-1-pro@denx.de>
 <20220412101905.514310-3-pro@denx.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220412101905.514310-3-pro@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 12:19, Philip Oberfichtner wrote:
> Add device tree for the Bosch ACC board, based on i.MX6 Dual.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>  arch/arm/boot/dts/Makefile            |    1 +
>  arch/arm/boot/dts/imx6q-bosch-acc.dts | 1048 +++++++++++++++++++++++++
>  2 files changed, 1049 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-bosch-acc.dts
> 

One more point - wrong subject prefix.


Best regards,
Krzysztof
