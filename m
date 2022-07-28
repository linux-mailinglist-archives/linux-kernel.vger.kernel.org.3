Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368315842E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiG1PT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiG1PT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:19:26 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C9C4AD7D;
        Thu, 28 Jul 2022 08:19:25 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id k10so553695ilo.3;
        Thu, 28 Jul 2022 08:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c32VgeS+HtTYIvfXDR6CWVJsL6lzakGW425ia25EmBU=;
        b=8H8wnZ+8IQ8QyNxE/1ynEdqzyDCJjd/K6HiSyzXaFLnnUMHNBhm8DUKeTCniK4a+/m
         RQ6oO4R3zinlYhQPjKUugmonpijv6Rr9QCy8dyUhAJsQzlDQ2u6eyS2zUMZfUkSEbOv4
         B+nKrm46HZCYVMcT2RDj0JuiwiOP6X9BnSJbXE6n5gXo/70X4oEMPb2puu6YqO1+s9NY
         1PalpKJtUq8y4G4q71ZTKLlDzWKAekiZYl2NcuUnaN17kbnqpTIdYvXOch9DeQjGoagB
         stS3HUIikTkbMnFj1dFvjDZ1HBgJDEMW38ucO4b5urewbStteTthcgkDm0hEK+r0/UNA
         SgWg==
X-Gm-Message-State: AJIora/didYdZQSDlOft3qD9CL+200/Y105LrTESH/4kSd7m9fxTjuhL
        lNnrV+FMNdNiKMKyJNsTqTSSLPp8nA==
X-Google-Smtp-Source: AGRyM1t0K6U1AMwaAS3WdZ+870BTno/oW/sBtQDT/5biP0z8Ii4KyEMGD4IA/0KAseFec7UxIhPmWQ==
X-Received: by 2002:a05:6e02:1564:b0:2dd:7792:9550 with SMTP id k4-20020a056e02156400b002dd77929550mr6416595ilu.292.1659021564500;
        Thu, 28 Jul 2022 08:19:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a15-20020a056638018f00b0034142dad202sm497011jaq.31.2022.07.28.08.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:19:24 -0700 (PDT)
Received: (nullmailer pid 902859 invoked by uid 1000);
        Thu, 28 Jul 2022 15:19:23 -0000
Date:   Thu, 28 Jul 2022 09:19:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: mmc-spi-slot: drop unneeded
 spi-max-frequency
Message-ID: <20220728151923.GA902761-robh@kernel.org>
References: <20220727164202.385531-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164202.385531-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:42:02 +0200, Krzysztof Kozlowski wrote:
> spi-max-frequency comes from spi-peripheral-props.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
