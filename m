Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4950F16B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbiDZGsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343493AbiDZGs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:48:26 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0ED2B86C;
        Mon, 25 Apr 2022 23:45:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7325A80CF;
        Tue, 26 Apr 2022 06:42:13 +0000 (UTC)
Date:   Tue, 26 Apr 2022 09:45:13 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
Message-ID: <YmeU+aSxQdixAESi@atomide.com>
References: <20220414192722.2978837-1-dfustini@baylibre.com>
 <YmEAA7kc4jNHSkGm@atomide.com>
 <YmI4rjkpX9krZAGn@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmI4rjkpX9krZAGn@x1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Drew Fustini <dfustini@baylibre.com> [220422 05:06]:
> Do you know what revision of the am437x-gp-evm that you have?

Not sure, it seems to be some early revision the last time I looked.

> The AM437X_GP_EVM_3K0006_SCHEMATIC_REV1_5B schematic [1] for the
> AM437x-GP-EVM shows that the EN pin on the TPS51200 is connected to SoC
> ball N25 which is GPIO5_7.

OK

> Unfortunately, the only AM437x board that I have is the AM437x IDK [2]
> which unfortunately does not have the TSP51200 EN pin connected to the
> the SoC. In addition, the am437x-gp-evm is the only board that is
> allowed to enable off mode due to am43xx_check_off_mode_enable() in
> arch/arm/mach-omap2/pm33xx-core.c

OK

Thanks,

Tony


> [1] https://www.ti.com/lit/zip/tidrc79
> [2] https://www.ti.com/lit/zip/sprr396
