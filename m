Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B959447BFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhLUMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbhLUMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:33:55 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6CC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:33:55 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l17so190172qtk.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRb2+biYRz+tifj2jXTfIb0511qliwqkvCVc/e674+s=;
        b=KAGNb75gWranBedQ0OOHTCdA/GRp7awXZJzsYnyHq+2z7I4KNYm4wt++TwpqQ4jTSo
         We/B9kqRFzFS2z0MSdEcbKdpeAjP6nEw3tDrBgNU0FcU2G9hcVc6YVelgnACex7YYL3C
         9yvqSH8M8Ssmn8PUarOQOddKq4T6OKTge/Oct38IfILq4P11FY/iUY3z6UnFzEq8gYY+
         KisrK8/SGAGU+MV060KX4+qXn/cZ1SRKv1162/q/gfQHEaarGpizYeD8Vej98QFwidp7
         mQCL34GO0K+Jm8zJSAam8u7RLi49uWX9m1LcR2taObR3AIo5AoZV6T1RG19605cPwb9g
         vIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRb2+biYRz+tifj2jXTfIb0511qliwqkvCVc/e674+s=;
        b=ypKXU6UImcKTRl9MNWas00ipCZAwuDITpAvFbMJTrj0lOhu0B77IuJXP8k4zmFb/dQ
         PfXhZ7Za5LM/74mHHjgUv8hxdV0VIYF+FnRYDQVii8YdSmK74MBma0OjL9LMlBVRTFDL
         7yCd2x2eReeZSXuNH1gxGKR8Q2i1JUN1JArBkl/CmpsaQ4qHIBMIAhw3XZugYQGeyz7p
         QkmEdyYpT7Z5hDJ/fMbFdfkfTC+TVa7gi1UTh5IX+vGDbZx3bbzrrQibw9wgk5jwBjS3
         jFQYvmGv4B2Ve8N37M/IcmxfXMk5FhCPOrSYeXxtMW/uUxco8cp9C727RJ0iBHF4ADrx
         Yj1g==
X-Gm-Message-State: AOAM531/NLmR03QLnpGOhBR1gMypoXitNkYL0pMeQ76FBMyTI4ktzFn2
        9XzWgpKgQr/EgcLxVkp1DP4AXQvN3a8fNHtCn+wfoQ==
X-Google-Smtp-Source: ABdhPJxcLyr8ljv9Q9dBtqLQefPD1HkvmcH0HRVsbIk1HMQukTuHmA8fLRpIsiljsrgoSRt6UIyDzbICxEAlCA0czQY=
X-Received: by 2002:ac8:4e8c:: with SMTP id 12mr1876205qtp.45.1640090034796;
 Tue, 21 Dec 2021 04:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20211221101319.7980-1-jose.exposito89@gmail.com>
 <20211221101319.7980-2-jose.exposito89@gmail.com> <CAA8EJppMsqot1isnMYeSWVJm4tC-PoqUDL9jwd5HJ72tca0HQQ@mail.gmail.com>
 <9_OAfk8h0URTETEHMPKLX0zP7-pirLOCmv0iAiOCuRRcuuVRBjYBXk2YWAAogEANzumyffgjeRZD0nGtKTk5AeGdTLsN5Q7gVnQzr_x45WA=@emersion.fr>
In-Reply-To: <9_OAfk8h0URTETEHMPKLX0zP7-pirLOCmv0iAiOCuRRcuuVRBjYBXk2YWAAogEANzumyffgjeRZD0nGtKTk5AeGdTLsN5Q7gVnQzr_x45WA=@emersion.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Dec 2021 15:33:43 +0300
Message-ID: <CAA8EJpphECjTnr=EPaToxeqoQshSt-aF_41mEjO41GukZqbvTA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/plane: Mention format_mod_supported in IN_FORMATS docs
To:     Simon Ser <contact@emersion.fr>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        freedreno@lists.freedesktop.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, wens@csie.org,
        linux-kernel@vger.kernel.org, maxime@cerno.tech,
        tzimmermann@suse.de, sean@poorly.run, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 at 13:50, Simon Ser <contact@emersion.fr> wrote:
>
> On Tuesday, December 21st, 2021 at 11:48, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> > I think the fix should be applied to the generic code.
>
> Related:
> https://lore.kernel.org/dri-devel/t1g_xNE6hgj1nTQfx2UWob1wbsCAxElBvWRwNSY_EzmlEe_9WWpq8-vQKyJPK6wZY8q8BqHl-KoGwS5V91VgN8lGIl3PJt7s2fkdsRd3y70=@emersion.fr/T/#u

I'd still suggest to fix create_in_format_blob()

-- 
With best wishes
Dmitry
