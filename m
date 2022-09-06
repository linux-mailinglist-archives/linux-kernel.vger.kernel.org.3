Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173A95AE0F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiIFHYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiIFHYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:24:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1639A46E;
        Tue,  6 Sep 2022 00:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90D63B815F8;
        Tue,  6 Sep 2022 07:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008B1C433D6;
        Tue,  6 Sep 2022 07:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662449068;
        bh=5wZinesV4YM9YNTUcdPQv7G9QwZizzKWTyrHa7y87Tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sTT96vSHWRXT0vBdz5QioPuBOFK5K6bkOmIcXVbhQ2b30Wenkj+0AKsch6y81nGCo
         437YFLRNuB61JpA5g9lxEAdUDGrlP+Jf1lw6XH5vB8oFcm0kES6CLoqluM63oEOnKK
         MAq2LtZRA1LePUtBrZ/p1GrWGmC81qC7ij8EqTvLa7Eqy29LKyyLcNz6vK4N9scGE2
         3JmVtXyE2gWEJSx2dBMG2UM1d/Aw0hxzHVDKhmyqqK2ReVu741lTkqBD+NCBvg2+wy
         OkWdQzzckr8sJyKlvRvKs69USm589OAs8C5PDCi1JYQ0uTQ/pbWFxqZr1IWvMTwzx4
         9s74C8z1tgmrA==
Received: by pali.im (Postfix)
        id EA23972A; Tue,  6 Sep 2022 09:24:24 +0200 (CEST)
Date:   Tue, 6 Sep 2022 09:24:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Behun <marek.behun@nic.cz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Message-ID: <20220906072424.fmjup62f2hfilj3t@pali>
References: <20220819131152.6513-1-pali@kernel.org>
 <20220831142809.lcmnv3l4rnulo522@pali>
 <YxE2JqJutZ0ilghH@lunn.ch>
 <20220903152735.2ga3iwrivh6zhibf@pali>
 <30d3f753-187f-4a3f-c14a-f3b003f23773@gmail.com>
 <7a43aa79-9c40-867c-c585-3bb448a54647@linaro.org>
 <20220905171226.fla6i5cgrx2lbq3u@pali>
 <1750926a-9177-a26f-1219-c85eaf676890@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1750926a-9177-a26f-1219-c85eaf676890@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2022 08:34:42 Krzysztof Kozlowski wrote:
