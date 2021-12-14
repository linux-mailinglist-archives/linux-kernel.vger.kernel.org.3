Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC00473E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhLNIhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhLNIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:37:41 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839BFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 00:37:41 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id de30so16195650qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 00:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V775Jo7foyl5u33KO9wxNFO5Xpg512uth3xPug6/f9Y=;
        b=NmsmnUQjon4giEIPURXak6DNfz2uv3mxLeDEiVc8iUJV+WQGHo0oIywd2C3DSI4pVI
         4GuYtTQuyOG7798S3lnZcHyrILmqUoL50dlmbyCyTixojp/IGFP2EkTyKQgP170Pl3hq
         3ZZTfp+NvlUjYXYlRC9z5TqZF86aF2Zr51JO3mvpkOaTvBpEAUi9RCW9TtSQfOeQOXhx
         iHPWUKKEP3loANy/6Y5EPGU4/Y/NvufewNugTqqrzYw8tHGKjsES4Pu9OaWA58l7LcZH
         8iUJjaT1SIRs1kDZ/7XPmBNEpbbLyESohomuDZ8Ply7kroWO48ooXLGjptuR/AuMiHbM
         Rk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V775Jo7foyl5u33KO9wxNFO5Xpg512uth3xPug6/f9Y=;
        b=VOz87ex9vzQr+0VZSTWUJ+jNXmUSLBfLH6G8cVdH5MD4wWaFZyvXSgAFfe9GCLqF2v
         YJcV5LpvzTk4He1O43WL41VtuHQkhtsdZgRziUnp8vHHNDoEvEX6gdGRWhgVuJz2zfRW
         +fVs75GQdyNUSvO5wWWvj+hfIMsNSRFvEHk0HYKFvCJvDvFJl8cgjwCOYOuOQH4sbIHh
         8jHTnYZw3Mp1KX+sd3vVshJb1Dh+yDt2XhcUOihHw3tcWd/Q+98BlUUcFZ0GZNFOVJR2
         HZO8J6uxLPOPuf6YJotAYVMPiPBhjD+VkUFWiznvH8IaubtdMjxEYFtZRxcqq3QS6Pa3
         l3zg==
X-Gm-Message-State: AOAM532a91lplMcbS3UVufxM1wMsxAOF7BsX99vzK4V7S963sB3aSwpe
        1A3/F2fktVDr/kKglAHwJ2DgFVQs0r9sm5OL7IfPHQ==
X-Google-Smtp-Source: ABdhPJwTLF1AMEeFod/l2CxZZeOst/LaOVrIJybQJ5YF/RyGQnZ4Krjx2+P/GvWwxeDL73OopPshCk3YG/laGaGdXjg=
X-Received: by 2002:a05:620a:298a:: with SMTP id r10mr2844306qkp.447.1639471060440;
 Tue, 14 Dec 2021 00:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20211212062407.138309-1-marcan@marcan.st> <20211212062407.138309-2-marcan@marcan.st>
 <CABxcv=m4fu8h=FwY7R=thuvd13_ZbFqB9rNNN07QOAd__jdYSQ@mail.gmail.com>
 <63334964-d63d-7625-e46f-a6e6ec19e908@marcan.st> <CABxcv=kbR5GX3yEfqchKJPkCqpWp_oKWjG=pu7LikBwoSX8W3A@mail.gmail.com>
 <CAL_JsqLLTL-_H3XgsZRZaxE6qO6y8CDpoHfDkOgwekb1ysNQFw@mail.gmail.com>
In-Reply-To: <CAL_JsqLLTL-_H3XgsZRZaxE6qO6y8CDpoHfDkOgwekb1ysNQFw@mail.gmail.com>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Tue, 14 Dec 2021 09:37:29 +0100
Message-ID: <CABxcv=nFx9r+=qMXop6kp6E4KoXaX_8duLY7S9fo6uqs_539jw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] of: Move simple-framebuffer device handling from
 simplefb to of
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 3:50 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Dec 13, 2021 at 5:30 AM Javier Martinez Canillas
> <javier@dowhile0.org> wrote:

[snip]

> >
> > You are right that passing NULL is a safe code path for now due the
> > of_device_is_available(node) check, but that seems fragile to me since
> > just adding a similar debug output to of_platform_device_create()
> > could trigger the NULL pointer dereference.
>
> All/most DT functions work with a NULL node ptr, so why should this
> one be different?
>

If you are OK with the patch as is, then I won't object :)

> Rob

Best regards,
Javier
