Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A912847A2B0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbhLSWb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhLSWbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:31:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E0C061574;
        Sun, 19 Dec 2021 14:31:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6AC760F2A;
        Sun, 19 Dec 2021 22:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8F2C36AE0;
        Sun, 19 Dec 2021 22:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639953082;
        bh=/w8VSLnCpu7KBXLumH6V2wW2v/0w4xv8E3n6JwbadOM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=noz5d9WRawspaO6OvMFZOQY9zV7k9Tlpn5wVc36PGDQWjcQoV7WIEG8uogYuJMFr9
         e3vLWX1IOEgNTHbv4Jo781rtxrhWgSelf8BFi2ORscrhrD8yb59cyYZ7peU/vPKoo9
         SMeZUAhPbSgQXQluWLmoIMuU4EOByZhk0v0ts5Ug8/4l/6HAezFEiBT4MZ80xpomQj
         a6ut1WCsTpFjMpq0qLqLlHBveBV+DQsoYa5lCrw9PbIjc7nzmabD2zg0aSSJ4VHlT9
         BgNAS6PIB62DzPgxgK8dgq/ljdlKwI+U3H6l933QihTODh+3wbEljpdmIKY3+xho4T
         PTyESvL0Fk0gw==
Subject: Re: [PATCH v4 2/7] clk: samsung: exynos850: Add missing sysreg clocks
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
 <20211217161549.24836-3-semen.protsenko@linaro.org>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <664ee391-f220-1864-3897-15f8d96b470a@kernel.org>
Date:   Sun, 19 Dec 2021 23:31:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217161549.24836-3-semen.protsenko@linaro.org>
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
> Acked-by: Chanwoo Choi<cw00.choi@samsung.com>
> Signed-off-by: Sam Protsenko<semen.protsenko@linaro.org>

Applied, thanks.

