Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2FB5261E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380270AbiEMMaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350172AbiEMMar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:30:47 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3645F33;
        Fri, 13 May 2022 05:30:40 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2819A200002;
        Fri, 13 May 2022 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652445037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfIZfPF0PPO2o8Rv7WWbDVcJ48+Oi7T4hGnm7JBXGCU=;
        b=cTMZuuLBflU3IvfP3AHQkWSlhNlLdeqsxtIxfaqKJOLT7MeF6Rk7URV47KS/+mYQSWGmCZ
        Q7pgRXyJUxZlfh2Cae6/RTbGjQqJONZyZ7QjEpP1dSJY6eBAPSj5IHWal04SR4pk9pL2C9
        lZcA0h4WmC9IB2UccQXTlcaoD9BIvZkUW4NuC2OacMIIYo1DhBf06060X+/S/1L9RoWe6F
        VfpVsvh4vsWaOwHm62YTKzI4ncziEZKC3HZu+RJSSAgu6FwDhsBiYmiJay1zEJ6QZcjxha
        ZmojSV6psVY61zwNDNZOvcLebROO4oRm1UC8iiIekyEe93XbKHOUY6evtj4bAA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [patch 04/10] clocksource/drivers/armada-370-xp: Convert to
 SPDX identifier
In-Reply-To: <20220510171254.592781786@linutronix.de>
References: <20220510171003.952873904@linutronix.de>
 <20220510171254.592781786@linutronix.de>
Date:   Fri, 13 May 2022 14:30:30 +0200
Message-ID: <87wnepr4wp.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> The license information clearly states GPL version 2 only. The extra text
> which excludes warranties is an excerpt of the corresponding GPLv2 clause
> 11.
>
> So the SPDX identifier covers it completely.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory
> ---
>  drivers/clocksource/timer-armada-370-xp.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> --- a/drivers/clocksource/timer-armada-370-xp.c
> +++ b/drivers/clocksource/timer-armada-370-xp.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Marvell Armada 370/XP SoC timer handling.
>   *
> @@ -7,10 +8,6 @@
>   * Gregory CLEMENT <gregory.clement@free-electrons.com>
>   * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>   *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - *
>   * Timer 0 is used as free-running clocksource, while timer 1 is
>   * used as clock_event_device.
>   *
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
