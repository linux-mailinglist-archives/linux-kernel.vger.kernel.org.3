Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6354E5D28
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347758AbiCXCXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbiCXCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:23:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9A793995;
        Wed, 23 Mar 2022 19:21:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u16so4652080wru.4;
        Wed, 23 Mar 2022 19:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3qclwzwUGtDFwZwOazh4jA3jMuR+ekMkvwqZKLbIrEo=;
        b=IN6kcMcqkbzgaWq0PMKkxOy/Ro8RXyXtkuQaqY5vJTuTTjfZHJy/RpaWJpjReKg+UR
         auf1BvzN+SKkqvpLl1yUDxCb7TlxSN/tKYRKQI2yIATSWXRj1RY2Ac2UX2cc3Lg/NWn6
         3zb8nki0AnDe6QMK6Rqv8ba7ytJIM61EV2RPycDgNEYdwHt1ajt4TkVsK5u6AZeKCpwE
         Q2nugzeGqWTCjVQNEXrbv8Lb6t6SCBhginCnDvWwgJPR4/qclkHs0/OmLjX8a1izP84x
         hO25fLctmlZrXIKOT3uAbD2sFfHlXOMnQcBSxEzvighgy5SnVWQ34DbZTb81WRNk9Ggj
         Sl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3qclwzwUGtDFwZwOazh4jA3jMuR+ekMkvwqZKLbIrEo=;
        b=WyGAVRfBcV6NrFGw+tTF4swzWDOJConPFzU9sNNcI5vhU/Uayol5MYkzDfp9QXqIUg
         Rlm7GTq4EDIrPzaywiTQUobownAWRKsAIjTp3KbSl142hyTolZQdDhgJBW2sZYBpJp5l
         1X+fuuAVjo/0z3CDtUqqi7gXObg+Fj1BbXPNZTJV9EnyHw4QOAwhdaiRyhu/1nVoOhmH
         DfwNmXSPQnHA0q2NuxsiGRCheGG+xNbfj11FPen8zwbY9ihKueoEkoTK+DJCMElc2wrP
         DgW4oxYcG0cyWgUKsG+68Z+vebFXOqyy+/i9Lid9EYJO9IQmOFt5fFKjc3BbqTClJo07
         l6ew==
X-Gm-Message-State: AOAM532H4kCP11EFB7shVFmIeRxz6svygZQxeC6jis35JQoOOPhXkXvq
        nwO1GrjLb4WhkEmk//845Mo=
X-Google-Smtp-Source: ABdhPJyG3/JiSU2g884TYRg/m22N8rrRg+F9NF4NIXjKZqhxE59qCrFhppJ8HA8vTeNm8Gz8yuoJpQ==
X-Received: by 2002:a5d:660e:0:b0:203:eda6:e983 with SMTP id n14-20020a5d660e000000b00203eda6e983mr2554104wru.544.1648088491171;
        Wed, 23 Mar 2022 19:21:31 -0700 (PDT)
Received: from hermes ([2604:3d09:e80:800::72d9])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm1670165wru.99.2022.03.23.19.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 19:21:30 -0700 (PDT)
Date:   Wed, 23 Mar 2022 20:21:26 -0600
From:   Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     lains@riseup.net, jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <YjvVptj8exUCD7sx@hermes>
References: <Yifr4etBFPu1a2Ct@hermes>
 <20220323210423.GA10741@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220323210423.GA10741@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:04:23PM +0100, Pavel Machek wrote:
> Hi!
> 
> > The HID++ protocol allows to set multicolor (RGB) to a static color.
> > Multiple of such LED zones per device are supported.
> > This patch exports said LEDs so that they can be set from userspace.
> > 
> > Signed-off-by: Manuel Schönlaub <manuel.schoenlaub@gmail.com>
> 
> Please cc LEDs stuff to the LED lists.
> 

Will do. Though it seems like first we should discuss whether the kernel
in fact is the right place, no?

> > +static int hidpp_mc_led_register(struct hidpp_device *hidpp_dev,
> > +				 struct led_classdev_mc *mc_dev,
> > +				 int zone)
> > +{
> > +	struct hid_device *hdev = hidpp_dev->hid_dev;
> > +	struct mc_subled *mc_led_info;
> > +	struct led_classdev *cdev;
> > +	int ret;
> > +
> > +	mc_led_info = devm_kmalloc_array(&hdev->dev, 3,
> > +					 sizeof(*mc_led_info),
> > +					 GFP_KERNEL | __GFP_ZERO);
> > +	if (!mc_led_info)
> > +		return -ENOMEM;
> > +
> > +	mc_led_info[0].color_index = LED_COLOR_ID_RED;
> > +	mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
> > +	mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
> > +
> > +	mc_dev->subled_info = mc_led_info;
> > +	mc_dev->num_colors = 3;
> > +
> > +	cdev = &mc_dev->led_cdev;
> > +	cdev->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
> > +				    "%s:rgb:indicator-%d", hdev->uniq, zone);
> 
> So this is keyboard backlight? We should add the documentation at the
> very least, so that other drivers use same name.
> 
> Best regards,
> 								Pavel
> 
> -- 
> People of Russia, stop Putin before his war on Ukraine escalates.

I do not own a Logitech keyboard, but some mice. There are RGB leds
that you can normally control with Windows software.

I'd suppose (but could not verify) that supported keyboards by Logitech
work with the same feature.

Best Regards,

Manuel
