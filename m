Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD98E58F7DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiHKGqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiHKGqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:46:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE91AF26
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:46:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq11so24341227lfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Ze5ZL6mhZA/038hc0sNqOpFFP77DQHoANtqwTyyYtwo=;
        b=RY/pf8JiaZcQkcC+P2qhQc18MJw/HJn+xkkoDUToY9iW1xgqkbfMZGFlUormKUpqrK
         fySHe77hclKqS7plk8bEuO2w5dMq+nzVrXi2vkwToJ7nNjC/wTsQxXWnwwo7q/2zjtLY
         K/QCdeHkzzzVl4KNzUENfRuvntkgrjAYNyyZ9GgQe1zFXzf3gL4Q6VhrH4KRMwq3dBZ6
         K1axPKKBY6Dtruxw0COScRdQIVkOfxsIZjoQSKBVqWpMBqpuknzewebRrT6+POoysB1d
         dk0fYROZ0+Yblz8e7/Qeqq7TIVMdCALvJ4P2o6LsOyqWFIub1sKb1uBPJJ6orVJlazed
         krYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ze5ZL6mhZA/038hc0sNqOpFFP77DQHoANtqwTyyYtwo=;
        b=5CxMd3He3srXtYTp+/FR4QUl1uoYr7/6zLWJloEl2zYwyZm3uWsKngixOskcLXeP4W
         vsIfZ/34aplLNMwzW8YhOMUNicvNOjyJbVahQO1HQp7MvSyXUaLjnk/jTK61QiAUYIC6
         46+UX1KFNgSznQGMcp0cjas7iaNDnAj028qkiFdkf6XJcwPyjKpqdO91X+1Ume0pTtyb
         IfJDcMDJGb4LO6k8klVBKVKgegq/hZqupdb3aurfmCOfhg7RXNrW7+lAWPNclC0tStyb
         CGm6PXxjx5xI4Fxs2ZcUSdGwnPDlZQlpLCuPptSECs4ptiBcm+m6cM3yJuqR728eGDN1
         1RAA==
X-Gm-Message-State: ACgBeo2hWUSC98/h9wVpB3oLT4MDF9/cMeGNt6NGfHVwXOLztfM4LgDJ
        ZNGHWErx4K4uv6TgR95LSQNQhw==
X-Google-Smtp-Source: AA6agR7URPCr/SYdpLGcqmjqS9vKnv4ta1Zr4nypW+uAe3yWDyfZdPtxX9/38lQaUQqi5eAYJnh4eg==
X-Received: by 2002:a05:6512:688:b0:48b:967a:8266 with SMTP id t8-20020a056512068800b0048b967a8266mr8002229lfe.243.1660200407731;
        Wed, 10 Aug 2022 23:46:47 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id j24-20020ac253b8000000b0048b28acab8csm600703lfh.64.2022.08.10.23.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 23:46:47 -0700 (PDT)
Message-ID: <f6fb0920-facf-05b0-9901-e23df71d3175@linaro.org>
Date:   Thu, 11 Aug 2022 09:46:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] dt-bindings: arm,versatile-sysreg: Convert to DT
 schema format
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220810160341.51995-1-robh@kernel.org>
 <20220810160341.51995-3-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810160341.51995-3-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 19:03, Rob Herring wrote:
> Convert the arm,versatile-sysreg binding to DT schema format.
> 
> The original binding was missing 'simple-mfd' and a 'panel' sub node which
> the only user (versatile-ab.dts) of this binding has.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
