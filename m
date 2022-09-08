Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945235B1418
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiIHFgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiIHFgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:36:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62394543DD;
        Wed,  7 Sep 2022 22:36:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v4so15642260pgi.10;
        Wed, 07 Sep 2022 22:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=XSaEEp3bnQCQ+NAfy3AWeCLVxgW8xttjR0bTKrhnYDM=;
        b=CzD/sQkcxG5xYCXNPHtmRcqHe2zScH6KQGjpNa2bVwiPwKyW1cKv4l0FUIweaobM/E
         FvKHO9lWX51ZJoceB/T50BXpsu/I+EbON6dUVmQgavalnbjU1H9FnYqb4YXYoP4wUXyH
         Xsx0QPwLn5Nw37Xt+pfqA0BlAkN2hQff0jsyLvepP24pWJVNtEeF3Kj/khJsGbiBcW+e
         265r3+FaqWsDE6JKpcMhXHb/miH9iZYGxiwGLbNu6uPHvp833/qozMhkr2jA9E9mz/j5
         vX7oS8vR846KySY0Pjx74fY+N92+CL/E7K0RrcgJE92jmZCoelXn7aUNQifLfnqg3qx/
         p2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XSaEEp3bnQCQ+NAfy3AWeCLVxgW8xttjR0bTKrhnYDM=;
        b=EfxBFSWodAXHVHFKM1VWeBus2xW+4VsShSenbqxhRDZn5lxk/aosEtliCClXLe71JG
         sBP3YoiZ9nSWsS+UZaOdLHJ3fXe/Qo/p+GREXjPO/obuOfuuvUf3h8i/ChvzUwTqgihb
         1d1QrvsgV8dAtCmONBmwEuAdqferzimz56wldr3Vs2bHXwMc1I1zXNFNwH3cLzPXPYcc
         a+CFeJWpygp0dlHulmcjD5tvxpgu6ZNYUl140Kkj9UEYlhttV3It0miG2IOgRKq67fJe
         3P/pRLdkVs703m5qSOA/9ar7bO5eMIrDxrkkg3FVMGor9y3x6ViAkQ93AdS+PHQdZBis
         /zGQ==
X-Gm-Message-State: ACgBeo1TA/OSHo8qhVpBzxhw5qQHbsVaond6MvjiH5vcATnJOCMvLA0E
        inlBuQtiQXQ5kDrMMi0yooA=
X-Google-Smtp-Source: AA6agR6oJbZtP7MyjwSY9Sf5oEoSVV7tmITNkThEoGTbyNRrEDeqPs/5pgJyKfYRs8GmYXa7XaDSJw==
X-Received: by 2002:a05:6a00:21c8:b0:52e:3404:eba5 with SMTP id t8-20020a056a0021c800b0052e3404eba5mr7472850pfj.67.1662615398688;
        Wed, 07 Sep 2022 22:36:38 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7af1:2c0d:fbfa:b9d7])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b00173cfaed233sm1290356plf.62.2022.09.07.22.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 22:36:37 -0700 (PDT)
Date:   Wed, 7 Sep 2022 22:36:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Nate Yocom <nate@yocom.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
Subject: Re: [PATCH v5 2/4] Input: joystick: xpad: Add ABS_PROFILE axis value
 to uapi
Message-ID: <Yxl/YxSRtV9Hv271@google.com>
References: <20220825222420.6833-1-nate@yocom.org>
 <20220825222420.6833-3-nate@yocom.org>
 <3e48ef8d13337ce1c3ec68baffc612fde4740b0e.camel@hadess.net>
 <Yw0OjoVzKV3QOYah@ghaven-kernel>
 <661ee8227c96aeba7aae9fff6ac9a73f1d81e765.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <661ee8227c96aeba7aae9fff6ac9a73f1d81e765.camel@hadess.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 05:41:08PM +0200, Bastien Nocera wrote:
> On Mon, 2022-08-29 at 12:07 -0700, Nate Yocom wrote:
> > On Sat, Aug 27, 2022 at 12:40:46PM +0200, Bastien Nocera wrote:
> > > On Thu, 2022-08-25 at 15:24 -0700, Nate Yocom wrote:
> > > > Add an ABS_PROFILE axis for input devices which need it, e.g. X-
> > > > Box
> > > > Adaptive Controller and X-Box Elite 2.
> > > > ---
> > > >  include/uapi/linux/input-event-codes.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/include/uapi/linux/input-event-codes.h
> > > > b/include/uapi/linux/input-event-codes.h
> > > > index dff8e7f17074..7ad931a32970 100644
> > > > --- a/include/uapi/linux/input-event-codes.h
> > > > +++ b/include/uapi/linux/input-event-codes.h
> > > > @@ -862,6 +862,7 @@
> > > >  #define ABS_TOOL_WIDTH         0x1c
> > > >  
> > > >  #define ABS_VOLUME             0x20
> > > > +#define ABS_PROFILE            0x21
> > > >  
> > > >  #define ABS_MISC               0x28
> > > >  
> > > 
> > > 
> > > You probably also want to add it to the absolutes array in
> > > drivers/hid/hid-debug.c.
> > 
> > doh, roger.
> > 
> > > Again, you might want to wait for confirmation from Dmitry that
> > > this is
> > > the right way to do this for the profiles.
> > 
> > Makes sense.  Dmitry?
> 
> Dmitry, could you please confirm whether ABS_PROFILE definition is
> correct?

Yes, I think this makes sense. Do we have a buy in from userspace folks
(Peter H, etc) for this?

I'd like some documentation added to Documentation/input/event-codes.rst
and potentially to Documentation/input/gamepad.rst even though profile
does not have to be gamepad specific event.

Thanks.

-- 
Dmitry
