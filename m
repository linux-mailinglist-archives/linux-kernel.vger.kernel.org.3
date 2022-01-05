Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB24748531A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiAEM6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiAEM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:58:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64456C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 04:58:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: wlozano)
        with ESMTPSA id C658D1F44882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641387523;
        bh=yNIafW9es9iDBNSQ/Z9On8LylzWUxeHdxcDf8KMevu8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uz12lUBT86dTKzlw85feeUUvK0m1ni1+Pq8j1N7osSGPfIWbWarxgzWt5rdZVqo69
         Wkv9eHV67rAtbgjdEWL3xTcaFIGJJ5KjAjTf51/p0Zn9cOZFBpArdQLHE5k5RX8xvN
         nB7rE6xwz7VRzVmfC/Gotb2ezNgIsMigY9aCeDo4JHpHjvEyIsTB35b08U4PplYFFs
         5XfRNnDf46byemcpc7I/tbK37dG9/rh6uTCw+XKVum8ZWm6yVxBKL1+YglT1YWAfMd
         6zaUPLM/UBhdBiQBKRU2ZEe7ihPzZbSVypcatR5OQSDfHPa0IeWYPV32GvDg8eeAMF
         jPmeu3CPdFbnA==
Message-ID: <7a228120-f8fa-53ce-8857-32330968eebb@collabora.com>
Date:   Wed, 5 Jan 2022 09:58:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Occasional hung with UM after enable VMAP_STACK
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sjoerd Simons <sjoerd.simons@collabora.com>,
        ritesh sarraf <ritesh.sarraf@collabora.com>
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
 <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
 <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
 <41fe09354fc736fb1ff2cb429e035633f24176ce.camel@sipsolutions.net>
From:   Walter Lozano <walter.lozano@collabora.com>
In-Reply-To: <41fe09354fc736fb1ff2cb429e035633f24176ce.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On 1/4/22 16:49, Johannes Berg wrote:
> On Tue, 2022-01-04 at 16:26 -0300, Walter Lozano wrote:
>> Thank you for your quick response. The Debian configuration on package
>> user-mode-linux have these settings
>>
>> CONFIG_HAVE_ARCH_VMAP_STACK=y
>> CONFIG_VMAP_STACK=y
> OK, so it actually _is_ enabled.
>
>> as you can see in [1]. I did run some tests disabling those settings,
>> which passed without any hung.
>>
>> Unfortunately the "occasional" behavior makes this issue a bit tricky to
>> debug.
>>
> Right.
>
> Hm. I've been running our tests with it for about three months and
> haven't observed any hangs, but I guess that doesn't mean much.

The issue is very rare at least in my setup, I had to prepare a test 
environment to stress the system in order to be able to reproduce it 
more or less consistently. I will continue investigating and share any 
useful information.

> To be honest, I have no particular reason to even want it, other than
> that it catches accidental DMA from stack more easily ... so I guess if
> we can't find anything, we might as well revert it.

I hope we will be able to find the root cause of the issue.

> Feels like it _should_ work though, since it's just a different location
> for the stack.


I see. Thank you again for your quick reply, I will keep you updated.

Regards,

Walter

-- 
Walter Lozano
Collabora Ltd.

