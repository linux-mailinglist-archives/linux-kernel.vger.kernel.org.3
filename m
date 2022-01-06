Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735F4485CFC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbiAFAOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiAFAOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:14:18 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659EC061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:14:18 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 19so1141294ioz.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 16:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eeQl+BjiH7+9wbd64O7+kbmLU8ftNF3eSrLy24wAkHM=;
        b=XTpBcug0jMUyVVygTkuhrYPh7taAiCKOQ2ajtLCa6zFeMKNNgZNqtoWpNvDjnpq4l+
         Tco9Ef2SuRSmXJTpkRY3x4pABxhPj1fR2Dj9mMSrXJ7LPlmngN5Xy7WRPm3kJE6/eJpT
         g5Kg8qyu5YxUI6+E36FXKlSKGhhxr/926Rwu1aH70EyRhHjd6ju5dIEXWd1K7P1wW16l
         iAQsJRj+16S1YUQ7FBQeQZEfLgp7gHoaawYIW/hXukRIjUIFN3Hg6Tt0dsOW34F/BIfS
         3l9i4+7shoX6KWYnLvs2oghzEqX9i1f/H3dOGMEl2WTtjvl6+xsbw0T9IUp7ULdLM5Xs
         M4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eeQl+BjiH7+9wbd64O7+kbmLU8ftNF3eSrLy24wAkHM=;
        b=rx0VwKDPClIFsMLrpULHi07wM94SdG6PdxESrAeiRAwp1j+1KQhJFiQRTfYFy0YlPk
         xAMlTfyxaVNQfXq8sA1aFxMl4U5c8qFmILpdfWz6b5pxS7sgwbfAecO3AatmEOqPxfrZ
         Kls7Ip1Vk6Q3F2AwKOBPGAQUv0YRbKunzem0Suq0ogF9aXN6+Cm3n9ERkcrQkCYKAKdr
         HiY8lip1JSHHyyNhovJ53bunoKpSeSD0Ww4fUqX5OAcrAeDHSEx+O/47Q7hrCnwE8V0w
         219kHxXRW6ylwJdKVDLgJxjLQg2P3tCOuWAngfE3v9sVNPQE7wZRnKkzi8i64QWYCY+5
         9IxA==
X-Gm-Message-State: AOAM530ACDNegxQlHEA1GtpdEf2IV1TmRmkPhV95QUmfrhOuT+fzpZw/
        FePOm9JXbxdyRV12xlBwueyETPMmuxy2FdKIXiW6Ow==
X-Google-Smtp-Source: ABdhPJwgz5mAVWnIZYrCCi+2ofFB5tcua3t/hb3QCI9cdP9/EDCDtQWzZH0gswykWxT3NZ+I1odtjfToa8dWD7+IijE=
X-Received: by 2002:a05:6602:2d84:: with SMTP id k4mr27083247iow.168.1641428057726;
 Wed, 05 Jan 2022 16:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20211231045056.118640-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20211231045056.118640-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 5 Jan 2022 16:14:06 -0800
Message-ID: <CAD=FV=XK5=mm8O7QbSuCfrvM1cfkVQ81_jR=1kMExNQw7ZbqLg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Update Boe-tv110c9m initial code
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 30, 2021 at 8:51 PM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Optimize two problems
>
> a)Turn off low voltage detection register.During the esd test,
> the low-voltage detection ic may be triggered to enter the slpin state,
> so a black screen occurs on the panel.
> b)Optimize CMD2 page1 gamma.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

While continuing to grumble about not liking this big binary command
stream, I'll still apply it since we've accepted the previous ones. At
some point I'm going to get fed up with it, though, and say that this
needs to be converted to something understandable instead of a big
pile of binary data.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...and pushed to drm-misc-misc...

506d9d7414cf drm/panel: Update Boe-tv110c9m initial code
