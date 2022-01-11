Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5E48BACC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbiAKWa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:30:28 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:46877 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiAKWa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:30:27 -0500
Received: by mail-oi1-f171.google.com with SMTP id w188so983433oiw.13;
        Tue, 11 Jan 2022 14:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCQdWu1p3SjT0066qYcPttp8iL07o6DnAH1kBwTjtiw=;
        b=nYXpesEpYwjovhnMDk6KFjaZ01ujKTomNc1Fb2dYiVztg45NXYYbSyhT2+uQSD3I5I
         GtlyGRCTeXbxSNTZqVnGZKU/58IKlmgOdG1dnLNgFUx6yVhfgX5GuwNuAdNkhLngZ5ov
         2G+WInqEX1/Y3Z/u2Aj8eNXhtFjm1W+Qp18lt/b7APejj9SRzJyzg529BWn35PA+9r8F
         IWyYY6rp1TUXmKCHGVq+xeBrsr9JXF5Fk9YbAu8SRHFduUrSaMnCffZWe/a37Nn3bE7F
         87/IjvdGFVsGlyJTMefW1QFERL5WiIAsREsw+X9run+EJpsy07eI2N2bf0jNFpcZb9tf
         N7ug==
X-Gm-Message-State: AOAM530+VqlrXuT9RUBasqEDSWoJpgn0z12ZD+0WLf53n3C3ciKjVRxw
        5pcNo1OTqoAwjrAfeUSWAni5ChbYiA==
X-Google-Smtp-Source: ABdhPJz7CfQ9kgnMUuD5JF6svjJ5RmMkmSvyACdv/7vUvO1blHXyiDwty4gQaOKucHCt6iujWr1W9g==
X-Received: by 2002:aca:646:: with SMTP id 67mr3249344oig.175.1641940226545;
        Tue, 11 Jan 2022 14:30:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v41sm2142340ooi.0.2022.01.11.14.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:30:25 -0800 (PST)
Received: (nullmailer pid 3620050 invoked by uid 1000);
        Tue, 11 Jan 2022 22:30:24 -0000
Date:   Tue, 11 Jan 2022 16:30:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max77693: convert
 to dtschema
Message-ID: <Yd4FAI2dqonI5lUw@robh.at.kernel.org>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 18:50:16 +0100, Krzysztof Kozlowski wrote:
> Convert the regulator bindings of Maxim MAX77693 MUIC to DT schema format.
> The existing bindings were defined in ../bindings/mfd/max77693.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/regulator/maxim,max77693.yaml    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
