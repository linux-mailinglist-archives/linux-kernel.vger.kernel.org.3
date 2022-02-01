Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23A24A6315
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiBAR7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiBAR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:59:01 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04429C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:59:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c194so4017753pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rFvrRBFYRkSNYSi6O0ttf9bwGkRMX6RYVT/6/lJeLok=;
        b=PY+xxDCzAMHt2lg40chWYBo5Y90OZfcEPXi/CdWCoZu843MG4rCT96JMgN3487fGzG
         XJLZuEH6na9zI07H7uGh7Hhzf9fgBoXxmER9fxEuicvV+u5OjNq8YaNsemDUkSIYfxs/
         XY3R+vDruuYr29uU91i73Up4roBPOIDpY6I1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rFvrRBFYRkSNYSi6O0ttf9bwGkRMX6RYVT/6/lJeLok=;
        b=VUXOQbv++ul8fUfn4IpYRM3WzdOKL4GBTBBKX02f0ZmgDm2d94DQ3aYvliuI4nMumk
         6SCl9dhpRdMz2sDfkRkvUbXQXCBAp8kc66xvxIfAS5lZltLYFBJYawbcQ1fw8QNrpwtC
         hTzwOfW1KgJO4IA+OUst0Z6LfyspMntfUyJydtbtL0M4D6yIjLB7WUcuXuJu95gvbHOc
         auSmIz6NBVYffdJJaC7+apMbYXV7xtbG7iYB2mBMgvdBO/O0DN6WXV7scFygOLclGqjG
         LxR/YAiCfYctWAelRPhXcYprIhNeiIZI5JsgeWwwqrvufMzZfr2FhWf0wPSs7L7hd47F
         Thgw==
X-Gm-Message-State: AOAM533euGVHCDY0FOYT5sy/QaOlKcmL/OdmDctRcSVBgcCBFEcpup1D
        sRDdHrat/dqaFjR7mm0H3xzslzY6QuQ51Q==
X-Google-Smtp-Source: ABdhPJx5I/ackme38S3wD0KRczU01kWmkJruHtPxIf9wCJQB/mV7gmiTtoUIFK1lK9nG4PXb5SQojQ==
X-Received: by 2002:a63:8a4a:: with SMTP id y71mr9110713pgd.207.1643738340441;
        Tue, 01 Feb 2022 09:59:00 -0800 (PST)
Received: from localhost ([2620:15c:202:201:aca9:b3a5:6f80:8fb5])
        by smtp.gmail.com with UTF8SMTPSA id d20sm23757577pfv.74.2022.02.01.09.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:59:00 -0800 (PST)
Date:   Tue, 1 Feb 2022 09:58:58 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sc7280-herobrine: Consistently add
 "-regulator" suffix
Message-ID: <Yfl04n9YhB87Qe0F@google.com>
References: <20220201001042.3724523-1-dianders@chromium.org>
 <20220131161034.2.I627e60c5488d54a45fd1482ca19f0f6e45192db2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220131161034.2.I627e60c5488d54a45fd1482ca19f0f6e45192db2@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:10:39PM -0800, Douglas Anderson wrote:
> Some of the fixed regulators were missing the "-regulator" suffix. Add
> it to be consistent within the file and consistent with the fixed
> regulators in sc7180-trogdor.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
