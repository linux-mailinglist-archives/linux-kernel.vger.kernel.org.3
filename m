Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60DE573270
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiGMJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiGMJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:28:22 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B057F2E27
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:28:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u15so1883493lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=geaCj81ycceeJeyXEXcktsHsVE7AX6bBBwQNAJ0pr/A=;
        b=S9UUOPTrazzxnheUfpX3I67Pd3ngtwGlwrZqkw4oH5mr1bKsYmCavkQel245szv62F
         s4arzlvdOfTd1dbMTCq83Gkjozr6T/gW6c0Bw5IlktPUIaZ7rI1iPokcIVeMXPtWiwIR
         VmTAC+OAIG/RcV9mR2slJm3AIYbKkL/ZsBD71sNqogZsTllb67OPGdJuu2OGH92Omn80
         koRg5l6IlJB15f5Sr9jDO6nbOgMlNZnzMBTC/InVB3RLWD657uZgiQUPbTUIfRZMZVpu
         BbOdV+n0fXDsbdzy89aVce+EJ6IdssfNbrzuK0kDY5q0+Jyzgap+HKZ9CnKNT2BVVstG
         091w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=geaCj81ycceeJeyXEXcktsHsVE7AX6bBBwQNAJ0pr/A=;
        b=sQGbrhPREdb88xo544JtlIpQRIezP8DpXj5eZgDyFklQ+XgolxA8MSb63hQUsUnmFI
         FtCGui3AiMqI5aJZvYhsl44dCEOZWSnHw3nRw7YihrjIqT17iJtFYBf/iiMFAM00X7EZ
         yZ4DE/6xo7LjNHOUGwbXNWaNd8mZYCq1n3rADmPU3x0QHv8Ld+Z4uTIelgHuAi/glx6o
         PJokTxMoD9Cxtjt0DC9oLnunXjO1pZbEUS2FKsfSESwp1yLGJMcKBpt3pHsyDbeFrd+I
         2vsB0vFMzyiiWhgBzwq2OPBcuUPiL/Xyq8vj/NidDoDE3PtbqE5rvpc0PoCSVibhNXRj
         GboQ==
X-Gm-Message-State: AJIora+s5bdnygGr4n0gbfpZlZMxkYXja9OyiFFtAQWYjfAgYJcFb32z
        ipD//s9hCJXP82JTuvr3VOJASQ==
X-Google-Smtp-Source: AGRyM1stmOMnrs7WjrVZAWSyI7MmKoT76g3H1/dYirwNw8pzpVrkFiBFzsSgP1oFmVuQx70bMEdPPw==
X-Received: by 2002:a2e:a9a6:0:b0:25d:6062:91af with SMTP id x38-20020a2ea9a6000000b0025d606291afmr1187100ljq.144.1657704499441;
        Wed, 13 Jul 2022 02:28:19 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id l26-20020a2e909a000000b0025d4d4b4edbsm2990436ljg.34.2022.07.13.02.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:28:18 -0700 (PDT)
Message-ID: <f9e1ad3b-d6ed-7392-2fd9-ca6ff0417b16@linaro.org>
Date:   Wed, 13 Jul 2022 11:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v18 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220713084139.2810115-1-xji@analogixsemi.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713084139.2810115-1-xji@analogixsemi.com>
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

On 13/07/2022 10:41, Xin Ji wrote:
> Add analogix PD chip anx7411 device binding
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> 
> ---
> v17 -> v18 : Change node name from "usb_typec" to "typec"

Node name was anx7411, not usb_typec. What are you changing here? The label?

Best regards,
Krzysztof
