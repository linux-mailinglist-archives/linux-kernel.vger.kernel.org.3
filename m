Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F357F4AA013
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiBDTaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiBDTaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:30:11 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDBDC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:30:10 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id d186so5811654pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjz/d2uJSRskReEmVHKPPM9K20Vc4OsAmYuunLLpKFw=;
        b=nIRVyrBynAGmaqmots0Mq+aw1Avy4WkS6UPdfbbOrVc45NFzxxpY/9TWPB4t7o3pYY
         dll6b2poAli+XYy5rUVa4dTB5exq3qBNqKTnhC2Bf32hal1L/hovklTGk/YrufUtDo51
         h9TZPM1W6daiJ+dfC5cQOYRynQ4ltQhCmKqSYLep5Sn+r9USG6T/DhnBECkzhHDNWZJ+
         yf5FCQVjjG/R9Vvb2BLYD16zichIYpEBf8TeUT0x2XS/GhWXXsp5I2HZnx9lXleRP/yR
         mNgQa51908kvsqdlyNjPL5oHTXcNfsqJwyzQgtJf9/m4HKZtYG989mDnz6mclz4su77/
         2aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjz/d2uJSRskReEmVHKPPM9K20Vc4OsAmYuunLLpKFw=;
        b=RsW9DX9easbzGGfspW6O+gWnExBzxZvnWPPoQomBvgYmBuQ78bH8aepBqeeVZ7Ndgk
         F453dUkvr4jMXlAQudiqf5K+GKIYF5qcu2fJLLY62V+ohirQw9ALrLxyavbD5FL2VGqp
         GHnLvXkLlvwoqyzm76rhVDSRvSV0odeJZ8Svet3iJs/q6jayIcYZnDe37FDvgovx6O04
         i8IBrHZLReXjq0vcnibCiFKqO98ry5s/XygoWyhrbSEMuNueH1tmI+fI8Zt+NXDDT2L/
         lQU6/8lZYD8MxB9HQ65/ucINsvRJqXTvgXwpjCh2+lqlVsw0AtzUliPwf/8iJr88aUu8
         wxqA==
X-Gm-Message-State: AOAM531EkW5GWPzTc5VS1vRYvaP+Roksf0cyz6Mnc7DifqUEbVEifLCt
        iY2jX6RBS1h7SIkmMknwimZrTr9mt0UUe9w8QsJUdQ==
X-Google-Smtp-Source: ABdhPJwl/Ikwm+SRw8mO/XCAwWW+cI6ZLc926D0tRc+KyiKrxJHhusUtS8WUK1022mB/ftpk6q2o5I90X1d7yB8ZhvM=
X-Received: by 2002:a63:fc0b:: with SMTP id j11mr442424pgi.146.1644003008833;
 Fri, 04 Feb 2022 11:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20220202150201.290c7d3d@canb.auug.org.au> <20220202150320.3e9bdd62@canb.auug.org.au>
 <f50d5044-7192-bdb3-7ca9-7217ed311787@redhat.com>
In-Reply-To: <f50d5044-7192-bdb3-7ca9-7217ed311787@redhat.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 4 Feb 2022 11:29:32 -0800
Message-ID: <CACK8Z6EKsFwJcpmqFoVOkQYqLMK37Qz3FYkf+-EhP4AFiscbeA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the drm tree
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 12:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/2/22 05:03, Stephen Rothwell wrote:
> > Hi all,
> >
> > On Wed, 2 Feb 2022 15:02:01 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>
> >> After merging the drm tree, today's linux-next build (htmldocs) produced
> >> this warning:
> >>
> >> drivers/gpu/drm/drm_privacy_screen.c:X: warning: Function parameter or member 'data' not described in 'drm_privacy_screen_register'
> >
> > Actually:
> >
> > drivers/gpu/drm/drm_privacy_screen.c:392: warning: Function parameter or member 'data' not described in 'drm_privacy_screen_register'
>
> Thank you for reporting this, I will prepare a patch fixing this.

Thank you so much Hans!

Best Regards,

Rajat

>
> Regards,
>
> Hans
>
