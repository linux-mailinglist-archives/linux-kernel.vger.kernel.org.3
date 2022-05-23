Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5225312D0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiEWOdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiEWOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:33:20 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A674333E9B;
        Mon, 23 May 2022 07:33:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A1E4680C2;
        Mon, 23 May 2022 14:29:19 +0000 (UTC)
Date:   Mon, 23 May 2022 17:33:16 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/3] clocksource/drivers/timer-ti-dm: Make timer
 selectable for ARCH_K3
Message-ID: <YoubLHal7JxhoXtA@atomide.com>
References: <20220408101715.43697-1-tony@atomide.com>
 <20220408101715.43697-3-tony@atomide.com>
 <156a53a2-c33b-7ec5-3584-41ef25cb9cdd@linaro.org>
 <Yos0IOkCd4R9a9YZ@atomide.com>
 <5b71f5e8-c3df-46ef-094f-9739dd7a0f5f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b71f5e8-c3df-46ef-094f-9739dd7a0f5f@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [220523 12:37]:
> On 23/05/2022 09:13, Tony Lindgren wrote:
> > Did you notice some loadable module usage issues for timers that are not
> > system timers? Just wondering if there are some issues that I did not
> > notice.
> 
> I think the removal won't be supported. We already had a proposal to move
> one of the timer as a module but I wanted to have more insights about the
> changes, not just do that because of a GKI Android.

OK good to know.

Thanks,

Tony
