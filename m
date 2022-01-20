Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFEE495360
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiATRgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:36:22 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37449 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiATRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:36:19 -0500
Received: by mail-ot1-f46.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so8492689oto.4;
        Thu, 20 Jan 2022 09:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qQlvojQIJlI1LuVZbEtkS+KlAzI9wBW3pw0XQI8LAMk=;
        b=nsKq9Ekl9nRrTfJ21CxMLbbFwv6qWICF1voIhar2LQns+1PYw8C2tnQK33HckIhWOl
         hR9cdcdfSI0u51v6EmjuL2TEB2Fk68Rui2WzTDZ8y0pizNTRD88L0vCec278qGYwyVeZ
         /X0ir+r+XhlvyLYzPTZ2eLQKHuqhn0JdUTEeFpkuE3Ne0eSKofxqorOIO9hUYQRYA9P0
         UBB7mrAjatMpF1y0EfpqNY/ZKx9OeKQmU7GusP5G8QAhjNSSsvHF0iAgknYEzg0wT2hG
         wWmBgMci1mS85jg2pmi0pdQX21GaEv7Kjq3a9iKPYEr/+S5oPl0d9NhBOc3ZEksUDiBH
         rlyw==
X-Gm-Message-State: AOAM533uVzyO5xpfy0XtL1kniF1pLoaqG0I+oeIvPXaxfi3ylwxYOFWq
        n1nG+w2mWDzzwjjhpje7tQ==
X-Google-Smtp-Source: ABdhPJzCRxVNcMKOq7T+/Z1lxu7In4u72P8sWp+eMD1DsgHGhcN9VmWOc7txoszaZlPCUT1Kd3fnYg==
X-Received: by 2002:a9d:5a01:: with SMTP id v1mr21602978oth.337.1642700179177;
        Thu, 20 Jan 2022 09:36:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d4sm1651420otq.44.2022.01.20.09.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:36:18 -0800 (PST)
Received: (nullmailer pid 1648421 invoked by uid 1000);
        Thu, 20 Jan 2022 17:36:16 -0000
Date:   Thu, 20 Jan 2022 11:36:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        - <patches@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        linux-input@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Drop unnecessary pinctrl properties
Message-ID: <YemdkDfmemrwab2Y@robh.at.kernel.org>
References: <20220119015325.2438277-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119015325.2438277-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 19:53:25 -0600, Rob Herring wrote:
> For a single pinctrl mode, it is not necessary to define pinctrl
> properties as the tools always allow pinctrl properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/rockchip/rockchip,rk3066-hdmi.yaml         |  8 --------
>  Documentation/devicetree/bindings/input/gpio-keys.yaml |  6 ------
>  .../devicetree/bindings/pinctrl/cirrus,lochnagar.yaml  |  9 ---------
>  .../devicetree/bindings/pinctrl/cirrus,madera.yaml     | 10 ----------
>  .../devicetree/bindings/sound/samsung-i2s.yaml         |  6 ------
>  5 files changed, 39 deletions(-)
> 

Applied, thanks!
