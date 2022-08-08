Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE658CEA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiHHTmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHHTmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:42:47 -0400
Received: from cassarossa.samfundet.no (cassarossa.samfundet.no [IPv6:2001:67c:29f4::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3A915FCE
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:42:45 -0700 (PDT)
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.94.2)
        (envelope-from <egtvedt@samfundet.no>)
        id 1oL8e7-00C88y-G2; Mon, 08 Aug 2022 21:42:39 +0200
Date:   Mon, 8 Aug 2022 21:42:39 +0200
From:   Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>, hskinnemoen@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] AVR32 change for 6.0 - outstanding cleanups
Message-ID: <YvFnL37+33cSIo3g@samfundet.no>
References: <Yuo/mq0VrqTH9BS+@samfundet.no>
 <CAHk-=wj6SoG7iSDLijPKWQXhJkfTknMTQ9ZUUTpz+pY=Sq5ziQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6SoG7iSDLijPKWQXhJkfTknMTQ9ZUUTpz+pY=Sq5ziQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Around Thu 04 Aug 2022 15:23:16 -0700 or thereabout, Linus Torvalds wrote:
> On Wed, Aug 3, 2022 at 2:27 AM Hans-Christian Noren Egtvedt
> <egtvedt@samfundet.no> wrote:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git for-linus
> 
> I've pulled this, but can I please ask you too to use a signed tag for
> pull requests?
> 
> No, it's still not a hard requirement for kernel.org pulls since we
> have strict rules for kernel.org anyway, but I've successfully
> bullied^Wconvinced most people to do it, to the point where this merge
> window I've so far only seen two pull requests that aren't using
> signed tags.
> 
> Please?

Sure, no problem. I will create a signed tag for next round. Almost done
removing AVR32 leftovers.

-- 
Best regards, Hans-Christian Noren Egtvedt
