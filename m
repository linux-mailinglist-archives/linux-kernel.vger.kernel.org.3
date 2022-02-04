Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1244AA2FA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347985AbiBDWQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:16:29 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:40848 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiBDWQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:16:26 -0500
Received: by mail-oo1-f48.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so3316492ooi.7;
        Fri, 04 Feb 2022 14:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XEjs3gs75i2y/88d2IN/0xWahdsmntkxPqdo/s0LV6o=;
        b=zJy0VstODHZxzAAu3xHEJqZyfSG0CcTm4CniRQ7gzD5llsfdXakPi8gilKWw3w6cPj
         wTRxwwtA7nQA9tE751b2Zp24C2ULXsV0csz3TiO0lvs/iZMYNHhLVqtbIbTub6bpZYJN
         FR12wTUdPM7UMV07K9gUR1hDFia1NI7zZCerLi7yv+ThOJkwbD7XkPlQZGCgpMqkQu2B
         AQzBdOGYjn+avwyUbbwfX0IRGUYVdbuFgVmOtFJq9iu1f2ph7vGS6L+eeHn/nlM5ZbvL
         s16evb50eop9Eai2q5TCk3va7XJ3e6D3Vra6aw65THcEe7jvxJHByW2XskIfadjNIeXw
         ckUg==
X-Gm-Message-State: AOAM531vjXyVGxocxfusE04RCaQ+uA6umiP/ykLcnFCfigki5jtmMbJb
        VsqbOIVfpjqJ36WgC/ymbQ==
X-Google-Smtp-Source: ABdhPJyn2bz7oujBqIo7b5YOLQHM+z9kGpizKbR2HAkXb4+OgrhLjukGMDzBvZinyXBd8+i/9Kutmw==
X-Received: by 2002:a05:6870:e28b:: with SMTP id v11mr287033oad.20.1644012985850;
        Fri, 04 Feb 2022 14:16:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 21sm1018837oal.26.2022.02.04.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:16:25 -0800 (PST)
Received: (nullmailer pid 3279086 invoked by uid 1000);
        Fri, 04 Feb 2022 22:16:24 -0000
Date:   Fri, 4 Feb 2022 16:16:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/4] mfd: dt-bindings: google,cros-ec: fix indentation
 in example
Message-ID: <Yf2luPZARR+bA3s+@robh.at.kernel.org>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124082347.32747-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 09:23:46 +0100, Krzysztof Kozlowski wrote:
> Correct level of indentation in the example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
