Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2E599F54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 18:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350930AbiHSP7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351050AbiHSP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:56:19 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA81104B20
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:51:17 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bb16so5170936oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xgwTvjMwaFjXHhe/IO+w6T7DhkiHCUWjRJpOUsdchd0=;
        b=o9y70K1U/ZFzxXmKgJhnyH/S9odUAA6e++Ppu/HoYfGlet8DA1dkwSjRQH6yV+yZ7n
         yX3TF9mv9X40MfU1n/G/iPTAJYhY5DfBmEXlm5Kk0eHVtfslgQFhzNy8MDQVwT+in96d
         0QgmKJiJwl3JdNVnAcG6s4ydQhb5KxEh4ha+N7UZQr9fXN5Cnf6Qt52h2oNtamyyRekO
         J3rlTjz3kq5h5mlDAVGVisi21fgEV54fLjq7mGNucxWRBS1q2/kMN4Co+BHooEIT979n
         Pmm/GyWAEhbKElFesidIPmEEk8HS68Z/1qTGIHTa3rO86qZoNH4akiWwNwjZNHhq/qlR
         IpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xgwTvjMwaFjXHhe/IO+w6T7DhkiHCUWjRJpOUsdchd0=;
        b=rco+S27loD8q+iHm5pzwXAFQBJGqdG4U351zDE1prH7l0j2xWfcJ9RicTE6KdtzOWg
         KK2cHIVZzF1OOS/KE5yTaJxjjsD6NldSZxFLmA7W/FYM8f1EahqorDXG57Y90QnylRxj
         TxZQ44k8XBMVuVjyme4FL4ctEzHdCEHCAPON2FhT6g89UL8VL4Tx+pExEYNkXp0/Krs5
         lXXsoaOMCz/WLMB/RJEGox5PxQCXUH0ERgVRzEe060ijaajulez43eFD1+I2RAkldmA8
         ki/y71dXOKke8/H6xBVerRPkgWLaI+vbZNG1jwNUNz7Qw0cAhyfeebYxRPujjmstqv7N
         pdCA==
X-Gm-Message-State: ACgBeo3FY0y06pRzf1II66z/Q3WIJWFf+wmCcazQPHymw0H6aVJre4qr
        leV+HWYZ3ioMS7cjQAaVqxVd7y47r7RwZL4bImE=
X-Google-Smtp-Source: AA6agR7S0xUz50QPqMSnBBMcfiJgBBVAfan5W+tNffrGBgq8Lr/C6R5EhYRVOsOGMWIzKSB1eFOpWCVHozZt4n6o0Jg=
X-Received: by 2002:a05:6808:1491:b0:343:7543:1a37 with SMTP id
 e17-20020a056808149100b0034375431a37mr3653355oiw.106.1660924276437; Fri, 19
 Aug 2022 08:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220818025912.87327-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220818025912.87327-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Aug 2022 11:51:05 -0400
Message-ID: <CADnq5_OX48EnKN8eMaD9tNhiBSME=CYLzvr0-KVP2vXYGBHDaQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@linux.ie, sunpeng.li@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com, christian.koenig@amd.com
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

On Wed, Aug 17, 2022 at 10:59 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Semicolon is not required after curly braces.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1918
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
> index beb025cd3dc2..1995e1d708d9 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
> @@ -614,7 +614,7 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
>                 bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
>                 bw_params->clk_table.entries[i].wck_ratio = convert_wck_ratio(
>                         clock_table->DfPstateTable[min_pstate].WckRatio);
> -       };
> +       }
>
>         /* Make sure to include at least one entry at highest pstate */
>         if (max_pstate != min_pstate || i == 0) {
> --
> 2.20.1.7.g153144c
>
