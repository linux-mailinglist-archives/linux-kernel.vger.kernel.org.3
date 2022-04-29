Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296F5141C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351084AbiD2Ffs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350582AbiD2Ffn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:35:43 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2418A84A1F;
        Thu, 28 Apr 2022 22:32:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2750980C1;
        Fri, 29 Apr 2022 05:29:18 +0000 (UTC)
Date:   Fri, 29 Apr 2022 08:32:24 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jmkrzyszt@gmail.com, aaro.koskinen@iki.fi, vireshk@kernel.org,
        shiraz.linux.kernel@gmail.com, nsekhar@ti.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 6/6] ARM: omap1: add back omap_set_dma_priority() stub
Message-ID: <Ymt4aJ2OvNk+Scj/@atomide.com>
References: <20220428133210.990808-1-arnd@kernel.org>
 <20220428133210.990808-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428133210.990808-7-arnd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [220428 13:33]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> One of my multiplatform patches went a little too far and removed
> a declaration that is needed for compile-testing the omapfb
> driver on non-OMAP1 platforms:
> 
>   arm-linux-gnueabi-ld: drivers/video/fbdev/omap/omapfb_main.o: in function `omapfb_do_probe':
>   omapfb_main.c:(.text+0x41ec): undefined reference to `omap_set_dma_priority'
> 
> Add back the inline stub, and in turn hide the definition when
> omapfb is disabled, like we do for the usb specific bits.

Reviewed-by: Tony Lindgren <tony@atomide.com>
