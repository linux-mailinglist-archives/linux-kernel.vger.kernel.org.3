Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A77515653
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381234AbiD2VE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381171AbiD2VD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:03:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105DD3AE8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:00:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so178610ejk.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=k+FLEaNOSlEZQgu+29CSWk5IjfdF4HGnJSzB2OIKnM8=;
        b=x7oX3LjaOjtefLkFeO1lfDimV4wlwSgqTHvXxjvzfFsgSznI/BNVeHchG5Vp1ycoGn
         6k+Q1ObllNBs2MPJ6e2M5I2HXhi7+XdSznQxo0xTkWwm2IyxxExE3QmAIGm5D8iWvYhl
         qSs+w87c/MjCdApC5C7chhvDTDjQd7Xsi+xrKtGNasicVrgymiuiqjgKAHaX3/qH3xcw
         i4SRReozeEenNuZ0+wfNtXl4BwpW4aZDH8y2YY6paDFXouFiVn7a228C2W8swy0QfVi7
         pxWXrAqcDJvZmTzsJ05GSBLb6sr32+RVq73JDprpkzwMzDdXpJoUzPcLKochMS+ZalvE
         Lihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k+FLEaNOSlEZQgu+29CSWk5IjfdF4HGnJSzB2OIKnM8=;
        b=XgZaLCbbiGpQUqTRjGKMAZI7wSQ1iZxM2neJt24B9nQvthWjB6XHTH3DZkSkIEaCfn
         r+6Xtm3ArwreyXdWoBMhghHjmdDDbtl0IeF04Z40QUEgdid1AhK0mnE48moTvoeD4dsb
         DWNkjkIICfQXqCjDwf6VtBk5S+rnOCleh9nL5Xde1i9mvlGKUeUU73wIEppcC+1dl4Bh
         wMypzhdUFmQ0PdYmKOYbWZ5OOPjKGOLCMl3mW6LisCaHaMZ3l/RGPpcrZPUGDWGbMhIz
         LSYoSUbwT17qZ8faZVkUrAFvEbl7xC3dMankwkMuinG54STElIEj1uGAJSJ0ZfUOVFEa
         Ua1w==
X-Gm-Message-State: AOAM533kkNK9bh0zq2wD6bzCjxF2jclZxUmmU7R7Tv4jgC6g0hJ6invD
        i5Ywbam9Y0q8UJG/J8u4liCx+g==
X-Google-Smtp-Source: ABdhPJw53pKMx9sI0aKBMCgGj/gUj/W0YSBOVUjOj6Oco83loSg4sAKu3bV6ZFbp/vCWQZx1JXQPVw==
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id nc6-20020a1709071c0600b006dfb257cbb3mr1042874ejc.631.1651266037074;
        Fri, 29 Apr 2022 14:00:37 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qz24-20020a170907681800b006f3ef214de0sm973786ejc.70.2022.04.29.14.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 14:00:36 -0700 (PDT)
Message-ID: <32712c76-df62-9a02-fbb0-14f97417feae@linaro.org>
Date:   Fri, 29 Apr 2022 23:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: devapc: Add bindings for
 MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     neal.liu@mediatek.com, runyang.chen@mediatek.com,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220429065429.7957-1-rex-bc.chen@mediatek.com>
 <20220429065429.7957-2-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429065429.7957-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 08:54, Rex-BC Chen wrote:
> Add the dt-binding to support MT8186 devapc.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
