Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3794F0C5A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376379AbiDCTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376371AbiDCTm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:42:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5030F49
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 12:41:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so13622347lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Dq9FqcaW4bnGUiA9j/82/g9draFpr45rWxqoYd/sYts=;
        b=lVhYSCE2MDb8z4KAzynUmf9RWn1oLKfknZAzsOFXpO/ArTUAkPCm3kuNEoIk6VBSFj
         0c6jwqnZwencjDku5qfuY0qa4uJL50k+uCRvKOc0QJjmyUlekcFEtjxcXapQHIZlfWZD
         +WI66kMn4E1JVlV8cKGq3OM0f8Z67B710O9/LjzxeHNnC6C05fyO6bagP4cJZScihveV
         xErn1cE8MuTDI9ZtnJm5p2oAm/d+oyhUPReDd0zSOdbThUvc4vuKoN6ZiPooGJWjh+Pp
         FBvfHULG0H97IUDvFUL+O8I3RE5T0bsbqGVbkTntlHD90Zl15BlTxXZgO0EWSwcwhb7G
         YYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dq9FqcaW4bnGUiA9j/82/g9draFpr45rWxqoYd/sYts=;
        b=OJw3X5lV+VsCmH/7m1bxEFWgA1kYewUtqrFslQfHARPYQ2RLZegf++JWStVrF+Uq1R
         9M0nmPvPR8bmct+uCMMO8JqOy0q+OWMGamuwJNCNkkoQEqGzADbeG6ebOfc7qy3U/POJ
         peUGjbhCHhBBO2NASzmz7Yz/SOHIE7tzBZ3vr06t1alKXixZJt0rGjKeXR3s1u7OYAew
         Ehv9h45nEM30GXeVwGSeOw6vqzLbPqxVecPJytIsidFCx0PPawM1u0Sl3qecGgtWO9Ui
         fWZrGTfLGmH2ykQ/nTcv/Kjx22EQmcRfsuqmrFQ9jhjPE568mc7fSiYihznxjqSzxRgJ
         Mmlg==
X-Gm-Message-State: AOAM532HVD4giEIxHF8zR2rfdnYeNRKPLemQeKEgi+Lcf/PaecDlNPdQ
        g5RPBM7zecTYpH+P1qszgzdYNg==
X-Google-Smtp-Source: ABdhPJxCjEskhGDKkzec7Qnt5xYihh3Cb7EltaO8SJKbXzSEn8n8+xIowvPOjKV6zw2zKKwxb5mDQg==
X-Received: by 2002:a05:6512:3988:b0:44a:f02e:f28e with SMTP id j8-20020a056512398800b0044af02ef28emr4753853lfu.458.1649014862412;
        Sun, 03 Apr 2022 12:41:02 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n2-20020a056512310200b0044a30030d33sm900758lfb.91.2022.04.03.12.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 12:41:02 -0700 (PDT)
Message-ID: <2bc53a5e-4832-429a-d19c-534fec2d43cf@linaro.org>
Date:   Sun, 3 Apr 2022 22:41:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: msm8996: Unify smp2p naming
Content-Language: en-GB
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210926190555.278589-1-y.oudjana@protonmail.com>
 <20210926190555.278589-4-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20210926190555.278589-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2021 22:06, Yassine Oudjana wrote:
> Rename smp2p-modem to smp2p-mpss, and make the subnode labels of smp2p_adsp
> and smp2p_slpi follow the <name>_smp2p_<out/in> layout.
> Also move smp2p_slpi_out above smp2p_slpi_in to make it match mpss and adsp
> where master-kernel is the first subnode.
> 
> This patch brings no functional change.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #db820c


-- 
With best wishes
Dmitry
