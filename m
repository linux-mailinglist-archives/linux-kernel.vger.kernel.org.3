Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE5C516918
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 03:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356330AbiEBBIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 21:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiEBBIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 21:08:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F643AA47
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 18:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0B71B80EAB
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0021DC385A9;
        Mon,  2 May 2022 01:05:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RuBV6/El"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651453503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jzyK9MyT8mC9OCGXyGNgpyYRzPGiZMOnxTghjkCxxdQ=;
        b=RuBV6/ElADelu236LLJpnixADUBmGhgpH9boUwmTsIKn/Iwr+GeczNq/UjJM7cmjrWUMNm
        Gb7eCllj/tD6S8QVkizTEc2cOdcpHMLASs6+ud78QdJ6kell+tbQn+PyMseBCWCylZEurl
        KNTbFEt4y0iHkmniFE3cUBMvi3re8TI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cba3d5bf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 01:05:02 +0000 (UTC)
Date:   Mon, 2 May 2022 03:05:01 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Changes in kernel 5.18-rc1 leads to crashes in VirtualBox
 Virtual Machines
Message-ID: <Ym8uPcuQpq1xBS6d@zx2c4.com>
References: <7f01221d-f693-adf8-f5a5-d71944b44162@lwfinger.net>
 <Ym7Hw9GDPP838JoH@zx2c4.com>
 <6bd35831-2d7a-77ee-55e9-755ca752b0c8@lwfinger.net>
 <Ym8YlXYM4HQg8tq7@zx2c4.com>
 <Ym8hoW7J60xAQv8f@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym8hoW7J60xAQv8f@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On Mon, May 02, 2022 at 02:11:13AM +0200, Jason A. Donenfeld wrote:
> Hey again,
> 
> I just installed VirtualBox ontop of 5.18-rc4, and then I made a new VM
> with a fresh install of OpenSUSE, and everything is fine. No issues at
> all.
> 
> So you're going to have to provide more information.
> 
> Jason

With still no more information provided from you, I've gone scouring and
found your much more informative bug report here:
https://www.virtualbox.org/ticket/20914 along with a larger log here
https://www.virtualbox.org/attachment/ticket/20914/Windows%2010%20Clone-2022-04-24-20-55-56.log

Why would you not have sent me all this information right away? Surely
you know how to report bugs. If you're going to concern me with the
possibility that I've broken something, at least give me enough detail
to be able to do something. Otherwise it's pure frustration.

Anyway, it's still too little information, but I could extract the
Windows build from that log file, pull down ntoskrnl.exe and hope it
roughly matches, and then go to work in IDA Pro trying to figure out
what's going on at ntoskrnl.exe+3f7d50, and if I managed to grab the
right build -- which I more than likely did not -- then that's a `mov
byte ptr gs:853h, 0` in KiInterruptDispatch, which seems entirely
unrelated to the change you mentioned.

So I think it'd be a good moment for you to show your bisect logs so we
can be certain we're after the right thing.

Jason
