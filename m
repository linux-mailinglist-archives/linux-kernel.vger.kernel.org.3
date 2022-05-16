Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0017528069
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbiEPJIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbiEPJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:08:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB11522B2C;
        Mon, 16 May 2022 02:08:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so8221206wms.5;
        Mon, 16 May 2022 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DbwlhGlNKP/GOpbAeD4xPGjFcllAu7o315UPeOpEeyU=;
        b=CxOeoldsv2HbmBTaajEpo3Tkl9Gk25dW8aWLkB2oOyZTqf7EKAIm4x9cD96zpHdSKG
         wx9h5cRz7nAgq5faFt3OnR34+Sc9y+ClpVN/gUwFRHZiy3x8Wg/2G0yd0QNtxRwX1s4S
         66I8ixhE0I9q44/UmFRPB89Gse9V1fzngkNDa5FvwOvajT0QFL/bhABYcy5mBHD/svPH
         +iAMItZmqJR6RXUuaiXV0ZJeqTGrbq0JNQdreZGrqoqAEruSqaVhnXiUGnaIn0aQYuZH
         cz/WN/N0mJttBo4Z1tK6vgl7z/YQ3Csqr6Y+sFu0xgvB4PS8zKGw8ZVnmdq2Iw4rHPxZ
         xIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DbwlhGlNKP/GOpbAeD4xPGjFcllAu7o315UPeOpEeyU=;
        b=0PsIQ0Iuffs1td3GCpSx9Iy/+l9BKdKdBqU3AfJo2SuefanZ6dtNa7B99/M7ip1JJZ
         H7Q6H+3gstKXm4fPzYYkErakTz3V8vO5qtQjFdaGDpywkOJ3H0Dwkhq6dubgVxKIi72K
         HxyqCUdA+tV1TQForfgTXj5cwVrZDIzNU5I1dKJ5sG4NqKzo/HRg0tfY3xIAzfcJdZo7
         fvho1rxmMWaJWxPApfNTT2g5DDep/bUKP9cLjw3ao8G/WdQFpukwr7HhddFB8umCdtnH
         L/wUiDpGqOCuUT+rmrW64PtJAntt6K0T500B+vw908EZTNt0JKcNkHI7ljbNmh9It9Ye
         EPsQ==
X-Gm-Message-State: AOAM533MmtK9Xfb64D8K+D0uMpiwdrgc2q4NNRRysfZHtQ6/SiLw3tUR
        Eaf1IOKAs7Ww8DrBRKZ5KRA=
X-Google-Smtp-Source: ABdhPJzPozxn0bDxJUwV0PT6jJ+mRjLbazeRvzPdImLmRzzygJHWYRqmNcOW4fzcXQCGMtylTDNqfg==
X-Received: by 2002:a7b:c081:0:b0:394:789b:915 with SMTP id r1-20020a7bc081000000b00394789b0915mr15494028wmh.105.1652692112175;
        Mon, 16 May 2022 02:08:32 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id h12-20020adf9ccc000000b0020adc114136sm11046252wre.0.2022.05.16.02.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:08:31 -0700 (PDT)
Date:   Mon, 16 May 2022 11:08:29 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Berzl <stefanberzl@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Status on hid xppen patch
Message-ID: <20220516090829.GA20623@elementary>
References: <941a793a-d2f7-9c2c-59be-b3930e1acfec@gmail.com>
 <20220423172330.32585-1-jose.exposito89@gmail.com>
 <95576534-1f5e-c2e3-4f73-c1b0a8300b56@gmail.com>
 <20220424093239.GA4380@elementary>
 <20220512205952.GA8936@elementary>
 <ebb6d627-4974-beed-1dc6-60634ab2f034@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebb6d627-4974-beed-1dc6-60634ab2f034@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Fri, May 13, 2022 at 07:22:49PM +0200, Stefan Berzl wrote:
> Hello José,
> 
> > The tablets are the Deco Mini 4 and the Deco L, both of them are UGEE
> > tablets. I already had a UGEE Parblo A610 Pro tablet and after having a
> > look to the Windows driver traffic, I found out that after sending a
> > chunk of magic data to enable the tablet, it requests a string
> > descriptor ("uclogic_params_get_str_desc" can be used here) and the
> > tablets respond with their parameters.
> > 
> > The information is encoded, in bytes, as:
> > 
> >  02 + 03 - UCLOGIC_RDESC_PEN_PH_ID_X_LM
> >  04 + 05 - UCLOGIC_RDESC_PEN_PH_ID_Y_LM
> >  06      - Number of buttons
> >  07      - Dial present or not
> >  08 + 09 - UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM
> >  10 + 11 - Resolution
> > 
> > Bytes 12 and 13 are present but set to 0, probably indicating my
> > tablets are lacking some feature.
> > 
> > Could you confirm that your tablet returns similar information, please?
> 
> yes, you can haz string descriptor:
> 0e 03 0b 8b cb 56 08 00 ff 1f d8 13
> 
> Byte 12 are 13 are set and zero, as in your case.

Sweet, that means that we are on the right track and the implementation
can be generic... Meaning that we won't need to write and maintain a
bunch of HID descriptors :)
 
> > In case you want to have a look to the implementation, I'm working on
> > this branch:
> > https://github.com/JoseExposito/linux/commits/patch-xppen-deco-l
> > 
> > I had to introduce new functionalities to the templating system of the
> > driver, that's the reason for the KUnit tests.
> > The last patch is work in progress (hopefully I'll have time to finish
> > it this weekend), only the HID descriptors are missing.
> 
> I hope you make it, but otherwise you can always use mine, as it's quite
> the same as yours. Only the logical minimum and maximum are -60 and 60.

You are right, 60 and not 127 is the right value. Actually, I think
that -61 - 60 is the correct range, because of the 0.
Running "libinput-debug-tablet" makes it easier to debug.

I also had to fix the descriptor to avoid an issue with the pressure
causing issues with the Deco L, but other than that, it should be
correct now.

> > I'll cc you when in the patchset so you can add your IDs :)
> 
> Is that all you want me to do?

Code comments and suggestions are very welcome, as well as testing.

Also, I don't know if you have seen this error after connecting the
tablet:

  xhci_hcd 0000:2a:00.3: WARN urb submitted to disabled ep
  usb 3-2: reset full-speed USB device number 6 using xhci_hcd
  usb 3-2: reset full-speed USB device number 6 using xhci_hcd
  [...]

It happens with the Deco Mini 4, even when using the hid-generic
driver. I need to rebase my patches on 5.19 and test again, just to
make sure the problem is not somewhere else.

Jose
