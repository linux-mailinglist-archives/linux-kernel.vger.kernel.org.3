Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6449059B389
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiHULnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 07:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHULnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 07:43:51 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3C1834F
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+ZoIW7lMeANBkFH1s5Rhmlkpatn+9yf4YSzovoyzSME=; b=Rog/DIBA9Pgcy9FHr0jeCRloS5
        T5bjh9kuls4yosv4p+VMRFi/9YqdOz104uBICNY3rScXHsRaJXVZXkIhBgVrZBZpaNbjOdS+fdQHT
        wWL9PrrSNN/Ci1hV1l9EsDcOgA7urAi/LCox0ajZs10oE/TfWBPc3tqtMiErWowCuMw+zCSN69Jf2
        u+NArMAqAkp7g1iymcKnjCFFyaCjZqvk7FbAm9VEz6tQK6IgJjwrUNpEmVlOctXrxxZx/3TbR2pik
        EWPPn4ThY+1hApReu2IzXpU0PkFEOsZIQgWoE0T12DZyEM3T5ERCjxM2CVFPVm22Tx/wTtm1acNh/
        1iTE3/NQ==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=62402)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oPjMp-0003Fz-F1; Sun, 21 Aug 2022 13:43:47 +0200
Message-ID: <9e0256bd-b37a-0b94-45d5-59e06cd1547c@tronnes.org>
Date:   Sun, 21 Aug 2022 13:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 05/35] drm/connector: Add TV standard property
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
 <9fdecae2-80ad-6212-0522-7dccf9fb57be@tronnes.org>
 <20220816082612.grebxql5ynnfnvfd@houat>
 <ea6ebdda-f779-78af-1ffd-bd86d715077f@tronnes.org>
 <20220816094922.oqhrhefv327zo2ou@houat>
 <be9b6b71-fa2a-3290-2bce-901342e01981@tronnes.org>
 <20220817114605.jpb3tlnoseyvf65d@houat>
 <30f3005d-0acc-e5af-10ca-cf46f18b3478@tronnes.org>
 <133c2a1d-0b4c-cef9-11fe-9ce9985253d6@tronnes.org>
 <9daca9bf-838e-c3eb-51de-1cf5188a9341@tronnes.org>
 <20220818153101.c25x33vkl6qboswe@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220818153101.c25x33vkl6qboswe@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.08.2022 17.31, skrev Maxime Ripard:
