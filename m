Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFFF48A230
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbiAJVyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:54:24 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37623 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbiAJVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:54:23 -0500
Received: by mail-ot1-f51.google.com with SMTP id 45-20020a9d0a30000000b0058f1a6df088so16595683otg.4;
        Mon, 10 Jan 2022 13:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nbuo4ro3nzdD0IScMxSgtEVRAPGYV0jGC/KSnm0R3QE=;
        b=i+69Ut3WIQoXrpFhslzhYazV9DvOCNQgJ6tc9nPFMIkNgup77b926mUS+zRl9mIQNw
         /R62Y4DNCo0eJ/NJGfqWeatKNTEXHz34Yho4Y0Ep6UgzkH9LO72AM5zUWEPU18z2z1nd
         ok0dLTAPutYBIFon/9iRx4gQ7IfHmpDTPfKAAjPUpuBwdr/vKIkCXmxTiU51wuM8gwf5
         ZFeZtluX5Oj5jVhWLdHFYHnhPWS4oBTWN1k6vjwqUL9HeGDreKA3QBXGo4ZDXMrv5tML
         b6mtwL6ojI92ZykfUB/7ArTtC6t6gUmTljwU3y17zoY87kNxVsfqgNNnB/Z4XMA0Oeqk
         doYA==
X-Gm-Message-State: AOAM532w9yWCXT2oCl5Dw7lLF5RRtpvFpB6Kniy2v2PuJ7CgpdCn5cs4
        LC/AZIqRzRO6rSJJnTLrr+cDM9Qn/g==
X-Google-Smtp-Source: ABdhPJxL5pmGClVVTEktJZZ8xhwU086xb1sB6DaYPpS+F0RIUXPR6B4sF0m3hHh63RnijGv3hzlfBw==
X-Received: by 2002:a9d:814:: with SMTP id 20mr1333098oty.253.1641851662790;
        Mon, 10 Jan 2022 13:54:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f12sm1669988ote.75.2022.01.10.13.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 13:54:21 -0800 (PST)
Received: (nullmailer pid 1583061 invoked by uid 1000);
        Mon, 10 Jan 2022 21:54:20 -0000
Date:   Mon, 10 Jan 2022 15:54:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: clock: samsung: convert Exynos5433 to
 dtschema
Message-ID: <YdyrDKivO+Jj/Ae/@robh.at.kernel.org>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
 <20220102115356.75796-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102115356.75796-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jan 2022 12:53:51 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos5433 SoC clock controller bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/clock/exynos5433-clock.txt       | 507 -----------------
>  .../clock/samsung,exynos5433-clock.yaml       | 524 ++++++++++++++++++
>  2 files changed, 524 insertions(+), 507 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos5433-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
> 

Applied, thanks!
