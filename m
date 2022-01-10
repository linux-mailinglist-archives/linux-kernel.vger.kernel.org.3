Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6821D489B12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiAJOLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiAJOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:11:30 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CCC06173F;
        Mon, 10 Jan 2022 06:11:30 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n6vOS-0006f9-IU; Mon, 10 Jan 2022 15:11:28 +0100
Message-ID: <933e14cb-7fac-c4bf-39fc-77a7ef48d175@leemhuis.info>
Date:   Mon, 10 Jan 2022 15:11:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
Content-Language: en-BS
To:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1641823890;8752d967;
X-HE-SMSGID: 1n6vOS-0006f9-IU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Top-posting for once, to make this easy accessible to everyone.

TWIMC, the parent mail quoted below misses all the important people in
To/CC. That was not the case in an earlier mail from the author that got
rejected as it was HTML. There is a reply to that mail now that made it
to the lists and everyone in the loop, hence it afaics is better to
reply there instead if you consider to send one:

https://lore.kernel.org/lkml/ff982786-4033-7450-c10c-8ce71c28d6eb@leemhuis.info/

Ciao, Thorsten

P.S.: Trying to make regzbot handle this:

#regzbot ^introduced 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
#regzbot title cifs: unable to shares that require NTLM or weaker
authentication algorithms
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215375
#regzbot monitor:
https://lore.kernel.org/lkml/ff982786-4033-7450-c10c-8ce71c28d6eb@leemhuis.info/

On 10.01.22 07:06, Davyd McColl wrote:
> Good day
> 
> I'm following advice from the thread at
> https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
> this, so please bear with me and redirect me as necessary.
> 
> Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
> mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> runs some older linux). Apparently I'm not the only one, according to
> that thread, though the other affected party there is windows-based.
> 
> I first logged this in the Gentoo bugtracker
> (https://bugs.gentoo.org/821895) and a reversion patch is available
> there for the time being.
> 
> I understand that some of the encryption methods upon which the
> original feature relied are to be removed and, as such, the ability to
> mount these older shares was removed. This is sure to affect anyone
> running older Windows virtual machines (or older, internally-visible
> windows hosts) in addition to anyone attempting to connect to shares
> from esoteric devices like mine.
> 
> Whilst I understand the desire to clean up code and remove dead
> branches, I'd really appreciate it if this particular feature remains
> available either by kernel configuration (which suits me fine, but is
> likely to be a hassle for anyone running a binary distribution) or via
> boot parameters. In the mean-time, I'm updating my own sync software
> to support this older device because if I can't sync media to the
> player, the device is not very useful to me.
