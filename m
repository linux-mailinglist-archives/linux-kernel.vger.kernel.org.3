Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987BD48EF16
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiANRLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbiANRLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:11:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991DAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:11:37 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o3so13955321pjs.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CRZUvior4qSuMl2PMYXMAWiEwViGY4hYBcxCDilxVC8=;
        b=nal068ypEOFzYl2TSNavDQWBYctnmTFE/lmauGthQ8xs0uEmhlPGDMIVblS9xI2VyR
         BNKVai7x8r0wVEKZDi08Yai5aVWwBXUnoubwRBq4urzhHzmequjGwMq1IILEKIHnPBaX
         MwvDq9m5+ftg3gLfY9/rS0Q3tsWio3Nt1YGbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRZUvior4qSuMl2PMYXMAWiEwViGY4hYBcxCDilxVC8=;
        b=p/noPV9LCoQAosBDQATD+3x1j6biMKJbP+Ve+Zp6qcqGezPUyWO7mNC4g9BDXPiwC7
         gILFwjcxrHr3xGx+9bIqGznJyYlKR+ZJTtTDrrbr23AbGCf5LZGPcbT1F1lmtBlYk1Fa
         1oX914CE5GVhuSOuJeX5tFr1PEJ3KHbB9dl1bt7P7NZu1I26jaSatfs4aB6iowL/hDUg
         J8X/qfRcNKtjYK3LcuVHWR5Dh1m12kTYgUKps3Kfu4ZVKww096SyHlQY7kypuXhRKavq
         ENk9tMiFFBHf0TSder0YosJmmaF0bHhtZXVJjBzV9EEyxpCa9ZnLGlO8sX3c19M9nYUt
         1qvQ==
X-Gm-Message-State: AOAM532+2c60i2b3zf+3vbNtAKxQzi1HEflV0JfkQGfaU17kiWcngXqm
        opoxu6pNxtSxe2o1yqR4HNQDUg==
X-Google-Smtp-Source: ABdhPJxbSLJmdoDiI5pqCuWWl/53bI6sPZAQa6CRffZQrpW2sHun3FflGcKOwGyfVfR1N99qVTwzSA==
X-Received: by 2002:a17:90a:c303:: with SMTP id g3mr21275081pjt.74.1642180297211;
        Fri, 14 Jan 2022 09:11:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:a0bd:cd39:e43:7570])
        by smtp.gmail.com with UTF8SMTPSA id l21sm5066532pgk.41.2022.01.14.09.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 09:11:36 -0800 (PST)
Date:   Fri, 14 Jan 2022 09:11:35 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        quic_rjendra@quicinc.com, sibis@codeaurora.org,
        kgodara1@codeaurora.org, swboyd@chromium.org,
        pmaliset@codeaurora.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc7280: Add herobrine-r1
Message-ID: <YeGuxzO3q/9S6VmO@google.com>
References: <20220114004303.905808-1-dianders@chromium.org>
 <20220113164233.4.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113164233.4.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 04:43:03PM -0800, Douglas Anderson wrote:
> Add the new herobrine-r1. Note that this is pretty much a re-design
> compared to herobrine-r0 so we don't attempt any dtsi to share stuff
> between them.
> 
> This patch attempts to define things at 3 levels:
> 
> 1. The Qcard level. Herobrine includes a Qcard PCB and the Qcard PCB
>    is supposed to be the same (modulo stuffing options) across
>    multiple boards, so trying to define what's there hopefully makes
>    sense. NOTE that newer "CRD" boards from Qualcomm also use
>    Qcard. When support for CRD3 is added hopefully it can use the
>    Qcard include (and perhaps we should even evaluate it using
>    herobrine.dtsi?)
> 2. The herobrine "baseboard" level. Right now most stuff is here with
>    the exception of things that we _know_ will be different per
>    board. We know that not all boards will have the same set of eMMC,
>    nvme, and SD. We also know that the exact pin names are likely to
>    be different.
> 3. The actual "board" level, AKA herobrine-rev1.
> 
> NOTES:
> - This boots to command prompt, but no eDP yet since eDP hasn't
>   been added to sc7280.dtsi yet.
> - This assumes LTE for now. Once it's clear how WiFi-only SKUs will
>   work we expect some small changes.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
