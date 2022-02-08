Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8A4AD125
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiBHFkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiBHFhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:37:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D269C03BFEC;
        Mon,  7 Feb 2022 21:33:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D3A1B81851;
        Tue,  8 Feb 2022 05:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1258C004E1;
        Tue,  8 Feb 2022 05:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644298400;
        bh=GvMavZdaXd2dac9vDfywbs/WRakU62/+ADWBjauPTEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyCVw4UtJlJfJfVzCSbizSNBkVvOKCYXhvaTXsaRckYX3CEfCeicvgvj2h6CIxDMz
         F6ME+Ur9ZyNzCJedKadFMjx9Kp6uTlSzobyQOBQRN5PbL4c8Jcn4qdL9jXU3vWtdFS
         OYfOpqdp5ZcwLsvY2ZrHqJpCGwZkIcOxfx5LsbCfCYcnecKaa5dRoQRLUNNo2/k5gc
         Cs6zIT+MkB4+2KcMpd8III82vjMz30p98XB9YQMmLzUAZUk/dLlReYEgyP7j2spHQ1
         Me4ROB/HWfD9APk8seBn+VP5mz87gJ6TqT8yG6vl9c/bqblGSSMwf60C/thKTI71pG
         D7+SpyITIm1nQ==
Date:   Tue, 8 Feb 2022 11:03:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        robdclark@gmail.com, quic_khsieh@quicinc.com,
        quic_abhinavk@quicinc.com, linux-phy@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REPOST PATCH v1 0/3] Add support for eDP PHY on SC7280 platform
Message-ID: <YgIAnNlrwVZOvWPM@matsya>
References: <20220208001704.367069-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208001704.367069-1-dianders@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-22, 16:17, Douglas Anderson wrote:
> This is a repost of the patch series that Sankeerth Billakanti posted
> back in November. As Stephen pointed out [1] a few days ago, it wasn't
> posted to the right place.
> 
> I've tested this and it seems to bring the eDP up on my sc7280 board,
> so I'm re-posting it in the hopes that it can land soon-ish unless
> there's something terribly wrong with it. ;-)
> 
> If it makes folks happier, I have no objections to Sankeerth's
> original patches landing. These are the exact same thing but simply
> with the addition of my Signed-off-by.
> 
> [1] https://lore.kernel.org/r/CAE-0n50sONq+URcWwvDH=UPshgy6+XZEB3sK_4n+5jNktHsEhg@mail.gmail.com

Applied all, thanks

-- 
~Vinod
