Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0E14A9752
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358077AbiBDKAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358064AbiBDKAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:00:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAEEC06173D;
        Fri,  4 Feb 2022 02:00:21 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nFvO6-0005Ng-6Z; Fri, 04 Feb 2022 11:00:18 +0100
Message-ID: <9d10a295-e087-fbbf-3714-63c872cc6dd6@leemhuis.info>
Date:   Fri, 4 Feb 2022 11:00:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MIPS: Fix build error due to PTR used in more places
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220125141946.54114-1-tsbogend@alpha.franken.de>
 <20220130163725.GA2792319@roeck-us.net>
 <20220131100845.GA19252@alpha.franken.de>
 <585e1812-3d0c-552f-3195-4e947b4fef9d@leemhuis.info>
In-Reply-To: <585e1812-3d0c-552f-3195-4e947b4fef9d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643968821;2f4d6b38;
X-HE-SMSGID: 1nFvO6-0005Ng-6Z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.22 10:26, Thorsten Leemhuis wrote:

> Anyway: I no big deal (just makes regression tracking a lot harder), I
> can tell regzbot manually about the fix:
> 
> #regzbot introduced: 50317b636e7184d

Argh, sorry, stupid me doesn't known how to use his own bot:

#regzbot introduced: fa62f39dc7e2
#regzbot fixed-by: 50317b636e7184d

:-/ Sorry for the noise.

Ciao, Torsten
