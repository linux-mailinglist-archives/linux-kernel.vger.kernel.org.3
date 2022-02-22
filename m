Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285894BFD77
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiBVPue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiBVPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:50:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956FE473B8;
        Tue, 22 Feb 2022 07:50:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30E51616A0;
        Tue, 22 Feb 2022 15:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180DCC340E8;
        Tue, 22 Feb 2022 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645545006;
        bh=3XdVfBzyh+mWPNy+QvRp+YnXjB3vswTd41Cbift6fF4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XuSsSZNsCXciSlKrbknV9i6INNiYHpgdKzl9o8Ny9lM69hqySz6i84GupToSyXyC/
         a/1smK2ypt0Oem7SdqQOnxQxSMU6TtrnJ0aYOPFMJc0eWlDw7adFHBbirjtChiJ0ju
         YJfYBGR4DEg0t4STiyCfz8RB+tbzwi8w0fwc6TYS6B+OyLCryqglyeMWK+lFPHEdoI
         FoycYI5d2lIxpXEcTSit9gDdREO9ZR/lDev3fgt2Xo6FqFpzMHMWa4YOQHtAf7kPBp
         6Zl3XSbRatqhPUZKfoBYf09duakmwyG7ZwYQB4U0HWiV7G26oTueBX2WxuFLgdlzb3
         pPot3j+83ZlMw==
Message-ID: <19cd9219-73af-3444-4dd5-e3c3499b2324@kernel.org>
Date:   Tue, 22 Feb 2022 09:50:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: socfpga: cleanup spdx tags
Content-Language: en-US
To:     trix@redhat.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217173453.3262672-1-trix@redhat.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220217173453.3262672-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/22 11:34, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Replace tabs with spaces in SPDX tag
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/clk/socfpga/clk-periph-s10.c | 2 +-
>   drivers/clk/socfpga/clk-pll-s10.c    | 2 +-
>   drivers/clk/socfpga/clk-s10.c        | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
> index cbabde2b476b..f5c1ca42b668 100644
> --- a/drivers/clk/socfpga/clk-periph-s10.c
> +++ b/drivers/clk/socfpga/clk-periph-s10.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier:	GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2017, Intel Corporation
>    */
> diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
> index e444e4a0ee53..1d82737befd3 100644
> --- a/drivers/clk/socfpga/clk-pll-s10.c
> +++ b/drivers/clk/socfpga/clk-pll-s10.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier:	GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2017, Intel Corporation
>    */
> diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
> index 4e508a844b3d..9b2e0275fbf7 100644
> --- a/drivers/clk/socfpga/clk-s10.c
> +++ b/drivers/clk/socfpga/clk-s10.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier:	GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2017, Intel Corporation
>    */

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
