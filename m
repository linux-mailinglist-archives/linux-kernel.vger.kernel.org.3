Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0E573CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiGMSrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiGMSrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:47:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE92C654;
        Wed, 13 Jul 2022 11:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B251B81E38;
        Wed, 13 Jul 2022 18:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B6DC34114;
        Wed, 13 Jul 2022 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657738062;
        bh=4rDfaPKROHhhVXEVjoVbRQkOiciAvRHPA1flmVehtyk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l/GczeGRAjW2IAxLewUEtoGNqhjYzEV07q28vyPsMG96cZOVueHmAk1dZ1SN74q0a
         Y7/dAMTNjX4tPVAMMJlzQaJKduDux2ktE90KDYIjn5fLBsMMuQwbohmKJEL1pq5ECV
         WA9eQSNY1Xm3B6qkZ7rmurDpQZ5t7JPRft4kBbamb+zQDtyfSCiEyVcwRdp578hceu
         RgqwBz9skTWvs3RALvyYsNq0xBDayp/AGLQHX1RjUtVZwpakx/8gcNUPkZUh0HJQz4
         jYf30JC62sJ3wAZcT+ywX6nXntmZJFHo+pzgx1wVxTkalaaQMKcDEwCfx6sNuPaz9a
         rXODNrdWJMy7A==
Message-ID: <d6d0220e-3464-cdb0-983d-d7677ce297da@kernel.org>
Date:   Wed, 13 Jul 2022 20:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 13/20] rv/reactor: Add the panic reactor
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <67e522ab57e64eee313af508a8c70f3cce33e525.1655368610.git.bristot@kernel.org>
 <3230f073-5228-693e-f7cd-5fc4b7226a66@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <3230f073-5228-693e-f7cd-5fc4b7226a66@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 23:03, Randy Dunlap wrote:
>>  	  Enables the printk reactor. The printk reactor emmits a printk()
> 	                                                 emits
> 

Fixed all the cases!

-- Daniel