> On 05/09/2022 19:12, Pali Rohár wrote:
> > On Monday 05 September 2022 18:34:48 Krzysztof Kozlowski wrote:
> >> On 05/09/2022 18:19, Florian Fainelli wrote:
> >>>
> >>>
> >>> On 9/3/2022 8:27 AM, Pali Rohár wrote:
> >>>> On Friday 02 September 2022 00:45:58 Andrew Lunn wrote:
> >>>>> On Wed, Aug 31, 2022 at 04:28:09PM +0200, Pali Rohár wrote:
> >>>>>> PING?
> >>>>>>
> >>>>>> On Friday 19 August 2022 15:11:52 Pali Rohár wrote:
> >>>>>>> At i2c address 0x2a is MCU command interface which provides access to GPIOs
> >>>>>>> connected to Turris Omnia MCU. So define mcu node in Turris Omnia DTS file.
> >>>>>>>
> >>>>>>> Signed-off-by: Pali Rohár <pali@kernel.org>
> >>>>>>>
> >>>>>>> ---
> >>>>>>> Same change was already sent to U-Boot project together with driver. As
> >>>>>>> Turris Omnia DTS file is shared between Linux kernel U-Boot, I'm sending
> >>>>>>> this change also in Linux. There is a plan to write also Linux driver for
> >>>>>>> Turris Omnia MCU, like there is already in U-Boot.
> >>>>>>>
> >>>>>>> https://source.denx.de/u-boot/u-boot/-/commit/832738974806e6264a3d0ac2aaa92d0f662fd128
> >>>>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/turris_omnia_mcu.c
> >>>>>>> ---
> >>>>>>>   arch/arm/boot/dts/armada-385-turris-omnia.dts | 8 +++++++-
> >>>>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> >>>>>>> index f4878df39753..f655e9229d68 100644
> >>>>>>> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> >>>>>>> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> >>>>>>> @@ -184,7 +184,13 @@
> >>>>>>>   			#size-cells = <0>;
> >>>>>>>   			reg = <0>;
> >>>>>>>   
> >>>>>>> -			/* STM32F0 command interface at address 0x2a */
> >>>>>>> +			/* MCU command i2c API */
> >>>>>>> +			mcu: mcu@2a {
> >>>>>>> +				compatible = "cznic,turris-omnia-mcu";
> >>>>>>> +				reg = <0x2a>;
> >>>>>>> +				gpio-controller;
> >>>>>>> +				#gpio-cells = <3>;
> >>>>>>> +			};
> >>>>>
> >>>>> Please document the binding, preferably in yaml.
> >>>>
> >>>> I'm not going to send any new yaml dt binding document as I see that
> >>>> dt bindings is clearly deprecated project. Either patches for dt
> >>>> bindings are waiting without any answer for months (maybe year?) or
> >>>> patches are ignored/not accepted by beyond reasons or there are request
> >>>> for changes which cannot work on the real hardware or that new yaml
> >>>> cannot be parsed/validated due to ton of bugs in other schemas.
> >>>
> >>> These are some pretty hard statements that are not nearly true, maybe 
> >>> they are based upon your past experience, but Rob and Krysztof provide 
> >>> feedback within a few days at most on DT bindings and DTS files.
> >>
> >> Pali, you wrote in the past that you cannot run one command to install
> >> dtschema ("pip") thus for you this automated testing is
> >> difficult/broken/non working. If running one "pip" command is not
> >> possible, what I can say more? Shall I login to your machine and set it
> >> up? Or did you configure your machine that way, that it is not possible
> >> to run one pip command?
> > 
> > Sorry no, it is too late. I have already lost interested in it. For me
> > it is like a ride on the dead horse.
> > 
> >> Whether the patches are waiting for months and years is difficult to
> >> address to, without actual links. Because for sure you will be able to
> >> find one patch which was missed in our inboxes and you did not get an
> >> answer...  With Rob we both work much more than reasonable/healthy 8h
> >> per day... Yet I recall you always received feedback, just not always
> >> what you expected or wanted.
> > 
> > Now I have replied to one example email without a reaction. 
> 
> Which was not a patch. You asked us for some knowledge and Rob provided
> you answers. Or maybe you think that our job is to solve each technical
> problem of everyone in the world till asking person is happy? Sounds
> like nice job. :)

No and no. You were unhappy with my last patches, so this time I first
send an email asking how to do it prevent sending something which would
be rejected. And now you are saying that it is a technical problem, not
answer. Nice way how to demotivate to try to do any new contribution
into this project area.

> > Another
> > example is this https://github.com/devicetree-org/dt-schema/pull/64
> > which completely blocked any improvements which I proposed in PCIe core
> > code for fixing PCIe state machine. After half of year of waiting I
> > decided to stop any work on this as I see it is dead those schemas.
> 
> It finished with Rob comments, so ball is on your side, isn't it?

Yes, after half o year? And I should continue to wait another half year
for another round? Why? And why should I wait again? Demotivate?

> > Other examples are that received feedback suggest to do change which
> > does not work on the real hardware. So yes, I cannot accept, expect or
> > want something like that. Schema which works in that ultra-supper-duper
> > software but DTS written according to it does not work on the real
> > hardware is for me useless...
> > 
> >> This binding here was never sent to mailing list:
> >> https://lore.kernel.org/all/?q=cznic%2Cturris-omnia-mcu
> >>
> >>>> Sorry, this is just a waste of time and energy to write new those yamls
> >>>> as it does not bring any value.
> >>
> >> It brings quite nice value - allows to check whether your bindings and
> >> your DTS are correct. Any difficulty to install and run dtschema is not
> >> equal to "does not bring any value"...
> > 
> > It just took lot of my time and did nothing useful. Hence for it it has
> > zero value.
> 
> Sorry to hear. When I was very, very small, C also took a lot of my time
> and did nothing useful. Nothing useful in that stage of my knowledge, of
> course.
> 
> 
> Best regards,
> Krzysztof

Seems that you just want to demotivate, nothing more.
