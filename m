Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB6483670
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiACR4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:56:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54006 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiACRz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:55:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4B63B80B4C;
        Mon,  3 Jan 2022 17:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348CBC36AED;
        Mon,  3 Jan 2022 17:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641232556;
        bh=Tgzn/rb+HnJQ8o7j1zZ/A7Ix4BYJq+5XmPEjmIm0Hpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lnU5+8bP2RBURZfo/2u3ulvtFggcSdb1Tl1ZOGTtDLscyt8TINm8WQbzP83iWmJUM
         PKkiqy3iJFKW1MQmyoNAu/SeEXt0znFVfrBcNKNbTG/ZdnPlecuuLrVI7XJERTdZ3B
         Vcfil6dSv8MPGHdZLOgXm3CCnqq/9oq0e+omRQ9zUAYTUFWWf7TljCEGzNwvAU9r6r
         YTfbhliUbp+PNWMVUsjyL/NbawBjnkK4HyMQlTdVLCdE9H7kGdtekvNHRBFwiLi13L
         dATEgYZ0Sd16WKqtCnOi+1/jTnAM0a59SnSoHwi1SR2vZtUywazHc901/Pbzfr7gZX
         sSe5/Sc1UltFA==
Date:   Mon, 3 Jan 2022 09:55:54 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 1/2] docs: add a document about regression
 handling
Message-ID: <20220103095554.34602944@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <122bf6e0-8e1f-6567-252e-5120b3f8a573@leemhuis.info>
References: <cover.1641203216.git.linux@leemhuis.info>
        <7b71a1262b8b72d30154203bb14f00db7d4170ef.1641203216.git.linux@leemhuis.info>
        <20220103090746.2599f729@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <122bf6e0-8e1f-6567-252e-5120b3f8a573@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 18:20:23 +0100 Thorsten Leemhuis wrote:
> On 03.01.22 18:07, Jakub Kicinski wrote:
> > On Mon,  3 Jan 2022 10:50:50 +0100 Thorsten Leemhuis wrote:  
> >> +How to see which regressions regzbot tracks currently?
> >> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +Check `regzbot's web-interface <https://linux-regtracking.leemhuis.info/regzbot/>`_
> >> +for the latest info; alternatively, `search for the latest regression report
> >> +<https://lore.kernel.org/lkml/?q=%22Linux+regressions+report%22+f%3Aregzbot>`_,
> >> +which regzbot normally sends out once a week on Sunday evening (UTC), which is a
> >> +few hours before Linus usually publishes new (pre-)releases.  
> > 
> > Cool, I wonder if it would be a useful feature to be able to filter by
> > mailing lists involved or such to give maintainers a quick overview of
> > regressions they are on the hook for?  
> 
> Ha, that's a great idea, many thx. I have been scratching my head for a
> while already how to give maintainers a better overview, but the only
> thing I came up with was "check the merge path a commit causing the
> regression took", which has a few obvious downsides (it for example
> won't work if the culprit is not known yet). This should work a lot better.
> 
> But be warned, will likely take a few weeks (months?) before I get to
> implement that: I have less time to work on the regzbot code than in the
> past weeks, as I have to take care of a few other things first (most of
> them related to regzbot).

No worries, do ping when you got it ready tho :)
