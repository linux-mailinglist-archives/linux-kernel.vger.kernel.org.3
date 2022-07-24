Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33BE57F4CD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 13:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiGXLPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 07:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 07:14:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B7517E27;
        Sun, 24 Jul 2022 04:14:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bn9so1312784wrb.9;
        Sun, 24 Jul 2022 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7yegliwNnjd7kIkZ4b5lHO5AyQPvCCSbxyixcu2qaVA=;
        b=CFFfX9KoMVdmA4EHR/VnfHTcBI4DoVRI7tV7dPl+DJ7FnsEe4+P1ztF1wtZxl+Tz9p
         jCv464spey43ae4c18DRn7wlkQUqVt99udJKVgV1fR5fhPs3Ej7PCjEJUclmv8N84i4D
         TGThUM+TfGHixVdige1ODNwzxA7hagvAmvQqffWrlR0VxWfSqZF+HOjLtHX9VjQJx3av
         zk3eLuJpe59oLq5ZuG6A8O2wIZSG0aQuY5inVoHFQB9GbxkqLnrJRiCsgwoGwL+E2mvX
         jeMjAG4ZeHhQ68rc2Rn/WCz3D88OlAdDpnHRz3kYQDrRwoSU0twDZ4GGZyUB1UjuM6Gl
         Ba/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7yegliwNnjd7kIkZ4b5lHO5AyQPvCCSbxyixcu2qaVA=;
        b=Hh4NKaZ2LFivovm3n+ZkeamnbWs+t71O/+Er/vTJAUgZTU3j4RUNF0of2fQH3uE5Dw
         Lq8AC128rRx4bU4NCvuBsfZElgzseiCv+gFBXI99qNepWGg9IDxKoQMf124XKATEoSTl
         B1xg84VjEHPxHP7dGtZJAncDG2PFihMbvMAIqiDO21QOMUCXy58jfds261J5f39rf9h0
         NUqGl3byTVRRy2AsMRE4fNU5v6psqNkOSF+GTGpAxt6oyIJitHGZV0JWm9eA1MkMoPWi
         uLSaaHa6a9GECFRS7XvEebKFXaBqHK74r1ZfcNS2yRP0fu8ANFbnkfVzgFtftF/gAhfN
         zTzQ==
X-Gm-Message-State: AJIora+olAqHdJqm6z8BhMJVtvDrhbmVYhbRfhlXNEnYukvY/l3dX77R
        XO9jYzpB9lK2MZudaZp629s=
X-Google-Smtp-Source: AGRyM1vcfHsrokcENKMMZszoABULy5nHkMEkPesgYVM4lMftp0c3DGYWPqDvWj04zr9Mma01RDp1Wg==
X-Received: by 2002:a5d:64c1:0:b0:21d:ac34:d086 with SMTP id f1-20020a5d64c1000000b0021dac34d086mr4881825wri.319.1658661295841;
        Sun, 24 Jul 2022 04:14:55 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c3b8c00b003a2ed2a40e4sm15703494wms.17.2022.07.24.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 04:14:55 -0700 (PDT)
Date:   Sun, 24 Jul 2022 13:14:53 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     spbnick@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] UCLogic: Filtering unsupported HUION tablets
Message-ID: <20220724111453.GA31129@elementary>
References: <20220718172953.6817-1-jose.exposito89@gmail.com>
 <20debb4d623f057b77ad9d2f5909540baf750c13.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20debb4d623f057b77ad9d2f5909540baf750c13.camel@hadess.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:39:06AM +0200, Bastien Nocera wrote:
> On Mon, 2022-07-18 at 19:29 +0200, José Expósito wrote:
> > Hi!
> > 
> > No code yet, just a kind request for comments and hopefully some
> > wisdom
> > and experience from Nikolai dealing with HUION devices.
> > 
> > HUION keeps reusing the same vendor and product IDs for their
> > devices.
> > This makes it really difficult to differentiate between devices and
> > handle them in the kernel and also in user space.
> > 
> > Reusing IDs could introduce a problem:
> > 
> > If HUION, or other vendor following the same practices, releases a
> > new
> > tablet with a duplicated product ID, the UCLogic driver would handle
> > it.
> > The device might work with the existing code or it might fail because
> > of
> > a new feature or a whole different firmware.
> > 
> > As far as I know, at the moment there is not a mechanism in place to
> > avoid this situation.
> > I think that it'd be better to ignore those devices in UCLogic and
> > let
> > the HID generic driver handle them because using HID generic would
> > provide a basic user experience while using UCLogic might fail to
> > probe
> > the tablet.
> > 
> > DIGImend's web already provides a nice list of supported devices:
> > http://digimend.github.io/tablets/
> > 
> > So, I wonder:
> > 
> >  - Do you think it makes sense to ignore untested devices?
> >  - If the answer is yes, do we have a better option than checking the
> >    device name against an allow-list? It'd be great to hear other
> >    people's ideas.
> 
> I don't think it makes sense to ignore untested devices, unless you
> know for a fact they won't work.
> 
> But if the name is part of detecting the device, it would certainly
> make sense to use that as part of the identifier for the device, rather
> than just the USB VIP:PID.

Agreed, I also think that adding the name to the vendor/product IDs
pair would be a better identifier. However, at this point, we don't 
have that information for all supported tablets, so I guess that we
will have to fix new tablets reusing the VIP:PID as they are
released.

It is unfortunate, but we'll have to deal with it.

Thanks a lot for your comments!
Jose

> You should be able to add the product strings in the .driver_data, and
> check them in probe().
> 
> Cheers
