Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B589849707F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 08:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiAWHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 02:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiAWHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 02:38:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48673C06173B;
        Sat, 22 Jan 2022 23:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=UdcNAIMjc7ztcdEzpkZME12kbVR0giTdEThicNaiALE=; b=h2Iov9K0l/0xc+iIcsHlD4A+Ny
        mPCCi0FlPDpDuDfEhOCB93DOsWV9g9PTIQcdqFpt4EMh9xepudI0ELmD88hkQFLQwLgnJTOrqOtmf
        hmXfndKZLrQrPXsfIXa+cyw4KKojdf9UNwBqvLUfeIBnOld++sQAqMUdRZu3BJF7Uq/fE0Ri4wcew
        rbZ7z0w2mj1OJ6otqjNteNz7YKQJTwmlaYftYM+5FPnMyELeS2Mx2RASnNeXl8grhVLIZUYiTwXXA
        X2iX+GqYbksBWpFv5JDk2eLeyYQwUTDAUa2P3JsdUtrpUzD5xwS0uYVkQz/0m4w3Aut8J9VIgy/Fm
        9+85VOig==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBXRx-00GulY-LZ; Sun, 23 Jan 2022 07:38:10 +0000
Message-ID: <44959d7e-a930-cd5a-1113-b5bfc6da7782@infradead.org>
Date:   Sat, 22 Jan 2022 23:38:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH ?next?] gpio: sim: add doc file to index file
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-gpio@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220123073536.12193-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220123073536.12193-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops. Yes, the subject should say: [PATCH -next].
Sorry about that.


On 1/22/22 23:35, Randy Dunlap wrote:
> Include the gpio-sim.rst file in the GPIO index (toc/table of contents).
> 
> Quietens this doc build warning:
> 
> Documentation/admin-guide/gpio/gpio-sim.rst: WARNING: document isn't included in any toctree
> 
> Fixes: b48f6b466e44 ("gpio: sim: new testing module")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/admin-guide/gpio/index.rst |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20220121.orig/Documentation/admin-guide/gpio/index.rst
> +++ linux-next-20220121/Documentation/admin-guide/gpio/index.rst
> @@ -10,6 +10,7 @@ gpio
>      gpio-aggregator
>      sysfs
>      gpio-mockup
> +    gpio-sim
>  
>  .. only::  subproject and html
>  

-- 
~Randy
