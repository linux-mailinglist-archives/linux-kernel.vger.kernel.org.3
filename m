Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5AB589B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbiHDMIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiHDMII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:08:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC4F1F630;
        Thu,  4 Aug 2022 05:08:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 12so17788781pga.1;
        Thu, 04 Aug 2022 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=oj4umfrgq5/P3WASTduG+ZLVS3oiMhcR65M2eR099cc=;
        b=LuleUjxrKP6D/pBxul3wAHqGWh0aVcsqdax2/+bYDPi9JbIwgiOsaQqrFp2L++tnXw
         EMmTYqHhgu844EG6sfW74u2bpTf6JtAQTwvSMWyRgOw9XYj4ebAjpu/UlZtVb4imYf8N
         6xvzOhH+ozn2/C5AGua6LlNPPgfye+ovsU2ojLHId+s8HsHipnXliz3/v+e7YwCvqdH/
         soUOFHyEu4pnYc757TTO/aIBzkH4Ay2fGpMpsMawKCu4DiTL3ttn1cBs5d1GhravgpY2
         quXUGxEc6Pb26yUIZq/9iIgICimkrQfYF5WXiTiQIqAuZVFw7NY2JzM2TXHGx9OclmG6
         fHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=oj4umfrgq5/P3WASTduG+ZLVS3oiMhcR65M2eR099cc=;
        b=AzlxFfpgdWgcZtsFcI1skjFmG8AwbqTMi0Rsz4E37fLPuq02Ke7XI+PhPntKMf709g
         IpJbKmSTJcc0q3xvzFJCZf/TYMBEOKXFk+yaAjEnB093RgYrxthbCWUgmuP48jgIb0zE
         iehqekiPIrFU8zA0IbxvrnA9i6yxQlt6ihlw7WCWN41SKNEvolmSELODhc7LL783cmPR
         2ovXjSHebhCppq1BQQT5QIWgKB0aTyL1b6rs1jYiCEAA89kIhkVvdxKQa8rpcoIrtT0n
         +WqAuCPWNP32KZ/43IPCIAJqdI1lmzKo1PsMOmAhCfzuK37btEzEXk+c7j6nExs4Sstz
         3l8Q==
X-Gm-Message-State: ACgBeo0CJ3CtwAd3re69VDYBcwNsw3Y5TaGN0pyYbvHV88XMyWsZ4kic
        dT55wcYdouXs1hrB5YGMhFJ1CGUZhr3VuyHezAs=
X-Google-Smtp-Source: AA6agR7c9B6BmWUZG/MFxtTewAmIGpTLdL4onK9iaW9qAYxPNAcay7lCrms7edzeTuNpJfdlRxdWJNppEDQhPgD2aJQ=
X-Received: by 2002:a63:5462:0:b0:41c:22c0:a429 with SMTP id
 e34-20020a635462000000b0041c22c0a429mr1376988pgm.401.1659614887201; Thu, 04
 Aug 2022 05:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220804110836.138614-1-tw.rayhung@gmail.com> <YuustIMaImn+0UYc@kroah.com>
In-Reply-To: <YuustIMaImn+0UYc@kroah.com>
From:   Ray Hung <tw.rayhung@gmail.com>
Date:   Thu, 4 Aug 2022 20:07:55 +0800
Message-ID: <CABEaRb5Tp6WL_oGKN0zbKthjez7YQ=Ve1dEo7QKpbOX6sgCZtQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: rndis: use %u instead of %d to print u32 values
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, akpm@linux-foundation.org, dh10.jung@samsung.com,
        songmuchun@bytedance.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What commit id does this fix?
> It's 1da177e4c3f4

And given this is only for debugging, there's no rush, right?
> Yes, only for debugging

Thanks!

Ray

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=884=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A7:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Aug 04, 2022 at 07:08:36PM +0800, Ray Hung wrote:
> > The driver uses the %d format to print u32 values. The correct
> > format is %u. Fix it.
> >
> > Signed-off-by: Ray Hung <tw.rayhung@gmail.com>
> > ---
> >  drivers/usb/gadget/function/rndis.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/f=
unction/rndis.c
> > index 713efd9aefde..10ba339bcea4 100644
> > --- a/drivers/usb/gadget/function/rndis.c
> > +++ b/drivers/usb/gadget/function/rndis.c
> > @@ -1105,7 +1105,7 @@ static int rndis_proc_show(struct seq_file *m, vo=
id *v)
> >                        "used      : %s\n"
> >                        "state     : %s\n"
> >                        "medium    : 0x%08X\n"
> > -                      "speed     : %d\n"
> > +                      "speed     : %u\n"
> >                        "cable     : %s\n"
> >                        "vendor ID : 0x%08X\n"
> >                        "vendor    : %s\n",
> > --
> > 2.25.1
> >
>
> What commit id does this fix?
>
> And given this is only for debugging, there's no rush, right?
>
> thanks,
>
> greg k-h
