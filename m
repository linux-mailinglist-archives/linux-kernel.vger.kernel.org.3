Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67BC59B739
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 03:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiHVBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiHVBR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6125E20BD0;
        Sun, 21 Aug 2022 18:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D2060E8C;
        Mon, 22 Aug 2022 01:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FD6C433D6;
        Mon, 22 Aug 2022 01:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661131076;
        bh=khw/7ROqATYdxiS9K3dnzmxhVPGIjNUqiF5lObZbaN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/8PS+x8jgI8naUBYxX4avOuOyaLw9A9T5845ihFHC7e5doOaN8ooDGglj0Z6HqgU
         /EoLMqjQlE7nJt39DItbtMGmIddfr3CyKExf69sXghXirU/BIVIzt7jI1J1N/yIOCU
         dNPh5z7EkHqAdVVPmROHC2YO0G6ZVYpH1E0hvN0sUHYML4sVoZG+yD7uRdTFomFZ3P
         oZw+u8WzHT2Zh2jsP2nYE4PQv78TnGouivWeGFD/45c9J54YhWzXuuzWMUgBEfLckx
         P09vtXFMpO93WZYqm3oNA/9n+E5uKI6B41wLmyR5A18DezeymeQLyF5U4gR7tTS4FC
         KJlBn0WOluBXA==
Date:   Mon, 22 Aug 2022 09:17:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: imx: align SPI node name with dtschema
Message-ID: <20220822011750.GF149610@dragon>
References: <20220810111008.280850-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810111008.280850-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 02:10:06PM +0300, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied all, thanks!
