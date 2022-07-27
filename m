Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4838C58295A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiG0PN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiG0PNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:13:25 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0059286C2;
        Wed, 27 Jul 2022 08:13:24 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id w16so9015601ilh.0;
        Wed, 27 Jul 2022 08:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVcK8N78Pei3/X1uT8eHm6xxqyO27Cv2+Zshxxl4FjE=;
        b=HPR1Wh8wSyYKY7xwmXTaIGscNZkRvrRuYjsqqe9K/R0ozNq368f8EqTJCEGl3p8AgC
         stqnLYxWmp3BG4VPz8NUtPtF/YFt2CR9Gzh6xpV5bUxyyyXjzwsFMK0Yh84HUgksueLh
         rNzSs/ZRJ4zD5bSNkspnYdOABDSndu/vfa4oFaXPt1eJ9nZCPLt6DiJTw99MXRUEqmBA
         ydC31x3V4sMc3WnrkwgRGHvvJgFfPXRC652hzuc5LU5T5+A4a+SkxF9Rv2o86Nu31gKJ
         EKwgMddyVJd/GI4Pbp5IbOk/D0XwLXARpoWovMxW1mP+OVFffwQMdMuYdiKnnOnVRxPS
         mJaQ==
X-Gm-Message-State: AJIora8yMka2UuRCQ6JA+7sQpgKFcXB5HhAlRN/Ak6RD6pUzk2vNMHsG
        BAxnL8yG1SWSfTCA4GZ/KNuXsUgDNA==
X-Google-Smtp-Source: AGRyM1sIZNCnDW5+Q1Zvyhe8zXZI7v37j3xPDCrhkrmBBs8rGAn/AxRNYqqHD58ImNArACvA+AuHmg==
X-Received: by 2002:a05:6e02:184a:b0:2dd:e533:f257 with SMTP id b10-20020a056e02184a00b002dde533f257mr128142ilv.294.1658934804099;
        Wed, 27 Jul 2022 08:13:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m30-20020a026d1e000000b00339e6168237sm7916373jac.34.2022.07.27.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:13:23 -0700 (PDT)
Received: (nullmailer pid 2679656 invoked by uid 1000);
        Wed, 27 Jul 2022 15:13:21 -0000
Date:   Wed, 27 Jul 2022 09:13:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-watchdog@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: reset: qcom,pon: use absolute
 path to other schema
Message-ID: <20220727151321.GA2679315-robh@kernel.org>
References: <20220726120215.101868-1-krzysztof.kozlowski@linaro.org>
 <20220726120215.101868-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726120215.101868-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 14:02:14 +0200, Krzysztof Kozlowski wrote:
> Absolute path to other DT schema is preferred over relative one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
