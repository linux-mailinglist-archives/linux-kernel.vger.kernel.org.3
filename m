Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC8513B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351062AbiD1SdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351056AbiD1SdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:33:21 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D9810E0;
        Thu, 28 Apr 2022 11:30:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1E99937A;
        Thu, 28 Apr 2022 18:30:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1E99937A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651170605; bh=uUe5JPUPEKkIi+hqGokCtEf0h8oRxp9iVJg9+zYxsU8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Qf2JMoC0f+2BtE+ldAj5N9nc346WH2ayqc1wBBGg6xqO0/ETgNv/7JCqJlZpVGntE
         t5eQQpaptDH3ukGgDG0DWp8tjzjKPNpzW8ezr1mKMS3fcNXqtOm6QRmoVpXh5qqDV6
         obkv1eE/rL2uzYmlV0xS2LnWd9NXbGVutC/cXUldjWG5X8RcENNHgrH3RSYL5EV3vk
         K9mViUJCCJPxq2Nl5oEEyhdT0GVVahNKcdqmDjn5krjTaL61yWKokPhgh5/3S1btnw
         YmXMd1zePutOLpQE0cK4ehlF8KKu/jX8X7HjWIESFJBl5vt5YlzBh3BSXT41VwvlRz
         a06fVk+p9PLiw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] Documentation: devres: fix typo in interface list
In-Reply-To: <20220427073142.16700-1-johan+linaro@kernel.org>
References: <20220427073142.16700-1-johan+linaro@kernel.org>
Date:   Thu, 28 Apr 2022 12:30:04 -0600
Message-ID: <877d796oyb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan+linaro@kernel.org> writes:

> Fix the misspelled devm_get_clk_from_child() helper name in the devres
> interface list.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 5018403fe82f..2d39967bafcc 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -249,7 +249,7 @@ CLOCK
>    devm_clk_bulk_get()
>    devm_clk_bulk_get_all()
>    devm_clk_bulk_get_optional()
> -  devm_get_clk_from_childl()
> +  devm_get_clk_from_child()
>    devm_clk_hw_register()
>    devm_of_clk_add_hw_provider()
>    devm_clk_hw_register_clkdev()

Applied, thanks.

jon
