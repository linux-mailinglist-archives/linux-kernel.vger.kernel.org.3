Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFE469DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387618AbhLFPbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358217AbhLFPTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D24C0698CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:13:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q17so7237162plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnQqBSAo+K5oxr9l26dxH3RShjXf+td6E+PHuLLI4y8=;
        b=VQIiWgpFRexhnDvLc40hcuZW7IZloc67v1EO6pDc4gDJnAh0CPsQ5fznnTZhQcFJXW
         ktjxw6RbnBpLiUVoQ/VacQo/TSIwujyyBjZaLSEgclpiWnMOU0wdE/lJEBphP9+pWKl1
         MLh+Ujy0n3oE+c9MqT0iP4kmn7D/myUpNO+J5WgQ7hnBstrPn6rVBDc6ScOZQCYHYQoj
         +aICtAZrE2isxEmPRNrM5erhDnCag58kMThzQA/slIoLTYR09wAa1WJmPubjtobDJ1XZ
         9q3B9k6Z9uz/EgFWcroiQpydY7/DYNHpq0fI+n4mKDIt2+NZ47cNlDIXk/1cTE+i5Yn5
         t7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnQqBSAo+K5oxr9l26dxH3RShjXf+td6E+PHuLLI4y8=;
        b=3HuV5Em5RS0fRVq0u15UdhEwz6Vvh99jThJ6u7dh79MnYVNDVANIj6MkUT+BvqqVS1
         0jwjcWdvzgWBSzAefXwopixWBlgnjL9luyhIgoBIYO4E4yNn9PI8sUrOZDFqE99FkvzM
         hYnLVqeA3N7SaaxZXHzJgoJ7jpPCnpYLBhyIsJYfk6b+/BR8GjsJggmg5gxi1MMOVUzc
         1ma0JLw2f51onimfzkgsinRQ20Snb93rd9+lt9fZL7piw1bVfD3OXOvMz3OcHCeF8A/R
         lYWtBFQcOSnESsiBrWFs+LPDk1VCH8n4xg7uG5zOdcyvgbQc9BKeOZNiEs5HMG7Yx5gq
         zjBg==
X-Gm-Message-State: AOAM530qLYDcKi51y72D54CFxMn8zBrS0woNyqSyM1D1AwGup9ahlwcq
        A0xEwJXHfnmGOUUHb9idcfkGhYSEnC2P1LEp2MsYAw==
X-Google-Smtp-Source: ABdhPJxLJ6uUWWiSZlny/JEj/mVjhmgg6C7BE3VsA338kjFc2t92GnAbloeXMtJTb10Jeu46/eWHG5/ObtlkLgQyN8c=
X-Received: by 2002:a17:903:2004:b0:142:6344:2c08 with SMTP id
 s4-20020a170903200400b0014263442c08mr44072941pla.51.1638803620589; Mon, 06
 Dec 2021 07:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20211118124819.1902427-1-robert.foss@linaro.org>
 <20211118124819.1902427-4-robert.foss@linaro.org> <Ya4nEMnZ3zQiXbaR@ripper>
In-Reply-To: <Ya4nEMnZ3zQiXbaR@ripper>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 6 Dec 2021 16:13:29 +0100
Message-ID: <CAG3jFytNQHK=dTHGzd57V_m_6YNwtD2zRYgBSjykd3whzqy9pQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: apq8016-sbc: Remove clock-lanes
 property from &camss node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 16:05, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Thu 18 Nov 04:48 PST 2021, Robert Foss wrote:
>
> > The clock-lanes property is no longer used as it is not programmable by
> > the CSIPHY hardware block of Qcom ISPs and should be removed.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Although I'd be happy to take the two dts patches through the Qualcomm
> tree, once the driver changes has landed.

Thanks Bjorn. I'll split the series and submit two fully reviewed v4 series.
