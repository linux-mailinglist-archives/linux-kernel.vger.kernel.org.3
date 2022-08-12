Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B8E590F14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiHLKSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbiHLKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:18:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11172AB4CA
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:17:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o2so750526lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JBdN3TTY+x85cJo9xU+STNsmWxxgCOjlwR8dZZFbZ3s=;
        b=it93Fcojqit0LSDm39bwjrQBHwb2Xg/hi4qz9c3sAHCyfShJGh+MW5isbblmYcfrdw
         WYxjGjqceRInUE/owps9tUL9g2+7zXcwRYy26Acp5g2+EUHfiOxb/KdowSx0e1N7AX2l
         USVjoiXHpbp8LQs3wwax0iF4lScBmtlso2UcdcChmsez8PAtFwvoqhtZnzAwq998Kzbo
         /2RxeDXaJ6ryKiiSNN1wPFp7oVrwQSVRNXblOvZzOpENXMuS0cKI/ha3UYKuYHBa0hUi
         pyba2ICfmp/ObiYxSCjycvcnCHdIYUPgi8/HvQYC/9FEAmjxUcqflP1J2f9qZ1rNW9UN
         4loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JBdN3TTY+x85cJo9xU+STNsmWxxgCOjlwR8dZZFbZ3s=;
        b=MXl+N3ggP03xFo/IqMAagmYbxerAAB06aMdlMKQWtuFbGK2TBv0SlNJ9AcJ5XO6HSB
         ev9mj3XErGntSb2xvOFSddextYkKVpXhbM54Iy+xhPC2aQ7+4d5aOGWHbcw4qOabdwqp
         HFs2UECYD7DdsrddZjkb57NHPhNbuTaEs1IeA5306ma0BjLPBxi7CSjJn3dklOZPP0Me
         cPyOquVzIcibqhu3z3luryYpMVxg7NAs21UiEKNriIoB4njYSrf83SwjpNVdrm2Z1pSL
         ZgF+RCausGcQ5/GrfHK8x22U+CLRE/j/IM7pRPrG0iGfyilDuc49lLaQ7O4XxmztBl+E
         9/Nw==
X-Gm-Message-State: ACgBeo2iOE5haxusZ1Qp5lCkEHHiFOcXKhfy3uyc4YDKyC04/Ljn8r0g
        loTXwqkxyWlVgbetX+kngJwN0Q==
X-Google-Smtp-Source: AA6agR62mmgR7MSduKYEvF8c3bd0NGBXjOqFvuYc+OhdGe6rUbRjeGOiqhaKsUKBG7wsid0zUflTCA==
X-Received: by 2002:a05:6512:10d0:b0:48b:80d:849b with SMTP id k16-20020a05651210d000b0048b080d849bmr1092925lfg.399.1660299477473;
        Fri, 12 Aug 2022 03:17:57 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id d27-20020ac244db000000b0048d029cb0b6sm164373lfm.112.2022.08.12.03.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:17:56 -0700 (PDT)
Message-ID: <26668a74-2867-641d-0e50-52ee5df8123f@linaro.org>
Date:   Fri, 12 Aug 2022 13:17:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/4] soc: qcom: stats: Add SDM845 stats config and
 compatible
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
 <20220812101240.1869605-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812101240.1869605-2-abel.vesa@linaro.org>
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

On 12/08/2022 13:12, Abel Vesa wrote:
> SDM845 is a special case compared to the other platforms that use RPMh
> stats, since it only has 2 stats (aosd and cxsd), while the others have
> a 3rd one (ddr).
> 
> So lets add dedicated stats config and compatible for SDM845 to make the
> driver aware of this num_records difference.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
