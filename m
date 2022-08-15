Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BED594B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357342AbiHPANX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 20:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357067AbiHPADi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 20:03:38 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165716E620
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:25:42 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11be650aaccso1978820fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4dtzTFOnMPiWvS9NLNA0mqLFC7hsFAHAm90iIPVobYc=;
        b=SeFZ79e0Ib2qe8lWGXWbtJnO1uoeTkXxuyOheUHiRumZOEHdQ89jRkc6vdvRF88xO2
         0Q4WYBhfDHleGxaz7VEEdJub6/39aUSVuRtjj/iz4GfWVibrycWLP9p7CE8N1TJdzl4d
         qhgEgwEFHJndse9bYsrgVCgE+K0BCAgLTLlWW1gzXtQ8bmaF20ywDRNiRWy1bZFRPsHG
         0toLbWcpLKKazTOTp3TvkQW/FdV3lFfIE4wYErDaXHpUgSfYGrDAfhCBLMZv/v3Iv0cM
         ziNo0d3c97R3XwyxAKdIQSO4xdgM/1+2YjQcXlnBn8tkfDubyPNVAMyQioPLNvin9y3g
         UWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4dtzTFOnMPiWvS9NLNA0mqLFC7hsFAHAm90iIPVobYc=;
        b=Z8S67mU6DmrKmNhsbLsqpPB0PRUpL4y9mFJtYC++5QL+2csYwbYvYjHfgm95uHHxDW
         JT8CzN1dhJjddNdgPpBDxoQF8Eu5RYg2sryvwsyACEQzBOEQjLf8fMNvOnxnUwkp1k9G
         9EOXUmA+AHos6bbdjll3qNmHStbUn6/v8PMW8moyJ7eIjyKFX2LJFN+Uj/tREjBLqSYH
         SAqfrgNV4ZZR/3jeyrshSg9K+8NLeppwTWNKsoEmqvo0yv11JhsGvUKbIoGyVZ9kAq6b
         AfInlKUynvJkl+AzUWUEZ2VndNITL4VI8PRus8eAKm3Ebpq2ns1+P+0OgGr3iaJTYDqW
         69ww==
X-Gm-Message-State: ACgBeo1oX37gH9TXYRcW/kZHoDKVB6zdinifkqiA8/jLgm/SdWrZy8cT
        EUPaxDux/wMzhNt+NtHH8JoPafuc8VtC1PJ7hAA=
X-Google-Smtp-Source: AA6agR6bJkCopn47V4nY1QH2wV548mliE5H5Sqfe/Al4hqBtReFyVjXia6hjtMitXPe9oKY4lE/EfAxJW9M+RkLGNrg=
X-Received: by 2002:a05:6870:e98b:b0:10d:fe5c:f818 with SMTP id
 r11-20020a056870e98b00b0010dfe5cf818mr7637447oao.106.1660595141685; Mon, 15
 Aug 2022 13:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220813153421.4754-1-tangmin@cdjrlc.com>
In-Reply-To: <20220813153421.4754-1-tangmin@cdjrlc.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Aug 2022 16:25:30 -0400
Message-ID: <CADnq5_O0CD0s0=Rf7+c4FDg_Gte7NPdh7OVrBda=Wq6mDOzz4g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Unneeded semicolon
To:     min tang <tangmin@cdjrlc.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, Charlene.Liu@amd.com,
        sunpeng.li@amd.com, qingqing.zhuo@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

On Sat, Aug 13, 2022 at 11:35 AM min tang <tangmin@cdjrlc.com> wrote:
>
> There is no semicolon after '}' in line 510.
>
> Signed-off-by: min tang <tangmin@cdjrlc.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> index 27501b735a9c..c87cf8771c6d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> @@ -505,7 +505,7 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
>                 bw_params->clk_table.entries[i].dispclk_mhz = clock_table->DispClocks[i];
>                 bw_params->clk_table.entries[i].dppclk_mhz = clock_table->DppClocks[i];
>                 bw_params->clk_table.entries[i].wck_ratio = 1;
> -       };
> +       }
>
>         /* Make sure to include at least one entry and highest pstate */
>         if (max_pstate != min_pstate || i == 0) {
> --
> 2.17.1
>
