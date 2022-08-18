Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B18F598685
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbiHROyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343762AbiHROyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:54:02 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E178C5141D;
        Thu, 18 Aug 2022 07:54:00 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id a15so1277692qko.4;
        Thu, 18 Aug 2022 07:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ujz55jYASFaRdU5V+twrZMuHIGV8g4Xw0JRJRhCAhLU=;
        b=gjO6Dw8iXIjWqVYRn73fFSH/OiKXJJgl+NRD+8htxfIBjcZO8sfAurdYrYP3jtjfCl
         1JcCEPwadoee3zXOMaFlT54FdksiH0k6pSky/AUR1I7oyKJR0VmmGZyyQlFfcsmPLNXg
         TxUEg0LGDIHPq47U73wpNrAwK8EbAVodHacPpmCex66Jc6MsZDAkZc3nVxxS3Hu5NvwF
         UYqc3okYRinqfmvknGsY1OL2vAGm8StnLfHQBa9G0IsU2bstikyoBo+dAALhlRtgaVp7
         FrSdzTbESjsc//gcxpHcVWb9I3QBoN6aZLfD18N971mDR29YW2WHQX4z1AxYGrGYhrgX
         QBNQ==
X-Gm-Message-State: ACgBeo3VeqnjtoOg9ZKb9YCJ+jPB2K1k+RlLk79ACY/l3xYfaSNhDT//
        PcOoRHsi8m41QJfpkWp7aA==
X-Google-Smtp-Source: AA6agR4e9h+VuCyYkQ1w18AsaIub6RkSazdsaz532acBvTNpJ4U/JOitUhAqYe6NsVwsxf3NJM4VcQ==
X-Received: by 2002:a05:620a:444b:b0:6bb:238a:2454 with SMTP id w11-20020a05620a444b00b006bb238a2454mr2337290qkp.183.1660834439973;
        Thu, 18 Aug 2022 07:53:59 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.155.115])
        by smtp.gmail.com with ESMTPSA id u7-20020a37ab07000000b006b9bf03d9c6sm1501214qke.104.2022.08.18.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:53:59 -0700 (PDT)
Received: (nullmailer pid 1852432 invoked by uid 1000);
        Thu, 18 Aug 2022 14:53:50 -0000
Date:   Thu, 18 Aug 2022 08:53:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: Drop Tomislav Denis
Message-ID: <20220818145350.GE1829017-robh@kernel.org>
References: <20220816125401.70317-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816125401.70317-1-krzysztof.kozlowski@linaro.org>
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

On Tue, Aug 16, 2022 at 03:53:59PM +0300, Krzysztof Kozlowski wrote:
> Emails to Tomislav Denis bounce ("550 5.1.1 User Unknown").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml     | 2 +-
>  Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
