Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5952057330B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiGMJl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiGMJlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:41:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D50F5D64;
        Wed, 13 Jul 2022 02:41:53 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oBYsQ-00012W-A6; Wed, 13 Jul 2022 11:41:50 +0200
Message-ID: <1dc0ab09-2cfd-a310-d1da-ef7d3cc47a71@leemhuis.info>
Date:   Wed, 13 Jul 2022 11:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAKXUXMy2WfsRj+nJuNCV4bPNYTvDySLOq3HgpK+gWJSpWS81Kg@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Update "If something goes wrong" in
 Documentation/admin-guide/README.rst
In-Reply-To: <CAKXUXMy2WfsRj+nJuNCV4bPNYTvDySLOq3HgpK+gWJSpWS81Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1657705313;f44ca44f;
X-HE-SMSGID: 1oBYsQ-00012W-A6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Lukas, thx for bringing this up.

On 13.07.22 09:26, Lukas Bulwahn wrote:
>
> During some other unrelated clean-up work, I stumbled upon the section
> 'If something goes wrong' in Documentation/admin-guide/README.rst
> (https://www.kernel.org/doc/html/latest/admin-guide/README.html).
> README.rst is---as it seems---the intended first summary page of the
> documentation for any user of the kernel (the kernel's release notes
> document).
> 
> The section 'If something goes wrong' describes what to do when
> encountering a bug and how to report it. The second sentence in that
> section is especially historic and probably just discouraging for most
> bug reporters ( ..."the second best thing is to mail them to me
> (torvalds@linux-foundation.org)"...).

Ha, yeah, guess so :-D

> Some random user (potentially
> even unknown to the community) sending an email to Linus is most
> probably the last best thing to do and is most likely just ignored,
> right?

I'd say it depends on the report and would guess Linus in quite a few
cases will act on it if the report at least somewhat good -- or about
something important, like a bisected regression.

> Probably this section in README.rst needs a rewrite (summarizing
> Thorsten's reporting-issues.rst, or just copying the summary from
> there) and should then refer to reporting-issues.rst for more details.

Well, any new summary sounds a bit like 'similar code paths for doing
the same thing'. Sometimes that is necessary when coding, but often it's
best avoided for known reasons. I think it's not that different for docs.

Maybe just copying the "short guide" from the top of
reporting-issues.rst might be the most elegant solution for README.rst
while adding the link your mentioned (maybe while adding a comment to
reporting-issues.rst saying something like 'if you update this section,
update the copy over there, too'). But I'm not sure myself right now if
that's really the best way forward; maybe a few modifications might be
good here. Let's see what Jonathan says.

Note, the section in README.rst you mentioned also contains a few
aspects that reporting-issues.rst despite it's size doesn't cover. :-/
But some of that stuff looks outdated anyway.

> Thorsten, do you have time to prepare a change to that document that
> gives a short summary on how to report potential issues and
> regressions? Otherwise, I will happily put that on my todo list and
> probably can suggest some RFC patch in a week or two.

Then go for it. Normally I'd be interested, but I'm short on time
currently, as I'm working a lot on bugzilla integration for regzbot,
have a vacation coming up, and need to prepare talks for two conferences
(Kernel Summit and Open Source Summit).

Ciao, Thorsten
