Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3C56674A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiGEKDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGEKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:03:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02F213F00
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:03:02 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a11so13868196ljb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w9+SQsY/NLl9h6xMjjbnzFOp0g9U5sIW1EUYanyyw+c=;
        b=HxGx8j+pPyygvzH4xlqJHqV6m1QNJxV4cPrs2F+AGjML6Y/2hCEL0JqlTSxgBqw1uF
         ObIdy/JmJaNkNCR0ccJCZXrdwJr5hitpKZHHiabgYKkcfEWr+sFr83PBScyKmcJDNhXF
         LNuOPmpjJvgTkQ9JS0tBwA0RsodAOTXEvM1w9xEXHzjzZ0gXx/AkzN9HVYGm92vJmUBW
         0omqDIVJhHeR/O0jgt/X0qDJicb6IGh1H/dTXVw1MYSiwuprvc/8dd3l4KQl1uexv/xf
         0PKX9REU3os1TA811cdPExcyH/+9RhDzWFOCGVu+IkKoGWTsmtmhnSyDKZmN/C8EKyU7
         hJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w9+SQsY/NLl9h6xMjjbnzFOp0g9U5sIW1EUYanyyw+c=;
        b=hk5Ns1IdCZpCTomvaBqxTjDCKrxqR4hNlhPDNYYYWToP7WwAosBdOlYFpPB+f4TPG3
         t92CfL/TRPb6+eNv0nEJGwRrxGZiYdN0F/2QxokPZ/jsPh2tScHTU/Xc3ovag8p6RF/w
         ka93nApmCq7LtaiH435JMsykTqTKO1fngGNMKajIR7Sj7APZDGNhfZvyc4CKnjIxjlIY
         YbtjGUFHfHTj/87svFKgfw7QsdtbfmeLOY5KWKlZz/VNaK5JnC14Z3WM19U+2WH9N0/s
         /JvH75S9lAyWBQ5Eevn+PJC7Trsn0gnS43peYwTjMP2cgYewfwQIAdY/ypa0xptcWIP1
         nQlg==
X-Gm-Message-State: AJIora8m66GkKaZtNBfL6PiCqi88owWkEZsusGnyJZMxJazJZhC3j8f9
        5VTlCNcUTZfYz26I7g8TothStQ==
X-Google-Smtp-Source: AGRyM1uwnvOcoQafM3SLYRmg5cf9HHvDJs0sgnpJ9Zzs28wWHyGPma2Rftkuh+3aPkH5nmdGjaunTA==
X-Received: by 2002:a2e:8958:0:b0:25a:852a:c302 with SMTP id b24-20020a2e8958000000b0025a852ac302mr19530866ljk.130.1657015381066;
        Tue, 05 Jul 2022 03:03:01 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id u16-20020ac258d0000000b0047f6f675ea1sm5610685lfo.161.2022.07.05.03.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:03:00 -0700 (PDT)
Message-ID: <7f418618-a40f-9ada-629a-6d6b08a29fd3@linaro.org>
Date:   Tue, 5 Jul 2022 12:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/43] dt-bindings: phy: qcom,qmp: clean up descriptions
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-4-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-4-johan+linaro@kernel.org>
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

On 05/07/2022 11:41, Johan Hovold wrote:
> Clean up the descriptions somewhat by using uppercase "PHY" consistently
> and spelling out "clock".
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
