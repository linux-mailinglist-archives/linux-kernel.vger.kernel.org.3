Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA76546B216
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhLGFIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:08:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52178 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhLGFIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:08:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5097BB812A7;
        Tue,  7 Dec 2021 05:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E7AC341C1;
        Tue,  7 Dec 2021 05:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638853505;
        bh=Id5CjFD7567HKM0pW34CSYpAxpPcH5hFeKDWZOYR8wU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5fkfo6k+OECwv8GeS9dMiYdfaR0iiZN+kmaUQ6xLbL+CO7WyhjPARrFaSdLK6gRi
         4DxVisnFZuJGUfIiF0/TXP51hP7I1bC0b8RysO4DjMyHsLPV40+T6U1bCJ0fpW7iWJ
         rlyaAETR7BjLV1AiibQn3rWa/tu3HAdaQivsyVylKJFK5xRzUzQ2jehO8KDArQ1VTc
         Tu4lT4DdJipcLQr3FDFWLfhDMQr4H6eJWKwGy/jJ+hnuxF3Gi3Xaf60NNF1RWsf/Pn
         CY7JbkDIVh8CR5EN4xDqjBeQpjIdyhPaOhTFVNLCwjze/388dPkh7OgfnJnNvYLKaZ
         29126gL76hAAw==
Date:   Tue, 7 Dec 2021 10:35:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, dmitry.baryshkov@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: sm8250-dispcc: Flag shared RCGs as
 assumed enable
Message-ID: <Ya7rfVuaqgTTJEoh@matsya>
References: <20211203035436.3505743-1-bjorn.andersson@linaro.org>
 <20211203035436.3505743-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203035436.3505743-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 19:54, Bjorn Andersson wrote:
> The state of the shared RCGs found in the SM8250 dispcc can't reliably
> be queried and hence doesn't implement the is_enabled() callback.
> 
> Mark the shared RCGs as CLK_ASSUME_ENABLED_WHEN_UNUSED, to ensure that
> clk_disable_unused() will issue a disable and park the RCGs before it
> turns off the parent PLLs - which will lock up these RCGs in any system
> with continuous splash enabled.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
