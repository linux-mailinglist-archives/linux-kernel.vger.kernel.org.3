Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295C8586E88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiHAQ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiHAQ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:27:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038FB2E6BF;
        Mon,  1 Aug 2022 09:27:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id tk8so21322504ejc.7;
        Mon, 01 Aug 2022 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KAf5vLbsKsp7uUbSGBZa7lZ5oL5yKjRD9qrhtjgTrjE=;
        b=fvsADXhMNgxWYjQhNVn5/Jvose5R01Pgm9ZY0dCYGK8pV3l4OE22DP6sziQyeDC3FJ
         rlcwyrFD67x0lyTlcHTV673jNFuktDXsqnr0ekX56h3jqlOhS2pXAtXELfLIKMDUbvHP
         R3MZ5vncKNkEUpotTPq5/LUX9e+bweVQt8DspZ4yQHTX6x+xI/WDTDVZ9crn82bY0L6H
         lLLR8wpV3+4qbegC5iOafeFHt6zOQNs8kOR9QCwN9UGKzWZC33cDYzuMrz0VUBAuH3XW
         LElpbSat9RYnHpJNlDTRDCUB5110aK5n+NHUu0+cUcmOAIRtgPsNKpzTDmgqArz5ol63
         djMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KAf5vLbsKsp7uUbSGBZa7lZ5oL5yKjRD9qrhtjgTrjE=;
        b=BOMaxVjJ509tqQriqHZKbAUbBd+y7Ds6X8XBYt2n0iBDB6kRmEmx446Hfw0ifk7Ona
         5IsJ764Z+ETAvXJGSxuz569aR9rb5CdNtCZa0g7FSQKP2E3LW5kZ0rC261U4URGcwnjv
         PVAN3DjcYbAa77lzcnLS3MVlyd1rAOXcZmMd115B4BGNWnBpJGDXCGVLu8J7gvbP+SMd
         SrciOXjqD/Za4ZkHXFL9Cpq2XrH5buEBI0+jMgqwFYnYhaod1Q/OxwGjB5cPVNIC8/gI
         6cc+6e34hqYchkU8CioN0+QJFqBsuouuIa1EHOqneJX0TH1ljxoph8uQgOBBhDU6VPd9
         Zskg==
X-Gm-Message-State: AJIora8evS5yo/2yqgqeBWoyBJeuFHwPijRsgY/b8jJ3KICNUqwXlxVK
        q1MLGgid0qWgZHXAVVNxmz0aCI6A5UPMSXjWeZg=
X-Google-Smtp-Source: AGRyM1v0u8I9accxzfNFkDttuh6f0VHssEMwUucAidbficguhXtKhnmXVsTva4GY5MzrXfydS4f4YK8orM19WbjcYYg=
X-Received: by 2002:a17:907:28d6:b0:72b:7497:76b with SMTP id
 en22-20020a17090728d600b0072b7497076bmr12798927ejc.365.1659371222414; Mon, 01
 Aug 2022 09:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
 <20220728125435.3336618-3-potin.lai.pt@gmail.com> <20220731130959.50826fc4@jic23-huawei>
 <4ea235d1-46c1-87de-760f-dc4775007ae0@gmail.com> <CAHp75VcZqTpmvVV=u4t=fdx=ffzksoWVDFZmq6Lfr6DrFrB2aA@mail.gmail.com>
 <Yuf7UAVrIJCnO40X@heinlein.stwcx.org.github.beta.tailscale.net>
In-Reply-To: <Yuf7UAVrIJCnO40X@heinlein.stwcx.org.github.beta.tailscale.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 18:26:25 +0200
Message-ID: <CAHp75Vfe33oJAf1j27B-pTd84kX5JNPd+e16ygLYgZjCs=ZJfQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Potin Lai <potin.lai.pt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 6:12 PM Patrick Williams <patrick@stwcx.xyz> wrote:
>
> On Mon, Aug 01, 2022 at 10:22:16AM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 1, 2022 at 3:52 AM Potin Lai <potin.lai.pt@gmail.com> wrote:
> > > On 7/31/22 20:09, Jonathan Cameron wrote:
> > > In our hardware board, we have "ti,hdc1080" as main source, and "silabs,si7020"
> > > for 2nd source. This two chip are locate at same bus and same slave address,
> > > and we want to use multiple compatibles to support both chips with single device
> > > node in device tree.
> > >
> > > Ex:
> > > compatible = "ti,hdc1099", "silabs,si7020";
> >
> > This is simply broken DT, you must not put incompatible hardware on
> > the same compatible string. DT is by definition the description of a
> > certain platform. What you showed is a combination of incompatible
> > chips in a single DT.
>
> We were mistaken that this is the appropriate way to specify this
> behavior, partially because it works as long as the probe functions
> return an error the next matching driver from the compatible will probe.
> It does seem that specifying two different compatibles like this would
> violate the intention of the DT spec:
>
>     The property value consists of a concatenated list of null terminated
>     strings, from most specific to most general. They allow a device to
>     express its compatibility with a family of similar devices, potentially
>     allowing a single device driver to match against several devices.
>
> >
> > > In order to support this, I need to add ID checking mechanism into the current
> > > hdc100x driver, so the si7020 chip will fail to probe with hdc100x driver
> > > (because the ID checking is not failed), then success probe with si7020.
> > >
> > > Base on you explanation, it looks multiple compatibles is not suitable in this
> > > case? Would you mind advise us what would be the better approach for our case?
> >
> > If I may advise... fix your DT by dropping the wrong compatible item.
>
> This doesn't really give any helpful advice.

Sorry to hear this, but it's the best and correct solution to your
problem. Believe me, many Linux people will tell you the same.

> The reality is that these two chips are pin compatible and function
> compatible but not driver compatible.  Boards have been manufactured
> which are identical except for this chip replaced, due various to chip
> shortages.
>
> Making probe fail so that the next 'compatible' is chosen sounds like it
> isn't desired.  I'm pretty sure you can't have two DT entries for the
> same i2c address, but with different 'compatible" properties, and even
> if we did you'd still need probe to fail on one of them.
>
> Are there any other suggestions for being able to inform the kernel that
> one of two chips might be present?

I guess there is a gap in understanding what DT is. DT is the
description of the *platform*. Changing any discrete component on the
platform is changing the platform.

-- 
With Best Regards,
Andy Shevchenko
