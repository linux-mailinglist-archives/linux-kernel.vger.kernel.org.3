Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9354504D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiDRIEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiDRIEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93CABCB4;
        Mon, 18 Apr 2022 01:01:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2CCC61046;
        Mon, 18 Apr 2022 08:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65842C385A1;
        Mon, 18 Apr 2022 08:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650268910;
        bh=IyzSVLfdcBbKl8zIAujJzT6QnmAgtPWoVsrvljUu2cY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZm+zTtL1HVfBKRURRM6yHdFi1tuH9UUEhml7HIpSkb9R5nUFgyJguKcup90Hd0PT
         W1eC8/f/MeJAe9GqfcjF3dxsknjk3WBNvRKKK1eKEcgKaP5kGndAqT8F8Akw/p8IZG
         WJbv0CEfFR1J4XAfTVBG7dXd/VBlJFYCZVQF1UNq5REQ0/qUuqSI3CPStThD0DFDE5
         L4Mvz6Rc6aF7psSNTKEH2+P44bokEOyhEYdJAA3ijU5S+D4XSiNuc1KMRvIWgpjSEH
         lG+YwSpSDtwJ+ycv0dSYbTTvlLSNaKG6H2572KLnaIyk5FHMzpyuwXFAPcEzcVPc5X
         AtTfTXU0t9HQA==
Date:   Mon, 18 Apr 2022 13:31:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8350: Add GENI I2C/SPI DMA
 channels
Message-ID: <Yl0a6THylbktMnp9@matsya>
References: <20220412215137.2385831-1-bjorn.andersson@linaro.org>
 <20220412215137.2385831-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412215137.2385831-2-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-22, 14:51, Bjorn Andersson wrote:
> The GENI I2C and SPI controllers may use the GPI DMA engine, define the
> rx and tx channels for these controllers to enable this.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
