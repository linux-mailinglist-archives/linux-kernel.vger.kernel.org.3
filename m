Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778235B0A79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIGQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiIGQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:45:13 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6194B4A9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9N6URuex089GHLCqcq5OwqFtSiBdOniUj0H5n1oTE7U=; b=CJU1sQi7bpE3/vdL5WN6zgzECp
        HHbmXjaIPD3FMzb3sar3e+/e26bryRNwv1KdQp0IoqozvMQr2DTCs0jssE29RdyuEJv/rK8lX2WJK
        w2o8NMpLEUrJk30eOPVkwTn6wxVW0kBbnnB7MtXliQTOvmqSHodwkDV+uwCs5gbOmF0eJBvZUDQ2z
        e2JcgdbF+68jArc56Os1nj6UK+Y6uy14uY/Jul33K5WJlLdVPkusBSWmxB8/5J+Jivi1yAAY2SqaJ
        uYShCgxeLJVticyfntOzrgiAdo8jbBv692avVuEnjNwP7CDEGvsUfDGMPAMFYNmIHjp8I7qWEiYf6
        MKMfxSqg==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=53589)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oVyAf-0000KB-VO; Wed, 07 Sep 2022 18:45:01 +0200
Message-ID: <eb06337b-d501-3ca7-0e50-eda3aec75683@tronnes.org>
Date:   Wed, 7 Sep 2022 18:44:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 00/41] drm: Analog TV Improvements
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <24e09a29-6d04-3b1e-63ce-cd3c31d350e2@tronnes.org>
 <020d44e6-884b-a817-8265-3461638cac71@tronnes.org>
 <20220905145729.ln675jko3aw6sgzs@houat>
 <965de5c0-bc6a-7210-c946-b916ae2219fc@i2se.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <965de5c0-bc6a-7210-c946-b916ae2219fc@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 07.09.2022 12.36, skrev Stefan Wahren:
> Hi Maxime,
> 
> Am 05.09.22 um 16:57 schrieb Maxime Ripard:
>> On Fri, Sep 02, 2022 at 01:28:16PM +0200, Noralf Trønnes wrote:
>>>
>>> Den 01.09.2022 21.35, skrev Noralf Trønnes:
>>>>
>>>> I have finally found a workaround for my kernel hangs.
>>>>
>>>> Dom had a look at my kernel and found that the VideoCore was fine, and
>>>> he said this:
>>>>
>>>>> That suggests cause of lockup was on arm side rather than VC side.
>>>>>
>>>>> But it's hard to diagnose further. Once you've had a peripheral not
>>>>> respond, the AXI bus locks up and no further operations are possible.
>>>>> Usual causes of this are required clocks being stopped or domains
>>>>> disabled and then trying to access the hardware.
>>>>>
>>>> So when I got this on my 64-bit build:
>>>>
>>>> [  166.702171] SError Interrupt on CPU1, code 0x00000000bf000002 --
>>>> SError
>>>> [  166.702187] CPU: 1 PID: 8 Comm: kworker/u8:0 Tainted: G        W
>>>>      5.19.0-rc6-00096-gba7973977976-dirty #1
>>>> [  166.702200] Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
>>>> [  166.702206] Workqueue: events_freezable_power_
>>>> thermal_zone_device_check
>>>> [  166.702231] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS
>>>> BTYPE=--)
>>>> [  166.702242] pc : regmap_mmio_read32le+0x10/0x28
>>>> [  166.702261] lr : regmap_mmio_read+0x44/0x70
>>>> ...
>>>> [  166.702606]  bcm2711_get_temp+0x58/0xb0 [bcm2711_thermal]
>>>>
>>>> I wondered if that reg read was stalled due to a clock being stopped.
>>>>
>>>> Lo and behold, disabling runtime pm and keeping the vec clock running
>>>> all the time fixed it[1].
>>>>
>>>> I don't know what the problem is, but at least I can now test this
>>>> patchset.
>>>>
>>>> [1] https://gist.github.com/notro/23b984e7fa05cfbda2db50a421cac065
>>>>
>>> It turns out I didn't have to disable runtime pm:
>>> https://gist.github.com/notro/0adcfcb12460b54e54458afe11dc8ea2
>> If the bcm2711_thermal IP needs that clock to be enabled, it should grab
>> a reference itself, but it looks like even the device tree binding
>> doesn't ask for one.
> The missing clock in the device tree binding is expected, because
> despite of the code there is not much information about the BCM2711
> clock tree. But i'm skeptical that the AVS IP actually needs the VEC
> clock, i think it's more likely that the VEC clock parent is changed and
> that cause this issue. I could take care of the bcm2711 binding & driver
> if i know which clock is really necessary.

Seems you're right, keeping the parent always enabled is enough:

	clk_prepare_enable(clk_get_parent(vec->clock)); // pllc_per

I tried enabling just the grandparent clock as well, but that didn't help.

Without the clock hack it seems the hang occurs when switching between
NTSC and PAL, at most I've been able to do that 4-5 times before it hangs.

For a while it looked like fbdev/fbcon had a play in this, but then I
realised that it just gave me a NTSC mode to start from and to go back
to when qutting modetest.

Noralf.
