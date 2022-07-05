Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13B566F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiGENmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiGENlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:41:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB392AE33;
        Tue,  5 Jul 2022 06:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A7FEB817C7;
        Tue,  5 Jul 2022 13:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB40BC341C7;
        Tue,  5 Jul 2022 13:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657026353;
        bh=JQBkUu4mKJ+61sPmOx3J1PpWn2oHFVeWXXnoqB4w36M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ls4x9dLt5VbUQOgWYXLIaG0V38Bv/2oJESyBpdkEjPkLvXvKqMuJ4MIcaCwVSGppX
         207y07jkN95AemAivjEDIXG8HmDch1Bv/Y8wg+34c0atTwCVBdLsKTs6FR8PQ86dAz
         khYccpBL4aGPzMaHCe4nsxkYldDpd8HWOQfI9iOmQh800G6lo0mZ/zJlAEveoovnQD
         8YF3/HHl36ZZCj+urXRtXFgEwAQxT1DPGYmgXQak7cq1SdXw4SxtteL0P7DX+5GDqa
         ekkH+f8uBODeYk/ER0moz9Hzxw6M+pFmwWkOZwmnklV34Qy9jysnWhp8wM8nMizeFs
         ulPBRV3FexPnQ==
Received: by pali.im (Postfix)
        id 30FEACBF; Tue,  5 Jul 2022 15:05:50 +0200 (CEST)
Date:   Tue, 5 Jul 2022 15:05:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add cznic,turris1x-leds.yaml
 binding
Message-ID: <20220705130550.uu6ix7tdtswn7vaf@pali>
References: <20220705000448.14337-1-pali@kernel.org>
 <42d837dd-fbd1-6294-2fa0-8a07ae0f8d44@linaro.org>
 <20220705114238.xwgexavgozqskwbw@pali>
 <90fd55cb-13f4-eac2-2b1a-85ae628ecc89@linaro.org>
 <20220705121541.t7jjcjp4hkqprsdo@pali>
 <3358f88c-5c58-ae0d-2c26-7ba9a954b491@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3358f88c-5c58-ae0d-2c26-7ba9a954b491@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 July 2022 14:55:10 Krzysztof Kozlowski wrote:
> On 05/07/2022 14:15, Pali Rohár wrote:
> >>>> You need to describe the items, if it is really two items. However your
> >>>> example has only one item, so this was not tested and won't work.
> >>>
> >>> Ehm? Example has two items in the reg.
> >>
> >> No, you have exactly one item.
> >> <0x13 0x1d>
> >>
> >> Two items are for example:
> >> <0x13 0x1d>, <0x23 0x1d>
> > 
> > Ok. So I should change maxItems to 1 in this case?
> 
> Yes
> 
> > 
> > And how you want to describe those items?
> 
> In that case, no need to describe.
> 
> > 
> >>>
> >>>> You'll get warning from Rob's robot soon... but you should test the
> >>>> bindings instead.
> >>>
> >>> I have tested bindings on the real hardware and it is working fine
> >>> together with the driver from patch 2/2.
> >>
> >> Bindings cannot be tested on real hardware. Bindings are tested with
> >> dt_binding_check, as explained in writing-schema.rst
> > 
> > Ou... this is something which I was not able to run, it just does not
> > work, throws lot of python dependency hell errors and it spend more than
> > hour with it. So sorry, I really cannot run it. Maybe it would be a wise
> > to provide web service for these checks for those who cannot run them
> > locally?
> 
> It's one pip command to install and one make command to run... I would
> say easy to start using, unless of course you use some unusual distro
> without Python 3 (cannot believe nowadays...) or without pip.
> 
> Rob's bot will test it for you.

Ok, so lets wait for the robot. After that I will try to fix found
issues and send a new patch version.

> Anyway, in such case please mark your bindings always as RFT, so we will
> not waste time on reviewing obvious stuff which is found by automated
> tools. I think we both agree that reviewers time should not be used for
> trivial stuff already pointed out by compiler/linter/automation.

