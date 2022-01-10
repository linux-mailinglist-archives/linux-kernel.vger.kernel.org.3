Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEA48A27C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbiAJWLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:11:34 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:36447 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbiAJWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:11:30 -0500
Received: by mail-oo1-f42.google.com with SMTP id k15-20020a4a850f000000b002dc3cdb0256so3529182ooh.3;
        Mon, 10 Jan 2022 14:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iDy9QNoW1YlTmt09nDZFc3aT1/W6TBSRrLsvjTkJhI4=;
        b=qnWltGAAmZHQGeHpviokFaHhHb1AcP8Pu2wLK/JbFstbuZG10QUhoL/QQ3KFjTewwR
         bJWkVFkXtqa1WGphifb17jCtAQ7ANS87jGNpDQw2KlAHARnVBj475TY1+O6bHD1kjPa2
         IJPZIm6hEaLoIMPay87o2w8hr13/KTcc0+2Q2pwT1+YYPAKelaitpZn0eF2SgnrfwQYU
         vBM+69DtPt8qNyrFi02KeDuMwdtAKSxd02WYp7iVC6r/njAk2thrbyaLL44g/bCPiRQk
         WbWKrp4tuaWphPYMj/IrdxOvo2nbZuecbZI2kH+2jfPwlf+J8M+zcW5UAJyDmmdOymHR
         5Isg==
X-Gm-Message-State: AOAM5308/3a02lTMrtVzh36iP1K6nTRcMt0996nKjZHSWqCGQwhViqql
        kB/K5/l3xin/lzqXlIxpoQ==
X-Google-Smtp-Source: ABdhPJz8u9B/HFiUOwVTe25pw2g6hoPBUetQvB6hfEOJGmjASzgYWhFvCBjnX6vEwGIcbHeCopiEmw==
X-Received: by 2002:a4a:4ec4:: with SMTP id r187mr1282776ooa.88.1641852689271;
        Mon, 10 Jan 2022 14:11:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l41sm1686841otl.79.2022.01.10.14.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:11:28 -0800 (PST)
Received: (nullmailer pid 1613381 invoked by uid 1000);
        Mon, 10 Jan 2022 22:11:27 -0000
Date:   Mon, 10 Jan 2022 16:11:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 8/8] dt-bindings: clock: samsung: convert S5Pv210 to
 dtschema
Message-ID: <YdyvD/yfB6Wm+Xua@robh.at.kernel.org>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
 <20220102115356.75796-8-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102115356.75796-8-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jan 2022 12:53:56 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung S5Pv210 SoC clock controller bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/clock/samsung,s5pv210-clock.txt  | 77 ------------------
>  .../bindings/clock/samsung,s5pv210-clock.yaml | 79 +++++++++++++++++++
>  MAINTAINERS                                   |  1 -
>  3 files changed, 79 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
> 

Applied, thanks!
