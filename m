Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C694BAD53
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiBQXrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:47:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBQXrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:47:14 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4EF3789A0;
        Thu, 17 Feb 2022 15:46:51 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id i21so939768pfd.13;
        Thu, 17 Feb 2022 15:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xm42ne/yx6DvrOIo44WYfwHLPMbmJuqV1Ps8LARJTg0=;
        b=H+dTq15llSlKJFUTyysK8buzf1UY/R/dWEnAGV6wFiKNm+DAAiNOyh5TX2p0AQSNQO
         I5nX6mxXvKRNC90vTu0d14ESglyV+7piK1JnAz/0UKg/6WHmPB7dNcnPGBbCbRrLiYNq
         41rOAkjO3sR+4XPvvxzRqmjxR2DqwE8ds01gZHfr0SbBz5YfPcVuuv4IVoMrXaLU1Yg8
         CaHmzbUxzH9NYfRLOP9mQoqVieRaZKmZziJD0aL675J2BSGdbOS63UWZz3zUr/zy7jv0
         aawSGUebyQ1uksnzTx/y+u+aHjJrrN8jtQufrH9Yd+L55JkD8jLIXn+yQUdcQbsbKHMW
         tpHg==
X-Gm-Message-State: AOAM531kbpISpdo1nBP1WGgucm0zET+cwt13FwPDdVFqJZFBu4nUUC5e
        M90dEcN4UMW8R8/kYOtNTQGz2ctFOQ==
X-Google-Smtp-Source: ABdhPJxD8QKqedbaM8B85/N5a9Ch5XWS/O2G9CW6yZJmUpw5h1tALWl4e6jUtYAj1TZYlIJAspvzqA==
X-Received: by 2002:a05:6e02:5c8:b0:2be:186c:1684 with SMTP id l8-20020a056e0205c800b002be186c1684mr3579262ils.199.1645140852153;
        Thu, 17 Feb 2022 15:34:12 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w19sm3433302iov.16.2022.02.17.15.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:34:11 -0800 (PST)
Received: (nullmailer pid 3979773 invoked by uid 1000);
        Thu, 17 Feb 2022 23:34:09 -0000
Date:   Thu, 17 Feb 2022 17:34:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        damien.lemoal@opensource.wdc.com, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        krzysztof.kozlowski@canonical.com, linux-ide@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: convert ata/cortina,gemini-sata-bridge
 to yaml
Message-ID: <Yg7bcTWAnLJPym50@robh.at.kernel.org>
References: <20220211120157.3385145-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211120157.3385145-1-clabbe@baylibre.com>
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

On Fri, 11 Feb 2022 12:01:57 +0000, Corentin Labbe wrote:
> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Change since v1:
> - fixed cosmetic nits reported by Damien Le Moal
> Changes since v2:
> - Added blank lines between properties
> - Removed useless quotes and label
> - Re-indented description
> Change since v3:
> - removed MaxItems from syscon
> 
>  .../ata/cortina,gemini-sata-bridge.txt        |  55 ---------
>  .../ata/cortina,gemini-sata-bridge.yaml       | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> 

Applied, thanks!
