Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF4658C60F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbiHHKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242095AbiHHKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:06:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46C8E0DD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:06:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f20so11894089lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xExDiNzjvGBll5feAm0Ok3SGRkY16fJNcNgVa/ZsGBE=;
        b=hhvSJv0hFGZXDYIQFwSL6k+5gXSL/X8a3LGryvzm+aOX1Xf4Qk7/+IqJDC0vJo/6gh
         OsrKkZOWoU/yq/DDMqPRabVVaEHdxX2W4dULe7nPW4FLVjzlEaAKCxnw+iDSzZtMQQjo
         QwtA+JluOjck1UM72qaTjxoFHwmU1Ic1NE9IaT5Cb5X5JBf1knRnyrrsVliurueMDtxl
         roZ50yyhmbZgRd9fLAPaJeS4AYkDfeihvWk8KFShGqBnLcVcUtDDCAhJT6U1kfnr4CmG
         DOpQyRPPwXi8d+puo2X+Ju64R96Aj6AgAM+lD0fz0rwmTP2+OKEgAAJZ7EiAnhiRO5BQ
         zAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xExDiNzjvGBll5feAm0Ok3SGRkY16fJNcNgVa/ZsGBE=;
        b=e7YgWtf4L/erMssplBzFMsFIHVZ5GZAkvYSXzsyNvPDVKdIZN9B4EZEFyty7gks0C2
         23p0yp+sQhXIPSNFHiU1tFw/rcXKUSWbyYDf+3eZCNKYk3y5gczAsGkqMiuWjfO4ppF9
         A46N1dUcI6wU1P+qh5IpJDnziji4tohBCMcKYYVL6F+LZ+C4eRIWpFgKrz8/RNsvJRfv
         5wNUzeZFeNN/En/Pifddj6TiA8BL9QKZQ+zj12jd6v1ixR96JIxseJjGok0H2oAqilC7
         /KDon27DQ/b7cJgSiBaBIdgQ92ElJMgdRiHAdX93pxdS5932XhD9T2suKY7Ig8+dI5ER
         KxAQ==
X-Gm-Message-State: ACgBeo2j48epkVM5zWD4vPpdTVGoqfxi0/LZsL/+GW9oE3wDFALnBa+i
        FTRx1OiggusTP9Bvrt7JlugbNA==
X-Google-Smtp-Source: AA6agR5fLlNwKp8whdVpURNPNlgo8OWPv5TAZJXCGxqyKVy70/MO2RmEgEc4QGjHblI45uK0wtoqYA==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id y14-20020a0565123f0e00b0048a5edd99b2mr5803617lfa.124.1659953186052;
        Mon, 08 Aug 2022 03:06:26 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512202b00b0048ce0a62226sm482724lfs.137.2022.08.08.03.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 03:06:25 -0700 (PDT)
Message-ID: <471c8c75-5658-ff08-1c79-4b8f1f76f289@linaro.org>
Date:   Mon, 8 Aug 2022 13:06:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 22/28] mfd: max77686: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-23-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220807145247.46107-23-paul@crapouillou.net>
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

On 07/08/2022 17:52, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
> to handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
> 
> The advantage is then that these functions are now always compiled
> independently of any Kconfig option, and thanks to that bugs and
> regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

With dropped Bartlomiej:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
