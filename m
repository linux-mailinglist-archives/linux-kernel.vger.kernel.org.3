Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2734993F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387279AbiAXUgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358203AbiAXUNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:13:45 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DBEC0604D5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:37:11 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id q145-20020a4a3397000000b002e85c7234b1so1449117ooq.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=OE7zpDJ/ImAr/I0egnBqJG8bk650Ar7DpEUyTPdTJtw=;
        b=S8celvhQE9q1bVrsDARpFL2ugWnZwTBbS5TBo3ge8O3ANqZlz/LKKjwmwAAyYfL+53
         BinD7Pbe4Z6hIVUdszsDpeVk4TVKG9cPqzfWIu70VfCiv/4vLUPApzaJZhZ4QPVK91Kd
         CpfFLphYeYEIT62X+JtCQK18CcbJ9Zdm4JMDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=OE7zpDJ/ImAr/I0egnBqJG8bk650Ar7DpEUyTPdTJtw=;
        b=Gk75PQv2MIKTatFOTkeFL2ixDM5N0407ikpxJbm7jNY8gaJ8dM/Ryz6ZoL7ewGg/7Q
         BvR7e389WBhx0EA1nUAiDwhCRh+fzWcqnbzP8AihcXEkNZkRLoHOH6JBsKjPFnbvVJ9J
         LJ1+uAf91APgl0XZGhincUmhjgdC/gT7AtbEs23byDWY0jN8doMsPLB0TlFhWprKBb+Y
         /IfD0Jc0QByHWEaJNghZeCwMOh0UWv248wjiBx865cnG/QCP5mqRs6GZ/i8/BXJt9KFb
         Ci8wsehNFATbMbdEkY0WoAXRdWi+kYspjemARdKS7gPSMIJOkROofAUWmsBkOyHLPDq4
         K0ig==
X-Gm-Message-State: AOAM530SakFRqiatGQzEJVnsYP2+KNprIp2HeUYUg7+q6n7ejZLIYk6j
        9h3NwcYPzl7RFviZqBsfbOwBwg+nmTEk9EszGpqmIw==
X-Google-Smtp-Source: ABdhPJytm+GOXzINucfGcA+WQ9XKPuPqK22JwGD5fA+K100i2lRiCUy7M7FJjrzhXKMKZjBf8J4ppeFUksmNinWY2Ds=
X-Received: by 2002:a4a:c118:: with SMTP id s24mr7146077oop.8.1643053030979;
 Mon, 24 Jan 2022 11:37:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jan 2022 11:37:10 -0800
MIME-Version: 1.0
In-Reply-To: <20220124184437.9278-1-tdas@codeaurora.org>
References: <20220124184437.9278-1-tdas@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 24 Jan 2022 11:37:10 -0800
Message-ID: <CAE-0n50bTcjL9qAdfprs43fdfn1Ft=cnCRVp9XjQ+iw_f57SLQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add camcc clock node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-01-24 10:44:37)
> Add the camera clock controller node for SC7280 SoC.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
