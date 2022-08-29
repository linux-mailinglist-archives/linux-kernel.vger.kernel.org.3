Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8385A54AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiH2TqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH2TqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:46:07 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D081F616
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:46:07 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so11677309fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vETszXP4tpDPkrySBXLgi1EkRM0QIaqBCFSpjffSf6A=;
        b=NwVZOfhTEFuNXz+pARnpVVoHpeMj7OR7hnfJiKnJnjG65J2EwYFa5F2LT5j9HaXnSu
         K6QI+xlxIA0ycuifqvLzWsYCk20WPrFSVOoORLYTbZ4gJKJAYQ1rQgBmja5WPZWI7uxv
         8zo/nsJF9knzLhre8yyB919nv5LI/zCXHZlN18axFiPgvDyI+rgwlpwp8AQXDsLUO251
         No20kghi+90Wv6nW7MLjHFNsELraNG9l1sxa7nzYkEQ5tkMzoVeQQ3UnhJMFtJlz9LRb
         CQmxSjFAYq/LcRVyWMw1k1XZcEEIuqfE27KTI02WzG5gLFS95VDaUAlTQW2Eh2wOnT26
         Tp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vETszXP4tpDPkrySBXLgi1EkRM0QIaqBCFSpjffSf6A=;
        b=Ho+XUNxoxYUuN1WeDH8qilTJHyxf/8uOOxEUULsIt2IyPcpKQxWz3JPyB8EUwd92ao
         8jLxjtkJq7o00inZcJ1TOBbOkJ8HLNWFr0vO+RmM8Clk0szUvJ0AcZZ24BzY6r0ajaLE
         BNhwS6mLdtZwf6XdB6VOf2IeX5/etLEOwug4Kwfpv/iOZO9U4kigqabgwB3SnpC+E1+j
         ZYmg8GoUFs1PMlmIuvyOI8t7YuLvoUTcs2FgpF2yB+2pe/A/2djS8wbpih7T4UPKQy8b
         IjMjBcbExL7zT+d3BK90KWtBrdDR19Su52k1pBxP4NJKpMTtd+xWEdoLaqaM++stg8wa
         Yz1A==
X-Gm-Message-State: ACgBeo1BkGiAIMHnJ/DAWITRtYCF900HezB9SjIk1PRhneeG4zy4l4DH
        RL/C3VfwxBGaVI60J0b4F6lcxP4OqKw2ya08lcM=
X-Google-Smtp-Source: AA6agR7YRRp6PNAzq4KftL331TiXIS5EjF73/0OlDNq0lmw7QCGwt3wKpQgAsM9gYb+yDZEiaZW0sg8C3OViNSuAqjY=
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id
 c14-20020a056808138e00b0034513d1fd66mr8076771oiw.96.1661802366350; Mon, 29
 Aug 2022 12:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220829121320.267892-1-cui.jinpeng2@zte.com.cn>
In-Reply-To: <20220829121320.267892-1-cui.jinpeng2@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 29 Aug 2022 15:45:55 -0400
Message-ID: <CADnq5_O6b5bhpppqjOrnXhyfk+jXeMcYiQCDLXDz_HcCujQ4Ag@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amd/display: remove redundant
 vertical_line_start variable
To:     cgel.zte@gmail.com
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Anthony.Koo@amd.com, alex.hung@amd.com,
        Roman.Li@amd.com, Yi-Ling.Chen2@amd.com, hanghong.ma@amd.com,
        mwen@igalia.com, dingchen.zhang@amd.com, dale.zhao@amd.com,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Jerry.Zuo@amd.com,
        dri-devel@lists.freedesktop.org, isabbasso@riseup.net,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        agustin.gutierrez@amd.com, Sungjoon.Kim@amd.com
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

Alex

On Mon, Aug 29, 2022 at 8:13 AM <cgel.zte@gmail.com> wrote:
>
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
>
> Return value from expression directly instead of
> taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 37246e965457..8f4f1ea447a7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -3741,7 +3741,6 @@ int dcn10_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx)
>         int vesa_sync_start;
>         int asic_blank_end;
>         int interlace_factor;
> -       int vertical_line_start;
>
>         patched_crtc_timing = *dc_crtc_timing;
>         apply_front_porch_workaround(&patched_crtc_timing);
> @@ -3757,10 +3756,8 @@ int dcn10_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx)
>                         patched_crtc_timing.v_border_top)
>                         * interlace_factor;
>
> -       vertical_line_start = asic_blank_end -
> +       return asic_blank_end -
>                         pipe_ctx->pipe_dlg_param.vstartup_start + 1;
> -
> -       return vertical_line_start;
>  }
>
>  void dcn10_calc_vupdate_position(
> --
> 2.25.1
>
