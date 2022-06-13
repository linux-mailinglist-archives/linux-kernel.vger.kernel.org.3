Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312FD549D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350220AbiFMTZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350193AbiFMTYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:24:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2FE3A5D0;
        Mon, 13 Jun 2022 10:42:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8A3B72D6;
        Mon, 13 Jun 2022 17:42:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8A3B72D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1655142143; bh=D/tkzvqkGG3tyA96/khy1O4WmIgfRfvmO+IJpiodDjc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WIQjVqR6dCCotZXHSAN3xulM+JTXouRZjvyTfzmHRlQdfLZdnYb4B1NbvbE5NUNmK
         nV8MOfUHjSzFrNzfYEaXJWdauneDeT/8JczTujB7oDwaB3cby+DWOHa0ilRi6SWxMx
         JaWTwOdiOuFPNy7Vicc4brU5iweijhHcETACbpqkIVZwnqR+4+8aniujnV7S5h3Dzt
         tsshuLEyHsJhFgcl8rLyNvq3zr/R3b0L8V8W7SBI+9wDfszix/MT5lfU3VN/I6xGSo
         64mAOgQHtzy3HPCuT03RczmsXPJQSed91p+tFs0hxiljRlga3HuUgHQ7LCTqP0JVrx
         orjuzXQGSLMnQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] leds: Add leds-qcom-lpg entry to
 documentation table of contents
In-Reply-To: <20220612000125.9777-1-bagasdotme@gmail.com>
References: <20220612000125.9777-1-bagasdotme@gmail.com>
Date:   Mon, 13 Jun 2022 11:42:22 -0600
Message-ID: <87v8t4zcht.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> After merging linux-leds tree to the mainline [1], htmldocs build produces
> a new warning:
>
> checking consistency... /home/bagas/repo/linux-stable/Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree
>
> The warning above is because leds-qcom-lpg.rst is missing in the table of
> contents.
>
> Add the missing entry.
>
> [1]: https://lore.kernel.org/all/20220531200619.GA8906@duo.ucw.cz/
>
> Fixes: 24e2d05d1b6898 ("leds: Add driver for Qualcomm LPG")
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: linux-leds@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Pavel, that document appears to have entered via your tree; do you plan
to push this fix too?

Thanks,

jon
