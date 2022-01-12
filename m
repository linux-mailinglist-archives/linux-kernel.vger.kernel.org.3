Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7380648BD29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbiALC0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:26:22 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42586 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiALC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:26:22 -0500
Received: by mail-ot1-f43.google.com with SMTP id s8-20020a0568301e0800b00590a1c8cc08so959117otr.9;
        Tue, 11 Jan 2022 18:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8skE+EhLiCSJlA3FJNIl/gCXTqckmqz6OxsyWaZ9u+M=;
        b=tmO1oV3GO+vhcsQ8yT8OHaBRZTlH1WcOuKgHtf7r4G3/r6hlpi3Cw5H+5u9plI5R4l
         CXklbq/MxOoI+f08rDh2KVldq2us/2T6Q+VumxhvbCvV7mborzFG7lvs6+9kZYjXK8hQ
         Yr++tTWZrTBZfqFXKUGxwLlOfd4tZcKxKSIQOhvbrrmZqnjBI8OIl8gJ0XrjR6c7VSZP
         R4qA9MagVOhm6LvXRCgK1a5saW9P/pJzreqOyRFQNMzVlwMpjjW8BI0lj11Zpl21z7T1
         dHxRESRAcBUkJADz0jo7h8OwBuY0ZyMD8oNqQg5ivk4Q9rHNMHayR/PIdXnOyLBAKNBR
         7tTg==
X-Gm-Message-State: AOAM530RWrtydGCbbVEJ0JfUBEvgZk3KKI3hZX/GW3wt5QsNpb/peQbW
        G9Md3IsoGUepMtVlKkvBvA==
X-Google-Smtp-Source: ABdhPJzXqX8XUOXqjUnZ7YOkTfLPWni4FeR/wl9DtlyO3BTkAIqM2zIPJBqinjkEhYLiTHGtJBr/rA==
X-Received: by 2002:a9d:6012:: with SMTP id h18mr5410418otj.203.1641954381390;
        Tue, 11 Jan 2022 18:26:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s124sm515068ooa.1.2022.01.11.18.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:26:20 -0800 (PST)
Received: (nullmailer pid 3951142 invoked by uid 1000);
        Wed, 12 Jan 2022 02:26:19 -0000
Date:   Tue, 11 Jan 2022 20:26:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-leds@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: mfd: maxim,max77693: convert to
 dtschema
Message-ID: <Yd48S1shnwqjs75r@robh.at.kernel.org>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <20220111175017.223966-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111175017.223966-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 18:50:17 +0100, Krzysztof Kozlowski wrote:
> Convert the MFD part of Maxim MAX77693 MUIC to DT schema format.  The
> example DTS was copied from existing DTS (exynos4412-midas.dtsi), so
> keep the license as GPL-2.0-only.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/mfd/max77693.txt      | 194 ------------------
>  .../bindings/mfd/maxim,max77693.yaml          | 143 +++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 144 insertions(+), 195 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77693.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
