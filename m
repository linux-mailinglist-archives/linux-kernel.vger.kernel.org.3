Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D273A48BACF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbiAKWbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:31:11 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40912 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346488AbiAKWbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:31:05 -0500
Received: by mail-ot1-f52.google.com with SMTP id t6-20020a9d7746000000b005917e6b96ffso445515otl.7;
        Tue, 11 Jan 2022 14:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zf4Xaab9Mi6m66uXX6q8eD/bR0Wdt4o3dVUViFjX3dA=;
        b=c68xlaAS1mO8rMh3+RxFDUsONxYsH6+M8sPY0M7MPa3pC1vPOtfKgxKDggfZFgPYSb
         BZ1iDhsKpEN5kC4L3Arkh5Jnzm/uowaSZnlmkIErheeTYBHFJNs2FDC5sVpPjjsgqC/1
         2tFVbzlR/X2SyjUlur0EZnDJLyo4OifZZVU9sGASiHPkSbBD/FdoW3dmOg9wIvrWxBfu
         X8B+zDWQF2lk4ASe8EmYoLgwZvSOEfQU8VntFIW6wiKDyPRf0JS1yKRgWMsiRS9hQwmH
         7SZLKWlMpEhyuytQMCJinJ4hefX/LMIQGwlABewb42vRhZH5+AkjlNUeYl3FnSQDXBhW
         3/CQ==
X-Gm-Message-State: AOAM531DM6fGAMrcaH/Jm887PB9beLM+kqT7MXd3D5a6XoHnJvgxnL9q
        Zyt3tyzSQa6AQqYeTodP2w==
X-Google-Smtp-Source: ABdhPJyzqeLADlS5QPsMnzpltt9vSaIKJtveLOoKhihdgWHr9uPJWC6xZwFnEGVD+sRNPYMBLOQ3TA==
X-Received: by 2002:a05:6830:2008:: with SMTP id e8mr4565447otp.290.1641940264574;
        Tue, 11 Jan 2022 14:31:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j26sm24877oig.54.2022.01.11.14.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:31:03 -0800 (PST)
Received: (nullmailer pid 3621000 invoked by uid 1000);
        Tue, 11 Jan 2022 22:31:02 -0000
Date:   Tue, 11 Jan 2022 16:31:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-leds@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/3] regulator: dt-bindings: maxim,max77802: convert
 to dtschema
Message-ID: <Yd4FJnbKHsmREfN3@robh.at.kernel.org>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
 <20220111175430.224421-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111175430.224421-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 18:54:28 +0100, Krzysztof Kozlowski wrote:
> Convert the regulators of Maxim MAX77802 PMIC to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/regulator/max77802.txt           | 111 ------------------
>  .../bindings/regulator/maxim,max77802.yaml    |  97 +++++++++++++++
>  2 files changed, 97 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77802.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
