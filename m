Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC425ABE60
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiICKD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 06:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiICKDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 06:03:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19C67440;
        Sat,  3 Sep 2022 03:03:20 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oUPzh-0008Fe-LK; Sat, 03 Sep 2022 12:03:17 +0200
Message-ID: <938a9905-217c-f02a-b5c2-35c1e5d7822b@leemhuis.info>
Date:   Sat, 3 Sep 2022 12:03:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/4] Rewrite the top-level index.rst
Content-Language: en-US, de-DE
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220901231632.518583-1-corbet@lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <20220901231632.518583-1-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1662199400;abdd4c00;
X-HE-SMSGID: 1oUPzh-0008Fe-LK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.22 01:16, Jonathan Corbet wrote:
> The top-level index.rst file is the entry point for the kernel's
> documentation, especially for readers of the HTML output.  It is currently
> a mess containing everything we thought to throw in there.  Firefox says it
> would require 26 pages of paper to print it.  That is not a user-friendly
> introduction.
<
> This series aims to improve our documentation entry point with a focus on
> rewriting index.rst.  The result is, IMO, simpler and more approachable.
> For anybody who wants to see the rendered results without building the
> docs, have a look at:
> 
>   https://static.lwn.net/kerneldoc/
> [...]

Great initiative. But looking at the rendered result made me wonder:
what overall structure for the docs are you aiming for in the end? I'm
sure you have a picture in your head, but I failed to grasp it, as for
me a few things looked a little odd:

* we do all of this for the users, so shouldn't the section aimed at
users be at the top? And list more things they will look for?

* What is so important about "Architecture-agnostic documentation" and
"Architecture-specific documentation" (both with just one entry) that
they have to be listed here? Same for "Firmware-related documentation".
And is the User-oriented section really the right place for the kbuild
stuff, as from a quite look it seems most of those aim at developers and
not at users?

* Quite a few things I'd had expected on that front page aren't listed
there. Sure, everybody has different expectations on what's important,
but I for example hat expected "command-line parameters" or "Reporting
issues" (here I'm obviously biased) to be somewhere on that page.

This made me think: should that main index page maybe just have these
three sections (apart from Translations) ?

* User-oriented documentation
* Application-developer documentation
* Other documentation on the Linux kernel and its development

I'd say that makes it quite clear where readers need to go from there,
even if the name of the third section is a bit vague (but in contrast it
becomes clear I'd say).

Each section could list its five to ten most important documents before
linking to a separate index file with more. And that index file for will
need subcategories, too, otherwise it will become large, too.

And sure, quite a few documents will be hard to categorize currently.
Making things fit properly might take a decade or two (unless somebody
hires a few people to bring order into this). But it would set a clear
direction. It also would tell doc writers what tone and detail level to
use when writing their texts, as that depends on the audience which
becomes clearer this way.

Ciao, Thorsten

P.S.: /me wonders if Jonathan posted this patch-set as a bait and will
force everyone replying to come to his LPC/kernel summit session "What
kernel documentation could be"
/me despite this replied, as he had planned to go anyway
