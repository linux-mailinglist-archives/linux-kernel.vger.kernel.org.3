Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFF35AE610
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiIFK6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiIFK6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:58:03 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F813CBC1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:58:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w19so11837717ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ORguQGJ+jcnqw8eowE0KKiCcX55E0FSXFsOOApHEpOM=;
        b=U68Zh9mQBLzfJSdNR58ymOgPj/T4+G/zPlnyNdI/nsm3+1yMhbcmP9xrqAP3k3Xc+t
         4IV9tCu2U9nBjgB0WNJbhmSuUd2omplTLqSUH+FG7OUD2mcrt03QINczFmQvuSHdFgn5
         ngnf1ke/CQYXyBPlN7VCr5YWXXiUFXAtjaLXGB5D5uawKSwDNnZeOXAAC+ET+t9dzKYU
         Pgz5Raxph4iLk2qqrfXPPMEkCK1ZLTI1H5R4NjODKXkWuyKDhkZHQnGvuJjvlRtFFc7b
         cPOi4rwoqmiTZRtTk20f/ryqQomOAMIv++52KXlKxVk5VZdWI2Uy1b9lBTIxXAQyvClU
         7w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ORguQGJ+jcnqw8eowE0KKiCcX55E0FSXFsOOApHEpOM=;
        b=V46/h8QnxWKyuM89E3whM3LdxaBsUs/FuYVc1gLU3BTMK7JlGRtEQPTpikHqxlHjOR
         bknMQXbWMo7AXCoBbTzJutwXHOs+vXmxMdz/ExoORV9KGvbLW2LyyG3waqpqbdIt6/xx
         4chQIefihBTZQE8vV2gkxY8V93nlWpDdbn0v2YMTwi1SyQNiCZeFQeOvNhThkOJmTpsv
         sGMWQQLSs5Yon9vG7DeECMd+s+VJ3XPqgZsvNK7zmXjDyhtPaarTk6Hvy1XSx9lfaf9d
         EsO9zsp6G/agwELFWBmAH/vaw7lnn1AyXx/rqwnq0TnlWaTALUMyPpIovby5viH3eaPU
         G7qA==
X-Gm-Message-State: ACgBeo3WGyWR2buhoEFQd9Jd0Lg2eJSfJ4Gx+N1YveITVOQfqJ7+M+0o
        JMEJ7Kdv8KiygplLWVluLlYdTw==
X-Google-Smtp-Source: AA6agR7syjIYMu2DxjRvWa53god5653pNfvbu/mnSo4Wf8ca0qOupBU8ACKnZieein6B5857rZXlbA==
X-Received: by 2002:a2e:bc10:0:b0:267:b34a:52e6 with SMTP id b16-20020a2ebc10000000b00267b34a52e6mr10145748ljf.292.1662461880397;
        Tue, 06 Sep 2022 03:58:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a056512200400b0048b193041easm1658504lfb.209.2022.09.06.03.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 03:57:59 -0700 (PDT)
Message-ID: <872bffe6-416e-0d15-5994-0cf80c2063b4@linaro.org>
Date:   Tue, 6 Sep 2022 12:57:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 2/2] MAINTAINERS: Update fastrpc documentation file
 from txt to yaml
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org
References: <20220906103055.2089519-1-abel.vesa@linaro.org>
 <20220906103055.2089519-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906103055.2089519-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 12:30, Abel Vesa wrote:
> The documentation for fastrpc bingings is now YAML. So update the
> MAINTAINERS file.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Abel, I sent you two messages about this patch that it is not
bisectable. You did not respond to them, regarding maintainers entry, so
I don't know what to think.

This must be squashed.

Best regards,
Krzysztof
