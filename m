Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889DD52FD75
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353762AbiEUOr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiEUOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:47:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A021A4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:47:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v9so3199555lja.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GA9mH3WMjJ81/KtiwkTGrl8ViPGWKsxe+KmmYU4d55c=;
        b=iI3a2SiDH/iSRcCbU5DZSdvnCE4aXHkpw1R4259OfFl83UOz43+MiiVxfX79FXB5S+
         ZV3jeFVLIQSuOacpFTWb/Te+pfqkBIjmgYj1sQ2qWHsvW6aSxvTO/YHoYor1dw5GbWSP
         7SwZ2KZ7da6fBn4j1aRYntoulkLXuPD5aGDVDDLqyz38EZqW5OqfU+a6QnN/AsLd0bcD
         brhRxS8y7n7KcoAAqEzuvRteyqJc+KXY4o/Ch6s0ZwvZHgjeXM/ORd2vwI6CjY310C0F
         YosbvJcblorpPS0UDGUxXE0okaILSYgcKnnF7fhmYMo+WfCKl1vFV6Z16xczqFLEPlI8
         BMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GA9mH3WMjJ81/KtiwkTGrl8ViPGWKsxe+KmmYU4d55c=;
        b=52yUeMcicuspcZt0PL9bkFQUs4bBj1iREWZJ4LVJhGfW9iJBheBwcVkwZk8YT7APpe
         WFzCl5Jg1w/N+8SC+2q6mpH3OjRFj6BvLW5ZM3420Eyy7aG8rwhcuLJMcWdWEA5UD8MX
         SAUDj1Npnh7qLg90gCZZBGu6qZ5bDclUq9CCd6oN6Z1l7XNQlVc1KuXcO3jnwF5DJEwL
         oGhsLgwEcW1XSXKrZM0ZL83HZ/NAZMyudQGxjYVImQdS0cztaVLlcne8AWYtkzNC/Par
         sJLVcK4dgduDkpuTNfHjNWei8UL1E5Q7h07Y4sKNqPUGbTyI6Et1xymlTpCRrt/yPQZ0
         Vb0g==
X-Gm-Message-State: AOAM533Hxwmy0z0TEkAzApoHde6U3LfyV4EdGPKuiBwgO4JZyB2TQvZI
        LEwsOQ62Mntb84K9mrmHFKKzZ8+8rcTHLuBw
X-Google-Smtp-Source: ABdhPJxKxT0rGNcjo687Mv1XSend6B1Z3ulp/F5QTfbTr9XxXWmKcdIUtY6i5aFwu8TEVOY6WHQ1eg==
X-Received: by 2002:a2e:b60a:0:b0:253:d4a0:7b31 with SMTP id r10-20020a2eb60a000000b00253d4a07b31mr7400184ljn.20.1653144442583;
        Sat, 21 May 2022 07:47:22 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h20-20020a197014000000b0047855972515sm609253lfc.72.2022.05.21.07.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:47:22 -0700 (PDT)
Message-ID: <f82571e7-566e-6d72-415b-deb73187d1cf@linaro.org>
Date:   Sat, 21 May 2022 16:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] dt-bindings: arm: Convert CoreSight CPU debug to DT
 schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220520214416.302127-1-robh@kernel.org>
 <20220520214416.302127-3-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520214416.302127-3-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 23:44, Rob Herring wrote:
> Convert the CoreSight CPU debug binding to DT schema format.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
