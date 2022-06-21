Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E8655347F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351566AbiFUOaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349141AbiFUOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:30:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACCA237C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:30:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eq6so12299708edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmyUppEAbHEw40UHdzEMcMYioES0t5g3cXHjzlejo6I=;
        b=hzoq/W5TmKdJsmBhVvm014iKS/gQsMH0dIMooz1q2kjGRwwR+q7LaTJx4L8/jAFCae
         AmfKaKVVpm2TacyaKEKZG54rd/XT5Q1hNL+MKDxBwJFrOHy8DWSyu8Yl9ua29AgKkoVK
         65pfV/EKbrxV6eCP9VaiWYslQB4jhI8VBewDHFUf0aFicQee0hPR3zgg96zak3Wm3Wp8
         yMJbSY7L/zH61A27mwlfzc/Fa/WneHMN9k3FrR8KqloRELKaKhY44rmvWFvKef38TzC4
         xz1gcNiahV/jruiuIaNHUkedmJWI835SUj8I4sZ2S+WUJ+FVHvK4GrNzLojev7pTRT4S
         cdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmyUppEAbHEw40UHdzEMcMYioES0t5g3cXHjzlejo6I=;
        b=wx9JprYPRRZf/HSWMCWRarqgJQJhohsn5K+/7zrcdEkmTWRbh1NxabTaEDg/RfmP8t
         fJbKgAVbxTA4/JAGzXhvcEqeRH+Z0FbgD4T6RZr+muwxac+xehe7vbR4mZHebJzSekuN
         wHZOrogGxp/7WxrpXFCXiqga/cVa9+NWq9J+AUmNVlM6+sM09p+MrkZe8FEW9RWNyTEl
         /EB6DA/5k6+DhKqezU1pFO9kn8uzS4XUD9vcDItVIQxLGGK8hXO32q6D7GnVqMlBeyhU
         BAPwybxMnXwIX0qE2IRsLB4z3N0BpkAkWY0iVcdjW/t2hS2+23FibWRL+scJa7KzLoZ0
         nJPw==
X-Gm-Message-State: AJIora/WxCHTorgOau33CyLVzuZ3ztmDMvTglyMw1QRh+YHUtyXl2NAX
        jQPqDIalFPsW0YSaImcPLllHzJbDivq2dwfCI7U=
X-Google-Smtp-Source: AGRyM1skIT1zie/U8t4CrgIh821FCoNNzShxUjjckoKmUGsshKj/ON1AA+2CiyhmuGbjMtV/MY5jjSrsIiY1RDf76aU=
X-Received: by 2002:a05:6402:2933:b0:435:80dd:f75c with SMTP id
 ee51-20020a056402293300b0043580ddf75cmr12579482edb.302.1655821808373; Tue, 21
 Jun 2022 07:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220621131041.129513-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220621131041.129513-1-jiangjian@cdjrlc.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 21 Jun 2022 10:29:55 -0400
Message-ID: <CADnq5_NPrY-=jbKOxWCggD2UukxCXVQhVthbybvviWdkyZXbww@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: vm - drop unexpected word "the" in the comments
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Yang, Philip" <Philip.Yang@amd.com>, Qiang Yu <qiang.yu@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Eric Huang <JinhuiEric.Huang@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
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

Applied.  Thanks!

On Tue, Jun 21, 2022 at 9:17 AM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> there is an unexpected word "the" in the comments that need to be dropped
>
> file: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> line: 57
>   * the kernel tells the the ring what VMID to use for that command
> changed to
>   * the kernel tells the ring what VMID to use for that command
>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index dc76d2b3ce52..8530befb2051 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -54,7 +54,7 @@
>   * (uncached system pages).
>   * Each VM has an ID associated with it and there is a page table
>   * associated with each VMID.  When executing a command buffer,
> - * the kernel tells the the ring what VMID to use for that command
> + * the kernel tells the ring what VMID to use for that command
>   * buffer.  VMIDs are allocated dynamically as commands are submitted.
>   * The userspace drivers maintain their own address space and the kernel
>   * sets up their pages tables accordingly when they submit their
> --
> 2.17.1
>
