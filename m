Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BD5577A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiGRFbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRFbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:31:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C34DF85;
        Sun, 17 Jul 2022 22:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6106B80F4B;
        Mon, 18 Jul 2022 05:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF0CC341C0;
        Mon, 18 Jul 2022 05:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658122275;
        bh=USlOH77o98zsEtpsaF58YmchsywV0YCdwcA4xPf5J/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pD6lQCTYIlxO4s0PMC3MD785SlHGJ6MAmrkVs6I7QxIlBbRO1IjmPD7KGcqCcqOW4
         0fDHPiBAC+G6MIrbx7GZ2XLJK+cknRfJvq5aHygQCDtoZ9IbQUhgYNYAw8jN8+uy9c
         LCxgpLXksUEy9ejXvb2KCLfJfsqh/f3ZNBCkSpFtK0JHYFxtVWBB9N8eA8yh6VaSYM
         Sky5yqRDqz6S15qZIQBA6VVrA9rBG9yzloUzXR2x2/129hSC6ae+ip1pMNfAFGiKHq
         YJNJIMoVHcwY36kpq8UIT1oLQxZAvWeD4xEegDJKJ4rDse37O+PvWY0tAxU0SGojG3
         955QH438eoylA==
Date:   Mon, 18 Jul 2022 11:01:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sdm845-db845: Some i2c fixes
Message-ID: <YtTwH76dQFMWkX9/@matsya>
References: <20220717034403.2135027-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717034403.2135027-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-22, 20:44, Bjorn Andersson wrote:
> On my db845c (perhaps old firmware?) i2c14 is using GPI, so this enables that.
> And while I'm touching it I added dma properties to all the geni i2c and spi
> nodes and specified a default clock to avoid two warnings in the log during
> boot.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
