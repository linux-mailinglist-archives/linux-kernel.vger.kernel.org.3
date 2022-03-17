Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A04DCB19
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiCQQT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiCQQTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:19:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC16811BCF5;
        Thu, 17 Mar 2022 09:18:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso3447084wmr.1;
        Thu, 17 Mar 2022 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L5IHFn00HIQl3H2oahnFXJb93x4vuq9jd0lMrLSC+gw=;
        b=Ls/9ZPI3hpUO7732o3igrqs51Xpv4GvP68O58CQ8GjmXfEnJ6GMa/Am8TYQ+Zs5kwM
         vGf3/hQStd46VBRsJjmJCWYSOyWJP0QKqV0j/g9Wwze5zApNFAERL3JA38SgMTaGSgfE
         go3hPmGYcIXYAQvHvLdZyAE5fryTPujQVMYDgfsec9zM4Nw7MBGddwvIY+2UivYJPs4H
         yYZkYeTFLbTshQgbaT9lbHx/4Q3PWIvlyvEbvnCfVGdIIVBvPar+SnbrOl93gWMUHp5A
         4yj9H+TSRBLSCYjYh2QvZlhglK0EOit+cVrlEG76p5Nxzv53ZuiNdm8w+uzUUE0Y3tRR
         eyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L5IHFn00HIQl3H2oahnFXJb93x4vuq9jd0lMrLSC+gw=;
        b=1tWifBVwZs2trrMwFfhWAp1w7eEh+ojEUsMnyRcuiNKNggunE/+qkuq2PD9u1UdkBG
         lGHQqOFK73VzKPTg9e+skoHeqlhBOfYDHK+qXwp4pFVPYJscm6/mVNDV87pV2tERn+dX
         SPzmO4iL4r+fuqL/wGt2fvPXqmnLHTGL04mRFa4/x0StMZK0TZpVGIeijIURozatkmcf
         DAiIgwd73YfoQIo/2qGXPZ+cds7tVY7T9P7q4Yg849XUAoCycO86IWqpuG5Knx3Ltkjc
         xuM2GaA40MaTUBNdjUVPvyas7QJNL7V4bKbUejfY0u0G7FJWpVIvgPlki27bjQJsD8TB
         Yyxg==
X-Gm-Message-State: AOAM531ztaZ05k40pH3LhNXahmSAifZUoFvyI45T0T8cyO9bEwKh6taZ
        b8g44ocmJNMocBSWxsiiCEx3CUeiHD+Zti5Hrkk=
X-Google-Smtp-Source: ABdhPJwkGq/5CPvt3nTPvujPGooqwvT4J7CIV95MTshngIddMgKWff9gdH47/BrlbvIZZ8VL73qS8xk2nbR/EyABuvQ=
X-Received: by 2002:a1c:f616:0:b0:37d:1e1c:f90a with SMTP id
 w22-20020a1cf616000000b0037d1e1cf90amr12554136wmc.148.1647533882531; Thu, 17
 Mar 2022 09:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234611.424743-1-robdclark@gmail.com> <20220310234611.424743-3-robdclark@gmail.com>
 <YjMGac4Hnjmg1wE8@phenom.ffwll.local> <3945551d-47d2-1974-f637-1dbc61e14702@amd.com>
 <CAF6AEGv36V8bLoDn5O1SW3iTUtzd3O1XeuT5gJxyLMxd1E-o3Q@mail.gmail.com> <865abcff-9f52-dca4-df38-b11189c739ff@amd.com>
In-Reply-To: <865abcff-9f52-dca4-df38-b11189c739ff@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 17 Mar 2022 09:18:44 -0700
Message-ID: <CAF6AEGuoBeYoMTR6-KM9xGZ05XSSnSJWMDciawczi7qtiLN9Vw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/gpu: Park scheduler threads for system suspend
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 9:04 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.03.22 um 16:10 schrieb Rob Clark:
> > [SNIP]
> > userspace frozen !=3D kthread frozen .. that is what this patch is
> > trying to address, so we aren't racing between shutting down the hw
> > and the scheduler shoveling more jobs at us.
>
> Well exactly that's the problem. The scheduler is supposed to shoveling
> more jobs at us until it is empty.
>
> Thinking more about it we will then keep some dma_fence instance
> unsignaled and that is and extremely bad idea since it can lead to
> deadlocks during suspend.

Hmm, perhaps that is true if you need to migrate things out of vram?
It is at least not a problem when vram is not involved.

> So this patch here is an absolute clear NAK from my side. If amdgpu is
> doing something similar that is a severe bug and needs to be addressed
> somehow.

I think amdgpu's use of kthread_park is not related to suspend, but
didn't look too closely.

And perhaps the solution for this problem is more complex in the case
of amdgpu, I'm not super familiar with the constraints there.  But I
think it is a fine solution for integrated GPUs.

BR,
-R

> Regards,
> Christian.
>
> >
> > BR,
> > -R
> >
>
