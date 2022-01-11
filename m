Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7239F48BAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbiAKWWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:22:02 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43987 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiAKWWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:22:00 -0500
Received: by mail-oi1-f172.google.com with SMTP id s22so988573oie.10;
        Tue, 11 Jan 2022 14:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/gI0O3co3NFrG9LKDRU0rkCLTgEEKDyxk56HOlc7H0w=;
        b=GcLgYeJbq2unbO6zjQ7qhPwL9cagGRBwiYUgxXkNHkGwVemUh3wOL+tRzmHZG32uZq
         XJiME75/gDlVs9ynn5LPf6t5uG830VQG4hGAiMkBZCaBWVJYWb66VrlrlnBvLmGIJMat
         rGPYKzZsjuNxiRyoH7qhqBLPPvPj3ZsjXamJJXdZ0GvgmQXrW0BEg3rXF93++uPW8Pn3
         4GFor+9pxRxUQzJ763ngSI89JlLaieIlwNq7pzmkcvU+qA1ZyR2FO4zuHDk8h7zZb8Ug
         i34ZievgZsQwzBu0u7kCqPdJk3vCLhhKLc88q9wssKFPOFAjEh1keCnIH0bkrEayc3oc
         6ElA==
X-Gm-Message-State: AOAM531SHpneXJquhSjbTEz1oJY0TAotZXbk7dFKisI5VxX1CMhS2B7G
        NmCq11JkCbBLr7NEUxKKtw==
X-Google-Smtp-Source: ABdhPJyzaqduK8PWODJ1cY7HVLY6h7tzqzEP5K8H5zO8Hge4mHiq061i5kQcl47PiV8as/wJ/Z1dSA==
X-Received: by 2002:a05:6808:13cd:: with SMTP id d13mr3316701oiw.175.1641939719329;
        Tue, 11 Jan 2022 14:21:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o11sm1974430oiv.10.2022.01.11.14.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:21:58 -0800 (PST)
Received: (nullmailer pid 3608615 invoked by uid 1000);
        Tue, 11 Jan 2022 22:21:57 -0000
Date:   Tue, 11 Jan 2022 16:21:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] regulator: dt-bindings: maxim,max77843: add
 MAX77843 bindings
Message-ID: <Yd4DBfhJcNgazdpG@robh.at.kernel.org>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
 <20220111174805.223732-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111174805.223732-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 18:48:03 +0100, Krzysztof Kozlowski wrote:
> Document the bindings for MAX77843 regulator driver.  The bindings are
> almost identical to MAX77693 bindings, except the actual names of
> regulators.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/regulator/maxim,max77843.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77843.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
