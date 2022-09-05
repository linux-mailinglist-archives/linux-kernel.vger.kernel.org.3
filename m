Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730B45AD7B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiIEQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiIEQlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:41:04 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F765F233
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:41:02 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b19so9759340ljf.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lUVY9wLQD/KhYbvUWN5fb2ErW+DbSkU8EoAMBzx1S5U=;
        b=WC1h+oYOSZiMWUOdunF0j0EDSmX15JVM2O79DuI38xjocndQ6kMJQ16P39uIzVRh4h
         WqY+C+gkZstzumL2q66wpLvwl7pFGU+fDbfpmLJ7MkD7lZMhBkQ/DUV6lBeEql2N5j4V
         qOoJNBdMoxVeziWPoHYlbxKatnRHcmKCN7nB8G9AB9JEcHlYsdvnWEsPDk+g2fRU89e1
         tyenC9hjxteWi5vOkYPTb6trUJ9NrwKSARrrbiMOMciQ3G71h07GhVO67m8OivtRq7ab
         EjqXohSPn3IcWEB5LHRjeE6j88lN5xh1fAuSY5t6KrCgtbnBAa+BufI849Z0xDmLlNlp
         tyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lUVY9wLQD/KhYbvUWN5fb2ErW+DbSkU8EoAMBzx1S5U=;
        b=5gzq7t6fc7Dj8lLrDcxskGUJqsZsOTUb/iq8IJAOVln4DOOcqi85WgQaVIaZiWqvCM
         r+9Fcc6tH5bnSeAtKy7uT1yxm8wKcdIHY0eCi8lkaCQSflf8vDBdtw1BIRjh+0bumEWx
         IV92BwVHDOCsPd9zjyE5pTs8NK/XjZIn+iVsJ2716lad/9hyOIDCOeHxyhoLzvMruC6n
         GhJWN/KZEWMFgB7piOWXKDFQnoVsV9Hox66iHOzlHRa/X+gXyZSc5kLN2Jyrd3Bf0qG0
         zA4w+Of9l289clYRs6gjKprsW8BUuJitw9GfO7OiZLjlYd78Bw0nAIPaHhUoCkDwUT9R
         ZHUw==
X-Gm-Message-State: ACgBeo3VG3zW3q4FykL+yjLJoK96+DXFrG0dvTK0kRoRUOYOAzeiXw9S
        i+IKGgIHMh3wHdpm0+nSjRV8Lw==
X-Google-Smtp-Source: AA6agR6HLS4+eFG4fIaVMDGpISoxeLNvbeLnz1eGC4tU9uQhcoLlsR1quf0rWJIWZHNMR7k7Q+FPhA==
X-Received: by 2002:a2e:a913:0:b0:25d:3128:21af with SMTP id j19-20020a2ea913000000b0025d312821afmr14872323ljq.58.1662396061335;
        Mon, 05 Sep 2022 09:41:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t18-20020a192d52000000b0048af749c060sm1236556lft.157.2022.09.05.09.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 09:41:00 -0700 (PDT)
Message-ID: <84095d0e-28a1-885b-8217-f787c4cf338d@linaro.org>
Date:   Mon, 5 Sep 2022 18:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: qcom: document sc7280 and evoker
 board
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     mka@chromium.org, dianders@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220902080912.118592-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220902160845.v5.1.Ief93544cd0cbfa412092f5de92de10d59a2a5b3a@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220902160845.v5.1.Ief93544cd0cbfa412092f5de92de10d59a2a5b3a@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 10:09, Sheng-Liang Pan wrote:
> This adds Chromebook Evoker to the yaml.
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
