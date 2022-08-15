Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3D59348C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiHOSLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiHOSBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:01:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DEB24F15;
        Mon, 15 Aug 2022 11:01:02 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oNeOJ-0003w4-L3; Mon, 15 Aug 2022 20:00:44 +0200
Message-ID: <a7d10605-87e3-c4bd-4a76-f07a04f5751c@leemhuis.info>
Date:   Mon, 15 Aug 2022 20:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
To:     Chuck Zmudzinski <brchuckz@netscape.net>
Cc:     jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
 <bd66b5bc-4d07-d968-f46c-40cf624499a7@netscape.net>
 <a29a66e0-2075-8084-84ad-8bd3e8a9fd4a@netscape.net>
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <a29a66e0-2075-8084-84ad-8bd3e8a9fd4a@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1660586462;6091e165;
X-HE-SMSGID: 1oNeOJ-0003w4-L3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck!

On 15.08.22 18:56, Chuck Zmudzinski wrote:
> 
> I am forwarding this to you to help you cut through the noise.

Sorry for not replying earlier, I ignored this thread and all other
non-urgent mail in the past two weeks: I was on vacation until a few
days ago and when I came home I had to deal with some other stuff first.

> I do not apologize for trying to get
> the fix for this regression rolling again.

Yeah, it's important to ensure regressions don't simply fall though the
cracks, but my advice in this case: let things rest for a few days now,
the right people have the issue on their radar again; give them time to
breath and work out a solution: it's not something that can be fixed
easily within a few minutes by one person alone, as previous discussions
have shown (also keep in mind that the merge window was open until
yesterday, which keeps many maintainers quite busy).

And FWIW: I've seen indicators that a solution to resolve this is
hopefully pretty close now.

>  After all, it has been over three months
> since the regression was first reported.

Yes, things take/took to long, as a few things were far from ideal how
this regression was dealt with. But that happens sometimes, we're all
just humans and make errors. I did a few as well and learned a thing or
two from then. Due to that I'll do a few things slightly different in
the future to hopefully get similar situations resolved a lot quicker in
the future.

Ciao, Thorsten
