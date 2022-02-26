Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A364C56EE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiBZRBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiBZRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:01:39 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4418949F9B;
        Sat, 26 Feb 2022 09:01:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p14so16727232ejf.11;
        Sat, 26 Feb 2022 09:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VPASw0Pjg3A9RSZK9b9pwu/T/TyfBQMtAUoZ8ftIZpE=;
        b=S1FxSs+Ns1mvcG1GZiXmi/OLdfcHSI0aEKJDAnNS8Nr6lJ3VtE0KkcV46XaATYKf3Y
         Xcy8Dc3kx9/bqw28H+d0AWHHOAbOrvLeGMF/fqyPH3waHJPvX5JdFfF1NxEBqfWU65TB
         ZOjjOmtT+IqBTHiL5FlXaktRDS7DZz+qKvHfUVzKGQl5BD6ZoTjiPI4QNAXl+niiC1Ky
         6t9TLSOIg9rXRhjNIAVSkmXm757Rd717FhuzWwiSl23JMWg6z0Orz8jSKR0xm/dGenOY
         y86Y7Kup+afPuafNQn+Zsw3ZROCjhpGMEcn1vKeM6Plms7fCkg1eaK5RNOJzD5L7zkJT
         tVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPASw0Pjg3A9RSZK9b9pwu/T/TyfBQMtAUoZ8ftIZpE=;
        b=s48IaTbXw9RiUe4V5fEhfPUKzOGymZxwR3g+S8uixLXl83LpGWpZDj2gTmnO8X/FuG
         CxBoNQci0vXeeqEmCdcOlDtPmUv0r0KqHCLXNrsXXTucZJDIlMxx96xHP9b3OpyC/UGt
         ag5b/OPTRMzBIcJitd2IyLKZ8ofYS5FQ9T3cd1WgtVvVD7BUzAeTfYyPrax6058tUD8h
         9C+ViNT8qThUNFU5f9Tr0DAFF47bPsJjnEC5OVoBt+3hEimFb+z7yjWuk3Z4tGNwD1Xa
         uCR2txIs5neFRrtAIwcnAB79flDIbdzGmlPx0Z2YUzfbAkdiHRhatJBPf1XJAOQNTU+P
         quGg==
X-Gm-Message-State: AOAM532O+NBEHwzGlC8MYL4VKlP9E4ZS99fcDqof96Raet1phpWKWY+T
        NKsefji6I4yoSp1GzlxrAi+j/mbP24Vy0RNb
X-Google-Smtp-Source: ABdhPJzhyQMrwRwDl2geq4aP16/Ku6RYmQjlO4Fzg4EN6xIJWOP+nL7Vvfo9aCVWCciU6IK5rKmVfw==
X-Received: by 2002:a17:906:edb5:b0:6b8:1a5a:f3a0 with SMTP id sa21-20020a170906edb500b006b81a5af3a0mr10313283ejb.501.1645894859782;
        Sat, 26 Feb 2022 09:00:59 -0800 (PST)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7c842000000b0041314b98872sm3028126edt.22.2022.02.26.09.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 09:00:59 -0800 (PST)
Date:   Sat, 26 Feb 2022 18:00:57 +0100
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: add driver for Aquacomputer Farbwerk 360
Message-ID: <YhpcyU+9Rc+FmaFk@fedora>
References: <20220221102157.13574-1-savicaleksa83@gmail.com>
 <5fa0a22c-5f55-bd38-8d76-a4ea31898bca@roeck-us.net>
 <YhpCrNhjfb0E8rLn@fedora>
 <fd9710d4-73a1-2b9d-7848-4c6291f6b2e1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9710d4-73a1-2b9d-7848-4c6291f6b2e1@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 07:31:34AM -0800, Guenter Roeck wrote:
> On 2/26/22 07:09, Aleksa Savic wrote:
> > Hi,
> > 
> > On Thu, Feb 24, 2022 at 11:57:47AM -0800, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On 2/21/22 02:21, Aleksa Savic wrote:
> > > > This driver exposes hardware temperature sensors of the Aquacomputer
> > > > Farbwerk 360 RGB controller, which communicates through a proprietary
> > > > USB HID protocol.
> > > > 
> > > > Four temperature sensors are available. If a sensor is not connected,
> > > > it will report zeroes. Additionally, serial number and firmware version
> > > > are exposed through debugfs.
> > > > 
> > > > This driver has been tested on x86_64.
> > > > 
> > > > Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> > > 
> > > Unless I amm missing something, this driver is quite similar to the
> > > d5next driver (drivers/hwmon/aquacomputer_d5next.c), except that there
> > > are 4 instead of 1 temperature sensor, the sensor data is in a different place,
> > > and there is _only_ temperature data. It should be quite straightforward
> > > to merge the two drivers into one, so please  do that.
> > > 
> > > Additional comment inline.
> > > 
> > > Thanks,
> > > Guenter
> > 
> > Yes, it's very similar, I based this one on that. I'll send a patch for
> > the original driver. I also have code ready for Aquacomputer Octo (8 fans, 4
> > temperature sensors, very similar to all this as well) with PWM write control
> > support for the fans. And there is also WIP code for PWM and curve support for
> > the D5 Next from contributors on my github repo, though we're working on that.
> > 
> > Considering that the driver would then contain support for more devices (the D5
> > Next and the Farbwerk 360 for now), can it be renamed to just aquacomputer or
> > something similar?
> > 
> 
> We don't normally do that (because the Kconfig symbol is already established)
> and just name the driver for the first chip (or, in this case, controller)
> it supports.
> 
> Guenter

Got it.

Thanks,
Aleksa
