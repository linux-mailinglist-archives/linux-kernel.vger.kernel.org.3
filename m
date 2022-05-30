Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384285374FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiE3GgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiE3GgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:36:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3625A5A8
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:36:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h19so4079835edj.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5bd1zwKRQTw/2MjiuPSE5DqQLCXMdl35GogRqqM/QtM=;
        b=wVlhwLoaWUsouT9vMx/mCqe/7TZKl8tamH79+YO4YuwFM5hc1LdMGx8OBwDpTwWOws
         AXZwiXsGSVAIQUIUhMUMBggCGcC8IBXI1+aX48+F1lxgVfwn1O9MhIQbIJ0ukAtCJGxw
         /5Z8oeQQR284eD7TUdj42jevAzWBeM/jQ78UGvw4yrQq9WluUTe1aYr2SGtLzlAt7toU
         WAQxUgfq3phYEgrTqaKpBTVcGsz6+DtfBh4wkVEymLk4pFnjhPdb68quRuUQi0ct39S2
         YNO1/fyEWx8k0ryTPMsn77qMeH1B4+XYpQazC4XwgHzMB4BsrlvlC1nz2ut3LjABPS06
         YNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5bd1zwKRQTw/2MjiuPSE5DqQLCXMdl35GogRqqM/QtM=;
        b=0znla+kaUFw0NDXXrx7hrQeEtzaaIGPNxX+CWWanefsgYEnKoR2A4uXG/xc1HkCT4q
         6NbWGRmTDzXylvOg3dV3DQjZPvixlPk08RtWXcFSAsZT0HPhOV0vkBaxjwvAOTnzMtLV
         6uJmCjEUjy09xTE1fKCnoVjXMFpYUF+zbO7fcbrIk1uKit2ZUk+ak741LmwkiqRbHLi0
         36jRC1o4yJTOUuDOZXYIZN2lt5bqCFXzKbjTinue+Ybem/n1CdDGzP4Jme7QIGi5MBrV
         L6ZIHmAZpNUnO+Iy8vHiGFzz9EETwq5r+Es6kC6ndg8W7YUQPMGO3SBf1nJPfXXCP9LK
         2qbw==
X-Gm-Message-State: AOAM530ImHholBarT9GpzyVVNgwdYpvTXOmo91h93PQy2VJlMtGkmWma
        J03CEZ566xdyRsIWwdRi8Np3Ew==
X-Google-Smtp-Source: ABdhPJyja4KRmwbKmKLPAb7nAmnDug+V58kJEX9P4Yro5qWo7ELR6+8slML/nbk//NNQv+itfYT2xg==
X-Received: by 2002:aa7:cacb:0:b0:428:b435:dc43 with SMTP id l11-20020aa7cacb000000b00428b435dc43mr55583300edt.123.1653892566393;
        Sun, 29 May 2022 23:36:06 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b23-20020a1709065e5700b006fe9ba21333sm3668636eju.113.2022.05.29.23.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 23:36:05 -0700 (PDT)
Message-ID: <0a5f8b4e-87d1-cd77-3e7b-38e56d6a7e12@linaro.org>
Date:   Mon, 30 May 2022 08:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: intel: socfpga_agilex: use defined GIC
 interrupt type for ECC
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com, Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220530061212.1682439-1-niravkumar.l.rabara@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220530061212.1682439-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 08:12, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Use defined GIC interrupt type instead of hard-coded numbers for ECC

What is an ECC in the context of commit log? Please also add full-stop.

The code looks good, so with some explanation of ECC:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Best regards,
Krzysztof
