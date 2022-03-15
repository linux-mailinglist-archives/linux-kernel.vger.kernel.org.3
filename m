Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999244D9F54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbiCOPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349923AbiCOPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:53:02 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A75656408;
        Tue, 15 Mar 2022 08:51:41 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso24844485ooc.7;
        Tue, 15 Mar 2022 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXJSr2Riukg6sLC81qnw2+4YK/hUVT2VEwcL13m5MRw=;
        b=F5UxW4xBOA4id2EKViUjwaTL2L7Rne8ANhJGB6eRDgcEkf0Ez4sxDLUTUJXuYLH9i/
         ikXZw67iyjjgDfKx3WO1bGSQwoqivnkyzLsPNZNwo3Hk37oUNPplkqnqAcYedC0rAzBZ
         mq2qQn0Drt/hLDv2KYGOrRDPIZHxzRbm/0jU+NEijcmsk0xJ3SpHcygIOy9VbqLf00b2
         OcYNHPDs/LX7aPqN0Mgx12t4a/oQg6+sIfHAYQ+PunKcCoy4UhI6nvf9eljlibVvUuvj
         72fQMLBmghTQzGYJi5VNTLLRu/jZflDHG/QeZI5ughzB7tJzTI2F7oIqajoZk+7P5Rue
         Bieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXJSr2Riukg6sLC81qnw2+4YK/hUVT2VEwcL13m5MRw=;
        b=5O0dvn3HQAYh8t/M1zr/6zPKEuWCWuNKT0w5Mg1NPu1BUgqzlm5VeRENxxr8oTLV+L
         LVtq7KaWJtbbrAD/2HnkSmeH2vbSGeCclAhHdGFwG4DQZrrpvMbaxxASmm68S8oPEDY+
         +acIRFNVYKj2dQwZeCfNKhj5sBg7iorvxpBBc5WXawa7VgmTH+FlaPPhOgLqzQalteE4
         8mWx1II+SIVjzu+lyfjpzt+6nKYSLrJopa2fkj2gYldQ85KK6YU1JGJdGNiG/9O4i4P9
         EesnWNS0/GdWFPqmhdzSgzUpwqyLMc2z/TU7YGQg04yXrW1/BHqxkWpNxjapyNqMw3tE
         s/XA==
X-Gm-Message-State: AOAM533DhH6gCn7bZeXh4ftThuPk02jqqZuhxU32SInuDpKapPZFMTQL
        m4WFKSQDED+ifEoDPc/MJ5skrU2K2GMCkeNV+Ec=
X-Google-Smtp-Source: ABdhPJwxx1IWwZmVPysAWToOvN9DlgTFvAw4uemt8AVvgMLB/Lqxvpyu2g0j5plBDR8QwAPwsdCLZMpJJpzi28U3hb4=
X-Received: by 2002:a05:6870:630c:b0:da:b3f:324d with SMTP id
 s12-20020a056870630c00b000da0b3f324dmr1821885oao.253.1647359500464; Tue, 15
 Mar 2022 08:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <20220314115354.144023-24-Julia.Lawall@inria.fr>
In-Reply-To: <20220314115354.144023-24-Julia.Lawall@inria.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Mar 2022 11:51:28 -0400
Message-ID: <CADnq5_PqHgorHeLbZhF2MKt39GDhJvcD6yjWRN209h1A4fQgcg@mail.gmail.com>
Subject: Re: [PATCH 23/30] drm/amdgpu/dc: fix typos in comments
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, kernel-janitors@vger.kernel.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Mar 14, 2022 at 8:01 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> index ad13e4e36d77..0e36cd800fc9 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -456,7 +456,7 @@ static enum bp_result transmitter_control_v2(
>                 if ((CONNECTOR_ID_DUAL_LINK_DVII == connector_id) ||
>                                 (CONNECTOR_ID_DUAL_LINK_DVID == connector_id))
>                         /* on INIT this bit should be set according to the
> -                        * phisycal connector
> +                        * physical connector
>                          * Bit0: dual link connector flag
>                          * =0 connector is single link connector
>                          * =1 connector is dual link connector
> @@ -468,7 +468,7 @@ static enum bp_result transmitter_control_v2(
>                                 cpu_to_le16((uint8_t)cntl->connector_obj_id.id);
>                 break;
>         case TRANSMITTER_CONTROL_SET_VOLTAGE_AND_PREEMPASIS:
> -               /* votage swing and pre-emphsis */
> +               /* voltage swing and pre-emphsis */
>                 params.asMode.ucLaneSel = (uint8_t)cntl->lane_select;
>                 params.asMode.ucLaneSet = (uint8_t)cntl->lane_settings;
>                 break;
> @@ -2120,7 +2120,7 @@ static enum bp_result program_clock_v5(
>         memset(&params, 0, sizeof(params));
>         if (!bp->cmd_helper->clock_source_id_to_atom(
>                         bp_params->pll_id, &atom_pll_id)) {
> -               BREAK_TO_DEBUGGER(); /* Invalid Inpute!! */
> +               BREAK_TO_DEBUGGER(); /* Invalid Input!! */
>                 return BP_RESULT_BADINPUT;
>         }
>
>
