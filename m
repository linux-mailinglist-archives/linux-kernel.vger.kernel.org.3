Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A6A4BB2D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiBRHDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:03:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiBRHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:03:09 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D742A251;
        Thu, 17 Feb 2022 23:02:53 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d187so1629376pfa.10;
        Thu, 17 Feb 2022 23:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FJqrkQfzTnG3eDmhPKmKXJVLXCEy88O3PeJm+Gvo5fQ=;
        b=Eba2adp7v6mpSgtbQqDRnlcx98z/cWg31mRLWAl8rbnOt0gcknZ4Q0vywzaaOgg2c5
         wUkuJEGi212lS2nCo4PEZIk7Wo/yjwS9mvUSWCE7QmIU8P3xmegLxrfuqiYt1Neamug3
         N3KK56PmUv32+dfiOvTgrmVbgtYEYWGl/qgGDnuXTWDU4TEXs8mFQYXQcRCPePYzs2DC
         n1U9J/3Ghb4QnhQeYSutuX75uYtL8mobqecRlb5tj/ICIhNIzv2w99CtI06cuElrC2c4
         PeOQZLwTbGqcPp7gWoFSyhW7bJyyIF/rgaRD9Bi40zpOrZiE8uwkBMzrOCSsqgOofUcK
         EfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FJqrkQfzTnG3eDmhPKmKXJVLXCEy88O3PeJm+Gvo5fQ=;
        b=pPrfDKeKIJz+vaOz81A1L9KkjcSk81fQwzOFOjBbKbKLow0CfXPwrEfbrEMz83OACW
         6lTkRDtyJRErfyZeTQW3eqbQk3u8my3oeXXtYDXuMvViZqCp7kuReHogYn+wDjIyJxMC
         fodlQSnfNFMk2PMdQvNnnG2oSy+hA8j2aeFCCOmrfzSMLoKoLDKstFX0OuUoSqCLK4b2
         ZLK8afVCz4rsga6YfOUB1rtGzmsujZw9G47H/HFsIeX3ehRGDvPtj8VcYzOc+vjX/AA5
         ftdt7nGP3gYeM0F8k8WFr4HUd9rA2n9NvCMpyX0kuBpZfyaZ/CQiFRgwVTlr2w1UlvWO
         YHeQ==
X-Gm-Message-State: AOAM530cBpOQBhV6ky7PDg+Zw+W/kUhtvaxzlldGrVoiLZG34DMAODyi
        xjDMWH7wI+bkR1iVXjp3ROd+3t1Vf4s=
X-Google-Smtp-Source: ABdhPJyPi4O97+YrRTUqHf8Ye2GyvILWU7QwlWOVr6c3rQcRC/n5ZFWFw+p6+7iL/jUy6aJAVhDjCA==
X-Received: by 2002:a05:6a00:c96:b0:4e0:5347:92df with SMTP id a22-20020a056a000c9600b004e0534792dfmr6736769pfv.36.1645167772724;
        Thu, 17 Feb 2022 23:02:52 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9800:6e8c:a0db:87e7])
        by smtp.gmail.com with ESMTPSA id f3sm1422502pfe.137.2022.02.17.23.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 23:02:51 -0800 (PST)
Date:   Thu, 17 Feb 2022 23:02:49 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shelby Heffron <Shelby.Heffron@garmin.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Message-ID: <Yg9EmVAHpEpmnLok@google.com>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126211224.28590-1-Shelby.Heffron@garmin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shelby,

On Wed, Jan 26, 2022 at 03:12:24PM -0600, Shelby Heffron wrote:
> Add keycodes that are used by marine navigation devices
> 
> Signed-off-by: Shelby Heffron <Shelby.Heffron@garmin.com>
> ---
>  include/uapi/linux/input-event-codes.h | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 225ec87d4f22..26b6a2f482ab 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -660,6 +660,34 @@
>  /* Select an area of screen to be copied */
>  #define KEY_SELECTIVE_SCREENSHOT	0x27a
>  
> +/* Toggle the focus in or out */
> +#define KEY_FOCUS_TOGGLE		0x27b

Could it be served by KEY_SELECT?

> +
> +/* Move between highlightable items */
> +#define KEY_NEXT_HIGHLIGHT		0x27c
> +#define KEY_PREVIOUS_HIGHLIGHT		0x27d

I wonder if KEY_NEXT and KEY_PREVIOUS would be suitable for your
application.

> +
> +/* Toggle Autopilot enagement */
> +#define KEY_AUTOPILOT_ENGAGE_TOGGLE	0x27e
> +
> +/* Navigate Displays */
> +#define KEY_NEXT_DISPLAY		0x27f
> +#define KEY_PREVIOUS_DISPLAY		0x280

I am not familiar with marine navigation devices, could you please
explain a bit more about displays you are navigating. Are there separate
physical screens or are there several application screens/views you are
switching between?

> +
> +/* Shortcut Keys */
> +#define KEY_MARK_WAYPOINT		0x281
> +#define KEY_SOS			0x282
> +#define KEY_NAV_CHART			0x283
> +#define KEY_FISHING_CHART		0x284
> +#define KEY_SINGLE_RANGE_RADAR		0x285
> +#define KEY_DUAL_RANGE_RADAR		0x286
> +#define KEY_RADAR_OVERLAY		0x287
> +#define KEY_TRADITIONAL_SONAR		0x288
> +#define KEY_CLEARVU_SONAR		0x289
> +#define KEY_SIDEVU_SONAR		0x28a
> +#define KEY_NAV_INFO			0x28b

This are fine I believe.

> +#define KEY_BRIGHTNESS_MENU		0x28c

Do you have multiple menus in the application?

Thanks.

-- 
Dmitry
