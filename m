Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4C51F53D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiEIHYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiEIHRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:17:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11F1B1855
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:13:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so24968784ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ac0wdZ20AHn5wVPxVYwtmg/c1OI3pc9hHhoSEjeifpc=;
        b=ZZC9iQtnZRNTyGmUsZa7/DrBwotSxXWiCSY2rboitpOCAh5WrIkUR6+tiDV6P6cATU
         ehuALpVBNDk97t5KAdpXvbLp/CuJ5FnMeFfFgl9/bNVMlvNmtiEKFpDIF8qiGq5Qt4uV
         ar8B4lD5t+y0ZSto5BKU/hh382WJ7p86RlTPfYPkX23Gc8KIaFQXpDOMr7Ueq5zM7DhK
         IhAtt/Dh79iqqrSZhheHZtUqo2pdyfZktnorxHQc9xRp7P73r5JGgAi94xxjvLNcjPjw
         nR5lm75IXPdMJl0v1d/Cj99tEBivO7D+42vYsNRhEYzcK468IkLUOuAaVWeFFptHcHiO
         qkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ac0wdZ20AHn5wVPxVYwtmg/c1OI3pc9hHhoSEjeifpc=;
        b=DedU/yd6cSgklXm/lKMu/EWSLMlpgnarsAm/OxuHBBGC/j0Hn/Mu8Db3joppONjPCO
         +BGETb3KQLVulOER6As7e3Wjjwcrpb8fjTPXrIUUaNs0TtoBrHHD9w1x1yj/GILzxPQx
         zPZWVwy5taAIUgtzgW68VBdqKUMyRAKtp1kBWjs+WHWD5KOQhWaM9uDi9vKIPg2Wktnc
         d5XGXo1aHsjGaLn5hwZhScXFGfwW+LBJGmZzGNuIxlf6OeQza54qUHQjTuDXBiBl2UjZ
         QfTg3eoexZsA6Sd+zltbkVu46jTsjbze1dYGKF/VWkUkE0wG/y0754kpgfQf51mzE/FK
         TYiQ==
X-Gm-Message-State: AOAM532tMOm5Nd9NwLX/hObrLpgoP5LG7ewDzR0qJGY/vr8aBPFw1qMJ
        +DmRbyhbBFzqnlte6Qj9guxluQ==
X-Google-Smtp-Source: ABdhPJyZUiyqYlM/No92bKswLQXC05uEE20qb/n8pLGATD1lJjK8igzRKiN8DiowBQA0FrB0/i1gZg==
X-Received: by 2002:a17:907:6d9e:b0:6f9:b861:828e with SMTP id sb30-20020a1709076d9e00b006f9b861828emr5170050ejc.427.1652080426647;
        Mon, 09 May 2022 00:13:46 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id el22-20020a170907285600b006f3ef214e1dsm4771728ejc.131.2022.05.09.00.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:13:46 -0700 (PDT)
Message-ID: <f0e27ff9-8eb6-1250-1262-e7ab7908bb33@linaro.org>
Date:   Mon, 9 May 2022 09:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/6] dt-bindings: clock: Add support for IPQ8074 APSS
 clock controller
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220507203620.399028-1-robimarko@gmail.com>
 <20220507203620.399028-2-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220507203620.399028-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2022 22:36, Robert Marko wrote:
> Add dt-binding for the IPQ8074 APSS clock controller which provides
> clocks to the CPU cores.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Correct subject

After explanations about license:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
