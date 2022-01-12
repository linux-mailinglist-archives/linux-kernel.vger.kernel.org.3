Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE4448BCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348025AbiALBvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:51:23 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36419 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiALBvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:51:22 -0500
Received: by mail-ot1-f54.google.com with SMTP id s21-20020a05683004d500b0058f585672efso919644otd.3;
        Tue, 11 Jan 2022 17:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nJ06M7x1XgF7yAjC1iLtiDKFvUsW6vbYekU5nFYFTc=;
        b=5iFO4P7s70tsOjln4vxjqOADWyy5alTrhQ90Txfo/HXTPqBL+kWHpasy4mDQBC5k90
         n6d+TkISFP4rc0sd9cp0PfIf+bZIfUkT47TSv+4VB3utjk7MfGfN0D6Vahmi+yqvvkgc
         FVnYFkT4jntQfOQrhRQI+D2clxegRQtl9SKVfnd/rNqNbQCR64UEQJrG+A3BncGjSeu1
         kP1mGeMcp4hc3flP0KrckVqBOqybLJbnybK6frlQqT/GG92OVwZlqaetI6bJgZ5lAQIf
         nZTW2uNcfzX941UsUYcNC6Hf3m+Er7zCf96hErIm1gDBjcvmra7tubSgzOK6+3v4nM92
         Koew==
X-Gm-Message-State: AOAM530v95eOFNL7E3cjzNR++TXe6pVjl2596eHXS+QW1/IndabTF/E8
        EOOfU90tYJp2bxaIMj6VSQ==
X-Google-Smtp-Source: ABdhPJyWAaUOt7C6oceNwuUPeGTcZmYdyGD5ZndwST01GxuZmbsF6GtL41TaCk7fUZKuPIga6L+m+A==
X-Received: by 2002:a9d:6452:: with SMTP id m18mr1436280otl.99.1641952281637;
        Tue, 11 Jan 2022 17:51:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n26sm1949402oij.5.2022.01.11.17.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:51:21 -0800 (PST)
Received: (nullmailer pid 3899690 invoked by uid 1000);
        Wed, 12 Jan 2022 01:51:19 -0000
Date:   Tue, 11 Jan 2022 19:51:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, chunfeng.yun@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        ryder.lee@kernel.org, wenst@chromium.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v8 3/4] dt-bindings: pinctrl: mt8195: Add
 mediatek,drive-strength-adv property
Message-ID: <Yd40F1noUJW4VNpJ@robh.at.kernel.org>
References: <20220107115345.9075-1-tinghan.shen@mediatek.com>
 <20220107115345.9075-4-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107115345.9075-4-tinghan.shen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 19:53:44 +0800, Tinghan Shen wrote:
> Extend pin driving support for I2C pins on SoC mt8195.
> This property is also documented in mediatek,mt8183-pinctrl.yaml.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8195.yaml      | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
