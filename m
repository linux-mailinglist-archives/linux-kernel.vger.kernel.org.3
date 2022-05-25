Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A951B534081
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbiEYPlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245192AbiEYPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:41:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0827AB0C8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:41:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i82-20020a1c3b55000000b003974edd7c56so993929wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WgZHeljHeDsIF0Q3Bp5cCUArAU6gv2HjuQpnboZhtms=;
        b=FZxSw6EUC50GSdfF8YKhwN0iLGcFSgv9ZtvcDdwg1vaj71hTOWyyigRwCDQiF08hrH
         KueH9cpCjuOrYgMtX6oOpGllt2tNR2SXpVOwdezZXwMl4p1MQDEn8fEwQwJQAC3vWhYh
         uoAUCV9LnKvcBv4qMo5vozP96azAoeI+En8iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WgZHeljHeDsIF0Q3Bp5cCUArAU6gv2HjuQpnboZhtms=;
        b=jmtAJaDt+c9w+X6UVVrUFsg2l7UwLl56JjbFEJmWY6jHr0WZyjUe1+0JyRy7gm8knB
         TFnXgj3HwJS296rkGddkTlnFSfDsiFkQNwdF1XcXhx2NKgffBnoKybipmbAviOveWeDH
         Es7ZWPcy3M551i3AQhciCBKU9sn5wTSUtBG4BtPBUjMVk2SibRbZktxuXvqHwKLhJaIe
         aswX9Y8+HLwDktzaGxJWHa3ouotUdo1wTxo22QJPNLVLQ50voNVaZPTeHanWZnGilpen
         CEqJBea7nSGusTOGzn1edkbEH2FcpGP94jrzyKSmASXL3/nmFO+j218NuRDs2ESPqOiF
         P58g==
X-Gm-Message-State: AOAM531hb3cNqPoQR/HfpseoqyV/OJDEHMc6IU1H8kd7BAhMW57jBTjs
        Wujxug3KtVQiFNP8zWXiSGfK5A==
X-Google-Smtp-Source: ABdhPJznB9B6uq7kgaMh4CeHqv5J1w05ZI7o5D0/HWElvBoPxhMB16R41PdTrfoUYPOtW8wxhZcVWg==
X-Received: by 2002:a05:600c:510b:b0:397:46c2:37 with SMTP id o11-20020a05600c510b00b0039746c20037mr8708410wms.107.1653493262502;
        Wed, 25 May 2022 08:41:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d6081000000b0020c5253d8e0sm2428682wrt.44.2022.05.25.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:41:02 -0700 (PDT)
Date:   Wed, 25 May 2022 17:41:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com
Subject: Re: [PATCH] drm/vkms: Update vkms_composer_worker documentation
Message-ID: <Yo5ODIGuMI7GcoYZ@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20220521191342.23520-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220521191342.23520-1-andrealmeid@igalia.com>
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

On Sat, May 21, 2022 at 04:13:42PM -0300, André Almeida wrote:
> Since commit ba420afab565 ("drm/vkms: Bugfix racing hrtimer vblank
> handle") the work is scheduled at vkms_vblank_simulate() and since
> commit 5ef8100a3919 ("drm/vkms: flush crc workers earlier in commit
> flow") the work is flushed at vkms_atomic_commit_tail(). Update function
> commment to reflect that.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

Applied to drm-misc-next, thanks.
-Daniel

> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index c6a1036bf2ea..914c0ac7dc8b 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -213,7 +213,7 @@ static int compose_active_planes(void **vaddr_out,
>   *
>   * Work handler for composing and computing CRCs. work_struct scheduled in
>   * an ordered workqueue that's periodically scheduled to run by
> - * _vblank_handle() and flushed at vkms_atomic_crtc_destroy_state().
> + * vkms_vblank_simulate() and flushed at vkms_atomic_commit_tail().
>   */
>  void vkms_composer_worker(struct work_struct *work)
>  {
> -- 
> 2.36.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
