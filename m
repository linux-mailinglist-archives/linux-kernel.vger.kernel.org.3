Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA15AB6FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiIBQ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiIBQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:57:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0ECF5CCA;
        Fri,  2 Sep 2022 09:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66724B82C73;
        Fri,  2 Sep 2022 16:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20911C433D6;
        Fri,  2 Sep 2022 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662137873;
        bh=nSblD5UqCy74QFKWkUWbtw4B/a+G4x9PFaaqP+ffbgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPUdkaN3kUxA4RJQedVLuYLtMrsfxJftBpL4EPU+1fJxwKKxW61Xi50vSAoR4GWM7
         zz1tTvHGM2AoGE/zFxY0c0q15dBYUcLJy44sjYfLj9eR+oW9O7nCYJ4QqfvjpEKUfn
         8QL+W7GxCY7z7JtLxIS5w/9gPZymevv3G1wVVbGEjpt1KZH2XxFj7b9tZGcJNH1m82
         /LzVuO9qK/gTCWSlPfneEh+ZfZxpWfUfJJbQc1UTIg7IlayRZsM6RNMdOxVaINJkS6
         DejLnhK0LFzn2ps4j/C8nQLXp5VW5F9YbxDNPqVJVmp3I7w1oXXCmlS0jTAPzC6azN
         D/maxdqIpDiXg==
Date:   Fri, 2 Sep 2022 22:27:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH] phy: qcom: edp: Postpone clk_set_rate until the PLL is up
Message-ID: <YxI2CyoBNnV+q22W@matsya>
References: <20220805154432.546740-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154432.546740-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-08-22, 08:44, Bjorn Andersson wrote:
> When the platform was booted with the involved clocks enabled the
> clk_set_rate() of the link and pixel clocks will perculate to the
> children, which will fail to update because the PHY driver has just shut
> down the PLL.
> 
> Postpone the clock rate updates until the PLL is back online to avoid
> reconfiguring the clocks while the PLL is not ticking.

Applied, thanks

This gave me a conflict which I think I have resolved, pls do check

Thanks
-- 
~Vinod
