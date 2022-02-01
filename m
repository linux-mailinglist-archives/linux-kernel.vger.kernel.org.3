Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534E74A61C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiBARBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:01:08 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:38736 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiBARBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:01:07 -0500
Received: by mail-ua1-f41.google.com with SMTP id n15so14290680uaq.5;
        Tue, 01 Feb 2022 09:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEgpI3G2nX9Lw9uqceH2eAdidBvBzk5i80XCAAy1o9c=;
        b=TqFbGkXgYv+8bPMpSLxzkz25UUE+oG37dDDJMeDLTT03SYOFqgqXwSycmV2En8Kcnu
         E43+q8qLqh46Ir3U41NFMbpE3ZrBsFKQtZVNI2DQwqI9gOUOSQeptFMVIAnZ8nkF3jgq
         l0ZlkMkPyW7aVB+8BFZ/Des63cYiC+Yy4tt1BcLoumk8Rg+QVT3KeQvGs+pmf4Wej/3P
         48Yr4+OSQijyUIlmoMv8blm/fg+GVFldLluA2dhhDKyDQGHxJERrdwJWIHEWs8h1MrNx
         RIYkoVV2uNRSIagNdtGvXIDvuPycPFTzcOzMir9IcfgNcUAHdbMORYtFPi2l5L7U82Ag
         fdCg==
X-Gm-Message-State: AOAM5302Q4hcy/RCbAHpBRbBWR2KEeaxN36+DU+wd7R2LenmFpplCYVg
        3wZ/ygnC0R9fhDPiq6xs3o1PeQcmnrq9cdBl
X-Google-Smtp-Source: ABdhPJw1eLbRiwIsSfTabS0oVzOif7YS/bnmTvV8810HtSsf+9BNLZxRzN7BqCP+m4wCjDs3nUlGkA==
X-Received: by 2002:a67:cb19:: with SMTP id b25mr10412736vsl.8.1643734866551;
        Tue, 01 Feb 2022 09:01:06 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id h30sm4229897vsq.7.2022.02.01.09.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:01:05 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id b16so14288927uaq.4;
        Tue, 01 Feb 2022 09:01:04 -0800 (PST)
X-Received: by 2002:ab0:6cf9:: with SMTP id l25mr10528741uai.122.1643734864638;
 Tue, 01 Feb 2022 09:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com> <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de> <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com> <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com> <YfFWPmG2D093gz4N@smile.fi.intel.com>
 <6e74d4cc-655a-e38e-0856-a59e4e6deb36@redhat.com> <c423a2f0-e7be-3884-3568-7629c7e9104e@redhat.com>
 <ddb0f354-be19-92fe-20b3-56b00c9304ab@suse.de> <840ec74d-60c6-9480-709c-8cd597c6f5b0@redhat.com>
 <e7fbef3c-2f87-15f9-b24d-34ffaa5a2853@suse.de>
In-Reply-To: <e7fbef3c-2f87-15f9-b24d-34ffaa5a2853@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 18:00:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXnn+JcyMAV_Vbb4Yj8hJmae=Snc2R2fLviq67UYXg7Ew@mail.gmail.com>
Message-ID: <CAMuHMdXnn+JcyMAV_Vbb4Yj8hJmae=Snc2R2fLviq67UYXg7Ew@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Feb 1, 2022 at 5:16 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 31.01.22 um 11:18 schrieb Javier Martinez Canillas:
> > Another thing that's missing is a DRM_MODE_CONNECTOR_I2C, because I used for
> > now a DRM_MODE_CONNECTOR_Unknown.
>
> That might have implications on userspace. Maybe ask around. (Not that
> we actually run userspace on the device).

Looking at the list of connector types (and wondering if we're gonna
need more when converting existing fbdev drivers to drm drivers),
there seem to be two different families of connector types, for
  1. transports between CRTC and display (e.g. VGA, DVID, HDMI),
  2. transports between CPU and CRTC (e.g. SPI, possibly USB, and
     the proposed I2C)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
