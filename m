Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508104E5D96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 04:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347981AbiCXDgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 23:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiCXDgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 23:36:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF47E09B;
        Wed, 23 Mar 2022 20:34:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w21so235280wra.2;
        Wed, 23 Mar 2022 20:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PpfbgiEgnj1bxRm59Q2VEMgDChYwbV2bgnHOirqJF3o=;
        b=pgQPIuSUHGwh1aWAlPPKdBttPwsKjc1bTCbExBfDE++/0/18IQEDoZgxL1AND8Mvyv
         wNXLWngA9oa9923u/qfk6r3D84/Ig7X75J0mrnDFLcs2g0uYhf6D7A4l+FBaYKRYJV1P
         wc1unRDSnGcjZXYwTuup48Bg+g5h7YNMfgl3t6fkhKPl1/A1rvYVDU6ksQBEKwsrIKRA
         Qorh0Ys4kxo6gcFUKn75vTmxi7qI6NXMJhtF2cJWXFaYThADjP1ecMHQIwmCKo/L2qtE
         RacxK3Em8VZ49PcY37LEhdotWOXSfQW/sneTWAKNJLyDjU0MP8HXhjgQjqMDJcV9oH/Z
         5FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PpfbgiEgnj1bxRm59Q2VEMgDChYwbV2bgnHOirqJF3o=;
        b=xnbIJ02XNEaSyrcTuBQ6BEVnZA9BGSWKTJw2IldrY0mNI8NU0TrKlzg293zQThoyV6
         SW0nW/r3JJYMmh+0m6/DVzmTA2+b76e6dsEIJk89D62+fps1ODj2uIFOYN7DGeDl5x4o
         Y8DiuJTQbiEwynDfNtnsvMPZIb26vFJj/uUGzJlKvXdP3nywMijIFC0TIQ9K+CN71SgV
         IqaZZfCqlSlY2OewBFcQ9ws22Jn+56SvMXrFNjF+zrg2zOFh45xaYKryD9z+IdJ1Ri3L
         MAm2Zu+yM02lCk/f5peInd58IZui9mcp4gtFbwNIqSdO68H+WWggXeHP97bf4j9XWnDi
         AIyA==
X-Gm-Message-State: AOAM533KuEU+q1LWWrjNELjoP7Vkmy40k6nWPYtFew0oxg/8HsXgzxtW
        y58L/CsAn6DpE3bFxxjMxYxkE3Qn0/QAMB6B
X-Google-Smtp-Source: ABdhPJzm5n9YgnoiQpbmM1XYtMMzv9ka0SvRPyJA/efORsrTC1cxp1Yx1JME8T/Jjgp3JXMd1tjpXQ==
X-Received: by 2002:adf:dfc9:0:b0:203:fb83:83f1 with SMTP id q9-20020adfdfc9000000b00203fb8383f1mr2651277wrn.81.1648092888443;
        Wed, 23 Mar 2022 20:34:48 -0700 (PDT)
Received: from hermes ([2604:3d09:e80:800::72d9])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b0038cbd13e06esm3916892wmq.2.2022.03.23.20.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 20:34:48 -0700 (PDT)
Date:   Wed, 23 Mar 2022 21:34:44 -0600
From:   Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
To:     Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <Yjvm1F3ZrJnyAOE6@hermes>
References: <Yifr4etBFPu1a2Ct@hermes>
 <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:22:49PM +0000, Filipe Laíns wrote:
> On Tue, 2022-03-08 at 16:50 -0700, Manuel Schönlaub wrote:
> > The HID++ protocol allows to set multicolor (RGB) to a static color.
> > Multiple of such LED zones per device are supported.
> > This patch exports said LEDs so that they can be set from userspace.
> > 
> > Signed-off-by: Manuel Schönlaub <manuel.schoenlaub@gmail.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 188 +++++++++++++++++++++++++++++++
> >  1 file changed, 188 insertions(+)
> 
> *snip*
> 
> Hi Manuel,
> 
> Thanks for putting this forward, although I am not sure if this is the best way
> to handle this.
> 
> Before anything, could you elaborate a bit on what lead to you wanting this?
> 
> There are a couple of reasons why merging this in the kernel might be
> problematic.
> 
> 1) I don't think we will ever support the full capabilities of the devices, so
> configuration via userspace apps will always be required, and here we are
> introducing a weird line between the two.
> 
> 2) There is already an ecosystem of userspace configuration apps, with which
> this would conflict. They might not be in the best maintenance state due to lack
> of time from the maintainers, but moving this functionality to the kernel, which
> is harder change, and harder to ship to users, will only make that worse.
> 
> Cheers,
> Filipe Laíns

Hi Filipe,

sure.

While I realize that there is e.g. ratbagd which supports a great deal of the
HIDPP features and should allow you to control LEDs, unfortunately for my G305
it does not support the LED (and as far as I remember my G403 does not
work at all with it).

Then I figured that actually having the LEDs in kernel would allow led triggers
to work with them, so you could do fancy stuff like showing disk or CPU activity
or free physical memory... and here we are now.

As for supporting the full capabilities of these devices: The patch just adds
RGB leds, which is something already quite standardized in the linux kernel for
a variety of devices.
Some roccat mice even have support for changing the actual DPI in their kernel
driver, which arguably is a whole different story though and not scope of this patch.
There are also other features (like on-board profiles) which I would definitely
see being better off in user space, especially as long as there is no additional
benefit in having them in the kernel.

Regarding the conflict in userspace: ratbagd currently seems to always write
LED state in RAM and the on-board profiles at the same time, so I would
argue that the use case here is different: The user space tools want to
set the LED color in a persistent way, while here we want to have interaction with
LED triggers and a more transient way. E.g. the driver would overwrite
only the transient LED color, not the onboard-profiles.

If that is already too much, what about a module option that allows a user to
deactivate the feature?

Best Regards,

Manuel

