Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEAE519A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346552AbiEDIry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbiEDIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:47:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA7E24960
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:44:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq17so1546742ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9yrR8ovN4e3vCdcrotHqbMZyniAFA2hJaExlKiyLR0s=;
        b=eI7jxaZSMLwCY2OAs01SylkNgsWduEeZXZRm5XGuOXNe3dRTvAwu7GDdoryvNkMaWb
         t32vu73C4DTnUYXHeOy15quDXT8YG7pcr94Mu224ZzdLXH7iAmKkJMKZK2OlCzKLnD2w
         moEwaBMKbS7QixK1dbVoRbJ3ewKzg0nKLMboo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9yrR8ovN4e3vCdcrotHqbMZyniAFA2hJaExlKiyLR0s=;
        b=kap1NGgl5GQ7sIoWDD/WrNu0Haks+yqt1G/l+iu4gl3MvRbLckShjTiwaClBho1yXk
         FECQEJEsy7TR2KSdEDTay1v5UbWF/HVweF5IDurq5Om8ln+cKUp1x7A75lMH+67Rh9qs
         FmfTrWTvIiooldV8HG1+dEjR3E3Ba7rVxn8TSF+tp6s2amNN6LSzEsFEqZ2FrfYQQxv0
         ftL5dCRmkNMYc8VCFgkYoh7VmPDASG30Cp4E20cSdgG6Iv1tQkMGGCZPFJYJR5n+clyB
         aXCKdn7JUwyGLmMe2HMPRYkLrDi4MABQNlxiV6zdWn23wnj4eiXA+lGwMllUjlXTR8vU
         tOLw==
X-Gm-Message-State: AOAM530oe0VRrwjwMuhg+q9Phl3uFBkMlRddVeiqlwkMIJWMJIvo3tZm
        rKjCGfm8Mz7YSpWPkJiiZu5jcw==
X-Google-Smtp-Source: ABdhPJwdcKXaclQibk4WK6+dvYH/xaBfefFDYZnwUfRYHtNB0ZZItrraRdczZDB+V/3ZPThwsyl9mw==
X-Received: by 2002:a17:907:d05:b0:6f4:3729:8e36 with SMTP id gn5-20020a1709070d0500b006f437298e36mr13907086ejc.475.1651653845541;
        Wed, 04 May 2022 01:44:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7de8c000000b0042617ba63b2sm8859632edv.60.2022.05.04.01.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:44:05 -0700 (PDT)
Date:   Wed, 4 May 2022 10:44:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fix typo in comment
Message-ID: <YnI809cYMm1Uo20R@phenom.ffwll.local>
Mail-Followup-To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220426131912.3850354-1-raphael.gallais-pou@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426131912.3850354-1-raphael.gallais-pou@foss.st.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:19:12PM +0200, Raphael Gallais-Pou wrote:
> Fix typo in a doxygen comment (replaced green by blue) in drm_color_mgmt.c
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Thanks for your patch, applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/drm_color_mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
> index 9079fbe21d2f..17c6c3eefcd6 100644
> --- a/drivers/gpu/drm/drm_color_mgmt.c
> +++ b/drivers/gpu/drm/drm_color_mgmt.c
> @@ -259,7 +259,7 @@ static bool drm_crtc_supports_legacy_gamma(struct drm_crtc *crtc)
>   * @crtc: CRTC object
>   * @red: red correction table
>   * @green: green correction table
> - * @blue: green correction table
> + * @blue: blue correction table
>   * @size: size of the tables
>   * @ctx: lock acquire context
>   *
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
