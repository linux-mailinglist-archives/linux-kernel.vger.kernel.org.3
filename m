Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9073E5AC603
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiIDTOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiIDTOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:14:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6513EA6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:14:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z6so10372258lfu.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 12:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3GXh/ns1cJ/0c/GapXMPVA54+Xh4yfj4dl+7YFfWaUY=;
        b=wkk+uEcKDPx2YAmk7uSmpiP0cgoeu8Wq1z7ZeGpxUFA5yFBN22EgebzlDhFopcYLOj
         1cJV6h/SrBlvUo5g2hEMsQp2f3E8Fy3u1IKNiVNHx0gntkdlmJD8AmpZqwSYfmIkQZeQ
         HwgQLVlTap+yROtvfOo03sHgJVqnY0K5MbXkFEc3twCJXVWWBhqNGWVseli7gBHPGh1d
         +v17mkHqE5wBDmcIpl84E9AeQZ/sTw0VptttUOBPRI9NT8nz+HPtaSVaScfu3IlQZCRt
         FjizDrvAryJQ6Wd3yy4XkYd96uEBaZ/eyKamnEkKzCYK0aK6LtUiU8pomCHY5pmL/9oW
         wr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3GXh/ns1cJ/0c/GapXMPVA54+Xh4yfj4dl+7YFfWaUY=;
        b=lbgZoJE93jErOccqUs6wvU22jqdJqJSDdsHPpSv5LqpVwNgC0fp7OM2ie676Q4EEyT
         q6WNx7WEcFKRs6RQAAIxLw8N4RLg/vkn2fEqAtKB9PNh+rfQbyb1RLVjCgqZ1yIlOn2h
         LJQhbqEiGT4yViDrOkyR9maFlrP/zZEyDOQqb2vYuieFQeMtHsAxvgpLYHrU6DkqlnlP
         Lc72Du+oTkYQjlnA+wAJHMBYbqPH3816sxbwNKM1JYtyTpufEREk1VMvWqAF1WvYLJqh
         fW43NIJa1RaVXvVXhq+VVf2V5Djn88adRLH9TgJgYfBNTCidZ5Jx3zdfyfOa5jYCU/FO
         geYw==
X-Gm-Message-State: ACgBeo1dGur9rveQll+JoWqVtDwpsCdET1dV/WA4dcwJTGC8HdzSU5WL
        BzrTSth6FFUyTJdzLQwgnbu85Q==
X-Google-Smtp-Source: AA6agR65rv4fXBrevKCCM1P0Gy2/g/+9ZK4R6CXmOMuFjn+F7xVJkIQ1wisP9+dZws3s8X+HDpKvrg==
X-Received: by 2002:a05:6512:1149:b0:494:9b4f:75e5 with SMTP id m9-20020a056512114900b004949b4f75e5mr6148774lfg.236.1662318883009;
        Sun, 04 Sep 2022 12:14:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t16-20020a056512209000b0048aef1abb08sm987827lfr.297.2022.09.04.12.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 12:14:42 -0700 (PDT)
Message-ID: <423bc933-2049-5bf8-b0ca-7e1ddc1f5852@linaro.org>
Date:   Sun, 4 Sep 2022 22:14:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/9] dt-bindings: firmware: document Qualcomm SM6115
 SCM
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        linux-kernel@vger.kernel.org, Adam Skladowski <a39.skl@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
 <20220903174150.3566935-3-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220903174150.3566935-3-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2022 20:41, Iskren Chernev wrote:
> Document the compatible for Qualcomm  SM6115 SCM.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>

There was such patch:
https://lore.kernel.org/all/338f2929-aa67-bf63-2d66-5de48f6af1c4@linaro.org/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
