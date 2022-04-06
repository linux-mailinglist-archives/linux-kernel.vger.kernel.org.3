Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A94F6C81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiDFVWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiDFVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:22:00 -0400
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F003AE65
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:16:06 -0700 (PDT)
Received: from [2601:449:8480:af0::46ce]
        by baldur.buserror.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <oss@buserror.net>)
        id 1ncC2J-006Lmc-Cd; Wed, 06 Apr 2022 15:13:51 -0500
Message-ID: <7c2261ee00920aa6f8e6aeef98d99d34944957ab.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 06 Apr 2022 15:13:50 -0500
In-Reply-To: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
References: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0::46ce
X-SA-Exim-Rcpt-To: andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, brgl@bgdev.pl, linus.walleij@linaro.org
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v1 1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node
 assignment
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-23 at 19:43 +0200, Andy Shevchenko wrote:
> Let GPIO library to assign of_node from the parent device.
> This allows to move GPIO library and drivers to use fwnode
> APIs instead of being stuck with OF-only interfaces.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


