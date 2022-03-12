Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96094D6D84
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiCLIPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiCLIPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:15:38 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B1AF1B784;
        Sat, 12 Mar 2022 00:14:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B3BFA80B3;
        Sat, 12 Mar 2022 08:13:03 +0000 (UTC)
Date:   Sat, 12 Mar 2022 10:14:31 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Paul Walmsley <paul@pwsan.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC RFT PATCH 0/4] ARM: OMAP1: clock: Convert to CCF
Message-ID: <YixWZ+IiN2l9jmzg@atomide.com>
References: <20220310233307.99220-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310233307.99220-1-jmkrzyszt@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [220310 23:32]:
> The main motivation behind this series is planned resurection of OMAP1
> camera driver.  Since OMAP1 clock internals have never been visible to
> drivers, that driver used to use v4l2-clk to expose a pixel clock for a
> sensor.  The v4l2-clk code has been recently depreciated and removed from
> the media subtree, hence the need for an alternative solution.

Nice :) This will also help Arnd with building multi-v5 kernels.

Regards,

Tony
