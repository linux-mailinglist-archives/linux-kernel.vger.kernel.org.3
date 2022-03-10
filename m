Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E344D54D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbiCJWuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343962AbiCJWud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:50:33 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446CDD10B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:49:30 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so5077579otk.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=x/TT8dLlww2cRMcFnTjGyOogDZ68YWOXUbd7KMIvLHk=;
        b=l3RsfuUFBqBo0l9fCiJUOTYGsMxKeX/1SHoTtDTNvMQ9mDDBYCku7C7xT5Ts+8m2gX
         DDaLjCvuNRU5pTbxORwk2t04mJzR0RAr70A3voytdFWRhl+5JH4ohYvQ7JwizVo1U0F4
         24XSl7nqILv6Yhv6Te78UPQ9zza04eomRcklA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=x/TT8dLlww2cRMcFnTjGyOogDZ68YWOXUbd7KMIvLHk=;
        b=ksmOPpZyVOj/kHnzcCltsoYJSk7+alrcrfoSdcW6rFnaPezuAxjlUjHDKNiZFdxC5G
         2e1jWjG72cxL+PWe09+XblWR4POdXUe6Q9jf0eRLrxQ+wt3/khC6pNaa2mqUvKAj8En1
         x3K/pxoDSFl0CkaDOOBVpiUNn1OAvYF9yfEpdPFlwlmzW7aZpzpQhh9Oxf8eDfTGr/Y1
         fkfskrftd2zWpZraSza3WQGwysEoXDzd4NBkLdeFdxqMejPcfKrobncyALW6cnT6yfqb
         jC7loaxDFGcK3LI5QyMvbUwSj9x82QfVqqsSVCAh/BCUPKEXc8E/AOBa0Y/8t287z0SO
         OZFw==
X-Gm-Message-State: AOAM531slQlSfcbYWcZDgkBuwW3iY16VrzGWsHj2tyqa6vGm88scZLyE
        6drCVSxTjG9Kci1I3j+aHaGAYkjzQZXO7asrxB9F3LLb6f0=
X-Google-Smtp-Source: ABdhPJzkXMg76oLKwe91cD8Tb3qxaJYxjvruGUgDXA2xW/l+a06C+/Ddx2bCt1A7PKq/8Vj0NmTf/d1aldPMMl8z6Rw=
X-Received: by 2002:a9d:5a01:0:b0:5b2:5b6c:232b with SMTP id
 v1-20020a9d5a01000000b005b25b6c232bmr3546448oth.159.1646952569988; Thu, 10
 Mar 2022 14:49:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Mar 2022 17:49:29 -0500
MIME-Version: 1.0
In-Reply-To: <20220310130429.1.Id41fda1d7f5d9230bc45c1b85b06b0fb0ddd29af@changeid>
References: <20220310130429.1.Id41fda1d7f5d9230bc45c1b85b06b0fb0ddd29af@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 10 Mar 2022 17:49:29 -0500
Message-ID: <CAE-0n53zZ6aMu2ztu5sObyrQRbpfML22OmxK1eFx76P_PWdZ+w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-herobrine: Fix PCIe regulator
 glitch at bootup
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-03-10 13:04:34)
> While scoping signals, we found that the PCIe signals weren't
> compliant at bootup. Specifically, the bootloader was setting up PCIe
> and leaving it configured, then jumping to the kernel. The kernel was
> turning off the regulator while leaving the PCIe clock running, which
> was a violation.
>
> In the regulator bindings (and the Linux kernel driver that uses
> them), there's currently no way to specify that a GPIO-controlled
> regulator should keep its state at bootup. You've got to pick either
> "on" or "off". Let's switch it so that the PCIe regulator defaults to
> "on" instead of "off". This should be a much safer way to go and
> avoids the timing violation. The regulator will still be turned off
> later if there are no users.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
