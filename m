Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B84623FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhK2WLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:11:10 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:34571 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhK2WJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:09:09 -0500
Received: by mail-oi1-f182.google.com with SMTP id t19so37363868oij.1;
        Mon, 29 Nov 2021 14:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XIW+pH2qOJaBXjjYGeI9op4sKIfFc3lvE4r+eNWiM8I=;
        b=xbeWWXvpiUc87b9QBAltWhEzbYelWIA0VsrJ7iNzkXzoMP5HH6WKw8dgsmaEFLO29q
         ujyej66ckHupt3AYg99NALBFfjhScxyI5k9RLzs/0y3MNwvj9OQNxv2bJnCYnx9vrNqo
         w5GjCAwwjSo6rW2lKUTsErO0h1sGpj2eNK3O2b7rbqdPfcl1csrq6nBiFiRYJPR80pgY
         6Ptyrc8k/i6Egv+TmGA/RW2V1vznpDH4GtrKR/GScHyattZYldlbgQe3vSOb93MYSfOp
         bA1sYyQ89nkii3KlUXz6joUXLq/FOpQ3qklkq6ur2HWJOOOKa6PMSXS3fLo1saN/dP8l
         WUzA==
X-Gm-Message-State: AOAM532yH+DMpEM5QRLTZDw3F72N+NmXqDY5D5jU71T5oP9Yrs4/B458
        cixrZ5OF+wFrryIrc+pDUQ==
X-Google-Smtp-Source: ABdhPJxPkJnupnHOFRixHPEsqqXYG1X+4g9VnIUa5KYXQ517HqtQKaEAcoz7JUSOYt4sPqqKzVU0uQ==
X-Received: by 2002:aca:a897:: with SMTP id r145mr709451oie.136.1638223551413;
        Mon, 29 Nov 2021 14:05:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j10sm2440443ooq.5.2021.11.29.14.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:05:50 -0800 (PST)
Received: (nullmailer pid 693931 invoked by uid 1000);
        Mon, 29 Nov 2021 22:05:49 -0000
Date:   Mon, 29 Nov 2021 16:05:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: add TI DC-DC converters
Message-ID: <YaVOvZuvVlaTRTDD@robh.at.kernel.org>
References: <20211116110207.68494-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116110207.68494-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 12:02:07 +0100, Krzysztof Kozlowski wrote:
> Few Texas Instruments DC-DC converters on PMBus like TPS544B20 do not
> have bindings and are used only as hardware monitoring sensor.  These
> devices are actually not trivial and can receive basic configuration
> (e.g. power up mode, CNTL pin polarity, expected input voltage), however
> devicetree support for configuration was never added.
> 
> Therefore in current state the devices are used only in read-only mode
> and have trivial bindings, so document them to have basic dtschema
> tests.
> 
> Cc: Vincent Pelletier <plr.vincent@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Applied, thanks!
