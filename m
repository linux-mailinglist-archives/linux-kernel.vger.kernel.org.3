Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244C8513B36
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350737AbiD1SLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350728AbiD1SLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:11:40 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5EEF3A27D3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:08:24 -0700 (PDT)
Received: (qmail 920243 invoked by uid 1000); 28 Apr 2022 14:08:23 -0400
Date:   Thu, 28 Apr 2022 14:08:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ehci-omap: drop unused ehci_read() function
Message-ID: <YmrYF+WisV9UnXpr@rowland.harvard.edu>
References: <20220428102314.950323-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428102314.950323-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:22:58PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After moving the omap1 platform into generalized multiplatform
> support on ARM, the kernel test robot points out a W=1 warning that
> now shows up in more configurations:
> 
> drivers/usb/host/ehci-omap.c:64:19: warning: unused function 'ehci_read'
> 
> The function was last used 9 years ago and can just be removed.
> 
> Fixes: 87425ad36330 ("USB: ehci-omap: Remove PHY reset handling code")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>
