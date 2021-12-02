Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E09465A83
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354229AbhLBAR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:17:28 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:35790 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354212AbhLBAPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:15:31 -0500
Received: by mail-oi1-f177.google.com with SMTP id m6so52123843oim.2;
        Wed, 01 Dec 2021 16:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+s50L4ewH0uZfxKb9gTcsPyAWEISfg/7jiV2kO1vvPo=;
        b=j2N5M1FyJXIuBQ3Rv2D1/2IKHZzK38WNP4hVUz302nxDDPGUAlCPf41FjknD7Enpac
         QZTQkKMnVemNHQtEzbP4nW4HlAwwev2THmu6BQpDKFld1jcTkOZFhTJ1E+oc6JZnK2nW
         T7YaDk5MFaEeSEjjfsiZSkx9BHH0RaQL2U9OdsaKi8aHZApr7Ad6GTFS29Hak5h+3lXv
         1qKux6mTUyThvRFV+kCDSlGkYFtRMVQN0rrm3b49DZTk4Q7QKH8TfhFz+uLCLTkN2H8f
         CV/XhE4LnzTU8ojmX7ohZlsJNHU6w9gvnrxzmNBqWzxCIXlWGbcbmf0j9IF5QxWny9bE
         kHWg==
X-Gm-Message-State: AOAM530xE2eJ3EiqYlDHarIA92IBz4Vg3fBPkSqFOxbRnL7q9KTUhNSW
        Dg2g4aWQMD5MNnqp5NGIpA==
X-Google-Smtp-Source: ABdhPJzdsRJrpzhVv6agP0inyMBFQdKUoQ0uW3BGKemHkqnCoJHNosyy7qg6P8pSiq37ZeYtxJeRkw==
X-Received: by 2002:aca:4b11:: with SMTP id y17mr1660931oia.170.1638403929689;
        Wed, 01 Dec 2021 16:12:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t11sm514328otj.24.2021.12.01.16.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:12:09 -0800 (PST)
Received: (nullmailer pid 3278312 invoked by uid 1000);
        Thu, 02 Dec 2021 00:12:08 -0000
Date:   Wed, 1 Dec 2021 18:12:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        David Virag <virag.david003@gmail.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
Message-ID: <YagPWOj0CLxE/+ER@robh.at.kernel.org>
References: <20211126203641.24005-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126203641.24005-1-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 22:36:40 +0200, Sam Protsenko wrote:
> System Register is used to configure system behavior, like USI protocol,
> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> make it possible to modify SYSREG registers.
> 
> While at it, add also missing PMU and GPIO clocks, which looks necessary
> and might be needed for corresponding Exynos850 features soon.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
