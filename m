Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48831475193
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhLOEEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:04:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52050 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhLOEEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:04:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65F63B81D4C;
        Wed, 15 Dec 2021 04:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E8AC34603;
        Wed, 15 Dec 2021 04:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639541088;
        bh=OFQiIOJbDDB0jieVQbMNdFCClUHvhKr3mYLSoThmrow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIT9p5f4zAijGCEl4xxozDdr36MCMdYx1k0D/h+BY9NZt2BEcNdqGOVpAolFbjdHI
         +xoFWVoUN+6fi3gvy+vThBoHDMM00JNZjHqwQrjKq0bP9FHCRsxIER80WCXNYMhGSt
         MjqICTCMLXyZjuWPyVlGHKYQiwIrizs250N9BUAdyg9yPHV29CoG/rCqiC4b9La1iA
         oa8uJhcNnYmcbUBBBNq4aksmCRakqrdbwZa6foT6b5rlMZbQtrDCce4WtNE9LLxdkM
         wgfKtUl+RJ6Z3oF+RCaLk4E3xOpZdIn+BtoWepLUeFYiDRpg1FMrx3IW5yjQZD8sce
         nL5L3bDu9ZuOw==
Date:   Wed, 15 Dec 2021 09:34:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels
 and thermal zones
Message-ID: <YblpXLf1nFnDoAhT@matsya>
References: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
 <20211005032531.2251928-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005032531.2251928-5-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-10-21, 20:25, Bjorn Andersson wrote:
> Downstream defines four ADC channels related to thermal sensors external
> to the PM8998 and two channels for internal voltage measurements.
> 
> Add these to the upstream SDM845 MTP, describe the thermal monitor
> channels and add thermal_zones for these.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
