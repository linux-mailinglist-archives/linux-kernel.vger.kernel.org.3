Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983A453DE57
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347575AbiFEVVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiFEVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:21:40 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618024B1E3;
        Sun,  5 Jun 2022 14:21:39 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id v1so9273549qtx.5;
        Sun, 05 Jun 2022 14:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XXXWEDjfuHYCfIXDSumNX+3E7d5iXSbe6DNn1lOd4g=;
        b=N7QdzH1qa+4N/4/kQXKhopPgauy5EknC+6olOVVDxcyyAH9XjYNtf6E38pCnS1mOd8
         ogQaeLtSpBc1irMVR+9ur7P42Y6nJj/kTa8GAG+krCbButycsVvYJzi9ofdDSpJw4CRi
         ghXHTG+6K/39A8O4lBBiPeUDvK2ZBDWMPv/m+45k2z5df6f2ya1cJgcAWYWQpvW3pxdf
         Of7JqjirPcHhn57suUjNkDoNBZRm8aZiQVAwhMC04zGDQsD74eYrODIr8dmXwAyErZtZ
         dOf1iwyRTmLtmXXt3dZ9pR6XxP6wBmUPi1Q6tR6bzNPXf50NBF+lrCoeRg1bdLgNXiVg
         ycWg==
X-Gm-Message-State: AOAM532wtcH8qO9kkREDblWnl9PrOwgm1KUwCPPROUZgemU07QKuaH2m
        cY2sWVuIXH/+AOUCV+R8IA==
X-Google-Smtp-Source: ABdhPJxg8lW9Q6SM/QjPCob7gXlo6b4anqT/h1nOtd8gSx2d8lxqP45JB9iTaLl3lm5YqQZlh/IV4g==
X-Received: by 2002:a05:622a:1115:b0:2f3:bd60:a33b with SMTP id e21-20020a05622a111500b002f3bd60a33bmr16106409qty.292.1654464098421;
        Sun, 05 Jun 2022 14:21:38 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id m28-20020a05620a215c00b006a03cbb1323sm9421958qkm.65.2022.06.05.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:21:38 -0700 (PDT)
Received: (nullmailer pid 3539028 invoked by uid 1000);
        Sun, 05 Jun 2022 21:21:35 -0000
Date:   Sun, 5 Jun 2022 16:21:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: mediatek: add binding
 documentation for MT8365 SoC
Message-ID: <20220605212135.GA3538973-robh@kernel.org>
References: <20220530183833.863040-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530183833.863040-1-fparent@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 20:38:31 +0200, Fabien Parent wrote:
> Add the binding documentation for the thermal support on MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
