Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10488552948
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiFUCV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiFUCV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:21:26 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5791512AA4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:21:25 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l24-20020a0568301d7800b0060c1ebc6438so9684901oti.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDQ6vaD9jgFu0zY8u96WS/d+kiDGgxfsRU+RPRfqSC4=;
        b=g0tJ5XPEBtRuOQ838gtdBgq6nLd+aC1GbAmqG7krMREQuzaaPwrmwG1R2o+r+N/1bw
         Bpt02cuXrVih9QHPbvF3Hd3IMlTqHqHqN5trEElcVJJtX93taJxJm/VYT+JTHjzXk4En
         4LuTHY7KQyGjj7jxaszAJgWFfmAhVoAGguM5+kxwf45wBqs+iPcPwMQ4adqspBAt2/Wv
         F3Yb8A6qh4h8gh/5kA5t1PsHB1TmpyyI+xAUBTwqGx63FrpOaUbs7ZosU7Q30clZwayV
         NVO1dtMJrHbPdkEjW/1haZXCYI9x69DbOji9nmwlAycEwQVrZREmNA2fFDogof6XmyCj
         u9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDQ6vaD9jgFu0zY8u96WS/d+kiDGgxfsRU+RPRfqSC4=;
        b=oNYptfb5EMKBcdv7qi91WzCRq8iwxduDeLaiLT+Gqso2WHw8R3WkTa7/Emg3u9PcKu
         +YoiH2Q7gejqRxp8eOHYvsX/nGCLStkce1K8ZD9GHJWcljklZBZzwEAvMqNcWANeVaCg
         AULC1msfZCt+uT2XentzFCJ7WisI3JI/AAQhUsXIzCUsylgokyfykKWT20LJAxnKoUlE
         jQReW06K1JKiYX3mqir2RwxnbNNBUT0T7I9xMX7S0MePUaYcYOdb1svnklYHEARgS2BR
         yInj8ytS7jzbxxpFZcWD0facQQGXsuJGPewDvrJu5nnrRCdKyHwSULmhuplr9naMmnpi
         AuFA==
X-Gm-Message-State: AJIora8TZv7jR5QoBQqjwoHmhm5T0AcOMCkjrIngWgfkbAM9n3SF1dTo
        sRETKDc8YBwDQVXVs2bZ6OwSUlV/4PRBVPbzFXxku1336sE=
X-Google-Smtp-Source: AGRyM1tXyP3psvJu6O4PF1IK/XHflmoEYLR2zzFCBMBvNteX28Ifos5XVGUW4IPF1yKdrWVz8+arJ07fY1flIn4oW08=
X-Received: by 2002:a05:6830:1188:b0:60e:32a4:349 with SMTP id
 u8-20020a056830118800b0060e32a40349mr9584898otq.116.1655778084686; Mon, 20
 Jun 2022 19:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220620100216.1791284-1-zys.zljxml@gmail.com> <878rprtzh4.fsf@intel.com>
In-Reply-To: <878rprtzh4.fsf@intel.com>
From:   Katrin Jo <zys.zljxml@gmail.com>
Date:   Tue, 21 Jun 2022 10:21:13 +0800
Message-ID: <CAOaDN_StZipqEd+XxyOEes0wRCE6AFhTKfX1rJbSDtxWbpO1pw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gem: remove unused assignments
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>, bob.beckett@collabora.com,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        katrinzhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 6:13 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Mon, 20 Jun 2022, zys.zljxml@gmail.com wrote:
> > From: katrinzhou <katrinzhou@tencent.com>
> >
> > The variable ret is reassigned and the value EINVAL is never used.
> > Thus, remove the unused assignments.
>
> It's obviously a bug, but it's not obvious just throwing the code away
> is the fix. Maybe there's a missing "else" instead.
>
> BR,
> Jani.
>
>
> >
> > Addresses-Coverity: ("Unused value")
> > Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> > Signed-off-by: katrinzhou <katrinzhou@tencent.com>
> > ---
> >  drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> > index ab4c5ab28e4d..d5ef5243673a 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> > @@ -931,8 +931,6 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
> >               break;
> >
> >       case I915_CONTEXT_PARAM_PERSISTENCE:
> > -             if (args->size)
> > -                     ret = -EINVAL;
> >               ret = proto_context_set_persistence(fpriv->dev_priv, pc,
> >                                                   args->value);
> >               break;
>
> --
> Jani Nikula, Intel Open Source Graphics Center

Thanks for reviewing!

Best Regards,
Katrin
