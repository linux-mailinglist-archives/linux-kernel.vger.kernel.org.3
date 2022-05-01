Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB665166D1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353582AbiEAR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353556AbiEAR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5571A39B;
        Sun,  1 May 2022 10:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6306D60F75;
        Sun,  1 May 2022 17:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07C3C385A9;
        Sun,  1 May 2022 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651427735;
        bh=L5wYZWSFVoGzNdMX0h3jxQx9rzpHO69jZH46PS8EiH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m9BUdF0tMKH/aUr65QFJkuxnW7F51cBus71jRRaYcbXuH+/s7nHsdfX9qJWYTf7Fs
         OEj6mT2U42TwAxekuSLozZwLBGMvLJP1hytVmynls3gqZxz4HaCAd4xu9X2FsyncOA
         CNIDtUh/LUX/KaBdp9pxWzu8fbwnLBRDQFcTkUt7QoF1W+Xw07wSv3GTy0iBozSRy1
         Epkg/vcxRtA5qKaZTzllPRLcx1rcNoYtJZRfBdL3vF3bbxf7PjoPrR6OszPrZbOw8T
         Ju+OzcbU0Upskgesgmgqfqmtv3yyXNppY1lrYOx8ZUF2D5cT60r4gwEXsf+7XgpAC0
         flRHn/nLw7mXA==
Date:   Sun, 1 May 2022 19:03:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add support for texas dac121c081 to the dac5571
 driver
Message-ID: <20220501190349.54aa48a3@jic23-huawei>
In-Reply-To: <20220428204439.4ec2b4ae@jic23-huawei>
References: <42db911c-5eba-0511-3e8c-8011a2a5b44a@axentia.se>
        <20220428204439.4ec2b4ae@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Thu, 28 Apr 2022 20:44:39 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 25 Apr 2022 22:46:30 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
> > Hi!
> > 
> > The new chip works much like the other chips supported by the driver, so
> > this is just adding another compatible to the list.
> > 
> > Chenages since v1:
> > - Guenter Roeck noticed elsewhere that my mail setup was botched and
> >   that my patches were clobbered. Hopefully fixed. *blush*
> > - added tags from Sean Nyekjaer and Rob Herring  
> 
> Applied.  Thanks

Backed out temporarily because they have crossed with a fix (that I'd
forgotten about) and were requiring a non trivial merge in linux-next.

https://patchwork.kernel.org/project/linux-iio/patch/20220324234340.32402-1-laurent.pinchart@ideasonboard.com/

Hopefully that will get resolved in my upstream fairly soon and I can
fix this one up whilst applying it myself.

Thanks,

Jonathan



> 
> Jonathan
> 
> > 
> > Cheers,
> > Peter
> > 
> > Peter Rosin (2):
> >   dt-bindings: iio: ti-dac5571: Add ti,dac121c081
> >   iio: dac: ti-dac5571: add support for ti,dac121c081
> > 
> >  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
> >  drivers/iio/dac/Kconfig                                   | 2 +-
> >  drivers/iio/dac/ti-dac5571.c                              | 3 +++
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> >   
> 

