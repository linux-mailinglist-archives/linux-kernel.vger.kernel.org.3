Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B5A5276D4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbiEOKOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiEOKOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:14:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4773D1F7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:14:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JC45VqDz4xY4;
        Sun, 15 May 2022 20:14:24 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
References: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node assignment
Message-Id: <165260953366.1040779.1251561450030500031.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:12:13 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 19:43:42 +0200, Andy Shevchenko wrote:
> Let GPIO library to assign of_node from the parent device.
> This allows to move GPIO library and drivers to use fwnode
> APIs instead of being stuck with OF-only interfaces.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node assignment
      https://git.kernel.org/powerpc/c/610cc9f45881f1a3758f323d6d7d67e572958c3b

cheers
