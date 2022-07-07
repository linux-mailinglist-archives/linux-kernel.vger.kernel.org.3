Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FB5569D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiGGIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbiGGIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:21:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00A1140F3;
        Thu,  7 Jul 2022 01:20:15 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o9Mk9-0001Rr-QT; Thu, 07 Jul 2022 10:20:13 +0200
Message-ID: <77dbe20b-b99d-ec7c-9043-6d2b053303ad@leemhuis.info>
Date:   Thu, 7 Jul 2022 10:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
Content-Language: en-US
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <272584304.305738.1657029005216@office.mailbox.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <272584304.305738.1657029005216@office.mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1657182015;77807d7a;
X-HE-SMSGID: 1o9Mk9-0001Rr-QT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.22 15:50, torvic9@mailbox.org wrote:

> Linux 5.19-rc5 does not boot on my Kaby Lake Thinkpad.
> rc3 and rc4 were still fine, so I guess something between rc4 and rc5
> introduced a regression.
> 
> Unfortunately, there are no errors or warning messages.
> It gets stuck quite early on boot, about the time USB is initialized,
> so less than 1 second into post-bootloader boot.
> It then just sits there doing nothing - SysRq still works though.
> 
> I don't have time for a bisect, but I thought I'll let you know about
> this issue, and maybe someone already has an idea.
> [...]

This is mostly dealt with already, as can be seen from this thread,
nevertheless adding it to the tracking:

#regzbot ^introduced ee7a69aa38d8
#regzbot title drm: fbdev/simplefb: Linux 5.19-rc5 gets stuck on boot,
not rc4
#regzbot ignore-activity
#regzbot fixed-by: bf43e4521ff3223a

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
