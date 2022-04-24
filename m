Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B3A50D40B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiDXRlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDXRlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:41:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86D888DC;
        Sun, 24 Apr 2022 10:38:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3C25B80EB5;
        Sun, 24 Apr 2022 17:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E88C385A7;
        Sun, 24 Apr 2022 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650821881;
        bh=OZ3ZNwAjJ99XyonwrsvaeBt7eMtJuk8ZKZXR950meuU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BDYPqfuZADYQJjCnehGftjbJlt/dAcf26kTVgjZvLZGCbZbE1/vJ+j1zHiYAR7xJ7
         +LW8cx1jXeOovrdrDXTmTSA0KrzQFj23HJ0FY2vZxy1Xfe94QSy2ZzLtzId98LCTvd
         ++CWOBaiqiInRIxyPL2FiSqK361v01RX858l7u3CP8U/l4SExEK2Uy8zrCKR6CriFn
         5QqPzIre0vyMAGx0ovVgIITkYQHyed+2OGBZqalr7mHUPWNxigbnbLKJXs7zFzwMyP
         fPsjxdBbZ/Yco8PnAJECmwDpzv9e3Dhizc0ENe4JG0kQ3nV1PkcmFIEO66bDyKVFua
         KdXsnZodl8VAA==
Date:   Sun, 24 Apr 2022 18:46:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v4 10/14] iio: document "serial_number" sysfs attribute
Message-ID: <20220424184606.571b3764@jic23-huawei>
In-Reply-To: <4a940702-8a34-c163-2e5a-8dfd835e56d0@metafoo.de>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
        <20220415130005.85879-11-andrea.merello@gmail.com>
        <4a940702-8a34-c163-2e5a-8dfd835e56d0@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 09:41:54 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/15/22 15:00, Andrea Merello wrote:
> > From: Andrea Merello <andrea.merello@iit.it>
> >
> > This patch adds ABI documentation for the new "serial_number" sysfs
> > attribute. The first user is the bno055 IIO driver.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > ---
> >   Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 2a6954ea1c71..3be613f64843 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2048,3 +2048,10 @@ Contact:	linux-iio@vger.kernel.org
> >   Description:
> >   		Raw (unscaled) euler angles readings. Units after
> >   		application of scale are deg.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/serial_number  
> 
> Can we make this `serialnumber`? IIO uses underscores to separate 
> different parts of the name and to a machine (e.g. libiio) serial_number 
> looks like a channel called serial with an attribute called number.

Works for me.

J
> 
> 
> > +KernelVersion:	5.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		An example format is 16-bytes, 2-digits-per-byte, HEX-string
> > +		representing the sensor unique ID number.  
> 
> 

