Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C9253DE6D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347927AbiFEVbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347738AbiFEVbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:31:01 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430B4D9C6;
        Sun,  5 Jun 2022 14:31:00 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id o68so9733525qkf.13;
        Sun, 05 Jun 2022 14:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jvbIlYtTimkFNkSuvwvsn7TNxlt9v4zuD1GIswaA658=;
        b=6qEHwputEV/aX/Zuk7ReSjRWfKM7TRzSEpY9LQb+fbr7KhoqVqWUiqUvPxkWVYXU/w
         mYC6rPvi4bMu4MS4PqPcpvdldZzmD9XAx7M43Q/d3e67sUe/OB0b9vRSaUR4KfLX5KJV
         THgHlPQW45aWSsJ4WMuC9XlOgZU77UqiYczqa24WtwoLicFVTfQckv6zHqilkq9dlNu4
         mqilfP05B6Xv/e41KL9bUJ85ZtiQo2hrk3xAWFs7T63gqyUH+KSwLPQAkiafJZcclU+I
         TkivlK8flJ6Go5XgMXo2H0OuKkWsfStwi9zOQYi71eJ49BlyhpUHGWqFRIc+16fyUD+r
         eaDQ==
X-Gm-Message-State: AOAM531xFMPFB8chE3U6GevHGwCnTnXQpTo3jp+c9B2U/CzLbXos3nmT
        rgnDY+WciqKOOpzYxbCQRQ==
X-Google-Smtp-Source: ABdhPJwFTjVuWXRjsufN/+qTiVsbFhiiHDYdgOwg1AeVs9k1uDLrqGyKvhs5aMXcvCtdU1pCv/ghog==
X-Received: by 2002:a37:8ac5:0:b0:6a6:a3e7:565 with SMTP id m188-20020a378ac5000000b006a6a3e70565mr8278256qkd.171.1654464659720;
        Sun, 05 Jun 2022 14:30:59 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id bc8-20020a05622a1cc800b00304bc47a690sm9026031qtb.44.2022.06.05.14.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:30:59 -0700 (PDT)
Received: (nullmailer pid 3553606 invoked by uid 1000);
        Sun, 05 Jun 2022 21:30:56 -0000
Date:   Sun, 5 Jun 2022 16:30:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: input: mtk-pmic-keys: add binding for
 MT6357 PMIC
Message-ID: <20220605213056.GA3553552-robh@kernel.org>
References: <20220531124959.202787-1-fparent@baylibre.com>
 <20220531124959.202787-3-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531124959.202787-3-fparent@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 14:49:54 +0200, Fabien Parent wrote:
> Add binding documentation for the PMIC keys on MT6357.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/input/mtk-pmic-keys.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
