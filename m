Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A677B5612D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiF3G4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiF3G4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:56:43 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D18DA31205;
        Wed, 29 Jun 2022 23:56:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F132780CD;
        Thu, 30 Jun 2022 06:51:25 +0000 (UTC)
Date:   Thu, 30 Jun 2022 09:56:40 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: use-after-free warnings in 5.19-rcX kernel
Message-ID: <Yr1JKPLQRj/IM21m@atomide.com>
References: <20220630043558.GA1985665@euler>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630043558.GA1985665@euler>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Colin Foster <colin.foster@in-advantage.com> [220630 04:30]:
> Hi Tony,
> 
> I'm running a beaglebone black and doing some dev on the
> next-next/master line. I noticed a lot of messages coming by during
> boot, and more recently a change that shouldn't have made a difference
> seems to stop me from booting.
> 
> The commit in question is commit: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
> Prior to this commit, the boot seems fine. After this commit, I get
> several warnings.

This should be fixed with:

[PATCH] clk: ti: Fix missing of_node_get() ti_find_clock_provider()
https://lore.kernel.org/linux-clk/20220621091118.33930-1-tony@atomide.com/

Can you please give it a try?

Regards,

Tony
