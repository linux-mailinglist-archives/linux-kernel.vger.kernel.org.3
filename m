Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95CD58B734
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiHFRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiHFRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 13:02:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E9355A8;
        Sat,  6 Aug 2022 10:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D2D7611ED;
        Sat,  6 Aug 2022 17:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABCCC433C1;
        Sat,  6 Aug 2022 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659805352;
        bh=065uU3xsQXc3K3lPrTGT6NFVQ52mQXrrPRYVEbifapE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TRdCuqPzo+OuUDezPf8bt7U2/rXipGVTXLwtvRvjE0zhqwkUcrmB4p2+jEd/hjfOX
         Vp3YvlVFDjPRpMv+qVIQj8oyqpP4SLz0gIRxPmChEYjulDbO+WvvOXti1IZ7uzYLCx
         dGBqU2cEyIbhtHarQaxEYdECfQ8xLf2WTEVeMz2rdctMf+UGyQdvdTtydi9WiHFVid
         NphBW23AsUbwT2H6XkQl7QjvWMJ0sFxY8q7atnQSyUML9zvIYyutxsuoROi89NLZ9w
         lQ0/tloxlxKMxPuJd3duJ/ZL1gsf9J9ms6tzWky4KEWF86QXm4RlJEKLnnYN7ddhxm
         2VdH3qra+Tm6Q==
Date:   Sat, 6 Aug 2022 18:12:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai.pt@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
Message-ID: <20220806181252.7633f19d@jic23-huawei>
In-Reply-To: <CAHp75VfOPgDbTdt1EXJ5+exGXCZeT9VdtcOUDt_g4fn20S2Qwg@mail.gmail.com>
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
        <20220728125435.3336618-3-potin.lai.pt@gmail.com>
        <20220731130959.50826fc4@jic23-huawei>
        <4ea235d1-46c1-87de-760f-dc4775007ae0@gmail.com>
        <CAHp75VcZqTpmvVV=u4t=fdx=ffzksoWVDFZmq6Lfr6DrFrB2aA@mail.gmail.com>
        <Yuf7UAVrIJCnO40X@heinlein.stwcx.org.github.beta.tailscale.net>
        <CAHp75Vfe33oJAf1j27B-pTd84kX5JNPd+e16ygLYgZjCs=ZJfQ@mail.gmail.com>
        <CAHp75VfOPgDbTdt1EXJ5+exGXCZeT9VdtcOUDt_g4fn20S2Qwg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 18:30:16 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 1, 2022 at 6:26 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Aug 1, 2022 at 6:12 PM Patrick Williams <patrick@stwcx.xyz> wrote:  
> > > On Mon, Aug 01, 2022 at 10:22:16AM +0200, Andy Shevchenko wrote:  
> > > > On Mon, Aug 1, 2022 at 3:52 AM Potin Lai <potin.lai.pt@gmail.com> wrote:  
> > > > > On 7/31/22 20:09, Jonathan Cameron wrote:
> > > > > In our hardware board, we have "ti,hdc1080" as main source, and "silabs,si7020"
> > > > > for 2nd source. This two chip are locate at same bus and same slave address,
> > > > > and we want to use multiple compatibles to support both chips with single device
> > > > > node in device tree.
> > > > >
> > > > > Ex:
> > > > > compatible = "ti,hdc1099", "silabs,si7020";  
> > > >
> > > > This is simply broken DT, you must not put incompatible hardware on
> > > > the same compatible string. DT is by definition the description of a
> > > > certain platform. What you showed is a combination of incompatible
> > > > chips in a single DT.  
> > >
> > > We were mistaken that this is the appropriate way to specify this
> > > behavior, partially because it works as long as the probe functions
> > > return an error the next matching driver from the compatible will probe.
> > > It does seem that specifying two different compatibles like this would
> > > violate the intention of the DT spec:
> > >
> > >     The property value consists of a concatenated list of null terminated
> > >     strings, from most specific to most general. They allow a device to
> > >     express its compatibility with a family of similar devices, potentially
> > >     allowing a single device driver to match against several devices.
> > >  
> > > >  
> > > > > In order to support this, I need to add ID checking mechanism into the current
> > > > > hdc100x driver, so the si7020 chip will fail to probe with hdc100x driver
> > > > > (because the ID checking is not failed), then success probe with si7020.
> > > > >
> > > > > Base on you explanation, it looks multiple compatibles is not suitable in this
> > > > > case? Would you mind advise us what would be the better approach for our case?  
> > > >
> > > > If I may advise... fix your DT by dropping the wrong compatible item.  
> > >
> > > This doesn't really give any helpful advice.  
> >
> > Sorry to hear this, but it's the best and correct solution to your
> > problem. Believe me, many Linux people will tell you the same.
> >  
> > > The reality is that these two chips are pin compatible and function
> > > compatible but not driver compatible.  Boards have been manufactured
> > > which are identical except for this chip replaced, due various to chip
> > > shortages.
> > >
> > > Making probe fail so that the next 'compatible' is chosen sounds like it
> > > isn't desired.  I'm pretty sure you can't have two DT entries for the
> > > same i2c address, but with different 'compatible" properties, and even
> > > if we did you'd still need probe to fail on one of them.
> > >
> > > Are there any other suggestions for being able to inform the kernel that
> > > one of two chips might be present?  
> 
> Btw, how would it be solved in ACPI is the playing status bits by
> firmware, depending on the run-time detected environment (straps,
> other means). So, you may fix it on bootloader / firmware level by
> patching DTB with status okay / disabled. I believe in DTB is the
> number, which can be easily binary patched.
> 

Indeed, it's common to have boot firmware prelinux modify the DT.

That firmware can do probing if necessary to find out which device is present
and by the time Linux loads the DT should be correct for the particular
hardware.  Often this is done from a high level 'board ID' but nothing
stops you doing it this case.

I've cc'd the device tree binding maintainers and list, who may be able
to give you some useful pointers to examples of people doing this
in their boot loaders etc.

Thanks,

Jonathan


> > I guess there is a gap in understanding what DT is. DT is the
> > description of the *platform*. Changing any discrete component on the
> > platform is changing the platform.  
> 
> 

