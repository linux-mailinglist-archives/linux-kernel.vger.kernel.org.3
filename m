Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230B74F5F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiDFNVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiDFNVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:21:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7055CD15
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:04:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so1321925wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gsn/KVUZ2ef93UgRqhOePHB9TxRguehEszYRtNa4ZMI=;
        b=NCWYdNcW45PTe6kKF0w+n8KY1aKTNCTcXWUn9Vd1Y+0HeE5v6VGX56SvDvtTWTcwvn
         foA/h57PkpDokJjifQ0W/rTHCw6AxOfDck6Yq/ES/yfX94n8dRjUnemTpjYP1qPqPEci
         fNfHE77j5zc+jbDIO9yC9EKgcCtmpjWmjQJ5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Gsn/KVUZ2ef93UgRqhOePHB9TxRguehEszYRtNa4ZMI=;
        b=HpV/WqMpk0IUiLOLdQDsieaMS6lglecdD99f18ayqAD85Bgolt7xcidYZSY9H6Nt3Q
         n8R63djLfzaWrLZ5mLHUV/G97ejV2D8lkzNODmfIZu713d1583RhbAZvJUJCjj/BPnAh
         PKhC8a8ua/gL0+gbDnA2JM84xQlqA9H9Mhg3jYXmBlyxrfV7rbDhBWNU+2wmWGC0B8Ne
         BHeOmWmsXUwN2cMbv0sRXTxoo5Xlb6hBp71+xZ50rOiH6f+ewJpj4gfWB37QLzQVIhaD
         sTj/gRYiAapd2561NMJLecEd4o27gNBjnEgoifiQKXKIpfaycDkpsurTGxUok/hk0/Z7
         2PQQ==
X-Gm-Message-State: AOAM533iwzEz3rwcnz6k2qBgMea5zZsi7hJlXA/KCcfnVqKA5MEfDUBo
        w5+mUYrbeqQSeuFWymAt3U482A==
X-Google-Smtp-Source: ABdhPJxpJ2B8ipfnst6KF5vUfg2vrUjZLgS+eJ7m2geRcChNtFKQ+Ox79lRxUALgsfwgkDOKI1RUvQ==
X-Received: by 2002:a05:600c:a47:b0:37c:965:2b6f with SMTP id c7-20020a05600c0a4700b0037c09652b6fmr6743785wmq.31.1649239448406;
        Wed, 06 Apr 2022 03:04:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm5286345wrb.63.2022.04.06.03.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 03:04:08 -0700 (PDT)
Date:   Wed, 6 Apr 2022 12:04:06 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/drm_modeset_helper_vtables.h: fix a typo
Message-ID: <Yk1llmSuQEmtCk1Y@phenom.ffwll.local>
Mail-Followup-To: Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220406073036.276288-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406073036.276288-1-15330273260@189.cn>
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

On Wed, Apr 06, 2022 at 03:30:36PM +0800, Sui Jingfeng wrote:
>  change upate to update
> 
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>

Applied to drm-misc-next, thanks for the patch.
-Daniel

> ---
>  include/drm/drm_modeset_helper_vtables.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index fdfa9f37ce05..fafa70ac1337 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -1384,7 +1384,7 @@ struct drm_mode_config_helper_funcs {
>  	 * starting to commit the update to the hardware.
>  	 *
>  	 * After the atomic update is committed to the hardware this hook needs
> -	 * to call drm_atomic_helper_commit_hw_done(). Then wait for the upate
> +	 * to call drm_atomic_helper_commit_hw_done(). Then wait for the update
>  	 * to be executed by the hardware, for example using
>  	 * drm_atomic_helper_wait_for_vblanks() or
>  	 * drm_atomic_helper_wait_for_flip_done(), and then clean up the old
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
