Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70745A5FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiH3JtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiH3JtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:49:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF9C2A712
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:49:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s15so5611425ljp.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=AcuCk4+e+KRZRMqw8MoQ/WuRfLAds3XsIU+iBTt/SPw=;
        b=foXJ6wbxzshpneb30SQuoXhhe2u8EWyCpbF2Tv2lH8S8cBoNt/U/1wa71g3m0a76CU
         suCNPZVxWEvCdd0rFQzErtKjaDJVcwoJ8/DFIbigdZ1+ezpYbCzvKJFmC1cqydgdVz8g
         pklNRaZiu2CnliDb1sHa43pHcK42dvjUqylFNYpQsKvtuIay65OMc/bOZ1sxmYO+sqRq
         vihnRQNFBWtT1GyXEyjoQ2xtosD6m1raAxY5khVExIyZQSGriKT02jaiIZ8+J1FH5Mwf
         yiBzrdoI6d4baQzosAgazhRLgrotM78bhJ0U1oTFeml6b0Zp7Txj9X8YyzgGRIpf/XhG
         Tk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AcuCk4+e+KRZRMqw8MoQ/WuRfLAds3XsIU+iBTt/SPw=;
        b=hpOV067YHuoKei8bg1qAN4s2tft6MqMC1KP6olq42eBLzqQsOQu+7YJlmS2yy/kNBZ
         718G9Hb9/clx1G+j9LzYIZ5PCFouSeh9j6M7Lb1Bt+m3EHLR5PLw9twTkEdk2xaVu0Zg
         l6rcud7EguKkhutA1PM0le/lcUM7KK3WcXvkCufU6VXJovNc+FE9ylXQz2A1VorgcDlg
         rrHGGLWAQG3n8SNORMVD/cGZgLUp+tJbMJeLYF67ndE7sPfy2yWpm8uNGiK78kD2cWg3
         p7fULdoTKfglTrMzZetkWVI2zRSwPOLnrj/uDn1li4nVFW/8JmM5tU4Yt1bkJf1Cmajq
         5aMg==
X-Gm-Message-State: ACgBeo1JcfbVUropZdKxzTHsmhwkpwx+p5cQzI48Hq+JrVBWThjmtdGh
        rk9u2z9Ew/fszWVa0KGJatkhgQ==
X-Google-Smtp-Source: AA6agR4z0JLfAUxpRgWDj2uSPv6e86hAExC8wxOhgcZacnV8AvvmODylWJwoJ38g7xERmFOM5kh9uQ==
X-Received: by 2002:a05:651c:244:b0:253:ecad:a4ee with SMTP id x4-20020a05651c024400b00253ecada4eemr6339245ljn.21.1661852952708;
        Tue, 30 Aug 2022 02:49:12 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id u15-20020ac2518f000000b00492d064e8f8sm1542758lfi.263.2022.08.30.02.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:49:12 -0700 (PDT)
Message-ID: <6729c3d8-c59e-4655-d30a-aed315e8fe8f@linaro.org>
Date:   Tue, 30 Aug 2022 12:49:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: riscv: update microchip.yaml's
 maintainership
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Cyril Jean <cyril.jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220829134102.1248504-1-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829134102.1248504-1-conor.dooley@microchip.com>
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

On 29/08/2022 16:41, Conor Dooley wrote:
> Daire and I are the platform maintainers for Microchip's RISC-V
> FPGAs. Update the maintainers in microchip.yaml to reflect this and
> explicitly add the binding to the SoC's MAINTAINERS entry.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Two patches seemed overkill for this, but scream and I will split them.
> I figured I would take this for 6.1 myself on top of my other changes
> to microchip.yaml.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
