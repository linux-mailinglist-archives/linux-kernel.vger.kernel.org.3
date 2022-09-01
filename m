Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADA5A98E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiIANb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiIANa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:30:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A5C4F692
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:27:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k22so17872713ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EcDrZFdluBLqgSl5y1ge/xoHolSS2B2PXo4EVlgY9h8=;
        b=j6IU/3o+B9aEmh+ikjTzDwhSeMNO1INjgkzCxiPuyNnqIi3323Gd0aOQh06w1RJhme
         5SOCFmnBfbgt2RzJClw06E4PZmEDSjfLwsu/73EngsMnRKi3bsQWqAhNY9a37Dv8sXCs
         q5MsU4p6YsaZaf+iMl0cpibYG6qHz9aFgLW448Y1l//uAm0SNXZhQivcB9QOg91KdOgZ
         Xc4Atvk5wuVfydlEhYbtt+xcfjGKLHnZNzxij+spb8O+C8LCwreg3fBXAl6xIaYB9SX0
         AZWi5JFPzIhw5PKq+kjqkHeKQ3enl+V5ogJtPLW0rVpK+4h8lw08Yw2iETEIG3T7/vZu
         yUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EcDrZFdluBLqgSl5y1ge/xoHolSS2B2PXo4EVlgY9h8=;
        b=TnMz6N2wRk7Iqp0UpBc0hw7PpoBYmZ7AMGAC2FXis+wJeTDFVoYPEyPd04CCuOzf0E
         NeOxWSB9xTGizjEj10H8MxwarM+q+S1/k5BYR1G/rAJn9vLnBfGVFGv+lDR39NHDRH8/
         T+zlES1TUWp8wprs1bqlRj+QjVMsAHeBW/KzDhALRHQ4woYqiiRsuHy4xd96ySzpJzv3
         key11OXI8dg5/BxJeulahofDUQTTP9efeE4YiycAbnQhYJHSdi3xmSyFFHjfuKjbWGtQ
         CnEPS8htpqw/303zHGlmmn2vQvtHsrjeX3NTe9VCiwXquIYQMmjHwJrEOdc1uk8uKfLd
         PBsA==
X-Gm-Message-State: ACgBeo2Aa8Hpaz3i7PV8a9IoVpvH7WtLHrdYsgKLYJp9V/hNzWiBuDDN
        fg0JnOl7MWWYTKd35a2XXh0rAw==
X-Google-Smtp-Source: AA6agR66LdtSQj0ErovOdBSUE2/wMNblh1NMSJXQ+hi1C75YSFN3XvuzmmLIIMrUbY62tKyIE7rVcQ==
X-Received: by 2002:a2e:b052:0:b0:268:87be:ebc0 with SMTP id d18-20020a2eb052000000b0026887beebc0mr2434520ljl.203.1662038826500;
        Thu, 01 Sep 2022 06:27:06 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id q14-20020ac25fce000000b00492f1b2ac0bsm2346542lfg.101.2022.09.01.06.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:27:06 -0700 (PDT)
Message-ID: <05eb3c6a-404d-1bfd-1361-cff952b68400@linaro.org>
Date:   Thu, 1 Sep 2022 16:27:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: adc: Add docs for LTC2499
Content-Language: en-US
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901121700.1325733-1-ciprian.regus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 15:16, Ciprian Regus wrote:
> Update the bindings documentation for ltc2497 to include the ltc2499.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
