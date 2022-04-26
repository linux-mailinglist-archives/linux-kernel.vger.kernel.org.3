Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BC5106CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351205AbiDZS1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbiDZS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:27:46 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC9D15A42D;
        Tue, 26 Apr 2022 11:24:38 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e2fa360f6dso20280927fac.2;
        Tue, 26 Apr 2022 11:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CvMUDbRmBMULaPrSvy29y8lkb941E3y96qWPYQTdY/Q=;
        b=Vd2GKGuigIDYqeSthr1XHlGrWmE8278vq0hSC1l9niX2p46MO//wGYhttHa2/tZF2h
         1GNBAFuJatlePjjOMFIoZaXjMGEdDa2jJGz6idgNO5xfQCF0kvZ7Ql7jKUYzeiGjUvgg
         5IIQsGpegiT8cauecWPsZCt5fr/rWahKzmZyF0AcAfvHfsH78J8wYH1vLp5XwdrpWonH
         zdJ2Z2N4X5aV1Zj30sGsDE2DgTeajmCX1uWxCE6K7Sk7rK9AdEpB8F7Jks/pAJtWObr5
         58TC+5RI8H5VE50BndjjRwR/AT0xta+vBpp7MTXlRB9Niq5GdTt+9CWhx/9hOojvw2eb
         FGvw==
X-Gm-Message-State: AOAM531IF5HzSqdMCQVZepCxnygbwl7Skz8PyHZDANJolTZe789xTpdl
        JDraSFSSHAW4WRVZ4NEKpw==
X-Google-Smtp-Source: ABdhPJzKDpE4dIDRP2/fyRgrEUEF3RYpW6ouwQg5y1NvFIfAwEReF5gm9xUP3qw/cFdBm6ItJeP73w==
X-Received: by 2002:a05:6870:51cc:b0:e1:e6ee:448f with SMTP id b12-20020a05687051cc00b000e1e6ee448fmr9706297oaj.136.1650997478038;
        Tue, 26 Apr 2022 11:24:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d10-20020a9d51ca000000b00605522f0739sm5225378oth.41.2022.04.26.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:24:37 -0700 (PDT)
Received: (nullmailer pid 2303384 invoked by uid 1000);
        Tue, 26 Apr 2022 18:24:36 -0000
Date:   Tue, 26 Apr 2022 13:24:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     hsinyi@chromium.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Ryder Lee <ryder.lee@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: Add compatible for Mediatek
 MT8186
Message-ID: <Ymg45G1QkKY9KkqQ@robh.at.kernel.org>
References: <20220426125046.17311-1-allen-kh.cheng@mediatek.com>
 <20220426125046.17311-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426125046.17311-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 20:50:45 +0800, Allen-KH Cheng wrote:
> This commit adds dt-binding documentation for the Mediatek MT8186
> reference board.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
