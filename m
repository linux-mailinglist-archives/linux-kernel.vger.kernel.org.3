Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA2489FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbiAJTI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:08:27 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42931 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbiAJTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:08:25 -0500
Received: by mail-ot1-f53.google.com with SMTP id s8-20020a0568301e0800b00590a1c8cc08so10159824otr.9;
        Mon, 10 Jan 2022 11:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VQaqdEqj0uvNnL02FK4WQruusoOye7MsD6275qvZ2HI=;
        b=tjL8iYMhtc6FmN/QVf+ScjAy27+Yk0lSa6iSIcWi2fMOs0MMt/b/Ca2uEUMK9KZ8Nc
         2a8kgwFZGAVfsHb7Uali/68TDQgDmM64qKAYtMsyKNLR6prC2hl7z60UO6avGE22wn8i
         ctst4LkwhsetOziY7Uq9HvLZLRR+P2dDVo8cOkUCeCLqhkQ680zMoghVaoLH7cuwkh+R
         he/TuE19PMvSKE1nWakimJGZ4vjsU8a3y0G5gB2/mUy9CesSYiPVncakkEmybCPSvEtT
         rMud82kiT5cNewAvepMdVHaEMLv0gPbIofdAu4MT5zBEa4hkAyZCIc0+2oSJ0vvT++bZ
         G19A==
X-Gm-Message-State: AOAM5300ciSRATN25iSCxW3yM7LHZDRAk/jtpHZcO0OUDJuVaqOgYqL8
        HwNhkJ2EUMGXrXREKY6XeRAN2Qad7w==
X-Google-Smtp-Source: ABdhPJyh68idIsWaVjFatJWDSoDu3pa/wyt86O7SAvPb2euLBWm43U/1/S5ZktsBM4pOAVTCqJQDrA==
X-Received: by 2002:a05:6830:40ac:: with SMTP id x44mr929980ott.330.1641841703677;
        Mon, 10 Jan 2022 11:08:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i16sm1467979ood.41.2022.01.10.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:08:23 -0800 (PST)
Received: (nullmailer pid 1305597 invoked by uid 1000);
        Mon, 10 Jan 2022 19:08:22 -0000
Date:   Mon, 10 Jan 2022 13:08:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, linux-leds@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: maxim,max77693: convert
 to dtschema
Message-ID: <YdyEJqhArUszOQBW@robh.at.kernel.org>
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
 <20211228163930.35524-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228163930.35524-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 17:39:28 +0100, Krzysztof Kozlowski wrote:
> Convert the Charger bindings of Maxim MAX77693 MUIC to DT schema format.
> The existing bindings were defined in ../bindings/mfd/max77693.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/power/supply/maxim,max77693.yaml | 70 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
