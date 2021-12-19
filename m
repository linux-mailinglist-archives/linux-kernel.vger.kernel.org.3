Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21C247A2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhLSW35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:29:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57076 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbhLSW34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:29:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DDCDB80D13;
        Sun, 19 Dec 2021 22:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA2EC36AE0;
        Sun, 19 Dec 2021 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639952993;
        bh=WZHvYM1NaHiC+0EkPRsy6OrrEhMLzt7zU2cxnh2rPcM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=msm8uPWbIVFV1zp4KyQd5KTQPgh1DkMt34qrc+jB/9UOM+d7HSd8v7WFfNDG9p5GR
         CNXYWcNYEQyOt5dME5KbNO1a3v0imrFe7pycama1lyrrlSPil87SPzU3HwW2y1wvAa
         q69D6DTafHQPfXbIpxvhbUxCJPDfsBSqEGEDqf0Q2dMxeLY40x3fZXV3DEGQb4WZ5H
         WuCei8RUY9kBziqG+zhk6tEHdZg5k8xehM0DE3sGQ4rUz/LxNfK1O6lwXcj+7kPQMT
         h+i6yxIqcf0KRX5ISPNxRgBm3gu34oFmDQom/ZzPoAU01VAQZUnrIYrrim6LR7nX2B
         COOvIJxXM9IBQ==
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20211217161549.24836-1-semen.protsenko@linaro.org>
 <20211217161549.24836-2-semen.protsenko@linaro.org>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <2fdc5c97-6c19-8e70-d717-28b29d86160c@kernel.org>
Date:   Sun, 19 Dec 2021 23:29:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217161549.24836-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.2021 17:15, Sam Protsenko wrote:
> System Register is used to configure system behavior, like USI protocol,
> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> make it possible to modify SYSREG registers.
> 
> While at it, add also missing PMU and GPIO clocks, which looks necessary
> and might be needed for corresponding Exynos850 features soon.
> 
> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>
> Acked-by: Rob Herring<robh@kernel.org>
> Acked-by: Chanwoo Choi<cw00.choi@samsung.com>
> Signed-off-by: Sam Protsenko<semen.protsenko@linaro.org>

Apologies for late reply, this patch is applied now.
