Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D42F483556
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbiACRHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiACRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:07:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C6C061761;
        Mon,  3 Jan 2022 09:07:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 294A5CE117F;
        Mon,  3 Jan 2022 17:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3516CC36AEB;
        Mon,  3 Jan 2022 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641229667;
        bh=jkSk31QDIM5s+9ePDN5Jb6L6NRLmwDjSEIOaC/hqZLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d9Nr+X9+U+g6EVJUVmEHwP679adAISFKL46TU16Rl9H4z1Zpd2gYt3Cu7060atTEp
         qJmLkMs2eQ/p3abHrFizSUnYFwtQS90/S91X1w2ERxYcvtr/yzwuUsw2HcODjclDWC
         3PEdqK2Twk2Is2G8c3h3pW1s1PGqr7z7UB/KXmumbuTszfYxONRverI8PcLt4ix5EQ
         y0H071ptdykxjj4rJz372Ksw3KxqEriI1TRNwdxqMpr+BJ6gefjUL2Jet+9ygCuri4
         RQJhnmziYT4V7GbUxig4UI1y7GE+4sFwam4j+okjnHRj1j/Hwk3Dt9Tpr7T648dkf9
         jp5GGRhmH7Pcg==
Date:   Mon, 3 Jan 2022 09:07:45 -0800
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
Message-ID: <20220103090746.2599f729@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <7b71a1262b8b72d30154203bb14f00db7d4170ef.1641203216.git.linux@leemhuis.info>
References: <cover.1641203216.git.linux@leemhuis.info>
        <7b71a1262b8b72d30154203bb14f00db7d4170ef.1641203216.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jan 2022 10:50:50 +0100 Thorsten Leemhuis wrote:
> +How to see which regressions regzbot tracks currently?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Check `regzbot's web-interface <https://linux-regtracking.leemhuis.info/regzbot/>`_
> +for the latest info; alternatively, `search for the latest regression report
> +<https://lore.kernel.org/lkml/?q=%22Linux+regressions+report%22+f%3Aregzbot>`_,
> +which regzbot normally sends out once a week on Sunday evening (UTC), which is a
> +few hours before Linus usually publishes new (pre-)releases.

Cool, I wonder if it would be a useful feature to be able to filter by
mailing lists involved or such to give maintainers a quick overview of
regressions they are on the hook for?
