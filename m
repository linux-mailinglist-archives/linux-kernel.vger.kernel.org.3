Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE7E4C5786
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiBZSfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiBZSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:35:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72D1D67C9;
        Sat, 26 Feb 2022 10:34:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD83B60DB9;
        Sat, 26 Feb 2022 18:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A96C340E8;
        Sat, 26 Feb 2022 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645900478;
        bh=jOQp5rolbAGTkVLkpiD3PsedHXrZMFFhZBI4e6pxSxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LAZi+ZaPQIcotuQpYoGzdlIPunsYr4tPLB0zr9XfZtalzGU/o6JjHzUVh9opkNXuf
         nUKa3L0fq/nNE2Ua+4tc5WoDO6bnINg6stK7EWW44bsxFNA7kFURjoQb2LZZrLGSG3
         YF1HUujUewnoUoGBU6lV9Dq7ggoFb/JW09IMmpb0CRy1WwDJ2luxr8jJWXZ4f0hFxA
         VhBt40aFK8fGPzmk77q8hUTj+KGS1g/BvAoDi7ix2OqoW9f5d+gjBk8pca2ZZspKwC
         uk/s/G0YIyP8talav55Ou/EyvVBIelA6ioBoiEvF027GSxKf1ot5e9xRIKcCi93ps2
         zSk7Qsqmg4bUg==
Date:   Sat, 26 Feb 2022 18:41:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] iio: potentiometer: Add support for DS3502
Message-ID: <20220226184139.1744830f@jic23-huawei>
In-Reply-To: <CAHp75VfKtU9qjSYQmc78T_O8tjuGDamWpsULyeW1fD-sd-dP5Q@mail.gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
        <CAHp75VfKtU9qjSYQmc78T_O8tjuGDamWpsULyeW1fD-sd-dP5Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 02:47:53 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Feb 23, 2022 at 6:35 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > Add dt-bindings and support for Maxim DS3502 into existing ds1803 driver.
> > DS3502 is a 7 bit Nonvolatile Digital Potentiometer.  
> 
> LGTM, thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> for the entire series,

Applied to the togreg branch of iio.git with the various tweaks I mentioned
in reply to individual patches.

Pushed out initially as testing to let 0-day run it's much more comprehensive
set of build tests against it than I run locally.

Thanks,

Jonathan

> 
> > Changes since v4:
> > 1. Included property.h header which has device_get_match_data()
> >    function prototype.
> > 2. Removed blank space in tag block of the commit message.
> > 3. Style changes for ds1803_cfg structure.
> >
> > Changes since v3:
> > 1. Dropped the chip type switch statement in read_raw function.
> > 2. Added device specific read function pointer in their structure.
> > 3. Added two separate functions to read values from two different types
> >    of devices.
> >
> > Changes since v2:
> > 1. Addressed Andy Shevchenko comments.
> > 2. Adding device name in Kconfig file.
> > 3. Spliting up of patch into 3 patches.
> > 4. Adding channel info into ds1803_cfg in separate patch.
> > 5. Dropping the use of enum in firmware data instead using previous
> >    pointer method for accessing device specific data.
> > 6. Separate patch for using firmware provided data instead of
> >    id->driver_data.
> > 7. Adding DS3502 support in separate patch.
> >
> > Changes since v1:
> > 1. Fixes the alignment to match the open parenthesis in separate patch.
> > 2. Adding available functionality for ds1803 driver in separate patch.
> > 3. Moving maxim_potentiometer members into ds1803_cfg structure.
> > 4. Droping of the INFO_ENABLE channel type.
> > 5. Firmware entry with data is used instead of id->driver_data to
> >    to retrieve the chip specific data.
> >
> > Jagath Jog J (7):
> >   iio: potentiometer: Alignment to match the open parenthesis
> >   iio: potentiometer: Add available functionality
> >   iio: potentiometer: Add channel information in device data
> >   iio: potentiometer: Change to firmware provided data
> >   iio: potentiometer: Add device specific read_raw function
> >   iio: potentiometer: Add support for Maxim DS3502
> >   dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
> >
> >  .../devicetree/bindings/trivial-devices.yaml  |   2 +
> >  drivers/iio/potentiometer/Kconfig             |   6 +-
> >  drivers/iio/potentiometer/ds1803.c            | 170 ++++++++++++++----
> >  3 files changed, 138 insertions(+), 40 deletions(-)
> >
> > --
> > 2.17.1
> >  
> 
> 

