Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150FC590989
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 02:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiHLAWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 20:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiHLAWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 20:22:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4548D3C2;
        Thu, 11 Aug 2022 17:22:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tl27so36255228ejc.1;
        Thu, 11 Aug 2022 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EN5+cvGMcOovfjiFR718HovjHcsX+utyNmXckAqLFhM=;
        b=mm2uciCc+ggSX7r5RzkdDchYRJQ+5CDMG/ARxH8UaDXRF2AlID6ff3K41PwS0GEv5B
         mF0QMZwUwXDaJvozBF/hCXi/aPh21C2hAJ1rPwdzyKlEpw8L3ObW+ghqBndl1RF361tf
         J+B8nd4N6Y23lLZTMOfdEgOapX2S62ukPKCkVTaZoAvH+fhk/2owUsKiRokf4ZubMaa8
         WzaUBjU9liFqsNtJEVX11ljsE90UJldzU4mUpBC2KXYIkoUDvVVEgRCnSFzraP7rxs3R
         Koo1msAh4l69a+YSTMgGVL3OfDuyTuVolaRS6btQisvk/lM1L0pKm8Yk/gug72gjMFHo
         4cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EN5+cvGMcOovfjiFR718HovjHcsX+utyNmXckAqLFhM=;
        b=brrKGpA4lcUOmPnB37zZt7e9E90x5PHuLUsCgJXE8MX4As178gdG5YO00QAQ0B8ZBE
         Wv2Y+fKdVGIYnQiRjTGXsrUAef8T+08J6OTf3uvbWOuJVBSrGcVkzekPOaoZPqIfdCFL
         skwmHf/6Q66QuLZmdTsxvvsQXKyuFLXli+TN4hAYulRIbY1I8wn63wOMkPKSCQ2DzOHD
         53MLBaEebmYhewqrD5CSQ1xIvzCFAzBDkIDOj2VR1Q3rT6U71DWTa9ohNGD8jByVZ6qQ
         a9hnIWbzRZaeAdoZAjaQD2e9uJG64ZKMJXLjTS7qQ5czoUT+jf0/kPCZIdXF0egagJjg
         6BrQ==
X-Gm-Message-State: ACgBeo3H591zU+fexewklJGVqPGb4K9ms9/xGmIc4c634ErMnmYaNcet
        MNMkycjEkVlo1QkyGsULxqsyBF5D5vi8Z/J6kFGBtNQ79kQ=
X-Google-Smtp-Source: AA6agR5I5oJfcu7zeE7Fkkv4of2+dHvGa8zmgx36a3FYq950gqoCG2xe5os1s+ASJJvO0D/ugvZ4yCkBDQ0S3XGJe3Y=
X-Received: by 2002:a17:907:d0f:b0:731:5c2:a9a5 with SMTP id
 gn15-20020a1709070d0f00b0073105c2a9a5mr917131ejc.413.1660263735575; Thu, 11
 Aug 2022 17:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220811090213.35899-1-dzm91@hust.edu.cn> <20220811090213.35899-2-dzm91@hust.edu.cn>
 <YvTGlV/RIN1QCce8@kroah.com>
In-Reply-To: <YvTGlV/RIN1QCce8@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 12 Aug 2022 08:21:00 +0800
Message-ID: <CAD-N9QWJt5_XyfdjWyN8q9HjBNnm=nzb2t+C+RS-mxEXTyZo2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] USB: trancevibrator: simplify tv_probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, USB <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 5:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 11, 2022 at 05:02:09PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > The function tv_probe does not need to invoke kfree when the
> > allocation fails. So let's simplify the code of tv_probe.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/usb/misc/trancevibrator.c | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
> > index 55cb63652eda..30d4d774d448 100644
> > --- a/drivers/usb/misc/trancevibrator.c
> > +++ b/drivers/usb/misc/trancevibrator.c
> > @@ -84,22 +84,15 @@ static int tv_probe(struct usb_interface *interface,
> >  {
> >       struct usb_device *udev = interface_to_usbdev(interface);
> >       struct trancevibrator *dev;
> > -     int retval;
> >
> >       dev = kzalloc(sizeof(struct trancevibrator), GFP_KERNEL);
> > -     if (!dev) {
> > -             retval = -ENOMEM;
> > -             goto error;
> > -     }
> > +     if (!dev)
> > +             return -ENOMEM;
> >
> >       dev->udev = usb_get_dev(udev);
> >       usb_set_intfdata(interface, dev);
> >
> >       return 0;
> > -
> > -error:
> > -     kfree(dev);
> > -     return retval;
> >  }
> >
> >  static void tv_disconnect(struct usb_interface *interface)
> > --
> > 2.35.1
> >
>
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.

Sorry, Greg. I forget to add the changes:

v1->v2: fix the truncated subject of PATCH 2/2.

Shall I resend another v2 patch with change information or send a v3
patch with this information?
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot
