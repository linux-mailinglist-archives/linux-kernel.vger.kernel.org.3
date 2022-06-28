Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4C55E906
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbiF1Og5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbiF1Ogv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:36:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F02C651;
        Tue, 28 Jun 2022 07:36:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q6so26121684eji.13;
        Tue, 28 Jun 2022 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sciSoRCJP9tmgG43WFiyHgQnQbIDAWhG9JNH7sehjOg=;
        b=LNdkm2CNmCjn5xV828HqDI0l3owRABoKkDSiWA7l8+mfB2EnovxirwQ4PclXBHSjo5
         X1iYRhkmChyihhXYfaVsVWzPJxIrUBewxBVl+pDqChSu1zlYrP7TrOvI26CJGhTkdp3j
         ocoBkCLO262zGyz2hP9A9gO6AWXpyYNTiF2iiMRUkC0majwM62NZz0l+RrM8y4Wg57D8
         Ct5kwwDf49gYFOq4zRQbrsovY4fdKWn8bUGpvPMcgYUwfQeVdAo3IssTzXJ/y2msJ3Nb
         2KxDKWS3UxmAHGyCYrMf4BM/dTY6zGfFJEIm3xc0JvKfK6A+eX0u1JoVCVN36uht+15l
         TslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sciSoRCJP9tmgG43WFiyHgQnQbIDAWhG9JNH7sehjOg=;
        b=QKDqWfZxbGIL+sm7sze3dU9ixjPJe6li5EGHDo0nt1FJGwG5+18oRLYwR89zYiEr8l
         0iYD0o9eGKnltOONBHiKd5iN2+iJhsRUOpiH2RxEXBMUtgtNMRC8Zt8uG3E6zrkc5TsX
         z2vbBXQlZ6StZ75iGApPJYUcz/PYXDrTu9Y4Zf/ZIMbTM28FUE9s7NO9qldsxwMRiTx6
         hFyJ6R7EK++o3yI4cbXBBh8ZqZ4YOZ/K4dmX+YWtwwgptVzOTfzsq58NCsBczPKlCkXr
         QAWCgA62fWUmfVVZ1wjkQdc/Y1hxdn0cqAvXUPt/NbE7XS1VRSTw4aEAdSwSb5nDhTGP
         PFJw==
X-Gm-Message-State: AJIora/iyyjQgN5hzcXiiyA2HAUZHBU8gpFKVVzUS/Wzj6fMfpiJfLRB
        TKkrgN4kVzfdAGfhybOb8lbTNcx7HzAPe6fQUIA=
X-Google-Smtp-Source: AGRyM1sfDVLE/mwWgB0QAtpx/HKLbEABP8/5Q/zeZSDF33rzwMvDpmwCLCKrNziaUCKnyksiRGhPYaXbhcB1kJ/6rZI=
X-Received: by 2002:a17:906:74c2:b0:722:e1e2:edea with SMTP id
 z2-20020a17090674c200b00722e1e2edeamr18426813ejl.658.1656427008994; Tue, 28
 Jun 2022 07:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656409369.git.mchehab@kernel.org> <3a54b73b6cbd251d3d5a899b9cfe8b794be78146.1656409369.git.mchehab@kernel.org>
In-Reply-To: <3a54b73b6cbd251d3d5a899b9cfe8b794be78146.1656409369.git.mchehab@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 28 Jun 2022 10:36:37 -0400
Message-ID: <CADnq5_NEB_FRwXaQ4vYK4oTHGCTCXLLwwqsjNSWmesQYQ_Y5UA@mail.gmail.com>
Subject: Re: [PATCH 09/22] drm: amdgpu: amdgpu_dm: fix kernel-doc markups
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jude Shih <shenshih@amd.com>, David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Shirish S <shirish.s@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jun 28, 2022 at 5:46 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> There are 4 undocumented fields at struct amdgpu_display_manager.
>
> Add documentation for them, fixing those warnings:
>
>         drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:544: warning: Function parameter or member 'dmub_outbox_params' not described in 'amdgpu_display_manager'
>         drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:544: warning: Function parameter or member 'num_of_edps' not described in 'amdgpu_display_manager'
>         drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:544: warning: Function parameter or member 'disable_hpd_irq' not described in 'amdgpu_display_manager'
>         drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:544: warning: Function parameter or member 'dmub_aux_transfer_done' not described in 'amdgpu_display_manager'
>         drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:544: warning: Function parameter or member 'delayed_hpd_wq' not described in 'amdgpu_display_manager'
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 547fc1547977..73755b304299 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -242,6 +242,13 @@ struct hpd_rx_irq_offload_work {
>   * @force_timing_sync: set via debugfs. When set, indicates that all connected
>   *                    displays will be forced to synchronize.
>   * @dmcub_trace_event_en: enable dmcub trace events
> + * @dmub_outbox_params: DMUB Outbox parameters
> + * @num_of_edps: number of backlight eDPs
> + * @disable_hpd_irq: disables all HPD and HPD RX interrupt handling in the
> + *                  driver when true
> + * @dmub_aux_transfer_done: struct completion used to indicate when DMUB
> + *                         transfers are done
> + * @delayed_hpd_wq: work queue used to delay DMUB HPD work
>   */
>  struct amdgpu_display_manager {
>
> --
> 2.36.1
>
