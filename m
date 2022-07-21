Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530EC57D19D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiGUQeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGUQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:33:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6889AA2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:33:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u13so3637988lfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0wZNg+3wPANTd0lRPHXLuv+xpAninwLRTERLUu9/iV0=;
        b=VqMex1M6FRxuAjOX5PnC/HKTSGZJlg9F3Xl1Th8veis9ZwLc8vDjULvKc5W7mKvdei
         UyrqTs0MSVXnYDpTkaQCjk6dltKKxb6E2AF6xC+d5WuPbwawbs0EBXOxhCHwO0IlvNvj
         Lg5NQUECCQiifIcnY8aAspgN4O2OZEyflkzfZVOQP4vKZGU3InFxkg//fNB6eRZaqlHq
         47czCUSM+Jwy36BP2/ikS4zshHQLPrXSTsEittrTRMFEdvUs6wPCpSC2H2UEyT38Zx/k
         LE7UBa+JvuYxgC4J04LfAt9mBh9YwO6MgSHmEHRmbuekLhdo38DM3YVXtXJkCJ4BYhpz
         ertQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0wZNg+3wPANTd0lRPHXLuv+xpAninwLRTERLUu9/iV0=;
        b=u66oViEPLUQmHdeQjULrMtyPEx+exOsIOZgKGo942+/VaxsPD2Q+h71XV6OwN8p5iL
         swXgqOKdR+FoLU7kDY4bJmrNaTAo1J709E5TYHBtL7pN10/uzvtD+WzxQq7LHCReltnY
         hpyj8NTvyJS4MxxJROxyQ3PfR3x9op2QwKq38FeWGqkibk69xBz0kkAlUFI2bubF+ncA
         fT0QkiKv6wgxoyd2yJYerl4ZTX6xdWFBd15yRwCkTqdJNCRRxuNOaKbQ7YxtB+ICuoOj
         4omAfP6l/3y5luvAmNXYEskLE9txzB2NEDFskS9wlPhIM4GXgqDkIsblSMVvG5IkNbaH
         shhQ==
X-Gm-Message-State: AJIora+WmW4wTM9chWJHdYvVDxl+N0Ci/OEeE5IYmcXIqiyBgsIQOTcJ
        V8S4mlLqYsxu5cZtEnfIz+tK+w==
X-Google-Smtp-Source: AGRyM1suwpWeDcSxhta8Meu7xyqrPbrBgRqfzDYdr1Ot0b9fitq1x465Kq3zXTHaFYc9Em7plvJk4Q==
X-Received: by 2002:a05:6512:6d4:b0:48a:2aaf:1d93 with SMTP id u20-20020a05651206d400b0048a2aaf1d93mr15556923lff.457.1658421235985;
        Thu, 21 Jul 2022 09:33:55 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id t14-20020a056512208e00b00488bef659d2sm526769lfr.234.2022.07.21.09.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:33:55 -0700 (PDT)
Message-ID: <05ad5e68-7ff2-b1b5-fa49-0e48c7cc313f@linaro.org>
Date:   Thu, 21 Jul 2022 18:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM
 and SM2-MB-EP1 Carrier
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721101050.2362811-1-martyn.welch@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721101050.2362811-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 12:10, Martyn Welch wrote:
> Add DT compatible strings for a combination of the 14N0600E variant of
> the Avnet (MSC branded) SM2S-IMX8PLUS SoM on it's own and in combination
> with the SM2-MB-EP1 carrier board.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
