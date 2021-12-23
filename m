Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39347E253
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347968AbhLWLdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:33:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51862 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347908AbhLWLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:32:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84E161E4D;
        Thu, 23 Dec 2021 11:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B682C36AE5;
        Thu, 23 Dec 2021 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640259178;
        bh=0RrhX3k1ZIV+bJYkPMaUSIE5xLzRFmh9h4IrE2Y0Ytc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0N0zOxaG+hfvhbe6NMb7vBzhs0Y2RSCGxjDsFCD1+bUxqfzCTkUx1D5FGuLOEQTF
         PaTc0vmTs8slpuAwrPJwsuA+tx9JAe+vFYOn6sACHcMNakmwwfOPlGZJWaCrwim6y7
         ZEVYQoy+09FlQmctw70t7E03e9UgsUqBY3YfFGtt2yXpmYgbIwMpRN+6L9HpQLHitF
         ryzZXuIokw3qZJ1qC7OHaIV5EKbGxVyMQTmdSpaIt6XgyQgQig1c/yvFpNBcuwM7G+
         HwUF42Q2osVSofJq5Uk7v1uw/ZMGOvuvrxsX8qK1iyj3aAprsDveLmbQAJqO2TwAqE
         pfjMhO4k7joBg==
Date:   Thu, 23 Dec 2021 17:02:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] phy: qcom-qmp: Add SM8450 PCIe1 PHY support
Message-ID: <YcReZWk8DkhFzItD@matsya>
References: <20211218141754.503661-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218141754.503661-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-12-21, 17:17, Dmitry Baryshkov wrote:
> There are two different PCIe PHYs on SM8450, one having one lane (v5)
> and another with two lanes (v5.20). This series adds support for the
> second PCIe phy.

Applied, thanks

-- 
~Vinod
