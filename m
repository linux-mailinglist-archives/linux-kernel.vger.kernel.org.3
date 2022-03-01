Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851D74C8527
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiCAH3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiCAH3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:29:35 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA944740;
        Mon, 28 Feb 2022 23:28:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1485879pjb.0;
        Mon, 28 Feb 2022 23:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ux6f0w+/rugl91b1fITi77MXLqhRABNU0vOsRDVUGr8=;
        b=YTabYLTKvQUeycuTSVEF/GiCuWpt3dgzOnXmHVGIW5yXqUpnGHRl3YRcr38JpbcBBW
         Dm772Fy0OzObt5rK9mLNV/0VXmDdFEYx+mI41ROMORsvCAd9He+WqFpMQr1bYIavmPLw
         MsiK3pf7qxNeYndwU8tfJFmIoagPMRRwyMoshRqDaKmolGlQzEuZmumkFKJ7ibMY2Bny
         IualYTy+dBZltLnDYQuMSVA5Mh2jeC+pIz5I9HFRprbwHNScxq5H7NQ/17cwatg/WdG5
         UTlzxG8bk0JAp800rnrOmHSkmoTAZHmXw1NALtBdORhqF6bU/ldszfPZ7nLinp9vLLPH
         bwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ux6f0w+/rugl91b1fITi77MXLqhRABNU0vOsRDVUGr8=;
        b=f5xcHe7zCxCMCpuXuT3PWLuFayFczaVgAuNsZZbNJCIA4EGqCa8s1TfD9CHIo3IEHE
         upwBrfvb5unNwklALK3aHB4QN/zpDacRnof7mUbSihqy5Ikl6vcasFe+RrKX0kTzKw5q
         vOM63mZtDpwd/vHnN7V9GaPcRgaVHr+LR62UGcUo1aSd1ynH56DLay0v1FYvY6FBM/1U
         BLBUiR2I900kFgP126LJ75pHsrgX0IGpJUZPzHrA2KoxUHOsUg6tKk3lnhwl/PgNNE8D
         4xuXrgYThbvGLcg/NsnYws448xjd3JtFFW5vTqDLAM4bhOoolXy1vo/My4oo9+7xEXC9
         2Ppw==
X-Gm-Message-State: AOAM5322Fd0SD2m9L3884mPKFj3qqxAkeGqFnwA0uQDReS8Uni2kddPL
        +j+txx98akkJQ2iB4vbDkKQ=
X-Google-Smtp-Source: ABdhPJyCTEG7fLlL28LAVzdKcGkZaYShISnGyiIPsrN+MzQul1f6SxT7Vb0F786PVAqpULT+rWwcRQ==
X-Received: by 2002:a17:903:1206:b0:151:7d67:2924 with SMTP id l6-20020a170903120600b001517d672924mr2920678plh.45.1646119734656;
        Mon, 28 Feb 2022 23:28:54 -0800 (PST)
Received: from google.com ([2620:15c:202:201:c174:264:5e49:f2cb])
        by smtp.gmail.com with ESMTPSA id w17-20020a056a0014d100b004f1063290basm15953880pfu.15.2022.02.28.23.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:28:53 -0800 (PST)
Date:   Mon, 28 Feb 2022 23:28:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     William Mahon <wmahon@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v2] HID: Add mapping for KEY_ALL_APPLICATIONS
Message-ID: <Yh3LMzmru8cngoGT@google.com>
References: <20220218233350.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218233350.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 11:35:49PM +0000, William Mahon wrote:
> This patch adds a new key definition for KEY_ALL_APPLICATIONS
> which is an alias of KEY_DASHBOARD.
> 
> It also maps the 0x0c/0x2a2 usage code to KEY_ALL_APPLICATIONS.

Jiri, Benjamin, OK for me to pick it up?

> 
> Signed-off-by: William Mahon <wmahon@google.com>
> ---
> 
>  drivers/hid/hid-input.c                | 2 ++
>  include/uapi/linux/input-event-codes.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index eccd89b5ea9f..c3e303c1d8d1 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1162,6 +1162,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  
>  		case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT);	break;
>  
> +		case 0x2a2: map_key_clear(KEY_ALL_APPLICATIONS);	break;
> +
>  		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
>  		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
>  		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 311a57f3e01a..e520f22c1b8d 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -279,6 +279,7 @@
>  #define KEY_PROG3		202
>  #define KEY_PROG4		203
>  #define KEY_DASHBOARD		204	/* AL Dashboard */
> +#define KEY_ALL_APPLICATIONS KEY_DASHBOARD
>  #define KEY_SUSPEND		205
>  #define KEY_CLOSE		206	/* AC Close */
>  #define KEY_PLAY		207
> -- 
> 2.35.1.473.g83b2b277ed-goog
> 

-- 
Dmitry
