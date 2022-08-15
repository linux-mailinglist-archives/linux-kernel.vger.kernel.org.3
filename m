Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB035936C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244310AbiHOSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiHOSs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:48:28 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3F42AE6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:41 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id c185so9418100oia.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xr6JHD6AFlrXJM6hu6thcV+Az5D3BSvwhjamyNOLK2U=;
        b=ZL6j2aZKnPT9BzOcJXtmGblq+Cr4dfi/Nv9LSagWsbWX1e4NdbYHodjiedJL70lrR9
         IQQap1hMa3NR0CwTrdB1Wf42NhJ/kfhJcATdkjdgjcruyhjVBaHrXyaNcQppJ1Li2kQb
         JE0ye0LdvPw69kByyeqX4ASHgTEnred0IXglQPommePBsHtGhcL4e2s8ro5YPmvxmN3/
         D2V9b+2BA4s5wGQyfKgceRV9sjm3k9MBN1lWTI/q4jk3HNlYxsmutp55rRKkPa51qQ/0
         Uu5yMgpCmDioN8eDLnwDa4mRm5ld+CdNaYNUkjSdAKj2mBs4dEaBNx6p8Akae0KHGEY7
         kgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xr6JHD6AFlrXJM6hu6thcV+Az5D3BSvwhjamyNOLK2U=;
        b=A2QWZ/rALA1BVa7mdNRopBeR/ynrPI8w2Yflv1vIa/kaesVK9U0HgvbLY5ZkCZ+/Xp
         TQq1PITy8ZjROQq3XpKde8+U5Hq/DlH88fRnViZSXjClKWNhXkrqmUPGTmBqbekkIYc5
         +SGW27e+y6tmZdtxbfI6m17gaVh1nhjPfff0tBOTNLiP52LDPhL4F6HvuJ84r2NiKK7w
         JSRvbqvpCbii324YOKNInIrIgJtTt92GFE/4cb8zOxFpnyNZD6l2ikpVBMcGPOPYALxp
         iLH6COn3CbzuiWlDS3t6rv30m9W0dsuY7soaywxhY4RF3c3kUXSMRhXXhiusvwujOjmH
         U7Xw==
X-Gm-Message-State: ACgBeo0TAIN4EN/0935NfFJ9hSQvZipMij04yZTH19kZPpkBEQwuPFT8
        pNqkpl68eMaEVO4kGjfCQ56tqHVmz+j5tmH6It5A9g==
X-Google-Smtp-Source: AA6agR4v3x1WhnxjKeasF3bXPDPg2zd7s5kes2dQkr2E98b6hUIgSzGyPCj88i2ddzks+sDf7pzB6zRpG9Hi7SrPdxs=
X-Received: by 2002:a05:6808:1c06:b0:33a:9b3b:b3ce with SMTP id
 ch6-20020a0568081c0600b0033a9b3bb3cemr7429087oib.53.1660588120827; Mon, 15
 Aug 2022 11:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220727164202.385531-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727164202.385531-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:27:58 +0200
Message-ID: <CAPDyKFoDNkLk_FLuYRSdGVmCK809v8m_R_tLbgTTRP5tfaz08A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: mmc-spi-slot: drop unneeded spi-max-frequency
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 at 18:42, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> spi-max-frequency comes from spi-peripheral-props.yaml.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> index c45b91099325..c0662ce9946d 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> @@ -23,8 +23,6 @@ properties:
>    reg:
>      maxItems: 1
>
> -  spi-max-frequency: true
> -
>    interrupts:
>      maxItems: 1
>
> --
> 2.34.1
>
