Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ADE48BAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346438AbiAKW3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:29:51 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:38874 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiAKW3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:29:50 -0500
Received: by mail-oi1-f171.google.com with SMTP id g205so1036937oif.5;
        Tue, 11 Jan 2022 14:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dOEt1+o5hBTx5P13D7x4AyWlrDY1KWiLJ4JeLJv3OPs=;
        b=Lviy4H4LHe7kDAObHXAGzvPFAqm6FaoZNe7XAT7aE4d5Po9yszwgTvoz6uPASjSpHl
         n6Bjqxptw+gBoMblWv2cX2KYSDhlQv1TYq1RBG/V0itExpqSFzu0MYYv20xbpAvLLnUY
         wjL0Ehez11AHsxRlA6ymTXGoU7IGIPyJkKBShRRjOuZ0EdaqqwcGHuHC5umXKigcLHlz
         LGoEb9czS0QDFXsE21L9wqSVarZdvbU+QPpHWEFsyepJOXU4QAJECZmq1QpqfEey70Sp
         9yLeC2fNC5YTKdoS/4aQcXSzadaKbAoZhUKtQda+MSJ1o+X72msjUnETNTNQymO4dMJN
         MnKA==
X-Gm-Message-State: AOAM531/J6bnoGEZMbyKM/x2d+3B/yHULIzY4GMTCvdryY87cEZ4X7Ad
        o4SofbHg3r3HEAt13igKhw==
X-Google-Smtp-Source: ABdhPJxxt5rSy/19rLgPckJTEwZ4qThv9JPSoyfdQfuBUsXC6432Wm+sUEPj7K2apU/zjQektFZjKg==
X-Received: by 2002:a05:6808:5c9:: with SMTP id d9mr3292892oij.109.1641940190033;
        Tue, 11 Jan 2022 14:29:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v6sm1032530oto.80.2022.01.11.14.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:29:49 -0800 (PST)
Received: (nullmailer pid 3619110 invoked by uid 1000);
        Tue, 11 Jan 2022 22:29:48 -0000
Date:   Tue, 11 Jan 2022 16:29:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: leds: maxim,max77693: convert to
 dtschema
Message-ID: <Yd4E3Ky5wq/mfcLB@robh.at.kernel.org>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <20220111175017.223966-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111175017.223966-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 18:50:14 +0100, Krzysztof Kozlowski wrote:
> Convert the LEDs bindings of Maxim MAX77693 MUIC to DT schema format.
> The existing bindings were defined in ../bindings/mfd/max77693.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
