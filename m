Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69E55294F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343749AbiFUC1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbiFUC1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:27:04 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779513F8D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:27:02 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-101d2e81bceso7899704fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+H1yHRewfJ4TeRG+Yh5+qo4qD6sH1lCnmTiIvv7tW0=;
        b=YyMolUb7ycdPjzRVy7pn12nfKpgJZLRONkCxbxidaLJd+PRKgP27CLmQVbYuBM+yx2
         wb4CXQr1x9X2F3ICjltUjg/CBS1Klyu+TqSnHyIqNI/uoiogIdLyiveU9rb2tl5oAlIK
         PdE4ClbtKV1JLYOxhY+VFQL1gFuuHihE3kmlBEEEjrPVZrA+eNP4x/v7Fiu7BHetlAv2
         L3uhVWKK3LlZ808xO9sHxzGrpeJbFwpwy3d0c5uNqzXbPBUgn5CIUe9DPvlXtwmCY1t6
         QzmNI5sYUK+K+J0BWXdpWUdOeIeemze4Vfv9JyB/bxPeZ8PzZWRoaMdbsnUDugtZczIO
         L5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+H1yHRewfJ4TeRG+Yh5+qo4qD6sH1lCnmTiIvv7tW0=;
        b=3ZrOwHbAPnDKkvyikIWR8VFpphW73Y1J+32xMGiRSHu03kRmzh4SH1F8mzeoccPUCE
         RaC59tGgyzFlPjJXsOk5aoUsQlNvsGaYUKZsUe6AwpdJVX3ATUrKREhDYeVUjumVkYqT
         +baN4ZJFfKMLYPexl+OiMEdYjAhIcBXr0iUHbQoX55fb6GN8uIKyeyUxjvOROceAEwdp
         hDltY6U/8LmyHlZwMNmKrH1U5GktITxoWGGfz+rM+/yp0WAxvMzLXTGlEETfs+pYAAaM
         YxXU3FCbCo/cT8NLLR7+IkI3IaTA0xTAOQhKtrmP06Se6y/Pn3zCavNGtwMh2TYY51TM
         kM4Q==
X-Gm-Message-State: AJIora9Ye07qJ/O8U3G/8FFS5VHSCXA05nCA0nxrBR1NWHHRyTEdEPUz
        Jg526IElaxY6cqdKKoYXahZx6DWjvruCOYtTw2I=
X-Google-Smtp-Source: AGRyM1t9kYo9o6DosEPpQPNwOSkcM6g15Kxfltr5dCVQzIi38dGqVpWj4IuRrNzrmQGdtQ+lJx2gNUynP8rXFjLYsVI=
X-Received: by 2002:a05:6870:4393:b0:101:aef4:703d with SMTP id
 r19-20020a056870439300b00101aef4703dmr10018636oah.69.1655778421926; Mon, 20
 Jun 2022 19:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220620100216.1791284-1-zys.zljxml@gmail.com> <7a2028c6-8ed6-1fc4-3abf-b13f7254cdee@linux.intel.com>
In-Reply-To: <7a2028c6-8ed6-1fc4-3abf-b13f7254cdee@linux.intel.com>
From:   Katrin Jo <zys.zljxml@gmail.com>
Date:   Tue, 21 Jun 2022 10:26:51 +0800
Message-ID: <CAOaDN_T_ZVCfhmbqd1AJnt3vhTuxnGhKsxG2fjjF8-u4wXOBcg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gem: remove unused assignments
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
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

On Mon, Jun 20, 2022 at 6:19 PM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 20/06/2022 11:02, zys.zljxml@gmail.com wrote:
> > From: katrinzhou <katrinzhou@tencent.com>
> >
> > The variable ret is reassigned and the value EINVAL is never used.
> > Thus, remove the unused assignments.
> >
> > Addresses-Coverity: ("Unused value")
> > Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> > Signed-off-by: katrinzhou <katrinzhou@tencent.com>
> > ---
> >   drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 --
> >   1 file changed, 2 deletions(-)
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
>
> AFAICT fix should end up with code like this:
>
> if (args->size)
>         ret = -EINVAL;
> else
>         ret = proto_context_set_persistence(...)
> break;
>
>
> Alternatively move args->size checking into
> proto_context_set_persistence to align with set_persistence().
>
> Regards,
>
> Tvrtko
>
> >               break;

Thanks for reviewing! I sent the V2 patch, modified according to your
suggestion.

Best Regards,
Katrin
