Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7263A5740DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiGNBLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiGNBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:11:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC50201A0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:11:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd6so522414edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a93Cdw/b08yokkZOSoTxTp1XSO9jT1YPFIGh2tVBaFY=;
        b=UUMi4C1J6wo829oEZN7ope7dgBnp7YAvLYYnMn8vrRhxCl76VTZp95FiE2L0VKlIkN
         WgYqr0+0mpJY3k2EW3/4faf45g3D/11EJ9QNBYIu1Drq38/CStnSGwEGsxWCfdpHOGDW
         cZtOdCgXjI1sf2Zm6CUuRjVBkljGpwg0u9ARRc9kH09L0zOz4kvjMbzZW8HkbXrXwMBE
         7BCtU+4zu/BAGj9UsCUXu6tKAlcgAEgkwgw/04gUwounq3t4xykoSXyHt9Vw4tVNZHW/
         lHyeA0cF+Nf5+xSeggakBgwuPc59QlOT7gbOHGmUNi0hsdXwYBKmcO/wCKL5dBKRm40E
         erfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a93Cdw/b08yokkZOSoTxTp1XSO9jT1YPFIGh2tVBaFY=;
        b=wP6FBcmAnkFyL+QsYd/vBUhYNJK8m3+kWI1hQ2cbFSApJ9LPHiHhGstjsGvsW3lCMn
         +5cc85OpWbaea6HzKrsw1C4yXY/AIbHB4of8fELSArS/wo9dYGtNxY++wqv+1m96RlHt
         ontgMs05jFECqKd+At0i7D3dbiaIdut5ZcYfHWg2DSpnE/7o+u7RWYcERzsmeRC7fFn+
         Pl9vUASX3sWZGqb/ihexpUm1kHIuNIiSpXoWyDqJBuPPxqESLgUIUMDSpX8Q4EAY6QsJ
         8S6G5KkhSRqH6/ju3psfKKR6wr7ys+u4dxztO902OsSYhzj/zBzA8fXfzidZlvPKDRyd
         eiVA==
X-Gm-Message-State: AJIora8f5XDDutHQOy1pZoNqmMCpBX6Fb9INdQ9JHeYvdmhjzcRXuMMu
        /y33QvjmXdz/VD2DPPX5fg69hczoXKCTI6k/Spo=
X-Google-Smtp-Source: AGRyM1vejis9cF5nlYAXPBkQvErPD5hsJQ+0uQcZHBF7j95H9sjacuUDwJm2zzPpCY152/+jN4qYQcQzaSHHnVS9lO0=
X-Received: by 2002:a05:6402:274c:b0:43a:9204:95fb with SMTP id
 z12-20020a056402274c00b0043a920495fbmr8880451edd.259.1657761086555; Wed, 13
 Jul 2022 18:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220618232737.2036722-1-linux@roeck-us.net> <584fc348-7a60-26a2-af61-9edc4f4830e4@amd.com>
 <CADnq5_NkVWqcxwLMBeskqpcSEYCEjUAK0hqvA_PAo7ACHKL2cA@mail.gmail.com>
 <6a026c9a-c4ee-deba-e028-4c0f478c1911@roeck-us.net> <CADnq5_OrxMMkazXEPHeZXp_bV890=r21DRx2QsqLXUFj4t8aYg@mail.gmail.com>
 <20220713230917.GE32544@roeck-us.net>
In-Reply-To: <20220713230917.GE32544@roeck-us.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 13 Jul 2022 21:11:14 -0400
Message-ID: <CADnq5_PAg8xg2J3WUfjxK_-WFaLOK7cQd6bqWDnfVqE6fpXq2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add missing hard-float compile flags for
 PPC64 builds
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Axtens <dja@axtens.net>
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

On Wed, Jul 13, 2022 at 7:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Jul 13, 2022 at 05:20:40PM -0400, Alex Deucher wrote:
> > >
> > > The problem is not the FPU operations, but the fact that soft-float
> > > and hard-float compiled code is linked together. The soft-float and
> > > hard-float ABIs on powerpc are not compatible, so one ends up with
> > > an object file which is partially soft-float and partially hard-float
> > > compiled and thus uses different ABIs. That can only create chaos,
> > > so the linker complains about it.
> >
> > I get that, I just don't see why only DCN 3.1.x files have this
> > problem.  The DCN 2.x files should as well.
> >
>
> Seen in drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile:
>
> # prevent build errors regarding soft-float vs hard-float FP ABI tags
> # this code is currently unused on ppc64, as it applies to Renoir APUs only
> ifdef CONFIG_PPC64
> CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn21/rn_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
> endif
>
> Does that explain it ?

I would expect to see it in dcn20_resource.c and dcn30_clk_mgr.c for
example.  They follow the same pattern as the dcn 3.1.x files.  They
call functions that use FP, but maybe there is some FP code still in
those functions that we missed somehow.

Alex
