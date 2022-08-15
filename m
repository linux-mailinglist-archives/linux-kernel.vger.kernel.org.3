Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3DE593051
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbiHONz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiHONzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:55:21 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D674110B1;
        Mon, 15 Aug 2022 06:55:18 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oNaYe-0003xX-VX; Mon, 15 Aug 2022 15:55:09 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 02/10] dt-bindings: sram: sunxi-sram: Add D1 compatible string
Date:   Mon, 15 Aug 2022 15:55:08 +0200
Message-ID: <8650738.VV5PYv0bhD@diego>
In-Reply-To: <20220815041248.53268-3-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org> <20220815041248.53268-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. August 2022, 06:12:39 CEST schrieb Samuel Holland:
> D1 needs to export a register for managing some LDO regulators, so it
> needs a unique compatible.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



