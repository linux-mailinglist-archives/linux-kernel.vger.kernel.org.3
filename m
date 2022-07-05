Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E46A566F75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiGENkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiGENkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:40:06 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E99B186;
        Tue,  5 Jul 2022 06:01:06 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9E3252223E;
        Tue,  5 Jul 2022 15:00:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657026060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5IGhtBFhLHpkdv9OtcqSGseM9bhkDJbnjN/ntQxlYs=;
        b=t9nwjhY8s9jAk7CNa/duLCuzHRA/nhIPm9PvgFf+Rfgeu89yi17PrZhKOy0Q6zvXsbMyJA
        Gagd32VpKHjt2gM4k+f7rQnCmCjv5nLZbDfz4BvYPv+n0rs24Bc7UjO7zNUzD1UX1OHwwz
        gF5bhdg6Ga20DSC2S9XsQoHaRKVoWxM=
From:   Michael Walle <michael@walle.cc>
To:     herve.codina@bootlin.com
Cc:     alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        horatiu.vultur@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org, sboyd@kernel.org, thomas.petazzoni@bootlin.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 1/3] clk: lan966x: Fix the lan966x clock gate register address
Date:   Tue,  5 Jul 2022 15:00:36 +0200
Message-Id: <20220705130036.1384656-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704102845.168438-2-herve.codina@bootlin.com>
References: <20220704102845.168438-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The register address used for the clock gate register is the base
> register address coming from first reg map (ie. the generic
> clock registers) instead of the second reg map defining the clock
> gate register.
> 
> Use the correct clock gate register address.
> 
> Fixes: 5ad5915dea00 ("clk: lan966x: Extend lan966x clock driver for clock gating support")
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Tested-by: Michael Walle <michael@walle.cc>
