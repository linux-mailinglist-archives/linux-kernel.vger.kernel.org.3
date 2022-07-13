Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2116557313C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiGMIfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiGMIfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:35:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B51DA58D0;
        Wed, 13 Jul 2022 01:35:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B64B1FD4C;
        Wed, 13 Jul 2022 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657701334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CcsBBbemJwPnREj8tUcGtqYBeLDK85WV0Rb0buPzp3s=;
        b=BJ/2pHkXbNnHfTFeBIIZK9+C7zTuLNqlfrU5AON0AgJDEBieZg/cptr5j4lSS/Tth2GZh5
        uTTDK6JayWctFwZVWdAzcIMoe1cRbOEyqznFtt3Io4SkUf29BmMApL/9YZ4yawoXTVuWCf
        erYJs5aGcZo5a/6X98xFnRLAQa4ADEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657701334;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CcsBBbemJwPnREj8tUcGtqYBeLDK85WV0Rb0buPzp3s=;
        b=29egoYKkhz8DyFsT88GI2fB5xWVcR3WZlWzZxkJDRz32bg0P8E5Vfsut9piqSGhsjFOuvx
        Z82YwHDwj+9CZZBQ==
Received: from g78 (unknown [10.163.24.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4DBB22C141;
        Wed, 13 Jul 2022 08:35:33 +0000 (UTC)
References: <Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020> <87wncknkfe.fsf@suse.de>
 <CABGWkvqF9f4vOYUQeYuaDGT7yuB=8=h=yPpuG04VwicNP=wgMA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
        lkp@lists.01.org, Jeroen Hofstee <jhofstee@victronenergy.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-can@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>, ltp@lists.linux.it
Subject: Re: [LTP] [can] c4e54b063f:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/workqueue.c
Date:   Wed, 13 Jul 2022 09:23:28 +0100
Reply-To: rpalethorpe@suse.de
In-reply-to: <CABGWkvqF9f4vOYUQeYuaDGT7yuB=8=h=yPpuG04VwicNP=wgMA@mail.gmail.com>
Message-ID: <87v8s1l8a3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Dario Binacchi <dario.binacchi@amarulasolutions.com> writes:

> Hello,
>
> On Mon, Jul 11, 2022 at 10:05 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>>
>> Hello,
>>
>> kernel test robot <oliver.sang@intel.com> writes:
>>
>> > Greeting,
>> >
>> > FYI, we noticed the following commit (built with gcc-11):
>> >
>> > commit: c4e54b063f42f20a6b3ad1ffa61c574e631e0216 ("can: slcan: use CAN network device driver API")
>> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
>> > master
>>
>> I guess the problem is this may sleep with soft irqs disabled.
>>
>> static int slc_close(struct net_device *dev)
>> {
>>         struct slcan *sl = netdev_priv(dev);
>>         int err;
>>
>>         spin_lock_bh(&sl->lock); <-- takes lock
>>         if (sl->tty) {
>>                 if (sl->can.bittiming.bitrate &&
>>                     sl->can.bittiming.bitrate != CAN_BITRATE_UNKNOWN) {
>>                         spin_unlock_bh(&sl->lock);
>>                         err = slcan_transmit_cmd(sl, "C\r");
>>                         spin_lock_bh(&sl->lock);
>>                         if (err)
>>                                 netdev_warn(dev,
>>                                             "failed to send close command 'C\\r'\n");
>>                 }
>>
>>                 /* TTY discipline is running. */
>>                 clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
>>         }
>>         netif_stop_queue(dev);
>>         close_candev(dev); <-- calls cancel_delayed_work_sync()
>>
>
> I would try (since I am unable to replicate the test) to move the
> spin_unlock_bh()
> before calling close_candev().

I haven't tried, but I think it should replicate every time with
lockdep/lock debugging enabled.

> Can the patch be sent now or do I have to wait until the code is in
> mainline?

IMO it *has* to be fixed before going into mainline :-p. I can't comment on
the correctness of the proposed fix though.

-- 
Thank you,
Richard.