Yes!

> > 
> >>>
> >>>>> +
> >>>>> +  "#address-cells":
> >>>>> +    const: 1
> >>>>> +
> >>>>> +  "#size-cells":
> >>>>> +    const: 0
> >>>>> +
> >>>>> +patternProperties:
> >>>>> +  "^multi-led@[0-7]$":
> >>>>> +    type: object
> >>>>> +    $ref: leds-class-multicolor.yaml#
> >>>>
> >>>> This looks incorrect, unless you rebased on my patchset?
> >>>
> >>> So what is the correct? (I used inspiration from
> >>> cznic,turris-omnia-leds.yaml file)
> >>
> >> Which according to current multicolor bindings is not correct. Correct
> >> is pwm-multicolor. However if you rebase on [1], it looks fine, except
> >> missing unevaluatedProperties.
> > 
> > Ok. So does it mean that I should just add
> > "unevaluatedProperties: false"?
> 
> Yes, on that level of indentation, so:
>     $ref: leds-class-multicolor.yaml#
>     unevaluatedProperties: false

Ok.

> > 
> >> [1]
> >> https://lore.kernel.org/all/20220624112106.111351-1-krzysztof.kozlowski@linaro.org/
> >>
> >>>
> >>>>> +
> >>>>> +    properties:
> >>>>> +      reg:
> >>>>> +        minimum: 0
> >>>>> +        maximum: 7
> >>>>> +
> >>>>> +    required:
> >>>>> +      - reg
> >>>>> +
> >>>>> +additionalProperties: false
> >>>>> +
> >>>>> +examples:
> >>>>> +  - |
> >>>>> +
> >>>>
> >>>> No blank line.
> >>>
> >>> Ok.
> >>>
> >>>>> +    #include <dt-bindings/leds/common.h>
> >>>>> +
> >>>>> +    cpld@3,0 {
> >>>>
> >>>> Generic node name.
> >>>
> >>> Is not cpld name generic enough?
> >>
> >> No, it means nothing to me. Just like "a", "ashjd" or "wrls".
> > 
> > If you never heard about it, I would suggest to read something about
> > Programmable logic devices. It is interesting category of hardware with
> > which you can play. CPLD and FPGA are very often used in lot of products
> > and FPGA is very easy for playing and programming custom logic.
> 
> The are many different acronyms in the language so without context might
> be tricky to connect the dots.

Anyway, playing with FPGA is really a fun!

> > 
> > For example on wikipedia is list of different technologies of
> > programmable logic devices:
> > https://en.wikipedia.org/wiki/Programmable_logic_device
> > 
> > So if you want more generic name, just name it "pld"? 
> 
> That one would be fine.
> 
> > But as it is CPLD
> > device I would suggest to name it really as "cpld". It does not matter
> > from which manufactor you have CPLD, just like it does not matter from
> > which manufactor you have NAND.
> 
> Then cpld is fine as well.

Ok, so stick with cpld.

> > 
> > From bus point of view, cpld is like nand or nor nodes in DTS. All of
> > them refers to specific memory map of chip selects on the local bus.
> > 
> >> "The name of a node should be somewhat generic, reflecting the function
> >> of the device and not its precise programming
> >>  model. If appropriate, the name should be one of the following choices:"
> > 
> > Hm... You forgot to send what are those "choices:"?
> 
> I didn't, I just assumed you will Google it (or use other web-search
> engine of your choice) to get the spec. As this is a quote, Google
> results should be very accurate. No need to duplicate entire pages of
> publicly available specification.

This was the first thing which I did when I read email. No usable
result. So the next thing was that I started git grep on the linux tree.
Again no result. So at the end I come to the conclusion that you forgot
to copy+paste whole quote or something like that.

Now I started searching a bit more and found it in following documentation:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Original link to the quote would be useful (but now I have it).

> Best regards,
> Krzysztof
