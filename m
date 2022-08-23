Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0149259CF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbiHWDIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbiHWDIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:08:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A382DC0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:05:50 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o184so14550105oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc;
        bh=VmBfhr0vpPVDGehePX0qDoV9RWqgGhohFmKMY5nUDoM=;
        b=CZx1U4Ln0EyZYh59YOjcfrH+vkIPu5/IUhsoq1qWJqeQ8h/fUonDwwjeCuYodkBllx
         AYCOflksLOktkUTjuBHTnPM5rxiyxFXB1UxpbQTuKWyQpzktO7aP/4FYUHLllD+uEDbM
         JfDn9njIiH/P+1VVG8k10Q2XpLJNGFGZgMSCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VmBfhr0vpPVDGehePX0qDoV9RWqgGhohFmKMY5nUDoM=;
        b=KAnK/kQ7XuxztfkAtPgVzxZvjjAdOHts5rUTMSE7cEXNzmFXHhyrrazljjH8dcwGkZ
         d5+zQagFR5phAk87uLWnvG8JZOSvRFSgfJpNJKF5HiJKsDBiV2bWiWgdGW50gJa/oy6d
         yHjL7caq0GKexZd+e6QeVY6wMRAqUkoLgOTKDpeHXv0AFzCsmchiznMpkdCdiChmlPgK
         eZ8TH2YvejMSz1DkgprIx2TtiOrNAYAM9QIgOe9A6yjeuw5netoZtxiiJR3cUGUZdAJH
         tRs5thNEZljdAQyx1+x6jRXZW8G25p+Rux5a9D3S7E8jjCzNLkBcz7sw5kKzkj/QLgEs
         bJKA==
X-Gm-Message-State: ACgBeo1Jlj8l6/us51zVxH9Ty8eEL+arOlcNlp/gakksBMu38lRCMCX9
        Em3My++/JXLuZuPkdSS/p9vV1atglLvWWEUo5rQs+Q==
X-Google-Smtp-Source: AA6agR7x4KeAQutL5kyySAJzlnPzefZEz+ruRD7XlKs+TiWS1yrY8IIEz6wt1zAT4lA87TOfAYTxdqvLMxsfCLgAzm8=
X-Received: by 2002:a05:6808:bca:b0:344:ef42:930f with SMTP id
 o10-20020a0568080bca00b00344ef42930fmr516939oik.0.1661223949623; Mon, 22 Aug
 2022 20:05:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Aug 2022 22:05:49 -0500
MIME-Version: 1.0
In-Reply-To: <1661156523-22611-4-git-send-email-quic_srivasam@quicinc.com>
References: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com> <1661156523-22611-4-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 22 Aug 2022 22:05:49 -0500
Message-ID: <CAE-0n52iLf0R0ovrpzMs0jp_Ty-RsONy0gcUvDsBvCz38R1fWw@mail.gmail.com>
Subject: Re: [RESEND v5 3/7] remoteproc: qcom: Add compatible name for SC7280 ADSP
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-08-22 01:21:59)
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index d0b767f..6d409ca 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -701,6 +701,22 @@ static const struct adsp_pil_data adsp_resource_init = {
>         },
>  };
>
> +static const struct adsp_pil_data adsp_sc7280_resource_init = {
> +       .crash_reason_smem = 423,
> +       .firmware_name = "adsp.mbn",
> +       .load_state = "adsp",
> +       .ssr_name = "lpass",
> +       .sysmon_name = "adsp",
> +       .ssctl_id = 0x14,
> +       .is_wpss = false,

This can be left out, it's the default.

> +       .adsp_sandbox_needed = true,
> +       .auto_boot = true,
> +       .clk_ids = (const char*[]) {
> +               "gcc_cfg_noc_lpass", NULL
> +       },
> +       .num_clks = 1,
