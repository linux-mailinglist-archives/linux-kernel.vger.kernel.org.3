Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC855A38D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiH0QmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiH0QmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:42:09 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D5474FF;
        Sat, 27 Aug 2022 09:42:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t140so5691795oie.8;
        Sat, 27 Aug 2022 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZmxTNJXdfZJJ2Pe5JS3kCmHqPvETpA9u1Q36GaimG9Q=;
        b=WfNr5KGqtldRVuwfZONE+mIxQ0mEB5GJ4odOwhsZUPEPZ1UY84Rr2MF9je/ddUvf7Y
         MV3EtpWzq6UODVlTwUDV/EHVqvmm83oWxxIEJbLPTez587GAA2c0AJEDQUAJmRW/XIhT
         FX4YYJiDYwfId2Vc1++QvsIfsXsjxD0nNnw3fL6i75AukOj0Le9iS+qOwUsaRYlWm1Mg
         JkczjQMz8mV7bQIdIyKE4Bo1nq5fbvDFa9UuqVFjcamJBDhwXMp5RcVhFd4ni1HuV4Gq
         QLj9f4c11qrRbPm9MZN/STcSDtzxpp10D380N13sihUqh2CRXrwdg3l+4Af4OHmxEszP
         rZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZmxTNJXdfZJJ2Pe5JS3kCmHqPvETpA9u1Q36GaimG9Q=;
        b=IqHLVjzD5790aIfuHEuRX4p3u516lvEfkFLHpWygd66n8tlCkOhuWvJ+FvY9thVWcr
         e6nM5I2W9llvAVytre3pGuU7DHXXQR99hNOcrzRhHCbx3iXU7yZJ+5C6swWnpDnz6ojD
         BMgi+pj8T07Ev/YZMfjAmH93N6g76p1SteUCXOGgCUQxHn8MNj3fg4x+0tzupF8piCsb
         c4YDWPmS67zVUHWncejgEJH8/yhVLyWcFRLLN3wYLtAWCrzC2azsagLpdE2ciPg+jXAX
         jjeNVPHX2RcH+M2CHqRjsomy4aI2kTGbMoz8g8qzrr+WpEOs2MoY2ccSC8MMa8a/n9Kg
         dUjg==
X-Gm-Message-State: ACgBeo3rrCmtn5HhEXknBN0LskrAJAagd0Go6v/4OAiqfKN98be6hJ0G
        dzdgSKacBeJ7R4SXvTLlbGpiK1B+S+UiVYRjNj8=
X-Google-Smtp-Source: AA6agR6Wqr0YeZSEMWsmFyC16ahJ1c45RKtBIAagiDq5AHfxZbKwsuTkkIACI1f83+S71M3mN6+sVUYEeO+H5K6QcNg=
X-Received: by 2002:a05:6808:238d:b0:344:e5f9:db34 with SMTP id
 bp13-20020a056808238d00b00344e5f9db34mr3739338oib.183.1661618526484; Sat, 27
 Aug 2022 09:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220823115409.46653-1-yuanjilin@cdjrlc.com> <658faa4e-ad16-7b13-87f3-27ea91db4ba3@linaro.org>
In-Reply-To: <658faa4e-ad16-7b13-87f3-27ea91db4ba3@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 27 Aug 2022 09:42:42 -0700
Message-ID: <CAF6AEGvX_J_t04tUUxserXh_rrcdu5eYTt6JOHoD-SJ6944adQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix repeated words in comments
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Fri, Aug 26, 2022 at 2:43 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 23/08/2022 14:54, Jilin Yuan wrote:
> >   Delete the redundant word 'one'.
>
> The whitespace is unnecessary.
>
> >
> > Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 7198e6b03155 ("drm/msm: add a3xx gpu support")
>

jfyi, this comment (and associated list-head) is removed by:

https://patchwork.freedesktop.org/patch/496131/?series=105633&rev=4

BR,
-R

>
> > ---
> >   drivers/gpu/drm/msm/msm_gem.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> > index c75d3b879a53..e300c70e8904 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.h
> > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > @@ -118,7 +118,7 @@ struct msm_gem_object {
> >        * An object is either:
> >        *  inactive - on priv->inactive_dontneed or priv->inactive_willneed
> >        *     (depending on purgeability status)
> > -      *  active   - on one one of the gpu's active_list..  well, at
> > +      *  active   - on one of the gpu's active_list..  well, at
> >        *     least for now we don't have (I don't think) hw sync between
> >        *     2d and 3d one devices which have both, meaning we need to
> >        *     block on submit if a bo is already on other ring
>
> --
> With best wishes
> Dmitry
>
