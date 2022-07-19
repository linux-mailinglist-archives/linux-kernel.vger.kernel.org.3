Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8596057A772
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiGSTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGSTwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:52:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656752466
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:52:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z23so29205417eju.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wcWkViARSNdUyuwzdaEiSCLG/eyyzOrKPQf2VzjXtig=;
        b=QgSES/TyFjtv7+8i9uYc11G3zcakgHhlIrNMk0G5knRRpfikvXxEKpRgp8Xh2Vn526
         gPDp9nxQRvHl7uFV415hUWGn05L3gE27aYTTmIfmWmxE7f9KhYUohWyl/MUADndQRMDS
         U3wIKhaKQQGzt5qDvTHTrKW0j4CQunYGgxVylFiYiP85E6+EOLfe5bRPv2FOf+OtrBdg
         3h2HGNW2CRQdwl621H3R2cAfycvm11roc+0pCzoJKZas1KtuPKgs84qHyjoxezmbZ2mk
         z0neaEnPmX9wbS29KkEpB3ZwEacpDFlm5tUiE2OEo6rmRB5xtDVtQ7IFmFBGZHS4ffjm
         XkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wcWkViARSNdUyuwzdaEiSCLG/eyyzOrKPQf2VzjXtig=;
        b=F6zupDd2R5WSWomw9VIoPELrPJbAkfrovVPihvzvBBrn8ip11HSfYr47VL/f+P3L/c
         aaGssNb59yd8FABB/2ebFcFDYCPikzzyD08XSA6L/p0IG1DMYtls4aSSmwndMJEPBF6+
         wSOaIN4fOGH9/vIIV6ZyKXHcZERlfBpAI4LA2Bx7AO09WxxG8sDuMqpe2Gj91nfTCfqx
         XGL5jUgX6HGzvsg3NJmMfgTr34FVa+Lm72fxdr4xGCaruLkRrZBQ2SEu7HAp/zOjXEBG
         QMK/doOy2KKLpjVyZ++MdlG6pNqd3pRgql+vJE70AMIdw6SI4ICUx2Wa30JsSPd8WFKI
         34Nw==
X-Gm-Message-State: AJIora/NkrMpukCnV7fy3QneLBhy/03G3pou1gpVTj43RG5/sY0uCUFE
        jAY9+Zc63B8QrHvZYLtXCQirVJFUrOL6VfURVYc=
X-Google-Smtp-Source: AGRyM1vIPPaaNzMOh/Rvxld6XCfgXubOFV0G5wpuC7Z/7ARAOyHNBP7HdKmJGw21KVr0L9W264i8QPBX1kQzmqikP9w=
X-Received: by 2002:a17:907:2888:b0:72b:8f41:1405 with SMTP id
 em8-20020a170907288800b0072b8f411405mr30979322ejc.564.1658260332079; Tue, 19
 Jul 2022 12:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220716042841.40555-1-wangborong@cdjrlc.com> <9012daf3-1fbd-524c-55b5-21e9c7c70327@amd.com>
In-Reply-To: <9012daf3-1fbd-524c-55b5-21e9c7c70327@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 Jul 2022 15:52:00 -0400
Message-ID: <CADnq5_OwNR=9k=z7Qj6-puoe_40V0ycCGgrxyXM19H7Bu_-rtA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix comment typo
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Wang <wangborong@cdjrlc.com>, daniel@ffwll.ch,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
        kai.heng.feng@canonical.com, mario.limonciello@amd.com,
        alexander.deucher@amd.com, evan.quan@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Jul 19, 2022 at 8:34 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.07.22 um 06:28 schrieb Jason Wang:
> > The double `to' is duplicated in the comment, remove one.
> >
> > Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index e3d139708160..b45cd7cbbea8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -80,7 +80,7 @@
> >    * - 3.24.0 - Add high priority compute support for gfx9
> >    * - 3.25.0 - Add support for sensor query info (stable pstate sclk/m=
clk).
> >    * - 3.26.0 - GFX9: Process AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE.
> > - * - 3.27.0 - Add new chunk to to AMDGPU_CS to enable BO_LIST creation=
.
> > + * - 3.27.0 - Add new chunk to AMDGPU_CS to enable BO_LIST creation.
> >    * - 3.28.0 - Add AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES
> >    * - 3.29.0 - Add AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID
> >    * - 3.30.0 - Add AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE.
>
