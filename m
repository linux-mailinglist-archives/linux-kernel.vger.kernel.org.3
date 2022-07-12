Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889957135F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiGLHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiGLHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:46:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11D79C250
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:46:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so12533092lfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K+qrrxi4dkURwN7nWkg2ioROd7vEK8RUbZ8lLUmbysg=;
        b=jD5Z8VOVRj2JXep1DExsbhzTSXczYIuc0MUciIJ6SJapv+g+WfnBLdoTgkBa2yRFFf
         GnmDPQhUfTLvwzZxK+O8QBdB7bZ5N6VyGT498WhH7Be0NoUuCF2hHlM6Q4B51CcfeaIO
         iQrZb4WvroGCWDLpLuB+MIol/hxhgvYkzIP03QM/nyQNhwJxwn0a6oRqsJq9haIIR7Q+
         qj1bExzhDmibpHS2NhAy8/XqCg6Zn7s8FrvoT1Gh2Af1VLBACSbsKcDPFkPzAZgrCVW4
         p7z1nkzw5w2cHGvSv1T5BIIMDkeAAU2e19vfLJDGUYFxZniaZMQnnGzE3pw2sfv3lgLB
         kcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K+qrrxi4dkURwN7nWkg2ioROd7vEK8RUbZ8lLUmbysg=;
        b=GIUjVU5qioNU7Lmy6dVr+lKjy7t4sIMix3nLmBEi42zJ0kB16SDmqCPWB6LT/XZ4Cr
         JFmGzTymbkZjFv4Zh+nzYDzJ6DMDiM41FanWWJmY6INrnimexgmhdBKiW0nU4c+3/AOE
         QEfmFml9Op07JxkSR/MInyV7zBDjKAfTsuIK4a5b+I7739uPZkscnoM9M59OG4kccxiC
         Z/gVMifhFhGWF5ibb1rY+ORvuEEUJxkrQzrZQbqtgYZoqWlM0FDfGvaPJevNB6QdqlB3
         Jf0VAOWxOoBaKDSM3G0VHrrhA7+1qHIokNN2a7Mihf96p2df5RcyKvOYNREoh+9uBqUR
         xagQ==
X-Gm-Message-State: AJIora+BbGWpAv9h3RAD2MhwrKF06ERIQuLlHPtNUrHEt9wvS6zf3GPB
        aJl4bNJnwHdz3fLCWk6ws937kg==
X-Google-Smtp-Source: AGRyM1v8ThQlONj2IPNP3GVCkFsL3an3UWD4qkCdF3xhLCUexDpV2s8MI3+PSLUYlD0BGgMEMkHMgA==
X-Received: by 2002:ac2:483a:0:b0:489:c606:4711 with SMTP id 26-20020ac2483a000000b00489c6064711mr12099923lft.288.1657611968367;
        Tue, 12 Jul 2022 00:46:08 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id m2-20020a05651202e200b0047255d211b2sm2022523lfq.225.2022.07.12.00.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:46:07 -0700 (PDT)
Message-ID: <8e2e3867-96bc-df45-0319-d544e8b726f3@linaro.org>
Date:   Tue, 12 Jul 2022 09:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 2/3] dt-bindings: arm64: bcm4908: remove binding
 document
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-3-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712021144.7068-3-william.zhang@broadcom.com>
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

On 12/07/2022 04:11, William Zhang wrote:
> bcm4908 binding document are now merged into bcmbca.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

This must be squashed with previous one.

Best regards,
Krzysztof
