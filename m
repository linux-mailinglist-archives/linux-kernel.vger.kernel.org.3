Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34E546DD3E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhLHUq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLHUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:46:26 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2338BC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:42:54 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so3983600otl.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tCBJKqHXII8kRR+XyB0UNLoRGQjFyLNRUY7dH/E07n0=;
        b=R77+V9ewVdDKkywHmGe9KQPfPfjyTp7v6bw1iG9NVhpv+qvJIp3Y9g/YOQh6/o9uJs
         VVh1wCtzeqNJTFZQfBYmc3DG4AWcG4uMcaP3X1nH2JqRIbivX0UG70yaf3uEgfcQ4P4O
         UnPhxycP/SpogqACRZzhAlbMeGC5O/SLCBHMmhHOUk+d+HALvIr6leppy3FwxwJ+fI+a
         1PGGMahCNodf2PdtBoMvFzewdMjABO6h1CwRFWcVLQMtwJGtdhhvpmOkLj5sxl9HBTq/
         MCWCFscKyoFaiKmSDi5x2wfzST53u6QAshCYnC6xGe3QTGIjkIq2xBa6PRgr8An8R9G1
         2Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCBJKqHXII8kRR+XyB0UNLoRGQjFyLNRUY7dH/E07n0=;
        b=3WFrQss9GbzxgBFptO2U3Wgs9L2OsI1LGuECna4Y5kuOHlQiIHBT0is9GSMsM2jI44
         GLOYVN89u5ABO1WsPkYCnLV74WXydi8C1n+B3qCZomf6Y9zSx3hjeHe/MhXBCupj4UgM
         GrRngE/0VDYvx0pZKVWxq+At/AR221sZOiH4MY4gLQ861kouCz4nl6DT+O7I0Yji4/7T
         ZhOiab5Ma62M6Ngw3poC/NBHWcGVvZPZu5WNMgyWoT5eRBEi/KCCWv45maJdOMfCH7LR
         1Izqt/6UMu7aXshin0vwU5uBLEuDboQNl96XqumMpSkC/qasKNlPzy6mbFFs+DEcc6jn
         zh6Q==
X-Gm-Message-State: AOAM5335iuqInOFfRpJ+4tVo3uMDr7UIBT6dPb9NwxST1FRyixQY/Fxu
        L1zgqpOC5F6h/mRwZhb4aYbdvw==
X-Google-Smtp-Source: ABdhPJzze7ADwqhsP8xjBzDjn9m0MQEMTD7ok1WkYMP0triSndmF7RrJrDTkhrjJcJfvk8yeJgysnw==
X-Received: by 2002:a9d:f45:: with SMTP id 63mr1613969ott.350.1638996173449;
        Wed, 08 Dec 2021 12:42:53 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g61sm671210otg.43.2021.12.08.12.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:42:52 -0800 (PST)
Date:   Wed, 8 Dec 2021 14:42:48 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org, mka@chromium.org
Subject: Re: [PATCH v2 2/3] soc: qcom: rpmhpd: Remove mx/cx relationship on
 sc7280
Message-ID: <YbEYyGHqaHGeRXsV@builder.lan>
References: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
 <1638871712-18636-3-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638871712-18636-3-git-send-email-quic_rjendra@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Dec 04:08 CST 2021, Rajendra Nayak wrote:

> While the requirement to specify the active + sleep and active-only MX
> power-domains as the parents of the corresponding CX power domains is
> applicable for most SoCs, we have some like the sc7280 where this 
> dependency is not applicable.
> Define new rpmhpd structs for cx and cx_ao without the mx as
> parent and use them for sc7280.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> ---
>  drivers/soc/qcom/rpmhpd.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index c71481d..4599efe 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -120,6 +120,20 @@ static struct rpmhpd cx_ao = {
>  	.res_name = "cx.lvl",
>  };
>  
> +static struct rpmhpd cx_ao_no_parent;
> +static struct rpmhpd cx_no_parent = {

There are multiple variations of how each of these can be parented, but
only one way they can be without a parent. So how about we turn this the
other way around?

I.e. let's name this one "cx" and the existing one "cx_w_mx_parent".


This will be particularly useful when you look at mmcx, which on
8150/8180 has mx as parent and on 8450 has cx as parent.


PS. Unfortunately I had merged 8450 since you wrote this series, I tried
to just fix it up as I applied your patch, but noticed 8450_cx and
8450_mmcx and wanted to get your opinion on this first.

Regards,
Bjorn

> +	.pd = { .name = "cx", },
> +	.peer = &cx_ao_no_parent,
> +	.res_name = "cx.lvl",
> +};
> +
> +static struct rpmhpd cx_ao_no_parent = {
> +	.pd = { .name = "cx_ao", },
> +	.active_only = true,
> +	.peer = &cx_no_parent,
> +	.res_name = "cx.lvl",
> +};
> +
>  static struct rpmhpd mmcx_ao;
>  static struct rpmhpd mmcx = {
>  	.pd = { .name = "mmcx", },
> @@ -273,8 +287,8 @@ static const struct rpmhpd_desc sc7180_desc = {
>  
>  /* SC7280 RPMH powerdomains */
>  static struct rpmhpd *sc7280_rpmhpds[] = {
> -	[SC7280_CX] = &cx,
> -	[SC7280_CX_AO] = &cx_ao,
> +	[SC7280_CX] = &cx_no_parent,
> +	[SC7280_CX_AO] = &cx_ao_no_parent,
>  	[SC7280_EBI] = &ebi,
>  	[SC7280_GFX] = &gfx,
>  	[SC7280_MX] = &mx,
> -- 
> 2.7.4
> 
