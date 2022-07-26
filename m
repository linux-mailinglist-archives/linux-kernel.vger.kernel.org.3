Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFBD58162B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiGZPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiGZPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:13:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755DB2F02A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:13:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u12so13069703edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBRJ8tjENtSpeGeTiHbZwiRBnJ1kinArNIbw/C/Deio=;
        b=hnWhl18EZMAMwY1NbWl9Q2ew4kUnjjCqLMbb0F9JJjclqDY7CuP912KLiNKu590o+1
         8RnF31fx2WT2LYTxOEFlaS6xTqeFZQpvL6tqgLaEcBuyRfeADvMyMNu7WKCDqi4h+FQc
         aeP8E4YfZNPbL8yntzBlyrsxz96lXL2twpARm5kz32NHETxnRGKnDz3uZSV9PMuODHwB
         32GcyieXHvubioLoH1q0V7YJgJRjd8AdV7VH9OCH2Cfw96PKVgwSF2ZK1GvnKPO+DMeL
         dT3lhkXWhgL04qhFKhUWZylGGXoTebKaYIcUqEVB39EMYhRJ5lYkhfD5zxkRB8i5oFD2
         T8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBRJ8tjENtSpeGeTiHbZwiRBnJ1kinArNIbw/C/Deio=;
        b=R+Sttwoj3GVTm3KoMNuEaDVBFkKgtEhnW86msJ35SJ9GTqN4t3rOJOQOozuXhcnA4T
         NM7PfhOUHVpL9fqhMj7m+oX1GEP4IU4W6qpwejHfu+01ziI2EkDD89UWVuEk0RMuncMH
         +PvHRdKLvj/bQkSp01dMGaIEgdTBckLXJFV6CoFezdGzYKoiTbNe2ygRh2tIKhVdHyaY
         TzBU6I7fiAm4ZCW1rWga7m5IHAOlcigwai4ZV/POoTyOV+rD33BpI+LFU87OF2+M6wwM
         iZ2N9ostO5nG+TioWRLrshaM+JyLyP4Q81DGxhpP+orsqTQRkzdToVGf+2p89+PPFW70
         MWtg==
X-Gm-Message-State: AJIora9uz943PgSAPDdXY3jriLlPCqiqFlFMcjpNJsQimn/+ocnkLuvY
        tl3Nij5L1g8KZ2/8ivpyF/IQh626imPeB9NTokc=
X-Google-Smtp-Source: AGRyM1tTEzA+j1LcE8eqCjN/NB3z2kPwkvrzkDdGBPUNyOcJTawPwyOiihQ4eBh42pZcKNXQGF+9YNePw0SL33WUunY=
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id
 q13-20020a056402248d00b00437dd4ce70emr18432424eda.75.1658848379911; Tue, 26
 Jul 2022 08:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 26 Jul 2022 11:12:48 -0400
Message-ID: <CADnq5_MtM9+ThO3O-ejdrD+dhSvN5A9KgX4Bf2zt0iKge1FJZA@mail.gmail.com>
Subject: Re: [PATCH 01/20] drm/amd/display: Clean up some inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, airlied@linux.ie, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series.  Thanks!

Alex

On Tue, Jul 26, 2022 at 3:26 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> smatch warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:910 dcn32_init_hw() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index b6bada383958..201516a62b4b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -907,10 +907,10 @@ void dcn32_init_hw(struct dc *dc)
>                 dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
>
>         // Get DMCUB capabilities
> -    if (dc->ctx->dmub_srv) {
> -       dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
> -       dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
> -    }
> +       if (dc->ctx->dmub_srv) {
> +               dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
> +               dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
> +       }
>  }
>
>  static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
> --
> 2.20.1.7.g153144c
>
