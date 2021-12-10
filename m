Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59E7470C88
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbhLJVae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:30:34 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41661 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhLJVab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:30:31 -0500
Received: by mail-ot1-f50.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so10924387otl.8;
        Fri, 10 Dec 2021 13:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZuyX6z8S30jeHc6oSsRE3u6hAb6GHX4f7wcgH1PISY=;
        b=PXZrKTzOLI3jpJwZ1WtgyJC6kCU1xlUPo9J53c9cGOF5779bMCAsANu/JWKYNI3gAD
         DgTjQbmQs/ETwjOgLineqqkN5pCr3/ri9gBkTuBIoURjrP+cHHzk0lU5noipjj3bY99U
         zqUh/NqXJ9MHcuvYq6RHHQFfXzT2wSzrxSQ4flj1oYwbzI//WVKIvUOhwvQz5tHSuZna
         8mVWHcn7Bwv+iLJmg2oarBVhj4b8QQE4pc8b9uCUgLzni3+k8fMkzR1bufPiQnpM0mHY
         AjM7d9eT4XiFIjlN7vnMjYO9J8k3Sbg0/0NjCtR8NK8LMIT/mtzB2Yurt6iGjv9TVBd0
         X+Hg==
X-Gm-Message-State: AOAM532ALrgn3Di4QRqYeY/vnUt/b+1lf2gA8edMQ1i1ccZus/ONyVDI
        QeIVsv1TPed+LnJpIRGcvAaifGic/w==
X-Google-Smtp-Source: ABdhPJy/OeyMWo2q9s0YlIwOe67Bw9mijpU54WYT2IvHTTJoK/7NZQl3xWWEtSqFtWV6NyZk3oVlpA==
X-Received: by 2002:a9d:7cce:: with SMTP id r14mr12864118otn.114.1639171615215;
        Fri, 10 Dec 2021 13:26:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l9sm699579oom.4.2021.12.10.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:26:54 -0800 (PST)
Received: (nullmailer pid 1930479 invoked by uid 1000);
        Fri, 10 Dec 2021 21:26:53 -0000
Date:   Fri, 10 Dec 2021 15:26:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tomasz.figa@gmail.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add bindings definitions for
 Exynos7885 CMU
Message-ID: <YbPGHc8GeGrsAnDP@robh.at.kernel.org>
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-2-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206153124.427102-2-virag.david003@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 16:31:15 +0100, David Virag wrote:
> Just like on Exynos850, the clock controller driver is designed to have
> separate instances for each particular CMU, so clock IDs start from 1
> for each CMU in this bindings header too.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Added R-b tag by Krzysztof Kozlowski
> 
> Changes in v3:
>   - Nothing
> 
> Changes in v4:
>   - Nothing
> 
>  include/dt-bindings/clock/exynos7885.h | 115 +++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 include/dt-bindings/clock/exynos7885.h
> 

Acked-by: Rob Herring <robh@kernel.org>
