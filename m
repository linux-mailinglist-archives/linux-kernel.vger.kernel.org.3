Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D684A84FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350745AbiBCNQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiBCNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:16:56 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA5C061714;
        Thu,  3 Feb 2022 05:16:55 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id me13so8728834ejb.12;
        Thu, 03 Feb 2022 05:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bdyf7D6NeIfikPS/uqe99QCdtkoBXMfRD7d4Vkt8KZ0=;
        b=fnO4Z9ikvpsMPCsKu6x6QsuM8vFnXR7m2mYfr5RDy4CHjqdkG4l8mUCcQ3/A/ZVq3N
         Tiw9v8aDR+6j+MTTtKmYvP1/T6tCYwgGtshXIsljrlWgPPwefokeevA26/GU4gJlJ73R
         v0dAV3zxaUspQD+1z4tJbSqZGpYqAUUrBgUa+a+D6zSSAVrMHHcbvxZV/40hWQSwQAq7
         gZw6dMjO/DSilkrdUsV9tG53PBkShl+rCqf7H55tqCNq1oH9Wz5gpzenx95pIk2CUHH1
         D6nvoKHkradIsoR9S6Ugx8D65IEEi7P2NlMyirZyNM8K87yMmopmd2hD1WODbzd5MuUD
         IIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bdyf7D6NeIfikPS/uqe99QCdtkoBXMfRD7d4Vkt8KZ0=;
        b=YswYUextE4FqKBSDU36Pn3wLrt1Nog9f/ZJFtwzh86IVK9uKHX6Nl6BydBNblDaXUk
         0MggoRAeQovj7uUaErlkTnmjkq240Witm9p2p29WXQ2f1XTtUYUSBzZTf1930KhdquGh
         stS8ioyn7QTycjxOYe7TxCXJm5ENwG+AOIy11pVPLw8KNS0/oYJZ+RTupbkzqLcDS2WF
         1vybjLv0ZUJ4vhuYUUEP/HbmmB+chgjTkcSb5PauYHStjMhn0RophhYCQWXS4tT/uqTR
         EhwZ6ksLjx2/f9bcSB7+JcBpkahvcxjn5Flw96IFji+qiqXadVq/Lh7SlfIwEdVai6Ua
         FaCA==
X-Gm-Message-State: AOAM530Q9sXL3Joivw5J/AxxKGSkmywn1TlwJ+Sq4kVJ8/GooS3SJM+A
        uD3j1DX+ZrkKuuLl7ndPSqoEInBPrkTdOqjFua4=
X-Google-Smtp-Source: ABdhPJxk9m897IDjpBQJ4LNiGZxfQhz/ry40RQmM9zo6kAM1YbhCHKqydSjqdaAq8TwWy4Z9YFP8VO86vKIUQc2JKdU=
X-Received: by 2002:a17:906:4787:: with SMTP id cw7mr25116328ejc.504.1643894214217;
 Thu, 03 Feb 2022 05:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20220125171129.472775-1-aford173@gmail.com> <20220125171129.472775-3-aford173@gmail.com>
 <43e29322-fc4d-2c72-86b2-1f41fb05a2f9@xs4all.nl>
In-Reply-To: <43e29322-fc4d-2c72-86b2-1f41fb05a2f9@xs4all.nl>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 3 Feb 2022 07:16:43 -0600
Message-ID: <CAHCN7xLRnCRUwOLLW=EF2XdFY+V4EHqcGG-tj2SymiBL5Cki0w@mail.gmail.com>
Subject: Re: [PATCH V4 02/11] dt-bindings: power: imx8mq: add defines for VPU
 blk-ctrl domains
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 2:46 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Shawn,
>
> Can you take patches 2-4 of this series or shall I? In the latter case I
> need your Acked-by for these three patches.

If necessary, I can tweak the YAML file.  I just need to know if I
need to resubmit the whole series of just the one file.

adam
>
> Regards,
>
>         Hans
>
> On 25/01/2022 18:11, Adam Ford wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > This adds the defines for the power domains provided by the VPU
> > blk-ctrl on the i.MX8MQ.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > diff --git a/include/dt-bindings/power/imx8mq-power.h b/include/dt-bindings/power/imx8mq-power.h
> > index 8a513bd9166e..9f7d0f1e7c32 100644
> > --- a/include/dt-bindings/power/imx8mq-power.h
> > +++ b/include/dt-bindings/power/imx8mq-power.h
> > @@ -18,4 +18,7 @@
> >  #define IMX8M_POWER_DOMAIN_MIPI_CSI2 9
> >  #define IMX8M_POWER_DOMAIN_PCIE2     10
> >
> > +#define IMX8MQ_VPUBLK_PD_G1          0
> > +#define IMX8MQ_VPUBLK_PD_G2          1
> > +
> >  #endif
>
