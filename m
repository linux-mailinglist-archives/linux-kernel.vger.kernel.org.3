Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC3C510673
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350625AbiDZSRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346619AbiDZSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:17:23 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F26D793B2;
        Tue, 26 Apr 2022 11:14:15 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id e4so21613873oif.2;
        Tue, 26 Apr 2022 11:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D7k+hlmPvjASuRIFSXQ3Jybc3z99DtV6iqQdcbp6ruA=;
        b=FJoSP4PZ0KCNjdaQ7tY2zUrzdhNUrEoEhhRMGOznkF0UikgNxjOK5kqm3X4MtjaN7k
         3hKuypcrLPBno/QfLCXFdjSxwm9qGSPqZtu2mFt1iAXQxA4CszsDaE1LY9PmQlWO+e4M
         SmszPTCETRGtVyPdWqmPJlmiv5GCFmPl6qOEsistxjEpxNIy/O3WQXmChs8PT3Lk3py8
         SuRZWO428MsCoYWcWZup9NfAX7YMYk1nlpMRY9sigdMp0XYhJUSx+zWHiUBBJR/LGsRB
         CkR/HU6bBjkuBY3IAADywosgJtbZUJo7hJthlT61p0+xkue+GD1F0x1VFvGCHYK5bAGB
         NyNw==
X-Gm-Message-State: AOAM533qqFVV1rzUDDX7rnvd1PiWUTKKHEufGdrszA3zKDCCFqb8Atz0
        NC5KyfodbAR8TpsskZMyTg==
X-Google-Smtp-Source: ABdhPJwtcbfWHBKzPNxhv77mx5hkoU8uEbBtDzOdlIc8tpHYuh/NiAqfXqngo8RyuUdTes1mtk05sg==
X-Received: by 2002:aca:1908:0:b0:325:22f5:5858 with SMTP id l8-20020aca1908000000b0032522f55858mr6053944oii.283.1650996854817;
        Tue, 26 Apr 2022 11:14:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c2-20020a9d6c82000000b00605988f38c9sm4250547otr.21.2022.04.26.11.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:14:14 -0700 (PDT)
Received: (nullmailer pid 2287423 invoked by uid 1000);
        Tue, 26 Apr 2022 18:14:13 -0000
Date:   Tue, 26 Apr 2022 13:14:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: timer: cdns,ttc: drop unneeded minItems
Message-ID: <Ymg2dfy/C79/JhIp@robh.at.kernel.org>
References: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 17:03:31 +0200, Krzysztof Kozlowski wrote:
> There is no need to add minItems when it is equal to maxItems.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/timer/cdns,ttc.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
