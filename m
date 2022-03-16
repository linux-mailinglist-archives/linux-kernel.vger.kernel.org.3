Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E785B4DBA43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350249AbiCPVoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351384AbiCPVoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:44:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40391ADB3;
        Wed, 16 Mar 2022 14:43:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8694E2CD;
        Wed, 16 Mar 2022 21:43:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8694E2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647466981; bh=pTCxpiHnJ4HcEdSPwvHWoWBXSEV4Es8Dj2xNtwzjhUg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MaZCaRkfgaQojS33lg6k7IcRIYU+wLzUuResI2G0ibofzz+ljXiYvXFHEgr+Wjr0S
         s28q25vlB/CRWO1RipQDrksxcGojgh1IzIWGRGsyHGRDbevIzh91KEKE523ukZqJYr
         LlL1ebEAV85hNsyYMlv1mbiZgBuUwEBcGneBkyHhMBGzUCCw3Ua2xdIgaeFjPhoXeJ
         vR1uqbejoKiySx7WJl8+EkdAbTiJKNvSMHArQWa2XOUJMn47pyJdkfxQboFEWcDcS7
         vSfdDQVcV8TTU4BCoDu7nHcWwdzxFscoVI0UTZdFtXV9ZlceRHkrgs2/AZPWMwM5x9
         yOwohyWkkaB0w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@qq.com
Subject: Re: [PATCH] docs: serial: fix a reference file name in driver.rst
In-Reply-To: <af1c7dd1-d86d-d737-643e-1f20a19c3890@kernel.org>
References: <20220304100315.6732-1-wanjiabing@vivo.com>
 <f48dcaba-8015-380f-ac3b-54818c48350d@kernel.org>
 <87mthw2o93.fsf@meer.lwn.net> <YixE4K3ScGL3v5yQ@kroah.com>
 <eee93a4c-2629-af0f-03b3-4379a128c7dd@kernel.org>
 <af1c7dd1-d86d-d737-643e-1f20a19c3890@kernel.org>
Date:   Wed, 16 Mar 2022 15:43:00 -0600
Message-ID: <87k0ctshej.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@kernel.org> writes:

> Returning to this: staring into Documentation/index.rst and 
> Documentation/driver-api/index.rst. Looking at documents/paths they 
> reference, I still don't quite understand what is the rule to put the 
> stuff to either of them.
>
> What I used to decide to put the tty stuff to the root is that it's not 
> only driver-api documented there. It documents also tty internals and 
> implementation of some line disciplines.
>
> So, now I'm confused why it does NOT belong to the root.

My thinking is: for the same reason that drivers/tty is not in the root.

I've been pushing for some time to get our documentation organized for
the readers, which means arranging things in terms of the expected
audience.  Much of what's in Documentation/tty looks like driver-api
stuff, so that's where I would like it to be.  If you have material for
other audiences, perhaps that material should go into a different book.

When I started doing this, "ls Documentation" would scroll on for many
pages.  We've been slowly moving away from that directory as an
unorganized dumping ground, but there is still a ways to go.

Thanks,

jon
