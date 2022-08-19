Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10352599C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348536AbiHSMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349061AbiHSMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:46:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2397898A62
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:46:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so323810lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=K29+GrLurEVMz+IcmJCvsL3+V3VFmxk9IgPRnZQasec=;
        b=TCew6KzbEtV2gO9hXzpONAq4N4e+nQyw/iU+jfOE5az9Be/FXPJIBc6GNySAnomO20
         FgIqmRs+DEWlBchnjqHuoz3YZE/geyl87pjMz/Ohgiyr98XF9LbdAXYkAh1tN961/zPe
         nvE0Puw8RuLjR+ICfL2cnUsxHafBSNqAxo7/f0FDLkrQBKd/PfhZ/XQ1uall65czZmHI
         mS1Qz+aPkdTW1EnsyUJFILOw8mHFqrISCcZlrg2QEGnc1BV+YJUaqY+92Vi2aAOj6RFp
         90pqM0ZgqacFn5pYXGPSz1TOerkmaYMdg85naGczDEuR53WgtlRXDWo4pwIQTxpTFJWM
         jdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=K29+GrLurEVMz+IcmJCvsL3+V3VFmxk9IgPRnZQasec=;
        b=f7k8e4S78IrNeHpch0LZfZraFmg656z7Ic0gcCAOLp778qCXp3RKlj6D/bMuB6AqeD
         latpFXPMbAak6EMbEHfvXjp4j7K5uAPM8ktlohf/0Znguw/RWifE9dvCdWWsYK5jTnDw
         86T5vypHV+GK22pcc7fjQhrIxtT/XVD6QsIbLWEhooII0NEeKSBH4KeRLES21T1YkXEd
         ct2j6Sr956ghnUZJTE2MqZpf02FqV9sjwQKTirJqGgctdZPKMPHMiiGGg53QbdjcP4eS
         qdQ29xVye7qB1Bp/38MlSiRzqBEvM9Svr6noYQIXh7OeJeXozRfP1DPy5LH6/TOZeh9K
         PhQA==
X-Gm-Message-State: ACgBeo1pZ/Bbyz0xpByxQMpjXRo9THbP3cHjT/XbG3qss5QDE29dZWgt
        UpzDvAdTC/Z0PxS07ZE3qHWweQ==
X-Google-Smtp-Source: AA6agR5/vAR5q5Kr0vJwYrqhtgqJma98MRzgessllT6tIdcRYL/NOV9mrbay71eWVKq/BdtNDBUSLw==
X-Received: by 2002:a05:6512:10cb:b0:48c:e0a6:221b with SMTP id k11-20020a05651210cb00b0048ce0a6221bmr2775454lfg.218.1660913182522;
        Fri, 19 Aug 2022 05:46:22 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id c3-20020a056512074300b0048aee825e2esm88260lfs.282.2022.08.19.05.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:46:21 -0700 (PDT)
Message-ID: <3b1a99df-58ed-9bed-aa11-14a1cd8b62b5@linaro.org>
Date:   Fri, 19 Aug 2022 15:46:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/6] dt-bindings: riscv: microchip: document icicle
 reference design
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220819122259.183600-1-conor.dooley@microchip.com>
 <20220819122259.183600-6-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819122259.183600-6-conor.dooley@microchip.com>
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

On 19/08/2022 15:22, Conor Dooley wrote:
> Add a new compatible for the icicle kit reference design's 22.09
> release, which made some changes to the memory map - including adding
> the ability to read the CCCs via the system controller bus. Technically
> that was always possible, but the specific CC chosen could vary per
> run of the synthesis tool. Hopefully this is the last reference design
> version impacting the memory map.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
