Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79175650B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiGDJ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiGDJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:26:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA685BE28;
        Mon,  4 Jul 2022 02:26:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s1so12546928wra.9;
        Mon, 04 Jul 2022 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+jEi4BGnvw0Fd8W0naBqBCRqClUz+i2NxYyhI89U4wI=;
        b=BMRzbNjyu2uMIUOboEa7m0IYar4pQG8HpLgZWinc+bCH+xHllM0C0qJGkYfdkuThq+
         Wpv0wLHg+Z/56OVzI2uLaRmIIgemev7+wx2IwHmL0IreOvA0FTPsj2dH9Tq/5jvab++z
         xzXlKQT3bKRF4j7pXL2hWX7x51TGShz6TazCYNVJQU+izvBhjer7N4lJwcHBnbvYUhNI
         PN8VRAni/9Oj9PdqP0O3+bCbwSbJqfO8Xg8ZTuFAjzZqi3Mvzaw4wYAhvo/iEF0/azhI
         /oWg3rEZe6pA9RS5ygkO52nJcT+UGwm5IxvLvv4XJSN+Ogd6lORmW7qqfGy235xOU6DU
         feXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+jEi4BGnvw0Fd8W0naBqBCRqClUz+i2NxYyhI89U4wI=;
        b=OGL5xEyQ0hnoc3a+Ws2DN0FpEG8+8oNTKgd/ucYPy8Vk6GHVpPAEoQ7KW9nM0HaGP2
         iUdjj5duTg/rnPYvFeyzdpnVrov7uTqZTY1KkEwvsdwmj+30JZ3H8zEImYGJep8eQxK9
         g5N/bTmCB8mz3CCWZosZ4eXwJSEmnDrH0UJORW3BIGBOogA2mHv1dB3fVKJa0ZgpHuGi
         6elXBxzVWRAhCn6AfOyCTEeJbtrBOGX4sKKXL0hAaz2prFlI6ubh6LNpKJVbrnD2qgw8
         Jsii8tbH3MHY+RVpcK0AOV3oAt1J4c+8Ie/a18/9c7LEvrf4tE7TNreXPfaPlFjYHmAp
         VtTg==
X-Gm-Message-State: AJIora8QlAJSuKL//nFZioPaoOxTSmQAy1WLXzDDsjoo9KW5JepArz/l
        j6mULypP9hDyl18nQGPpoAex9B6bhaiekcuS
X-Google-Smtp-Source: AGRyM1sFikMyiskRDFpClyGO3m8wMQ/dVhL+e/jkPQE0rHf4Mcb3bWsG42Mk3XKrIso+sCD1NjVdMg==
X-Received: by 2002:a05:6000:1ac8:b0:21b:9239:8f28 with SMTP id i8-20020a0560001ac800b0021b92398f28mr26529502wry.517.1656926779450;
        Mon, 04 Jul 2022 02:26:19 -0700 (PDT)
Received: from [10.43.0.73] (68.201.26.77.dynamic.reverse-mundo-r.com. [77.26.201.68])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0021b5861eaf7sm30245355wrr.3.2022.07.04.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:26:19 -0700 (PDT)
Message-ID: <9a07f9b011646284db9e2eeeb76b80afad599b68.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: pressure: bmp085: Add BMP380
 compatible string
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 04 Jul 2022 11:26:17 +0200
In-Reply-To: <ad00b52e-cead-920a-9b99-db4032cb6d0c@linaro.org>
References: <20220704002641.207169-1-ang.iglesiasg@gmail.com>
         <ad00b52e-cead-920a-9b99-db4032cb6d0c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lun, 2022-07-04 at 10:58 +0200, Krzysztof Kozlowski wrote:
> On 04/07/2022 02:26, Angel Iglesias wrote:
> > Add bosch,bmp380 compatible string for the new family of sensors.
> > This family includes the BMP380, BMP384 and BMP388. The register
> > map
> > in this family changes substantially and introduces new features
> > but core concepts and operations carryover from the previous
> > iterations
> > 
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> 
> Please add Acked-by/Reviewed-by tags when posting new versions.
> However,
> there's no need to repost patches *only* to add the tags. The
> upstream
> maintainer will do that for acks received on the version they apply.
> 
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof

Apologies for the inconvenience. I'll be more careful with kernel
protocol and use the proper tags. Thank you for your time.

Kind regards,
Angel
