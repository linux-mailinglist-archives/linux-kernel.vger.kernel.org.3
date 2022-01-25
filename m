Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C841C49B62E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387651AbiAYOZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578543AbiAYOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD9CC061753;
        Tue, 25 Jan 2022 06:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED34CB80ED5;
        Tue, 25 Jan 2022 14:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7D3C340E0;
        Tue, 25 Jan 2022 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643120409;
        bh=VBPXtoyeUSCVpRdAAI/yKsdzCJEI/YyXimeoOTxuR1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qprXV0k5ZdGWTGdxA7swhxADvrp7GvbmLQBUOcx4PWb90IzJHt4T1wUECx2fCiBGM
         B8jKwM2k7qMNh4WeMVQ/dQSt01od5zD+22407x6l4jGjChlcGIX0gbpxTqr7huwbUx
         uyfew3i6T1UOkmXM7AJgh/fqZ22iirgq/MyzlwOxdNIg/BrIHzxV5qpylAzHHVWGlY
         bgGZCXEqZ2DMx4/i0N/tDCszu5zYlK6ZghzB0CK0MC3bFoDQHAKuowadeHbVvoy4zu
         m51vKRAaXYrR9yz/Hz/ATNllJRUrPlITqBPn5XftB7eq6kxoHhxLd9W9qV9tFeFpkj
         l/7MbMC5k3iCw==
Date:   Tue, 25 Jan 2022 19:50:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8450: enable
 GCC_USB3_0_CLKREF_EN for usb
Message-ID: <YfAHFYHtEzV9Tc+L@matsya>
References: <20220122162932.7686-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122162932.7686-1-jonathan@marek.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-22, 11:29, Jonathan Marek wrote:
> USB doesn't work at all without this clock enabled. This fixes USB when not
> using clk_ignore_unused.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
