Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3646C4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbhLGU6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbhLGU6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:58:14 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24DC061756
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:54:43 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id i6so912692uae.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnQaA6P+LIHQMrDzcMBkiFC3eYo06vZ3BgOWnpFUb+U=;
        b=KDelhbXVes+lqRe0cb53jkgLal/aW6GQGwffjQa0rUHsbe6161UF1t6Z2on4FaIk7K
         kpkpfJFoyxDKQNM8u5/DG4qXs14VX31bLcBiREhAe/fcde1lmjKR005B0B2dvpxIN7lJ
         mEBfjeYuO/+jL9tenYrHFM7UEN1XBRDKed1vVA6cU9emE0Y7fuY31Qx89Q2ci9KQaR6L
         fsjgccMmfK5xtAY1EFTmdpfMThTmerT33Sa/j2aUf0jUwpOEj8vuHNSUPhU4Pj9zD8mk
         ttkdJZ90tG1h6qpo4ANKcjDL7GvumlIwp2XJqi1+0kvTJLtAudu0VD6q7YGCLRznQnam
         adhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnQaA6P+LIHQMrDzcMBkiFC3eYo06vZ3BgOWnpFUb+U=;
        b=sRvCvEe2h9hGsEpKC4JLpr6nRzx3McvqGFDMqS7WOgSIv4NsSk3f5zkHbS/ZqUF3Nu
         j/eImdyRMgsyFPpVg8YOWSgxvpiLSkJbsW1tB77aAwioL/UEpwehwaoK/7LEota8Mihu
         5DmRyT8v+dZ/oGnHrL0XtAv+cd7F5nhgMY7rXwNfyqm9gRyjssdMvRtHWr/ICce7B6Ec
         ZBn09a82W2EgdmfPilgPLq1KIkCmK2I5lxyAG9QoXq6+yRHOp2PE9vFaNTD3Mov65WMQ
         6Q+b0Oh/L/fkOpCYKTGqecZHwkBMypxGUfJXA+rF5r1Z+OnzxTJbhsb1nf7CPbjI2lX7
         x/+Q==
X-Gm-Message-State: AOAM533TnDS+kd5xbCix1AWMzqaGX7Kr3WCN2Kp6gGJ90nCI3eOHQi6z
        P3n64a6fHwVpITB5zj/9OX6O5TOcD2gQF0JSTMzU1g==
X-Google-Smtp-Source: ABdhPJytk9aqZYoTy38J10oQ1ej1BjD0TBUC+GRw7/nU3TmvDeFV2TePR+yGXQDx2wGW2M7EDD6S8h4pv5K8ijYKEVs=
X-Received: by 2002:a67:d31c:: with SMTP id a28mr48540382vsj.20.1638910482661;
 Tue, 07 Dec 2021 12:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20211126203641.24005-1-semen.protsenko@linaro.org> <YagPWOj0CLxE/+ER@robh.at.kernel.org>
In-Reply-To: <YagPWOj0CLxE/+ER@robh.at.kernel.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 7 Dec 2021 22:54:31 +0200
Message-ID: <CAPLW+4=LTd8i2Tqr7Wa0NDRTJ5mRJXP=EvRCx84WxnwCDQ1eVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        David Virag <virag.david003@gmail.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 at 02:12, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 26 Nov 2021 22:36:40 +0200, Sam Protsenko wrote:
> > System Register is used to configure system behavior, like USI protocol,
> > etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> > make it possible to modify SYSREG registers.
> >
> > While at it, add also missing PMU and GPIO clocks, which looks necessary
> > and might be needed for corresponding Exynos850 features soon.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Hi Sylwester,

Can you please review and apply this series, if it's ok?

Thanks!
