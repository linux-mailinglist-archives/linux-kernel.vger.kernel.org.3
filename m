Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775A4481D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhL3Omm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbhL3Oml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:42:41 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9201AC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:42:41 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id q3so22245593qvc.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lKISuKQSLJq7W846wWyQPT/02yK4dCfDutUdXbJUE8=;
        b=y9GwPrdNAQFLG/s5DqEEynU9lk8S/zqa5e6AdqR3bbHQh+HBCIe3Olv0DXAR4+aF+S
         ssTo31FCoWMnUvKW9GA/+RdbfW+IjIS7cYi0x0MH6WBFzbWWhmcQ80ULhE4CaSZHjDTJ
         prnIYo8oH+A9pLL/p0hNgA+IilgY2tJ8xFWSJwaNFG8V6IDiXCUoI+15/VRGgCO7TzWn
         PPIDZXKjcRFYG1HyATVt+Z2aDTsulaP3morwG98dkGg1YjDx34vnc70nHhybhWv7vFMj
         dmY7yCFdbBweVZCzLMh4Rn9Uh9TPUenCVsRgInK4ZLa7FVA8A9X5DnlR4EDg3KtGgfaX
         0ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lKISuKQSLJq7W846wWyQPT/02yK4dCfDutUdXbJUE8=;
        b=LsthU+bF/CVvhziYIoHvYLS1lw9lVbZ0XAechWTssDvKj/rGSTHzSNrXhIH0czUK3a
         4LcynGvYL1+GxEcp6dxM7uvgsxeIroUPdfbhbSot+iIXq4dCwgoQO5mOzKFC6SkDP4yQ
         K0+HArg0y8mJi9P3yGnktylnPGdV/hOBWjtEWFrtverOq343lNtZHx3X/srMqChYn5Ma
         BtuNaGFyH9lQYdFO8OBUCnKUVLSx1cURlC+YaDciuVFJNeTU7oJfuaV8GDgWetMk9HAx
         e2Nr93H0NQuzRMzN9D2Nzhclm8xm88yl3l30I25N+ZeFSKzbANQuSv3oj92CjrjQO2qI
         Fa7g==
X-Gm-Message-State: AOAM531A1jA9MZ9v9hTTTj0GldCONhg2AEKnVorsmKJhm+QMAave3g8L
        mQRvRfIb84oaxLxdLLo/glN7isdc3klB+qAKu+mdD2VBsyFphA==
X-Google-Smtp-Source: ABdhPJzJuu40611h0P8gpEq2A1hMiIaXCb1nTVZL3xZi8wKhm6cKrO+ixRJE9sSU773pYMI6ZOlBsjki8tq1vohgACw=
X-Received: by 2002:a05:6214:248a:: with SMTP id gi10mr27557554qvb.115.1640875360837;
 Thu, 30 Dec 2021 06:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20211230023101.1122588-1-konrad.dybcio@somainline.org>
 <CAA8EJprR_eNiRTXOLnHzztbdH_RYj-+Po99b=7c2Asxvop+jtQ@mail.gmail.com> <5543bdad-3518-fe20-d755-69ebac4ddd69@somainline.org>
In-Reply-To: <5543bdad-3518-fe20-d755-69ebac4ddd69@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 30 Dec 2021 17:42:29 +0300
Message-ID: <CAA8EJpq_T0tR=zN8G43otsWEqgkfqV0egrAtfG-VJMib6ZtEHA@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gcc-msm8994: Remove NoC clocks
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 at 17:29, Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
> > You don't have to init array entries with NULL values (if it's not for
> > the documentation purposes). Uninitialized entries will get NULL value
> > anyway.
> >


> Forgot to address this in my previous message, but I think it may be a
>
> good indicator for the next person that decides this would be a good idea
>
> that they should probably stay away from it.. If it's really bad, then sure, I
>
> can remove it..

You can add a comment on top of those assignments telling this, so
that the next person doing the semi-auto cleanup wouldn't delete the
assignments.

-- 
With best wishes
Dmitry
