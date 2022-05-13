Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD39D525DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378642AbiEMIxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378602AbiEMIxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:53:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD4F2380FB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:53:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m1so10478192wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sLRt+qYzHdsZEXGXF5o0ydCpMpaHUYlN6LUVgHScaYs=;
        b=yS0I9yI7YUPgrFs/6zIC6c6rcKsESr00TRsP8etkUzBalJxzJgf9GASCWbR+qCTpoy
         nZAXNCqcKUD28hU+h/gj4F20UuF8il4ijIjn03X9cKud4qKH1iEd2B38njtZ8iQdspQF
         9p0ax7ROua0BLz8+aAKi6mQNCTEUbCKOLb9YJ7EKwCtFhgakEXlbRM4j2lPlQPmxpGtH
         dagNc1zgdNabGnJ0iYekny+InjeJZYpg53SHdlu1EYB9LLIcQJZT8l9qE594jtyf4qw1
         YDAMBZp3XuYCTSHQHKMQu8bXEAdDWsugGqrnWAjTdyzQfqVZU1/v96Wd3T61Hkebircc
         e+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sLRt+qYzHdsZEXGXF5o0ydCpMpaHUYlN6LUVgHScaYs=;
        b=Mhcy90NNDqRTcpuK3w7kH+8HxnSx94+I4Fe47wBQEZb2M/6FZpo73tM4Kf6qxv93kF
         AJ6g4k4GRPba2M6gZy6QB5fT0+PaR5Qy3rYwh9yWnRW+QAWT04FCiECQ0r9YzL0zOFK8
         zj0q7mAFx0lnqdwUiCAw923ZmA2zKXtVklrddDDuwkjjHwc/51L1Q2n6cYd1f/uuXYO7
         V5QLZCjxAKP6crrWFnzLsJ1pI+AX/demOowbcpunOB/J8s/aHRFZIO8eDScOGCI7hcq+
         AYmOFp6IMGp9TXbzT8JoLiow2wszRIQKOjvbtCEfbV3dgRHlT8NjVNky0TnUv/AMcu/1
         WSjQ==
X-Gm-Message-State: AOAM532bI57CpPeSxlF1JTTau0M2FBQHo8gqLRh/K3y9yvQ+ZGgp+4tz
        nf7KkJGjcCCU3s6vNb3qHfs3VQ==
X-Google-Smtp-Source: ABdhPJzb3pF6cTXO0n5cdqoo8ASlekhcGdL1JETa3T0pLC3gvLgPsk2+qpARPIps7b51o02m3JpnHA==
X-Received: by 2002:a05:6000:1d98:b0:20c:c29d:76db with SMTP id bk24-20020a0560001d9800b0020cc29d76dbmr3037181wrb.710.1652432008542;
        Fri, 13 May 2022 01:53:28 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z23-20020a1c4c17000000b0039456fb80b3sm4674767wmf.43.2022.05.13.01.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:53:28 -0700 (PDT)
Message-ID: <ca6bdf24-b955-6433-1e3b-a4ad4ae687ff@linaro.org>
Date:   Fri, 13 May 2022 10:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] dt-bindings: proximity: vl53l0x: Document optional
 supply and GPIO properties
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220512110757.5297-1-markuss.broks@gmail.com>
 <20220512110757.5297-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512110757.5297-2-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 13:07, Markuss Broks wrote:
> This patch adds the optional properties for the VL53L0X ToF sensor to the
> device-tree binding.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>

Same comments as your v2.


Best regards,
Krzysztof
