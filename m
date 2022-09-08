Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639B35B2124
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiIHOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiIHOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:49:03 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B7B75FE0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:49:02 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z23so20229591ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PfSELVZI7eWUgnlVdrZZBJM8x1KhGoZtl9ybjhJG520=;
        b=FMEreVe18gRsXa2sOJRkMJj3INTHssHJb5O6Iraqo6GO1rP4BxA4UpRR5FlZxPsT6B
         dk9MP7cUybAR/PEi7HlHfv5VlBAScbSi6W9yCZqUHhjGNFEAUecunDD1vINrFWe3bqeh
         HXPNZa/H+d2y1BgSE4/XcMnQMeVTe8NT/mGfTYW1tq2L8lwxdzrH0W4zO2qqAd7ZnrxV
         eEjfQsynMZyl6TIhEO9hgsG2SZttGDvAoTE8Cg7vuZETQ2VGDBGx3MnG0ALzVkHJLt2B
         cMgi6Wx6blDQA/kBj80YgPaWHMucD+Uzy8azxdDk0s/dpNrYfpMKutOCAaN7Hn10NPxi
         MaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PfSELVZI7eWUgnlVdrZZBJM8x1KhGoZtl9ybjhJG520=;
        b=N8yORw/FRs2qXdtgUYaUiR/zH/RGANE1mSHCxOKa6YGzfNvtpAbicMbs2XQ3Ps78lE
         YUMRdZ9Z/P/VjGh4vAlurd1LZKl4LDPfJdViBWHxJDqnLuFJHbiBnJTaU/DBnJIhkvio
         pOGJUCqpBvaDItHr+oWcRH639BoMglW/dJwMnhDY2MJZfNALMQg5OzTsgIsx9HVYFAua
         H+6MFLYa3l25cAI6fygrTWjSY2kjVQ/IcXupWJRVM/ziXfnWrj5wcNARSMAexc5s/aPm
         CiPbFrNTIxuiSsrIi+slgtX/uaBwVkWXeTjLSNxw1Fn5ygtoc2GL1EGkhpQCfFKJzBt9
         EUaA==
X-Gm-Message-State: ACgBeo2BTVdYs8k5aPfxJ5H+3c/PupvtMI0lQJda9mnDPl9e/fdCdymG
        3tgAaLm0Fr26R8or4HKaYmq1IA==
X-Google-Smtp-Source: AA6agR5qPzFhsQC5cI+nNt7o4Yt3qT2K8dukdCCbI0GateP+zD2zZq5d2Lz+38dWB/0Wa685d6NEUA==
X-Received: by 2002:a2e:9241:0:b0:26b:daf1:293b with SMTP id v1-20020a2e9241000000b0026bdaf1293bmr843569ljg.71.1662648540749;
        Thu, 08 Sep 2022 07:49:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u14-20020a05651220ce00b004947fcf0c0bsm3055589lfr.281.2022.09.08.07.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:49:00 -0700 (PDT)
Message-ID: <ee6b8de0-4293-aa1b-4b38-e9c834e0251b@linaro.org>
Date:   Thu, 8 Sep 2022 16:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+kernel@kernel.org>
References: <20220907204924.173030-1-ahalaney@redhat.com>
 <abad381a-dfe7-9337-ff35-f657bf373d44@linaro.org>
 <CAD=FV=VmnKtx9smitqvNgmiCs-UCnLGFgbPnKd41QWeo1t3c9g@mail.gmail.com>
 <168cde58-d061-97e7-54a5-5d3cccf3ce22@linaro.org>
 <Yxn+eieg1Xr28rEk@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yxn+eieg1Xr28rEk@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 16:38, Mark Brown wrote:
> On Thu, Sep 08, 2022 at 04:29:29PM +0200, Krzysztof Kozlowski wrote:
> 
>> Sorry, I don't find it related. Whether RPM has modes or not, does not
>> matter to this discussion unless it sets as well allow-set-load without
>> the mode... and then how does it work? In current implementation it
>> shouldn't...
> 
> It works perfectly fine, if the driver has a set_load() operation then
> we call that and don't do anything to do with modes.

Ah, I see now set_load() in drms_uA_update() in first if-arm. Makes
sense I guess.


Best regards,
Krzysztof
