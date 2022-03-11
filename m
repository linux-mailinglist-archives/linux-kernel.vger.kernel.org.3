Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90414D5CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347007AbiCKHxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiCKHxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:53:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDAB1B7576
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:51:57 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nSa42-000430-La; Fri, 11 Mar 2022 08:51:54 +0100
Message-ID: <c5d6fd7b-54ff-e407-2da8-ea2a6157fbff@leemhuis.info>
Date:   Fri, 11 Mar 2022 08:51:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [git pull] drm fixes for 5.17-rc8/final
Content-Language: en-US
To:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <CAPM=9txhThmkeKMjTVXGL+RYQDxBZv2c4syb_3V7WF=8sZhaHQ@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAPM=9txhThmkeKMjTVXGL+RYQDxBZv2c4syb_3V7WF=8sZhaHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646985117;9a4f176c;
X-HE-SMSGID: 1nSa42-000430-La
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.22 06:15, Dave Airlie wrote:
> 
> As expected at this stage its pretty quiet, one sun4i mixer fix and
> one i915 display flicker fix.
> 
> Thanks,
> Dave.
> 
> drm-fixes-2022-03-11:
> drm fixes for v5.17-rc8/final
> 
> i915:
> - psr fix screen flicker
> 
> sun4i:
> - mixer format fix.
> The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:
> [...]

Out of curiosity: I might be missing something, but why wasn't the
(afaics simple) fix for a build problem caused by 9d6366e743f3 ("drm:
fb_helper: improve CONFIG_FB dependency") (merged for v5.16-rc1) not
among these fixes? I mean this one:
https://lore.kernel.org/lkml/20220203093922.20754-1-tzimmermann@suse.de/

It's sitting in next for a few days already:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=eea89dff4c39a106f98d1cb5e4d626f8c63908b9

I already asked a few days ago why this fix was not on track for merging
in this cycle, but I didn't get an answer:
https://lore.kernel.org/lkml/782a683e-c625-8e68-899b-ce56939afece@leemhuis.info/

Fun fact: It seems the problem and at a rough fix were already kinda
known mid November when 9d6366e743f3 was still in next:
https://lore.kernel.org/all/20211117062704.14671-1-rdunlap@infradead.org/

Then the issue was reported again two times in February:
https://lore.kernel.org/dri-devel/CA+G9fYvN0NyaVkRQmA1O6rX7H8PPaZrUAD7=RDy33QY9rUU-9g@mail.gmail.com/
https://lore.kernel.org/lkml/YhofdlzadzRmy7tj@debian/

And the fix is relative simple, that's why I wonder why merging is
delayed. What am I missing?

Ciao, Thorsten
