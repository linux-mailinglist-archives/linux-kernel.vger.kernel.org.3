Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E58468A5E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 11:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhLEKgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 05:36:40 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48643 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232218AbhLEKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 05:36:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1571E3200A51;
        Sun,  5 Dec 2021 05:33:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 05 Dec 2021 05:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=QBHxdesHvo2iSpE5nb5ys+Q0WGY
        ZxfegNzFTDdB6WV4=; b=SQn61udpjGVg0DjNqKf4hWQ/7Ip9+fuW05vljIyGBEJ
        xo5AoEt3Zm+nCWRnD03ZhlC4/hq5WlepXEeSxFv7RwRaqItJQdjmmcs0NeuRZui9
        e8vPM81UnXIbQSQTAuEfLk63ugvlax3MG50Eu4vWRJLflRdpYfSfVyR64CjGcnkQ
        31A/ZMWKoO+H/A8qP2JJgbw6bB1ZiE7evhGVMw6GFQkknVIsPcXxMWTrqepcOl+x
        aYJMaEMhCWel6zkJ8pnJqOsLV8Q5Ugqlg+ouHeBcEbvEJEQGfoL0OgTjJsKmY2tj
        oRksSXqMuYSNI0xwumYWR8XWKnb+rNz5tOd1XF9EG4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QBHxde
        sHvo2iSpE5nb5ys+Q0WGYZxfegNzFTDdB6WV4=; b=OrWwr2TYyyBOHDCxqjF66g
        vhcepYpWljPm4HH677nsud4vNZ66o1FmYL0g9YCM7/yCoRTB75X3z7fCbVz4IoVo
        j+ToaGrYbz7FkWXsZ8ZRYKoXe3NdQEZZdXalzhb89eaRCgYrMFpn+a9TE9KeBMDI
        JDZLPNc1ROGnCcCYx4Cc7fTUNEINBWpQxeqPpenWfMw2U4aVoW07B7e34AHFcwPu
        bd+fb/HInVnZca2RVpvOihVAtCUGP7zw/ez110kE4VxJl8c7MlO69QKzpPCjUkfi
        U0967GYsgP/NMQeSv1acumXudmK8dowfiG7orJHO9keOkIfyxolnqXZYTjQIEURw
        ==
X-ME-Sender: <xms:ZZWsYSg-05-t6uzASdsMSo__5iwN6fx1hRbI0gjJXTPdcIQXhcCwGg>
    <xme:ZZWsYTCDnxs3zg0f0ebz7trxn4BWCHGDfSCCrjm7QcsiezwjH7p8b2krOekVLcsh9
    3AwWWkWGQNJY5nUOg>
X-ME-Received: <xmr:ZZWsYaFTaJredYYRGcbBW8bV9tt_ES1xHt3i2ipfxBU3RoxG1pwhDhcP6YL1ow1wPN-f7vP6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjedugdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhnrghn
    ughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrthhtvg
    hrnhepffefjeelledvfeevtdekfeeljefgleefgeeukedtgfetfeeivdejvdeifffgledu
    necuffhomhgrihhnpegrrhgthhhlihhnuhigrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:ZZWsYbSt3XSg2fsDWRXS2Yb0bdjod44py0ZjPnZv7fgc4O8ZbKDW3w>
    <xmx:ZZWsYfxxpmJphBv-_AxWigxw4EavhSbegaHhJzB9EzzIWnU1dhIzCw>
    <xmx:ZZWsYZ6MfagEIOlCUiPNwibqqmga4uwo6bKDclwMyckvhpdj25fKXA>
    <xmx:ZpWsYWl9rBAG0r8oQ5Q0CT8wKYM1Xfzy7azt2-4euJklDXOnL0kAuA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Dec 2021 05:33:07 -0500 (EST)
Date:   Sun, 5 Dec 2021 11:33:04 +0100
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Apply initial command workaround for more
 Intel chips
Message-ID: <YayVYIAi56097Ltl@zacax395.localdomain>
References: <20211202162256.31837-1-tiwai@suse.de>
 <acc7b5b4-72cc-9f3b-90a6-6fbf6c3a71e7@molgen.mpg.de>
 <s5h7dcnt0lp.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <s5h7dcnt0lp.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/02 05:47PM, Takashi Iwai wrote:
> Thanks, so this seems depending on the hardware, maybe a subtle
> difference matters.  As far as I read the code changes, the workaround
> was applied in the past unconditionally, so it must be fairly safe
> even if the chip works as is.
> 
> Or, for avoiding the unnecessarily application of the workaround,
> should it be changed as a fallback after the failure at the first
> try...?

I don't know if this helps, but I started experiencing this same issue ("hci0:
command 0xfc05 tx timeout") yesterday after a kernel upgrade.

My controller is a different one:

    8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
    ^^^^^^^^^

I tried with different (older) versions of the v5.15.x kernel but none worked.

Now, this is the interesting (?) part: today, when I switched on the computer
to keep testing, the bluetooth was *already* working once again.

I have reviewed my bash history to try to figure out what is it that I did, and
the only thing I see is that yesterday, before going to sleep, I did a full
poweroff instead of a reset (which is what I used yesterday to try different
kernels).

This does not make any sense... but then I found this [1] post from someone else
who experienced the same.

Is there any reasonable explanation for this? Could this be the reason why you
seem to have different results with the same controller (8087:0a2a)?

[1] https://bbs.archlinux.org/viewtopic.php?pid=2006188#p2006188



