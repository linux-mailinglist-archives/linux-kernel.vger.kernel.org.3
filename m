Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB153B4FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiFBIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiFBIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:25:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ECB16581
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:25:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u2so4163510pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2NGVK3ecMQmaSm/x/Ltq/st8dTSwNqY+rsrQ93ARxg=;
        b=jc6TkZPdF34qvkPaOsthSV7mmEZvVf2sOSBCZE0TIrNEZQ0qLy0uFRR2GN0uwmVGKM
         Y9FSd486m0gUl7cG6gJiMTxfjpzF5gLQe03S2ni4wyQN11A4eqqG53a3F5PxR8CMun5E
         XiBcFzESnMdpb8EiQ8S3z72pu4lz122VAyWoC7CoBKJTSP373LAotX5OH0EQeFRt9LdZ
         Bx1n/fLCgBzSw9DHz/Jd5fxq8CLkZRYIof8CA3lq870EXSdQzUf+hPjPcqFiIrzB5RvZ
         Z2uFpZwT1zOREgraxUWrtCFiiGqfwyAfSRqdpl1asAS+n2xKgL8QWVG4c3uO9izlCsl9
         pDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2NGVK3ecMQmaSm/x/Ltq/st8dTSwNqY+rsrQ93ARxg=;
        b=D+wcR+FzMd9cN5LItqWbrE3jx2zpupXIX/AG1g8nwRUheE0LfiJQJeGuN3SSC9vV8p
         AQeUrz8F/RTJd4a/VnhAhIsRuqQjVt8mDRTTJnYIOMTRktyciyeDBBrs5+A/8I6kYdiF
         jEjzCuElBoiA+XOAUapIsMoBvr9y5+0LaWAYQ6l6vR2Ui8WO4qhMZ+nXu5JYU0/eyXbG
         gHyPdJkPGmdtL5g2w8sDd3bUbyE1ficOndHO4pKYiOI7vX9HBwKvfsL+w61+nCmGculW
         8LfKUTneLEA7zwMnzU3yjTR7OLjI2Zh3ORBGc9fQypAYM8dtd9nXFpU+Otz/bGvZhtT+
         iaMw==
X-Gm-Message-State: AOAM530ZE1eOFTY/r6KJ+vuBCP/zxsfW0JMTVeHZ2/rC9KxCkjZ3j7At
        vvlw2JnCLiEi1I2jeD+lhl0zO+VHPNLXqLD/LJA=
X-Google-Smtp-Source: ABdhPJxdaxZfVyttIyFl2Xtrm0P2nA2t98lJywz/DUY7UhvNHVye505VrOw5VIzkRXBl6bMh8PTdM2L7cWgK0/xxPWQ=
X-Received: by 2002:a63:8449:0:b0:3fc:85a5:5b69 with SMTP id
 k70-20020a638449000000b003fc85a55b69mr3191172pgd.261.1654158313021; Thu, 02
 Jun 2022 01:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_E15665F62AAE22B108A00645874D3F53CF07@qq.com>
In-Reply-To: <tencent_E15665F62AAE22B108A00645874D3F53CF07@qq.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 2 Jun 2022 10:25:01 +0200
Message-ID: <CAMeQTsYNQ6_zfVKLS5pdA2q4s6UnHVWNmyG2ijGDnmDnzzetqw@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/gma500: Fix spelling typo in comment
To:     1064094935@qq.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        pengfuyuan <pengfuyuan@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 5:42 AM <1064094935@qq.com> wrote:
>
> From: pengfuyuan <pengfuyuan@kylinos.cn>
>
> Fix spelling typo in comment.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> ---
>  drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h b/drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h
> index 600e79744d68..7efbd7c45c90 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h
> +++ b/drivers/gpu/drm/gma500/psb_intel_sdvo_regs.h
> @@ -371,7 +371,7 @@ struct psb_intel_sdvo_tv_format {
>
>  #define SDVO_CMD_SET_TV_FORMAT                         0x29
>
> -/** Returns the resolutiosn that can be used with the given TV format */
> +/** Returns the resolution that can be used with the given TV format */

Hi,
Can you also fix the /** at the start of the comment. One patch for
both changes is fine.

-Patrik

>  #define SDVO_CMD_GET_SDTV_RESOLUTION_SUPPORT           0x83
>  struct psb_intel_sdvo_sdtv_resolution_request {
>      unsigned int ntsc_m:1;
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
