Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EE54F1880
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378616AbiDDPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378605AbiDDPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:35:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B8E1EAE0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:33:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g24so13389545lja.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BaM8mE0ADfMYlXtw7vleG40fbepoqGgL/4MX4webNM=;
        b=ksDgHMx2Bwif416kkxyTK83wbuEWqRC/SQPlHJuG9GB8hDgBz44MZMx/1HGX678eDC
         2wnh9ws+cUzeMzUdTaIyPQtYnoElHOckaTUs5tcDi/avbQ1x6JIoh4RvUzQOcbefBFYP
         POlWTz3c4d6YS1O0FNwvfPTZvfop8awZKXrfXMrZX16BNQ0qSZfcr86eDyI6BKWogCZ3
         DmyA08M1g8ZGRvb+ZjxFdcrjs7y9CNRW1GUgHQ5pk94DWguaGetZDh3W5V1yB6beKXIi
         u8vgw/L+145ltC71pdu+f2k4braelrsCFxwLBBG0l4ADlpwbtqqXFl4MDxcnX79WDnYY
         0xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BaM8mE0ADfMYlXtw7vleG40fbepoqGgL/4MX4webNM=;
        b=a+BwGT13IX/6/pMzE1zwA+bId+ln2GVyuUU/f6HpcJ2qYMAVZz2zVmF7iAQaRn/hQR
         amu9VLOkvFFbL2K4r2r/aVPlJ/KZPqWXRw/M1kKTH7z3k9TkJIi/pFkomnC9cICmLHjQ
         pKW5Zb74jVWnzAq7jAhxQEa/UScs3g6W3UVkEx/JTqNjLXqvpt9ZXPb0F2O3lKjMSLt1
         OXKRuR+cYwWhsg5ZPdEL8bDfMDo+SydEuxzuqxnGt0FAeDDHaHWdqs8YgEtFyevhgdwV
         jXI3LNWtlwXM/rF2Kc6ghlRCGELmPiPJJjqgZ2Vxuc6sFr2bEATQuJV2IPP9aHcup49A
         SegQ==
X-Gm-Message-State: AOAM530gcYmyq+o+pWh6e6l1CRlptuuSvAzlTk/mC7d35mG8pk3fsS+o
        a5d+tv1N+Xh3oAYLAmQw1EABaG8VyeK30kaPQ8TIGw==
X-Google-Smtp-Source: ABdhPJyJFY5IsdzIsRzag1xsA1I+Oi7D6rt+gN+XZTY4yAeNA4Wv9+v4zOmYqngowRK8wWY2VLqvd6/DtzNfEQUcpQo=
X-Received: by 2002:a2e:a268:0:b0:24b:1296:a1ab with SMTP id
 k8-20020a2ea268000000b0024b1296a1abmr89360ljm.169.1649086427030; Mon, 04 Apr
 2022 08:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220324134106.103588-1-krzk@kernel.org> <YkZFgGNRPUqJIY6x@robh.at.kernel.org>
In-Reply-To: <YkZFgGNRPUqJIY6x@robh.at.kernel.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 4 Apr 2022 18:33:35 +0300
Message-ID: <CAPLW+4k4RwOcUiKZU05nb7tcpM2MTxdJ_m=8byyGvHdJbHRbRw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: samsung: usi: refer to dtschema for SPI
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Fri, 1 Apr 2022 at 03:21, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 24 Mar 2022 14:41:06 +0100, Krzysztof Kozlowski wrote:
> > After adding DT schema for Samsung SPI controller, the Samsung USI
> > bindings can reference it directly for proper schema validation.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> >  Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>
