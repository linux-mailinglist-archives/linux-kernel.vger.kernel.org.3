Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284DC5B1F42
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiIHNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiIHNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:32:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00BCFF090
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:31:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i26so11992655lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jQghVYNNLFvAYVhHk3htZ31JTcz3j4JGO/5azadmfA4=;
        b=bdc3HEsGEFsO5u8cJFBMrMyO++uqvKIYwJpUGFRJOBPJcqUoo/pBD729kQ/cRKV/3W
         G7q923vp8/76mK4BbdU0y/M9LHwI5lvJl6M57l2NTsDNSSpdfARM8Oodb2JnL4WlJrVZ
         qrSg4fhSDU/tnEHit61qsdyGtsAx/FMhilE5MYHU1Av2+VXNsfIJdEcRxq3czu0Fh+P3
         dsFGEVAmifnbWuH9sDq6rO9n3wVzqJ2c+GODSPLMEcoRlp8y8in4rmx4rGyYDp8CEbSu
         d5bioHGbMYF1VU3ArX+/zaHyAAqqmYDlwChdelROLDeA5+51Q1uaPaw1rOQLlg/+2lRS
         AsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jQghVYNNLFvAYVhHk3htZ31JTcz3j4JGO/5azadmfA4=;
        b=dyBycrCE0LpMx8uBbVALnmyiEtN9wxcf035xrfhtCtMYWgNhP5lIxjuBppY6NBs/aN
         VSCKQ/Zpx01QfelVE1BUnhZd7cgUPjml+UrUfomJmL57S82pMmlPjo+tt9NW+p7AW1fD
         g/RUqMYewLZnfH7qx/bfrde+RsUySgVbs4Epd84hY74iBaGEDTro0fkcAxH2O5ui3g3k
         oEdEdYsHc3GEfrnSrglvoizBtN7bVih/Z5zIuz78bSRzAp4veOwndLEMMlwvKk0nugjR
         gzHJLrDpdeMQv1dQJE/w0hqet49Nh9ONpJDCe/liE4cv0h+RSuy8D+KG2uimtW51SThM
         I/4w==
X-Gm-Message-State: ACgBeo1SQT+HVTfCqNgILiv34eiIUAfepDgPnmHTzG/Vxl2KctIX7eRW
        jYAjQlnzcBbU39Ju6PTZkBa3eQ==
X-Google-Smtp-Source: AA6agR7qjl+zSeMlOQ9wemphfHK+lgEuVxLJn/6XmOv9c9Hoacw+i/jSv3JahMGxlU5YZiMqA7t+vg==
X-Received: by 2002:a05:6512:10c1:b0:492:a27d:ff44 with SMTP id k1-20020a05651210c100b00492a27dff44mr2540903lfg.405.1662643870345;
        Thu, 08 Sep 2022 06:31:10 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m3-20020a194343000000b00497817b8ebbsm1667932lfj.134.2022.09.08.06.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:31:09 -0700 (PDT)
Message-ID: <6b11389c-35fc-122b-5ee8-a00675f19540@linaro.org>
Date:   Thu, 8 Sep 2022 15:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/4] ASoC: dt-bindings: qcom,sm8250: add compatibles
 for sm8450 and sm8250
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20220908063448.27102-1-srinivas.kandagatla@linaro.org>
 <20220908063448.27102-3-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908063448.27102-3-srinivas.kandagatla@linaro.org>
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

On 08/09/2022 08:34, Srinivas Kandagatla wrote:
> Add compatibles for sm8450 and sm8250xp based soundcards.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
