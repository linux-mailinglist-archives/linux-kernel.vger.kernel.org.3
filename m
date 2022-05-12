Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10A052470B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351050AbiELHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347271AbiELHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:33:08 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563437016;
        Thu, 12 May 2022 00:33:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h186so1212038pgc.3;
        Thu, 12 May 2022 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yplM/Zeq0pEKF0U56fS8NRc7S0PAi8U3tlHusHHziow=;
        b=BjS1pP17h9/VkM+P3SCwK4Q0gK0VlPq4dk+mL5DNDlg7eS0+LcZ5CRsJfjvawZOx6p
         Oo+emYdFmuNnltVV/UT6s3y9vDQP0PGD4Gd43zSo3XWp/NVt9e50UOjzs4TpB1LnWDMJ
         1dmGy/wzYwrY9yAYxLERlo1HxmYwCDNtaCKV+NMp3DcPrXZ+UQY7efE4YXsCnixvNGyS
         GLxtnxJatwkb8fULHnsapr1FYnGp85jN3yeLr4iGAExenosLs0tg+I71BFj1B3AEG3/d
         NVI/Sxe/nbfCKXN3/6AKZE/iaQQh0KpjXgMh5N/0DlLBK/LHPgoad77mvMNHI4KL6vLc
         7QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yplM/Zeq0pEKF0U56fS8NRc7S0PAi8U3tlHusHHziow=;
        b=2TV3jBnwlnZZtboAwTevTidZmtEE1qsL/GwISHQlC1wJO9OG5WkXdLwdffGYje8x1z
         d7AQmLuA5iCkl9wWaa3hZZTzvRVG+o5MZFDu9pBcdDSr/q/xCTPqMfwBu63w2/imxO9Y
         U1xFmLzFxvI+RkhFOpzP2+sqlV6xpjexUBoWSwWlDx6LjKjlhYcWdvdWXTDKe+m1O4wS
         ZGx8JfS1nzF0WaIey9xaRychL8tRgVIIa9QduVJ7DBIZTlIIT6ms6JFG6J3BXoFXT+LJ
         wDaYzjFuDISmaePeOhhkUmLpvpMAUty9cemMbMlOhjxnYGEVGVTvxUXkNzc3QxPKEGh8
         jtcg==
X-Gm-Message-State: AOAM53231LKVEEwv1eCjZbDzeRiwLVBXVma0Bs+kxJvrqnX8bDwjhX7q
        jExU4quZQC0ohbjXYtS+Kn2adqLbu9QjE0Kfay4=
X-Google-Smtp-Source: ABdhPJwA7hXKO7tzzILJ/Si87B0V0C9/OF6fmLWqZ9vJYoR/FQUbQd79YV4b5U5rQI9VfrROoWGxsmz5cg0NAwAOW8M=
X-Received: by 2002:a62:3881:0:b0:4b0:b1c:6fd9 with SMTP id
 f123-20020a623881000000b004b00b1c6fd9mr10088127pfa.27.1652340786960; Thu, 12
 May 2022 00:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn> <20220510141753.3878390-7-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220510141753.3878390-7-Qing-wu.Li@leica-geosystems.com.cn>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 12 May 2022 10:32:55 +0300
Message-ID: <CA+U=DspAtKrDdgrzAyELDULQVjj6eFgMhsZjFCOXXYrxFAW6YQ@mail.gmail.com>
Subject: Re: [PATCH V2 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l bindings
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        mchehab+huawei@kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 5:18 PM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> Adds the device-tree bindings for the Bosch
> BMI085 and BMI090L IMU, the accelerometer part.
>

I think some datasheet links could be added to this file for the new devices.

The BMI088 has a link to its datasheet.

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> index 911a1ae9c83f..4290f5f88a8f 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> @@ -18,6 +18,8 @@ properties:
>    compatible:
>      enum:
>        - bosch,bmi088-accel
> +      - bosch,bmi085-accel
> +      - bosch,bmi090l-accel
>
>    reg:
>      maxItems: 1
> --
> 2.25.1
>
