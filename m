Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202EC4C36DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiBXUYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBXUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:24:09 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F0184638
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:23:39 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id a6so4742213oid.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biJP7S4dmlMQEfIEiFGAdrTmLmPJKRFHOtbGNeByUq0=;
        b=Bvc+9A4LBrYF5JnCMjcFUHbbdPdxylW4PblxL2/7c6pmrn50DNASncMB3wIqscfj1u
         baNzoXcnX/tY7M+6E+JGvPggZ6g/c32a4KQmvMbQZEU2Ms32dDrvlV+XrNcnOjZbEAx2
         qI5mlfEzZeZRSHlTnu+8Gc1HhmiicMgwExq2a+T7n0F3+rj+9bwi/14MzclnAJ5pLcTq
         ukEhoGrDqCIAF/vRm7nR9HcGaZRzl9yl2mtHdJILbT2QcNB78h5ezsHn5kOFwCIjeSUZ
         l3utO3fhFnU9ei7Ej2bfZB1OJbCW5dUkQdulOS7dP28YEqdSzpNJk6bE/TOASrpMnilM
         Rcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biJP7S4dmlMQEfIEiFGAdrTmLmPJKRFHOtbGNeByUq0=;
        b=4fqhCN4GrEhKvLtfsU5OrtMoNwCqkhZRyGU/5vabuJHCEjAW+rrvbyN0PN4kjHOFsD
         nfdZ5wg0lYieBql1k4eXt3evgQZzzLFSpcToFWq+ZkBxW5L0qchnLDgq2mo+BQsBwsZp
         0SOTaa0BAbztBY5+dqs70F5WNbF35pggAMUnE7o8Q4QWN7aNcXdQL1NCYzoVg9fQZKG3
         j5aPwn9/HXMV11GeADa8w0Ivpw/b3WFj8OneXbx1GdLVkwep9uYAl/nj6g1eWskRyLqZ
         vxXebhlTXD0GIOZR0va1WzjZ/fa3ugHuo5/0mtZOgf4B19xteeWWwHPGB3jDm3GKez5p
         QLkA==
X-Gm-Message-State: AOAM533BZx1yaa/J7CMvwWYSXqH7HWJr/SKK4eEoxx96QtQdMCt0axFq
        xKJnY9fFAYxkE/3E+pgDOaOP9LPErZDtkabyQPk=
X-Google-Smtp-Source: ABdhPJzOnZ51sY1NbmHpDjfVDBrKsT4cqT0nVj1WNaKXFkGzwc1KmT+UCdjsCPgSSm9+OOZmf4yYDk9v+sI4m3xfRjE=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr2382125oie.132.1645734218622; Thu, 24
 Feb 2022 12:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20220224191551.69103-1-magalilemes00@gmail.com> <cf085422-d109-2e7b-aaef-083d75fcef10@amd.com>
In-Reply-To: <cf085422-d109-2e7b-aaef-083d75fcef10@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Feb 2022 15:23:27 -0500
Message-ID: <CADnq5_OHmo2hRkKjo=yBNLzCvE3XH01MKF8rry4RcmEXPvPu8g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Address a few compilation warnings
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Magali Lemes <magalilemes00@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>, siqueirajordao@riseup.net,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, mwen@igalia.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Isabella Basso <isabbasso@riseup.net>
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

Applied with some minor modifications to patches 3 and 4 to avoid
adding new warnings.

Alex

On Thu, Feb 24, 2022 at 2:44 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> Series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> On 2022-02-24 14:15, Magali Lemes wrote:
> > This patchset addresses a few warnings reported by the Kernel Test Robot and
> > sparse.
> >
> > Magali Lemes (4):
> >   drm/amd/display: Adjust functions documentation
> >   drm/amd/display: Add conditional around function
> >   drm/amd/display: Use NULL instead of 0
> >   drm/amd/display: Turn functions into static
> >
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c   | 4 +++-
> >  .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c  | 2 +-
> >  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c  | 4 ++--
> >  drivers/gpu/drm/amd/display/dc/core/dc.c                    | 6 +++---
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 2 +-
> >  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 ++--
> >  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c     | 4 +---
> >  .../gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c  | 2 +-
> >  8 files changed, 14 insertions(+), 14 deletions(-)
> >
>
