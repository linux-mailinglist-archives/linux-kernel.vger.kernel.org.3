Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE565141CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352148AbiD2Fgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351502AbiD2Fgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:36:45 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A06D9154C;
        Thu, 28 Apr 2022 22:33:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8DEFE80C1;
        Fri, 29 Apr 2022 05:30:19 +0000 (UTC)
Date:   Fri, 29 Apr 2022 08:33:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jmkrzyszt@gmail.com, aaro.koskinen@iki.fi, vireshk@kernel.org,
        shiraz.linux.kernel@gmail.com, nsekhar@ti.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/6] ARM: omap2: remove include/mach/ subdirectory
Message-ID: <Ymt4pc+eh4EI1eYx@atomide.com>
References: <20220428133210.990808-1-arnd@kernel.org>
 <20220428133210.990808-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428133210.990808-2-arnd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [220428 13:29]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> mach/serial.h is only included from arch/arm/mach-omap2/serial.h,
> and the other two files are unused and empty.
> 
> Remove the directory by relocating the contents of mach/serial.h
> and dropping all other references.

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
