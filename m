Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F0255EF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiF1UZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiF1UYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:24:47 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16361E8B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:22:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31bf327d4b5so39504877b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soRYWtsPJuPgBzgOfiqcgq8BhmfYCuH0eXHHZJEWVAM=;
        b=j9BI7gp7y1yuGAEAYZQStxRnAob1tpvxFeSDkSnmrNlbTwJSmgUIl3fnciJfrbckqk
         D5cvKn1H2wpz12SEOsSc9+zmLFQ+NMJUnl88UY/RcX6lzY85fPYGRi89xS4Mimgrf1Sn
         h9YEc4m3Kjwqme/SeaRjDL9gpzHH4Pse4OmQoSaI6VXH1FUaJleQ8zTPNtBu/BZXiIDV
         MMTbOUxxQB9WE9AQmJg+c9EVDFao8+NVG0P0VYTG/AhrmaYC0b3e96yL5URneROsPGbO
         jV1kxin28RlbQshCTGOd2WuH9wF6TOnFs0/8UgJS0uz6QdNIJO/SJ2Sy0auCelmeRUna
         KEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soRYWtsPJuPgBzgOfiqcgq8BhmfYCuH0eXHHZJEWVAM=;
        b=VRg9NcmWUdew+yTOZbGo00iUOZc1hjZNJ30wHYhytaZ3yEhNaoK0ixYxH1CHEP4re0
         Hqn4brkPZmGNND7caY1g/6y8er8q4iISPyalwpWVxfW/HO7F0xMxw+UG0aDWQqJV1E1Z
         bGCqfjkTvaP3b8tZDnOXFvLe1Thgp0P7kSKE/gD1dJ2gtKHQsRLkDfcIq9WQxhdO8WQb
         BtdFYgPuJ8uutSByu9UtjntSsQTqxiHcVggQXnPiVibFcvbjk0b/aLG88qTKtOC+uRR9
         CnCRQsQHLShhfXu3IhpTAn+iwus8yTZ5svffowcD52VBkQiI+bzPieUwlJGtQ/+F6oSH
         Fpfg==
X-Gm-Message-State: AJIora+yDoLSa4YsPTalmM5cxSXu6xzNi0x4mBRcmXcKzLIvpBF39ihQ
        k44n5n8xPkNNbYi/7Vt4Isb9TR+rM0ZgmnswlY0erQ==
X-Google-Smtp-Source: AGRyM1tJUNZB01tRem3hFP43pssManUrJJQ/Uz/2Tk+U4lLvxJtyyxmRl/qMxGkw8ksXLo9a6CEpUAR3gTFGskb21IM=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr24231841ywe.126.1656447733193; Tue, 28
 Jun 2022 13:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220610204057.2203419-1-robh@kernel.org>
In-Reply-To: <20220610204057.2203419-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 22:22:01 +0200
Message-ID: <CACRpkdZBozy5Z3UjQcAfiuDyuA-OESfmhWZ_YNv8Y5ZVLGqG5A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: arm/fvp-base-revc: Remove 'panel-dpi' compatible
To:     Rob Herring <robh@kernel.org>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
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

On Fri, Jun 10, 2022 at 10:41 PM Rob Herring <robh@kernel.org> wrote:

> The rtsm-display panel timing node was removed in commit 928faf5e3e8d
> ("arm64: dts: fvp: Remove panel timings"). Without the node, 'panel-dpi'
> is not needed either.
>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
