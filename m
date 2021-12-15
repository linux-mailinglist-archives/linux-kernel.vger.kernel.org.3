Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8963475190
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbhLOEEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:04:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51962 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhLOEEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:04:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D7C8B81B3D;
        Wed, 15 Dec 2021 04:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E1C34600;
        Wed, 15 Dec 2021 04:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639541075;
        bh=fEz8JHlawvAt36xn6xKd/Hr8qGJL0lJZVBGuvG88CiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtSEhYlvxU7pF79U+UOTA+zvAceun8P3qMB2Gwix8uZf/eWcSbvZwhO8gHfUAWGb9
         /DU74hdvElcP77q6X4lCmKhLIeZSIJs9DsaHzObs39sjfP6TTk/zT3M2kvRM6/4e1F
         tsGOsA1w4zkbh1ojal9XCDt+IONyc0eyITTh5auK1U2bRzddtImK0Pyh7klU0leq5c
         KBbSmw2p6Np13uNTkbHcfJxJ6ShyWHdpMFe0cDa65rqrlXwpQz1pgF5UaHyNSLdD+O
         CqQOVUDIcAvpkg8ECVlhwrBCy/BAJNorGsI0EQBOAvvN6lP47fMLAumJFt+IrUin7+
         6WCPUvpRzZ4cg==
Date:   Wed, 15 Dec 2021 09:34:30 +0530
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
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: pm8998: Add ADC Thermal Monitor
 node
Message-ID: <YblpTgpmNhBhy/eR@matsya>
References: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
 <20211005032531.2251928-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005032531.2251928-4-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-10-21, 20:25, Bjorn Andersson wrote:
> Add a node for the ADC Thermal Monitor found in the PM8998 PMIC. This is
> used to connect thermal zones with ADC channels.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
