Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D896647A2EF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhLSWxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhLSWxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:53:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E98DC061574;
        Sun, 19 Dec 2021 14:53:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B179060F44;
        Sun, 19 Dec 2021 22:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEA6C36AE0;
        Sun, 19 Dec 2021 22:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639954380;
        bh=FD9AtrDTd8KjLPNhXk8ZsxoXiQCkG7iYeBcuNIPbCvs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mJS9IPz2HIPtnSTlwtXjjmSyylwzxtQWn8IY45R8rgjGkV6R1VJDiwSXN9VSNQjw9
         ElBeyQeAZTAA1eV3N0NdIHJ9voaxrw4geGOVGIcOhvtN85d4WYNAge3aosHOzW+OpB
         4/+lnU1PU1byprpxc5s2VPEwsvDzKUl9HaDld/AUXZGXBEmA2b0hpuZIn9KGSzJsgl
         uJVxbEBG7REYv0j5MKE+3qajlIDoz4sJEDBGLtDO2qkZHhJGSt5cV3o58mxyel+Aso
         Noy6yGY8OU66H4P4GY+O8CAlNFQrd14ItdAgnPDsRwu9B6E2PX2AzO96GpXpBMc+8c
         M4Vcj1oPx/TYw==
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add bindings definitions for
 Exynos7885 CMU
To:     David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-2-virag.david003@gmail.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <3c6055d4-3be2-baa5-81fb-4e5af339a945@kernel.org>
Date:   Sun, 19 Dec 2021 23:52:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206153124.427102-2-virag.david003@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.2021 16:31, David Virag wrote:
> Just like on Exynos850, the clock controller driver is designed to have
> separate instances for each particular CMU, so clock IDs start from 1
> for each CMU in this bindings header too.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: David Virag <virag.david003@gmail.com>

Applied patches 1,2,4,5,6, thanks.

