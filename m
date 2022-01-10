Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1418B48A238
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbiAJVyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:54:44 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40615 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345093AbiAJVym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:54:42 -0500
Received: by mail-ot1-f47.google.com with SMTP id h5-20020a9d6a45000000b005908066fa64so15706438otn.7;
        Mon, 10 Jan 2022 13:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+4nxlXrVkZoJFNXZQPBsDKZ5qkXAjMHB7WgcTcJz1MA=;
        b=ZiWYxLtstLWUfjXbecPxHIr/1fJr/HOMs89aRTyYWf+bvyxipNTJR9424FuFHLOiCm
         eSok2n0ozNJaKehfUytcJfNTfbv4aLf9ne4g30ZReHZsKY3zhUPacwmtfOWgEp5Xr4cy
         chACeUq/KtlA/QJuTD9Ux/XTn785LY9wr/OMf51PZHNpSfMarNfmVVG1Bl9MAaEUmhyf
         iohyidZaeM54ya4HFUEBzbn40QN3NPLruvEPg8HikmxUux2a9jn/BbXpVbzteiZgX30T
         zPzcRLwbsM3FUdl1nHnN7bQVGUD8bpver9IDdOMdMWKPVTTIvwoBaqlT6xDMsr5DYQn8
         714A==
X-Gm-Message-State: AOAM5331lFCl7Ic/0P/cgVK/TSXN4x63b71fmSjdjGBqskFvljCtDJoV
        62pOB4ahNaLwg6R4XU1Y/9OLFhGuVg==
X-Google-Smtp-Source: ABdhPJxocQDv8shH6doB7pKaIo4RiJOnq4JEo+/NIcaL4siK4t6vPBKdquiu21q85zgnj8vr8z+SVg==
X-Received: by 2002:a9d:c49:: with SMTP id 67mr1290639otr.351.1641851681337;
        Mon, 10 Jan 2022 13:54:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k20sm1670140otb.50.2022.01.10.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 13:54:40 -0800 (PST)
Received: (nullmailer pid 1583846 invoked by uid 1000);
        Mon, 10 Jan 2022 21:54:39 -0000
Date:   Mon, 10 Jan 2022 15:54:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 5/8] dt-bindings: clock: samsung: extend Exynos7 bindings
 with UFS
Message-ID: <YdyrH3WspngOp6ag@robh.at.kernel.org>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
 <20220102115356.75796-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102115356.75796-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jan 2022 12:53:53 +0100, Krzysztof Kozlowski wrote:
> The UFS for Exynos7 SoC clock controller requires additional input
> clocks for the FSYS1 clock controller.  Update the bindings to reflect
> this, at least in theory.  In practice, these input clocks are ignored,
> so it is rather adjusting of bindings to existing DTS, without affecting
> any real users.  I understand that is not how it should be done,
> though...
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/clock/samsung,exynos7-clock.yaml   | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Applied, thanks!
