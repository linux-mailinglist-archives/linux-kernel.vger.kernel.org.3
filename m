Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D155A9CEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiIAQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiIAQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:17:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20CC82872
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:17:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so25181180lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Pw7SR/RaYNdAbxzs8fWlzUi0/Q9E1CCUq15ZcZfhshk=;
        b=XwyOX/I9MYxWuBr2Ucoq/d6Eg1NhpsS4QgIzBAS2UHSH5jD0sOiSGzpS3HSfDDMNY8
         TsfAtC6h3GXWE5gakJ1M1XPaQ1jCZvOma7fBSITj/n0rWhfcNSd/RTkh8rWxRgyAW1j7
         kBrIpn6s9UjDQS0+oWZYfOp56DJsHtxalTUxalNc2OLQEtPc7/eQaYSKByf3VMyJ8I3i
         tXsrVUQ4asnt6Ie2bs4s/SYk0G0m1tee5ykOXb2U+vZctkU4TjUafyM8huYM2BCbYn67
         eV9bQaS90IXRPp7/nloogBdSQWyOHj5MKvnKejLWbsFqo0d+KqTLsQbiEGJ44OiXXlY+
         dEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Pw7SR/RaYNdAbxzs8fWlzUi0/Q9E1CCUq15ZcZfhshk=;
        b=hg+UEkpXV6HAjQh2yTxVAN/q/xgPWO9N6r05sGhtDVoqFuMB5AxzogcZYfWEV4WZ8N
         7+pQkc3+bC0AHk4oIXhCuMVr38xqkxN1hckF/PC6vFZ6s2Bm+JB0xwJQEhKpaI9vII0H
         iLKCwV483nFGLJzjL/6AIAqCzrtqxKGEg7sh0RO5r2j4K5d6d1Se/VZ8PBE6CApXVGB/
         MxL90E7tpnkM26Dfezd75t5GeoT7Akmdf3sz/o+DcjTpcU/he8eG2ZR2Yc3xRHeHYYB1
         TcJ+XFp4zaAdUgqgBiRIpcRI7zr52ZfyqIvEFIoIimv6ooUG86uZKhJJax0FAUd37G5a
         vuQQ==
X-Gm-Message-State: ACgBeo1s2YX0tCc1t+fOP3B5E4pBsOCotY4VdQ5Jn32jIpcEjcb5PMXG
        3Dxxd7WaesQgz2MiJFDZhZl7Fg==
X-Google-Smtp-Source: AA6agR6M5neHx4ebJfv1les3M63/zKblHkE+UvydSDI2Al+gian8ELIzigc6H64SRYNIpdxnq12fQw==
X-Received: by 2002:a05:6512:3da2:b0:494:686b:a111 with SMTP id k34-20020a0565123da200b00494686ba111mr6228998lfv.622.1662049048185;
        Thu, 01 Sep 2022 09:17:28 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id s26-20020a195e1a000000b00494a27500c1sm84920lfb.163.2022.09.01.09.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:17:27 -0700 (PDT)
Message-ID: <f2e9dda4-4255-8d14-e06c-6d7b6f0a697a@linaro.org>
Date:   Thu, 1 Sep 2022 19:17:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 13/14] dt-bindings: arm: qcom: Add compatible for
 oneplus,billie2 phone
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-14-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901072414.1923075-14-iskren.chernev@gmail.com>
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

On 01/09/2022 10:24, Iskren Chernev wrote:
> oneplus,billie2 (OnePlus Nord N100) is based on QualComm Snapdragon
> SM4250 SoC.
> 
> Add support for the same in dt-bindings.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Bjorn,

Can we get top-level schemas merged?
https://lore.kernel.org/all/20220830065744.161163-1-krzysztof.kozlowski@linaro.org/

https://lore.kernel.org/all/20220720073326.19591-1-krzysztof.kozlowski@linaro.org/


Best regards,
Krzysztof
