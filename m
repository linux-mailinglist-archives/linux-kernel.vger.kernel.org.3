Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BDD57464C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiGNICy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiGNICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:02:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E7248CA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:02:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a9so1484928lfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lI36sTnCb0+DmOyAUw1CM5m4XVa/PVp2AcLeXMQCCI4=;
        b=gjyUm66YJEPpSn//X3ZOvHoEpi1FH/8Ti98snRzY3cYPydTF8ZnX63AAE9cUJZ1LeG
         flkxCz92JB64spplRtBQ4ag4la0wOeDJWqJvY8iZCLS8j5F4Urs8JIkvHSSvgY5VVnZA
         C0fkX9aA++DGvTdIijtqvWxW0ssCQRrFN8pAlInPaAnNn4c4ccQSN5WNqViYkquGC76C
         Oz8zAia9QL6sqPsazX/HnawIYi2NiM9cVBY1j5icb+LjlV5FGm99AWca+SnoCSzXXNA9
         q1MuCwME7qdKhO30h+p6wY1P2mslDMt1NYba0GRA8yR8UQitIPmx4/VLqi8xUikX98mO
         KFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lI36sTnCb0+DmOyAUw1CM5m4XVa/PVp2AcLeXMQCCI4=;
        b=DvaTizJy2snm4B+4WWXzAjvEN6qTaURVxcINoeiBHfqttLoHfMy2EnNTL7o5Rleejm
         zFmXjObLTSRfpbOErexKU37sW4ENPyIm/8cgBKr/LVn6vcQ/uyGfjCQrwlq2OEwJL+Jb
         PlBzdXh/Ensf78tAaJEtfDcHZSLJ2RoEYb0xT8b+ScfZHAav9wB6qEQI7TBlVqn6YsTw
         wJNIPGy0qiVPa6BoLT+OWFAjHlO4PhvhrjCIGnZy6ekH4xDZi7/3Ps3O3V53b8+oeyjI
         3H98kcD7EeGiup2+5Zd3u6VGxEGoDj/e+FVnoj0Ld3zVkmFkp3VCS95MbwbUu3HQD7/W
         lhOg==
X-Gm-Message-State: AJIora+4EXvrz4/si83Jx6ENsKafS6aFGs9BuJwNR4YSduX2AggqwMlD
        7SNskw2tmDRJ72YDpCnp/XSW5Cofnovwsw==
X-Google-Smtp-Source: AGRyM1sv62lHORtgudSBwTulpCkYzf7vRdJw4P69KsktDIRzFN3BKy8OBP4FM0iNzTIQG2YNTwPxBw==
X-Received: by 2002:a05:6512:159e:b0:489:d127:5b38 with SMTP id bp30-20020a056512159e00b00489d1275b38mr4752696lfb.480.1657785768179;
        Thu, 14 Jul 2022 01:02:48 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id p17-20020a2eb991000000b0025a6da9cb86sm142898ljp.114.2022.07.14.01.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:02:47 -0700 (PDT)
Message-ID: <2abcefcb-92c3-713b-8087-f63cad781ba9@linaro.org>
Date:   Thu, 14 Jul 2022 10:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next RESEND] soc: qcom: icc-bwmon: Remove unnecessary
 print function dev_err()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220714075532.104665-1-yang.lee@linux.alibaba.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714075532.104665-1-yang.lee@linux.alibaba.com>
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

On 14/07/2022 09:55, Yang Li wrote:
> Eliminate the follow coccicheck warning:
> ./drivers/soc/qcom/icc-bwmon.c:349:2-9: line 349 is redundant because platform_get_irq() already prints an error
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
