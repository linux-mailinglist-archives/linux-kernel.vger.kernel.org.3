Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6E59FB15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiHXNSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiHXNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:18:33 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB158506;
        Wed, 24 Aug 2022 06:18:31 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oQqH8-000392-8f; Wed, 24 Aug 2022 15:18:30 +0200
Message-ID: <094a288e-f80c-49f7-9288-490406901c15@leemhuis.info>
Date:   Wed, 24 Aug 2022 15:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     plumerlis@gmail.com,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Hans de Goede <hdegoede@redhat.com>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Bug 216355 - Thinkpad X1C 9th mute LED stop working after kernel 5.19
 upgrade
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661347112;715ce597;
X-HE-SMSGID: 1oQqH8-000392-8f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported. That's why I decided to forward it by
mail to those that afaics should handle this.

To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216355 :

>  plum 2022-08-13 02:11:01 UTC
> 
> I upgrade to kernel 5.19.1 but found my thinkpad x1 carbon 2021's mute led stop working.
> 
> Function is okay but LED won't light up.
> 
> Back to kernel 5.18 and it's normal and working again.
> 
> Fedora 36 64 bit 
> Gnome-shell 42

See the ticket for details and further comments.

Please look into the issue if you're among the main recipients of this
mail (and not just CCed). I hope I picked the right people to sent this
to, if not just let everyone know.

Anyway, to ensure this is not forgotten lets get this tracked by the the
Linux kernel regression tracking bot:

#regzbot introduced: v5.18..v5.19
https://bugzilla.kernel.org/show_bug.cgi?id=216355
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report in bugzilla, as the kernel's documentation calls
for; above page explains why this is important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
