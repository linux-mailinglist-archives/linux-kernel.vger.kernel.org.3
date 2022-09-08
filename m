Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C343A5B18D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIHJfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIHJfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:35:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70799C6521;
        Thu,  8 Sep 2022 02:35:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5236B82063;
        Thu,  8 Sep 2022 09:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC22BC433C1;
        Thu,  8 Sep 2022 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662629723;
        bh=BsvpsZnx9KnJ8QRTFvQwCTuxSuSoudkvqY4ah5XzgaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/3qQZQhJ7d9HsS6s5HL+atI4EWkc5zIhvQSSaBbIOiJh8TY12r2wAyySq6udDFfY
         zIArbaYivjHQzdtStin/yoXYtXGIc1eypGmkU89LN7kLJDfdaf0nXlQAwOqhV12PLV
         3xEljeFaSjAClKQ6dZAATabiiL3zFRs3hnszcT+RYM/QH4GV4JXr2mK3EZBEl7y2tE
         vI9Q7j6Rskc4zeiE2Cqb+5AEAxe+ON6HbhKqrgDHusjOjRDYbIqcKqvUPvmh/fPyNH
         LK8ij4/BYn58ibIO/gwN9S0oiXm9cmAh09jgkgAKqlvZCDinjbqF01ZJv7iMp9k/U0
         O1qYkkl/SXzHQ==
Date:   Thu, 8 Sep 2022 10:35:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] mfd/omap1: htc-i2cpld: Convert to a pure GPIO driver
Message-ID: <Yxm3Vp/Ivn/1xGj2@google.com>
References: <20220905115810.5987-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905115810.5987-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Sep 2022, Linus Walleij wrote:

> Instead of passing GPIO numbers pertaining to ourselves through
> platform data, just request GPIO descriptors from our own GPIO
> chips and use them, and cut down on the unnecessary complexity.
> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Cory Maccarrone <darkstar6262@gmail.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> If one of the OMAP1 people can provide an ACK then it's best
> if Lee takes this into the MFD tree.
> ---
>  arch/arm/mach-omap1/board-htcherald.c |  9 ----
>  drivers/mfd/htc-i2cpld.c              | 59 ++++++++++++---------------
>  include/linux/htcpld.h                |  2 -
>  3 files changed, 26 insertions(+), 44 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
