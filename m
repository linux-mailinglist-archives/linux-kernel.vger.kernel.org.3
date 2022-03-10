Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABF84D3F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbiCJDMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbiCJDMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:12:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6D3085973
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646881906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SBwam6zmxJotVYnABBh/GlMSxj47srXl2RNNPbZVKXk=;
        b=AD3ykdRVbytliL0Ovwg9u0hh21VXsD3SoCeUPRSqVoxY5aC+VTW/hlgKXhPLhCeW6OWU//
        cARzwadRNMwWFVmSWTz0RYIjRvxosw+NLWZ7qrAXyzqt4y4xugtDVXb25KbVlYFkLp4RZN
        uzmMAFr+C0z1hoDRl47TcC5pOxTVlo0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-7P7N4D8yNF-Eg9nvGBruzQ-1; Wed, 09 Mar 2022 22:11:45 -0500
X-MC-Unique: 7P7N4D8yNF-Eg9nvGBruzQ-1
Received: by mail-lf1-f70.google.com with SMTP id m13-20020a19520d000000b00443423ff116so1380723lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 19:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBwam6zmxJotVYnABBh/GlMSxj47srXl2RNNPbZVKXk=;
        b=6EkxX9MBeFw+irpJjHTWEbHzfVtYRPYg1Tr/6/nSWO+2qiWBttlLoZNlLqnds392uk
         lGVAL42T62eK3Dt3KEa5UM+2h5PYrdBTZhhSVOKWwiuWe937Q2wm/ei6hKC0xmT+r/Ss
         BDCyoAcKEPTUl1V/VuVMCx5fScV3vqrMYDNo3wRncI9mU37Am3sqRnMYWV41tW5v7v4u
         TzfeDMA49GvJ3kaTS4zagc/3UbxCdvPfE8PtHWRt4uzzlIXXMvtklCEE6J5Yx2Q30HxZ
         JlaKkoTPYYPl2jglC50JV7PB4NCJ9FTbawwreS9TbymTH5ZhVpF6PNq/XlXOirribQss
         zhPQ==
X-Gm-Message-State: AOAM532wymWQpZfRotoD20P/dKsIMLZnOWIF0/cZ2wEMOK9nOtugERY5
        wuISaBibCdczmxTdmgFkI2s5AEglfftFxFI74NtXQ3Qlz92PLJtRUVwMgoFP216L0sbtuxIs3in
        zlvMUQXgBF8C6bZss4/jbRR6O8xfBPL/zqwY1vrzh
X-Received: by 2002:a2e:900a:0:b0:246:17bb:a771 with SMTP id h10-20020a2e900a000000b0024617bba771mr1639287ljg.363.1646881903920;
        Wed, 09 Mar 2022 19:11:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoT3uOxOvlsz3GBLPf25mDRpHrExnsy25c0F/5ulnxfNe8GQoNhvxaPmyZhmFmIHc5npbWPQRkvtXpNIR7AVM=
X-Received: by 2002:a2e:900a:0:b0:246:17bb:a771 with SMTP id
 h10-20020a2e900a000000b0024617bba771mr1639271ljg.363.1646881903553; Wed, 09
 Mar 2022 19:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20220309063456.102895-1-hpa@redhat.com> <Yija3YQ55gvCtKdR@paasikivi.fi.intel.com>
In-Reply-To: <Yija3YQ55gvCtKdR@paasikivi.fi.intel.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Thu, 10 Mar 2022 11:11:32 +0800
Message-ID: <CAEth8oHrvw9i4sS=cHUshubbhHSoLYkh5+QNhMPHqS+JkoiAPA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: media: ipu3: Fix AF x_start position when
 rightmost stripe is used
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hans De Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Thu, Mar 10, 2022 at 1:03 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Kate,
>
> Thanks for the update.
>
> On Wed, Mar 09, 2022 at 02:34:56PM +0800, Kate Hsuan wrote:
> > For the AF configuration, if the rightmost stripe is used, the AF scene
> > will be at the incorrect location of the sensor.
> >
> > The AF coordinate may be set to the right part of the sensor. This
> > configuration would lead to x_start being greater than the
> > down_scaled_stripes offset and the leftmost stripe would be disabled
> > and only the rightmost stripe is used to control the AF coordinate. If
> > the x_start doesn't perform any adjustments, the AF coordinate will be
> > at the wrong place of the sensor since down_scaled_stripes offset
> > would be the new zero of the coordinate system.
> >
> > In this patch, if only the rightmost stripe is used, x_start should
> > minus down_scaled_stripes offset to maintain its correctness of AF
> > scene coordinate.
> >
> > Changes in v2:
> > 1. Remove the setting of the first stripe.
> >
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> >  drivers/staging/media/ipu3/ipu3-css-params.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
> > index d9e3c3785075..5a8c07f34756 100644
> > --- a/drivers/staging/media/ipu3/ipu3-css-params.c
> > +++ b/drivers/staging/media/ipu3/ipu3-css-params.c
> > @@ -2556,6 +2556,10 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
> >               /* Enable only for rightmost stripe, disable left */
> >               acc->af.stripes[0].grid_cfg.y_start &=
> >                       ~IPU3_UAPI_GRID_Y_START_EN;
> > +             acc->af.stripes[1].grid_cfg.x_start -=
> > +                     acc->stripe.down_scaled_stripes[1].offset;
> > +             acc->af.stripes[1].grid_cfg.x_end -=
> > +                     acc->stripe.down_scaled_stripes[1].offset;
>
> Could you calculate these the same way as in the case both stripes are
> enabled? Some bits in x_start is masked and then x_end is calculated from
> width.

Okay, I will do this in my v3 patch.

>
> >       } else if (acc->af.config.grid_cfg.x_end <=
> >                  acc->stripe.bds_out_stripes[0].width - min_overlap) {
> >               /* Enable only for leftmost stripe, disable right */
>
> --
> Regards,
>
> Sakari Ailus
>


-- 
BR,
Kate

