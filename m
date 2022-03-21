Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C520A4E2997
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348876AbiCUOGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349233AbiCUN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:59:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5735255B0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:58:28 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id 8so1300646ilq.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+Ha+4MkGG0rcPyeHKUpRTP8Sg3O5ksnG1QqvI9ZHyI=;
        b=n2SzX5oZso0KhIFPs+X0TIL2//j1amgmhkmXqJupG9ju2j8lN3ilU10Ndb6yw0IS0M
         EN4IBOoeKBrZw9hI3pVwDtUrwSy3229Y2bI47POcBB9SYgGe4t0NmEeJwtIzYgb3DtzL
         CdmdPQlEUkLXGZjjz8+KYZ8/NyejAtcCSFWW4N5Zn2K+TAGEGOK9DogVIJrUjiwdfRL8
         BgigFB5ko0wmq9tzu3sfoakRuiA8WS58LqhYZ+3yenSvgqC0quJaq/miYqEBLcf4+Ykk
         enJP9BBxtv0JXf+8Ouyv6EqsQ9UYQLLjzh+nAx2Hnc0S/Hx+9rwaR4y4m/nuDPBq7pxq
         IRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+Ha+4MkGG0rcPyeHKUpRTP8Sg3O5ksnG1QqvI9ZHyI=;
        b=AtlWu/d0sHlrV3yKlaP4krlw5M3bn6Q1AOfXvaklc+Zkm2hhrV06kqjAxCKqCtLKO4
         XaN19GUMXixuw6fVlvmucE7Bvk/lUPfNDJ+vUTjUkYY/THCvSS/AcmYhHSQkVuRSCExv
         dI7Pxrfg7GkXWs84dW0HRzmASg45Oc5b+Hyb2Y5k2wDmbtUMy/pmFzYRJsb8dNIfopKK
         +/Ep+DawilFZg/zN6vRxuzbIPECb5P3zqQLA0k5mQpRHqhS6RfWmuA5o4OXMtrJAbGBP
         e0TCeM1oel92DFKLFWdL1ljqY3C4paw9TksTLRwASfTxYQmmW91dj1vPmFOWQVerXypL
         n6XA==
X-Gm-Message-State: AOAM530/YhtnP8SYE99dNxwciKZov1+6qD+UewlVbuZSqhQRkQs0BHXE
        jhQ4mDW1CE/TqmWcOuMKfZK9Fc5uPJW0a/2BF/0vsg==
X-Google-Smtp-Source: ABdhPJwiF1TaI5R3uwA7Caoz179NE8txpfZxe1JHe+wKDDSOaRVDVID3DkeZILA6n1+PDO5TDjqp+g5YEGLFAvJkZEk=
X-Received: by 2002:a05:6e02:1847:b0:2c8:1134:4d5c with SMTP id
 b7-20020a056e02184700b002c811344d5cmr4473803ilv.159.1647871108097; Mon, 21
 Mar 2022 06:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220321121728.414839-1-robert.marko@sartura.hr>
 <Yjhyg5cNe5KZ6SOp@lunn.ch> <CA+HBbNHw5v+R5WHPTvNj7oVtz0szsCm=JCXPFRtUf2GW7Qz35Q@mail.gmail.com>
 <Yjh6ysD/fPT/IQLc@lunn.ch>
In-Reply-To: <Yjh6ysD/fPT/IQLc@lunn.ch>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 21 Mar 2022 14:58:17 +0100
Message-ID: <CA+HBbNExq86kXpmFT4eiSBagcADyHFGmuuY3izkthEZ+GqEV4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: uDPU: update partition table
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 2:16 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Mar 21, 2022 at 01:47:21PM +0100, Robert Marko wrote:
> > On Mon, Mar 21, 2022 at 1:41 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Mon, Mar 21, 2022 at 01:17:27PM +0100, Robert Marko wrote:
> > > > Partition currently called "uboot" does not only contain U-boot, but
> > > > rather it contains TF-A, U-boot and U-boot environment.
> > > >
> > > > So, to avoid accidentally deleting the U-boot environment which is
> > > > located at 0x180000 split the partition.
> > > >
> > > > "uboot" is not the correct name as you can't boot these boards with U-boot
> > > > only, TF-A must be present as well, so rename the "uboot" partition to
> > > > "firmware".
> > >
> > > Are there any ABI issues here? If these names are being used
> > > somewhere, you are potentially breaking the boot. At minimum, i would
> > > like to see something in the commit message which indicates you have
> > > considered this and why you don't expect it to be a problem.
> >
> > Hi Andrew, this won't break booting as BootROM does not care about
> > partitions nor naming, it will just go to 0x0 of the NOR and boot it.
> >
> > The same renaming had already been done:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/marvell?h=v5.17&id=a9d9bfcadfb43b856dbcf9419de75f7420d5a225
> >
> > I can update the commit message if required.
>
> Yes, please. It is always good to indicate you have thought about
> issues like this. Not breaking the ABI is very important, and could
> result in this getting reverted at some point. So indicating why you
> think this is safe is useful information.

Thanks, will do it in v2.

Regards,
Robert
>
>       Andrew



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
