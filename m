Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E42B48BF32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbiALHrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:47:11 -0500
Received: from marcansoft.com ([212.63.210.85]:35780 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231359AbiALHrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:47:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1916744B5E;
        Wed, 12 Jan 2022 07:47:07 +0000 (UTC)
Message-ID: <0beed477-adc4-5362-f116-669832c862b1@marcan.st>
Date:   Wed, 12 Jan 2022 16:47:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 0/3] firewire: assist unit driver to compute packet
 timestamp
Content-Language: en-US
To:     stefanr@s5r6.in-berlin.de, alsa-devel@alsa-project.org,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20211202113457.24011-1-o-takashi@sakamocchi.jp>
 <YcGycqUrptkWYeOV@workstation> <YdgdfrcvhJrUXwYF@workstation>
 <Yd5QNs/YnvzGOy0g@workstation>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <Yd5QNs/YnvzGOy0g@workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/12 12:51, Takashi Sakamoto wrote:
> Hi Stefan,
> 
> I'm sorry to post messages several times for the patchset if you are
> still busy. But I'm still waiting for any reaction.
> 
> I note that Linus have announced merge window for v5.17 kernel.
>  * https://lore.kernel.org/lkml/CAHk-=wgUkBrUVhjixy4wvrUhPbW-DTgtQubJWVOoLW=O0wRKMA@mail.gmail.com/T/#u
> 
> I'm glad if seeing your action for pull request as a response to the
> window.

Hi Tahashi,

Just FYI, I think a lot of maintainers have been off or doing less work
over December/the holidays; I also have some things that didn't make it
into subsystem trees for 5.17. So I'm guessing this patchset will have
to wait for 5.18. AIUI most maintainers don't merge things into
subsystem trees after the upstream merge window opens.

I've also been meaning to test your Firewire improvements again (and
also with Pipewire), but I've been pretty busy lately... hopefully I'll
get a chance soon. When I tried the first round of improvements that got
merged (the sequence replay stuff) I noticed it fixed the glitchy audio
problem, but the minimum stable period size with JACK+ALSA was still
higher than with JACK+FFADO, and Pipewire also had even higher
latencies. So I'm back using FFADO but I hope I can switch to ALSA soon :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
