Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069ED516B05
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358247AbiEBHFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358215AbiEBHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E493646B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6146060DE6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F91C385A4;
        Mon,  2 May 2022 07:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651474944;
        bh=x3yGif9AvuXTPm5d4yUsySCr//SuwzJ1ykDGiwIPmeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDo54O/8SwurXXMQj1YTEu6OMLrs5YpUPMKVToa90dt05Bq62zbvNQm0fijdXzxts
         IFOFfn5KHm5VkV/12qs6D09w9bmwOAhuW2DPxUv3vKAibfbsLXawqSfLzzaHmEZC48
         r7UZsIJZ5/iG2SFoO9iLsKQeGjMCLW2mLlWnKjTvZhOgNHGnDTukDC3b+L/9kV2/Pj
         TpugTkl8MrbSf4GqlrY0WPhusyivQ0PD1/B3hO8jgVjdNj53r9rUIlzhnT83GWK378
         A/47NUMS5NNBXSq68tsceWy4ePgYto15xYQHbQt0hJdmvkWce6dMdWdVtkXCKwHbC8
         V7SByv9+di4AQ==
Date:   Mon, 2 May 2022 12:32:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kishon@ti.com, heiko@sntech.de, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Clean up some inconsistent
 indenting
Message-ID: <Ym+B/GVUqPOB09/H@matsya>
References: <20220421203038.4550-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421203038.4550-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-22, 04:30, Jiapeng Chong wrote:
> Eliminate the follow smatch warning:
> 
> drivers/phy/rockchip/phy-rockchip-inno-usb2.c:1203
> rockchip_usb2phy_probe() warn: inconsistent indenting.

Applied, thanks

-- 
~Vinod