> On Thu, Aug 18, 2022 at 05:01:38PM +0200, Noralf Trønnes wrote:
>>
>>
>> Den 18.08.2022 01.23, skrev Noralf Trønnes:
>>>
>>>
>>> Den 17.08.2022 15.11, skrev Noralf Trønnes:
>>>>
>>>>
>>>> Den 17.08.2022 13.46, skrev Maxime Ripard:
>>>>> On Tue, Aug 16, 2022 at 09:35:24PM +0200, Noralf Trønnes wrote:
>>>>>> Den 16.08.2022 11.49, skrev Maxime Ripard:
>>>>>>> On Tue, Aug 16, 2022 at 11:42:20AM +0200, Noralf Trønnes wrote:
>>>>>>>> Den 16.08.2022 10.26, skrev Maxime Ripard:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On Mon, Aug 08, 2022 at 02:44:56PM +0200, Noralf Trønnes wrote:
>>>>>>>>>> Den 29.07.2022 18.34, skrev Maxime Ripard:
>>>>>>>>>>> The TV mode property has been around for a while now to select and get the
>>>>>>>>>>> current TV mode output on an analog TV connector.
>>>>>>>>>>>
>>>>>>>>>>> Despite that property name being generic, its content isn't and has been
>>>>>>>>>>> driver-specific which makes it hard to build any generic behaviour on top
>>>>>>>>>>> of it, both in kernel and user-space.
>>>>>>>>>>>
>>>>>>>>>>> Let's create a new bitmask tv norm property, that can contain any of the
>>>>>>>>>>> analog TV standards currently supported by kernel drivers. Each driver can
>>>>>>>>>>> then pass in a bitmask of the modes it supports.
>>>>>>>>>>>
>>>>>>>>>>> We'll then be able to phase out the older tv mode property.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>>>>>>>>>>
>>>
>>>>>> How do you test the property? I've used modetest but I can only change
>>>>>> to a tv.mode that matches the current display mode. I can't switch from
>>>>>> ntsc to pal for instance.
>>>>>
>>>>> Yep, if you want to change from PAL to NTSC, it will require a new mode.
>>>>>
>>>>
>>>> So userspace has to check tv.mode first and then create a display mode
>>>> the driver will accept if switching to a different display mode is
>>>> necessary? In other words, userspace can't discover from the kernel
>>>> which display modes a certain tv.mode/norm provides before it is
>>>> selected? If so, maybe libdrm should have some function(s) to deal with
>>>> switching between modes that require a different display mode since
>>>> knowledge about which display modes a tv.mode supports is needed before
>>>> hand.
>>>>
>>>
>>> I haven't used vc4 on Pi4 in mainline before and have finally gotten it
>>> to work.
>>>
>>> I see that the connector reports 2 modes that together fit all tv.norms
>>> so userspace doesn't have to contruct a display mode, but it does need
>>> to know which display mode belongs to a certain tv.norm.
>>>
>>> When I try to use modetest I'm unable to set a mode:
>>>
>>> pi@pi4t:~ $ modetest -M vc4 -s 45:720x480i
>>> setting mode 720x480i-29.97Hz on connectors 45, crtc 68
>>> failed to set mode: Function not implemented
>>>
>>> The errno is misleading, modetest does a drmModeDirtyFB before checking
>>> the error returned by drmModeSetCrtc.
>>>
>>> Setting the property succeeds, but the modeset still fails:
>>>
>>> pi@pi4t:~ $ modetest -M vc4 -s 45:720x480i -w 45:"tv norm":2
>>> setting mode 720x480i-29.97Hz on connectors 45, crtc 68
>>> failed to set mode: Function not implemented
>>>
>>> pi@pi4t:~ $ modetest -M vc4 -c
>>>         37 tv norm:
>>>                 flags: bitmask
>>>                 values: NTSC-443=0x1 NTSC-J=0x2 NTSC-M=0x4 PAL-B=0x10
>>> PAL-M=0x200 PAL-N=0x400 SECAM-B=0x2000
>>>                 value: 2
>>>
>>> Here's the log, can you see if there's anything obvious in there:
>>> https://gist.github.com/notro/a079498bf6b64327105752b2bafa8858
>>>
>>
>> I'm one step closer as I now have fbcon working, I had forgotten to add
>> enable_tvout=1 and I had disable_fw_kms_setup=1 which disables the
>> video= mode on the kernel commandline.
>>
>> modetest still fails though, after alot of printk sprinkling, I've
>> tracked it down to the drm_mode_equal test in
>> drm_atomic_helper_connector_tv_check(). The aspect ratios differ:
>>
>> [   61.336295] drm_atomic_helper_connector_tv_check:
>> mode->picture_aspect_ratio=1
>> [   61.336301] drm_atomic_helper_connector_tv_check:
>> &crtc_state->mode->picture_aspect_ratio=0
> 
> I haven't seen this when testing, but I'll have a look, thanks!

I have found the cause, the kernel strips off the aspect ratio in
drm_mode_getconnector() if drm_file->aspect_ratio_allowed is false. So I
think the drm_mode_equal() test needs to be relaxed for
legacy/non-atomic userspace to work.

If I use modetest with atomic commit (-a) it works as is, having the
drm_mode_equal() test:

$ modetest -M vc4 -a -P 61@68:720x480 -s 45:720x480i

I have a problem because the board hangs, either right away or after I
press <enter> to quit modetest.

I often get this, sometimes after 10s of seconds:

[  136.822963] Unhandled fault: asynchronous external abort (0x1211) at
0x00000000
...
[  137.248496]  bcm2711_get_temp [bcm2711_thermal] from
thermal_zone_get_temp+0x54/0x74

Unloading bcm2711_thermal didn't help, in that case I got nothing, so
the problem lies elsewhere.
I have even tried with a fresh SD image and a fresh kernel, but it
didn't help.

I can switch from NTSC to PAL like this (but it still crashes):

$ modetest -M vc4 -a -w 45:"tv norm":16 -P 61@68:720x576 -s 45:720x576i

I had to patch modetest for that to work:

diff --git a/tests/modetest/modetest.c b/tests/modetest/modetest.c
index 8ff6c80d..accd2166 100644
--- a/tests/modetest/modetest.c
+++ b/tests/modetest/modetest.c
@@ -2188,12 +2187,13 @@ int main(int argc, char **argv)
 	dump_resource(&dev, planes);
 	dump_resource(&dev, framebuffers);

+	if (dev.use_atomic)
+		dev.req = drmModeAtomicAlloc();
+
 	for (i = 0; i < prop_count; ++i)
 		set_property(&dev, &prop_args[i]);

 	if (dev.use_atomic) {
-		dev.req = drmModeAtomicAlloc();
-
 		if (set_preferred || (count && plane_count)) {
 			uint64_t cap = 0;


I use a composite to USB adapter to see the output:
https://www.adafruit.com/product/4715

Noralf.
