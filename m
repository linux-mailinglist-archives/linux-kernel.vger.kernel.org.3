Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0350348A7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348168AbiAKGcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiAKGct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:32:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9684C06173F;
        Mon, 10 Jan 2022 22:32:48 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n7Ai6-0005D6-Ff; Tue, 11 Jan 2022 07:32:46 +0100
Message-ID: <51654a51-4264-c333-40d5-4f755e69d54b@leemhuis.info>
Date:   Tue, 11 Jan 2022 07:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: Add a few more FAQs to the [kernel.org] releases page
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641882768;4ae60de2;
X-HE-SMSGID: 1n7Ai6-0005D6-Ff
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Konstantin! I noticed commit 8d6ee9149676 ("Add a few more FAQs to
the releases page") to websites.git, which holds the source for the
pages published on kernel.org
(https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=8d6ee91496762c3e4955756a28fe92763d81d4dc
).

Nice additions, thx for doing this. Two quick notes:

* you added two sections that use the term "LTS", which is not explained
on that page and wasn't used on it earlier. I wonder if it might be
better to use "Longterm series" or something like that instead, as that
it the term used on the page (and the official one afaics).

This was also added:

> Does the odd-even number still mean anything?
> 
> Not since 2.5 days.

I guess a lot of users won't known how long ago that was, so how about
using an answer like this instead:

"Not since December 2003, when Linux 2.6 got released."

Ciao, Thorsten
