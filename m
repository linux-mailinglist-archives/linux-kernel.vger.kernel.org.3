Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40E74D0D29
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbiCHBAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiCHBAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:00:37 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAC2AE36;
        Mon,  7 Mar 2022 16:59:42 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so20159576ooa.10;
        Mon, 07 Mar 2022 16:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QpxfH7e2TQR8IJnD//5HUxcZE39rTUeMoOOPilGn61U=;
        b=YRquIIbs1vJKLvcX2N0fxD2arO02d0HXwNVGUsa0i1159/FuWxMA33XQKA0SN+dZhv
         /rRbjXcTpSE60vu5zyX7/vLoqGvetjBbRJrAfd/qfXbmR8VQrzfpRSqYB07FiUl8h+DT
         W/YskEfN6Kt+K0jJBYrqaznUXyy1cuLGTejW9snePU9TFR5WsR2QNWbFmgaOA0qUAOMB
         s1Yy75+mVMdbt03+MK6dyLXvb9lnrRQ3sSYn/NrEJA5gGya1KKBCOpGgnfSXCeHAG6IY
         o4WAbR3Yfeo7WVRpRwydZlAB2cI9P6eaZa6pkw3IIz3m0lYKqylLylmM47z71FPYixp0
         MW6w==
X-Gm-Message-State: AOAM533KjtN2EQGjipl07pI10cz6yc88tRGbk3wAxIv4RnACi52EIiTL
        j5z7TKwkU2ZFHxgQwJyzaBf0jdb0qA==
X-Google-Smtp-Source: ABdhPJxxLIyVApb2bbIkJlzE7/74k5UfQFnqrIV9ohK+cJpAbHO8Y/FgFwzR+5U/Uuj0ur5Ol3MZnA==
X-Received: by 2002:a05:6870:b303:b0:d6:f4d1:990d with SMTP id a3-20020a056870b30300b000d6f4d1990dmr943623oao.53.1646701181615;
        Mon, 07 Mar 2022 16:59:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm2799060oov.3.2022.03.07.16.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 16:59:40 -0800 (PST)
Received: (nullmailer pid 3610656 invoked by uid 1000);
        Tue, 08 Mar 2022 00:59:39 -0000
Date:   Mon, 7 Mar 2022 18:59:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: timer: exynos4210-mct: describe
 known hardware and its interrupts
Message-ID: <Yiaqe5wjKW5NkiW9@robh.at.kernel.org>
References: <20220304122424.307885-1-krzysztof.kozlowski@canonical.com>
 <20220304122424.307885-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304122424.307885-2-krzysztof.kozlowski@canonical.com>
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

On Fri, 04 Mar 2022 13:24:21 +0100, Krzysztof Kozlowski wrote:
> Most of the Samsung Exynos SoCs use almost the same Multi-Core Timer
> block, so only two compatibles were used so far (for Exynos4210 and
> Exynos4412 flavors) with Exynos4210-one being used in most of the SoCs.
> However the Exynos4210 flavor actually differs by number of interrupts.
> 
> Add new compatibles, maintaining backward compatibility with Exynos4210,
> and constraints for number of interrupts.  This allows to exactly match
> the Exynos MCT hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../timer/samsung,exynos4210-mct.yaml         | 67 ++++++++++++++++++-
>  1 file changed, 64 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
