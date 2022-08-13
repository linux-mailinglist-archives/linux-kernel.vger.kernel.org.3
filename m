Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED85591C17
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiHMRJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiHMRJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:09:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A4A180
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 10:09:51 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x23so3189568pll.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc;
        bh=7XLOg7bvUW6JPcCBSsbLMyM4207tH84mqtU1IP1whts=;
        b=kZ4wInc1V/RMdb+gVDm/QK2Kb3SFAB+pFbbjnLPevRr21TrNpbDWP4OCCPLPr5kVYM
         Kskpz8UZHS8+ZhEH3Dmg36m5LWBVtiaXJZ18Guk5rJsz6ZngcM9ge+zHQZIe1wHaIGo5
         xHoASiIADKyNleB8CG7rg0OdyMBswUXFlWj2xqLMspwlXVPiZ7ElEBTPonFvBoKTo59F
         dBnM4/M3hr/LUceAY8MFsf8VrWerRAnR9d61dBDpzXUAMjXBCvobRDFeO5wOVxXSdrC7
         k8LBjrzsRMoa5Qy+0klmUj8Pdrvn80du/AYRhL1s4GBTcJpngnd+UHSffCZIXoGNVgbv
         RTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc;
        bh=7XLOg7bvUW6JPcCBSsbLMyM4207tH84mqtU1IP1whts=;
        b=W5/SEp0Y5NgociTq40UoEWJ4UDDx4Ka6GIg9nnzA8Lf+w9UlM+ggN5kjNG0Lu0uzDV
         YqjZydsgW7jIywZZZXP4usFbfc5uyashhaJVMYL6qtZgfG7vZ74L47yLilDsH+qo8Gf5
         XsrSkYgfUwgLBjdzJtkPWU0M1bfk0LFU8MH4rEb9CkjYZMKnM0lDNL6UIW5A6KvEhW4a
         ctKDY8zWMY+2S6YuWrl25g/4Yb5n/+9FxaHtqstnXowY38HiVCOqun+c5xj/SOTCQ+ut
         e7RfM/3cIIoIZ1n3iDzlwBZ8Ar56KC4TsBzbUncQ31V/Wir3AAw9n1VLdGO+NvT3fsUD
         8WMQ==
X-Gm-Message-State: ACgBeo30eUgAjU5odd2getmpv5dR0YE9AlPBNIm54DCAuf5XjRO3/eov
        ymD5P3Xl42NAiWVJztaKs58XyV2uN93cmA==
X-Google-Smtp-Source: AA6agR5nHnduC6aAf88J5VINnD+OGX28ctUfEHe1AFpKiGXLM8KiY5xd1kho/336YTRPaNb7FuH6Vw==
X-Received: by 2002:a17:90b:4b0c:b0:1f4:ffac:699a with SMTP id lx12-20020a17090b4b0c00b001f4ffac699amr19436548pjb.145.1660410590729;
        Sat, 13 Aug 2022 10:09:50 -0700 (PDT)
Received: from ghaven-kernel ([2601:600:a07f:e6ac::1c])
        by smtp.gmail.com with ESMTPSA id v13-20020a655c4d000000b0040ced958e8fsm3234918pgr.80.2022.08.13.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 10:09:50 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
X-Google-Original-From: Nate Yocom <nate>
Date:   Sat, 13 Aug 2022 10:09:48 -0700
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Nate Yocom <nate@yocom.org>, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: joystick: xpad: Add X-Box Adaptive Controller
 support
Message-ID: <Yvfa3BZ1z0bNq8sN@ghaven-kernel>
References: <20220810141511.11827-1-nate@yocom.org>
 <32f116c30f1f071d57e8e2d15425178cbccf9b70.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32f116c30f1f071d57e8e2d15425178cbccf9b70.camel@hadess.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 03:19:50PM +0200, Bastien Nocera wrote:
> Hey,
> 
> On Wed, 2022-08-10 at 07:15 -0700, Nate Yocom wrote:
> > +               /*
> > +                * X-Box Adaptive controller sets 0x02 when x-box
> > button is pressed,
> > +                * we could probably condense into just data[4] != 0,
> > but explicitly
> > +                * checking here ensures no regression if other
> > devices set other bits.
> > +                */
> > +               if (le16_to_cpu(xpad->dev->id.vendor) == 0x045e &&
> > +                       le16_to_cpu(xpad->dev->id.product) == 0x0b0a)
> > +                       input_report_key(dev, BTN_MODE, data[4] &
> > 0x02);
> > +               else
> > +                       input_report_key(dev, BTN_MODE, data[4] &
> > 0x01);
> 
> 
> I won't be able to test the patch until next week, but I would actually
> implement what you mention in the comment as a separate patch. This
> would avoid having a special-case for a specific VID/PID without a
> quirk like "MAP_LAYER_BUTTON" defined, and if it were to cause
> problems, it would be straight forward to revert.

Thanks for the feedback, should I make this a series of 3 successive patches then?

 1) Add the device to xpad_device[]
 2) Support the Layer button with MAP_LAYER_BUTTON
 3) Support the X-Box button (as suggested in the comment instead of
 VID/PID checks)
