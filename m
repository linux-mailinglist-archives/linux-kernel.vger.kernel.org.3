Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18A55ACA9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiFYUpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiFYUo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:44:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64B13D25
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:44:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id cw10so11369963ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H+F5Z0mfBJYQ1TfQcrng6IvkUvurloIcIvH/FYvqkLM=;
        b=y6cxvDR/U1IEONYBz/iay5T3a4fJrrXTP/TaSHwaYef9QHD8Y+cj16a+TOP7lUK0eg
         LuvAZN1z5OUmo0KrNfyYL6pr9fY+4/BN8pTFnvAx3UZOZBSkGWG9YmyUDfotF9YaP+FB
         7VrdPy8RNCtM43r9nIEUYAChz51XVTe/yY18ml+Zn77Xj+7p2oIoBuYfVOiAvOruwWvu
         WuJwX6ZN1Q9/3xZicIGOnzRbUqT5WIcDXHC8ftMixV6IaGMzT5nPzV/jPpxHRBYhswo6
         CGRc45xqPauD9dfYgY8KXK7m5S3QntAixxtjRky8fNcIUSMFE8g24tAHH3bMw8q+oJOF
         aJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H+F5Z0mfBJYQ1TfQcrng6IvkUvurloIcIvH/FYvqkLM=;
        b=honqqPvn2/lVPPDtcrLuiMPmSRtjL6Z8eSQ46LylTgQXZdz1tHh4b6jSua8D7mNZIf
         MERVG9Y3JekicuQ+RMKSL2C9gX6ORMOODm9wdl/TLZnGOCrft6xu2qOZYA3R6Av0bAlX
         uYNQURBh88mRLyCDvpw/iOvKfmaNOadmpUMVrz4z6K9UFbO1nOdGWi321tsVC4KxGL5t
         ncjNcEZn2XZULLY7PAfsCJX+Ok18mr7HEZ2O3GppzVvQoQxFCmWtO4P4gXxc6q9VezKP
         e4PzsDZl2eoDtdm33Utwlh+j6cUqa5oIARh2ythf9CLR4G3V+1O82nwZEl6B2W7UmyIp
         X6pQ==
X-Gm-Message-State: AJIora+VWErWxLAAjJjSjDTPo+jbynyOk4NI4WxGxs3Doheow3ZzSzkh
        p4REQsE2btZCEKpy6IaOvT2zpA==
X-Google-Smtp-Source: AGRyM1stq1qihX1SSO618jlh5gyWIEwJPPZfqyE6Adl0Y9IsEGshwKvra48Heq8U+1Z+XsacUUCfUg==
X-Received: by 2002:a17:907:72cf:b0:726:77fa:ec58 with SMTP id du15-20020a17090772cf00b0072677faec58mr3242767ejc.551.1656189896729;
        Sat, 25 Jun 2022 13:44:56 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090648ca00b0070b8a467c82sm3010694ejt.22.2022.06.25.13.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:44:56 -0700 (PDT)
Message-ID: <3008fa44-e3b2-f394-5880-e348ace20829@linaro.org>
Date:   Sat, 25 Jun 2022 22:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Use WCD9335 DT bindings
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622161322.168017-1-y.oudjana@protonmail.com>
 <20220622161322.168017-4-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622161322.168017-4-y.oudjana@protonmail.com>
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

On 22/06/2022 18:13, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Replace DAI indices in codec nodes with definitions from the WCD9335
> DT bindings for devices that use WCD9335.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v1:
>  - Maintain the alphabetical order in msm8996-xiaomi-gemini includes
> 
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts         | 5 +++--
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts  | 5 +++--
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
