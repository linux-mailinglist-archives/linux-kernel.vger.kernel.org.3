Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E14512D75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343616AbiD1H5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343531AbiD1H4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:56:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF12E692A0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:53:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y21so4562260edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7imria7AOBpaNTcOn+sNIMNFLxOEbQktxf1OYV+mCb4=;
        b=oBowMauFsKiWlMKoUFjyn0tQc0cXzAUCM6P9dHhlgL92tclsRV4WUlyxpCbFrqdUQV
         f72EXv37YQX7++jcHgvGug7uOJZMjXKPknstXCPo8mdnQ6W/yjWJA8+FSAdOsX32NYYZ
         fsXyvOfb0Nom1+G58YXrxnPZ3GGu1sPmlSt0HCNJfQmpEu9sQLfnkLoHg1velrva+EF7
         k1gnG95qwNsq5wyis8alM2bRH9lboBDlg0gaLToO7nrIZzpbt/bIB0fx8fvduysn1dav
         gS3stFU86bS/wAC2R6fWE+9PpjsZze00EBMkZcAXA//4EV7ZsKUnZe6D3R780BeNX3hH
         0WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7imria7AOBpaNTcOn+sNIMNFLxOEbQktxf1OYV+mCb4=;
        b=MauCLV+KukUJFNP+bq126rP3JbUhrlKYpOqraDeqCoYVNh60RniRmTOnrv5MYuN8ur
         +iBh4gGk6n0KGkz4qDNiqBcphrkJGgOIiOyfdeoRFUXIY8uQviYevZs3VXw69x8uJab1
         IZ/Q72iCmWe34dDTPMFaIPoXJoNlsHJ27ajIhy4Rpfyj3X5gvKPWivj3INCr6lk0v/CG
         FNWjjO7JCBVrKvCZ0IJG6M8LucMgGrYlXBFtPmUBmC5NAyjIbDTJooStSRmaGUKv/tlu
         2mqmRq2U02ehy4XOGMFkXHjd84WSAu99m3rIK6d62CbyZW/etXtELjBLDt9SL472q7DF
         ykxA==
X-Gm-Message-State: AOAM533Ujnm1kVduZ2qa6yPKlLNeJPebR7MgF3TKeCq+Cuf+1+41eDBw
        4duaeikdoBVH1JrVMLl7wpYW1w==
X-Google-Smtp-Source: ABdhPJzviV5gS3KcyKsb8SDPBhzT7DiiOIR0C4FkBQNdYrbgZ3rUvu1yMYOzUNHDjnYGGQYf33IU4g==
X-Received: by 2002:aa7:c442:0:b0:425:ebed:4782 with SMTP id n2-20020aa7c442000000b00425ebed4782mr19873545edr.168.1651132409299;
        Thu, 28 Apr 2022 00:53:29 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402345500b0042617ba6393sm1081334edc.29.2022.04.28.00.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 00:53:28 -0700 (PDT)
Message-ID: <1e3afa05-2e2f-fb0a-19a3-5a7a6af50863@linaro.org>
Date:   Thu, 28 Apr 2022 09:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/8] dt-bindings: input: mtk-pmic-keys: add MT6359
 binding definition
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220426135313.245466-1-fparent@baylibre.com>
 <20220426135313.245466-2-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426135313.245466-2-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 15:53, Fabien Parent wrote:
> Add binding definition for the support of the MT6359 keyboard driver.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> v2: no changes


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
