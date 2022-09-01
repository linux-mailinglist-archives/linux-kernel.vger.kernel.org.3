Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2675A9BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiIAP3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiIAP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:29:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E689834
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:29:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bt10so24961624lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BCY/cRkulmgD8efvrpZqAejN7PwSrZj7VLEKd75R8dk=;
        b=EEg+s2Dk6ErATC6NodQiY0vR22s5pNaUp/idyFYWYa+dPgvboxX3wbd5I5k3vb3uEZ
         M4jlGBzEl8dqrTqFyMAbQwM4AMV76qpiItod025PJDUvPhRDDbj7eCtZKI8zC1peOSLX
         ROdrrCYYaM+ZY/5COw8hWQnsWy0HC4xfxcP+TyLi2tRAs4GR2zNYZtvE9O7hD4dw1cRc
         1M6Oz+xGv4LqoV1gVcx4iFAyBZIFcPY/6GH0sIkvaRjHa/GV8jsGi8MggQX9HoUCedgA
         3/78GVIfmx3vv6K80T7nWJiuk5PF8zJ4vVjELR3qocGmwzAVrsS2vAqnR6Nczj12qfvD
         zz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BCY/cRkulmgD8efvrpZqAejN7PwSrZj7VLEKd75R8dk=;
        b=HVB1EMYc2rycukelSzPfra7AlNewGDvPqFFxg6+b5slaf0vwyqEYDvZBmffUxKN1Nl
         /tYjM38Y8P5h/XDOb6Ydf50wxaWsdvxaY3qdTAm7CPw4qYss5q6gESbxKm2piKKgw1mX
         S7HLdrR7vQCcVVKLXtW7i3yR++NGlMrX9ZdN83vguHSKoUntTrVT+J9K6vlt7SvHc0SU
         1ueqYZ0KZVNbZsh5jeWlgFRz/nWecNuHhX5IWGqCe6HDCtmd7sERU9bbZjkYOqoBZKNu
         GkVAK2tZ3TJhtETZx7GC0XC24vxYvmUeUMpLprKKyjDet4prrst6PO9dcpI73xBoH3YT
         bhQA==
X-Gm-Message-State: ACgBeo2cwggBORLlFXQJsfVeLI6ct31evjadD7YhQM+KHE7pwKIDlcvs
        j5eLnQXLVrVIjeuOYFN1kdOyxQ==
X-Google-Smtp-Source: AA6agR6At8ltsyotH0RJp7m2Msf4mRKclPNAQhFe1NEiooPETdAZnykN74Jn0wEWps7gOZ7gn9z1Pw==
X-Received: by 2002:a05:6512:3408:b0:494:9aa0:b3b6 with SMTP id i8-20020a056512340800b004949aa0b3b6mr1295316lfr.318.1662046157817;
        Thu, 01 Sep 2022 08:29:17 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512214b00b0049461118819sm1875284lfr.77.2022.09.01.08.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:29:17 -0700 (PDT)
Message-ID: <f16cbcaa-1457-b809-1323-39f07695bc7c@linaro.org>
Date:   Thu, 1 Sep 2022 18:29:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/4] soc: qcom: icc-bwmon: force clear counter/irq
 registers
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220901124730.19460-1-quic_rjendra@quicinc.com>
 <20220901124730.19460-4-quic_rjendra@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901124730.19460-4-quic_rjendra@quicinc.com>
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

On 01/09/2022 15:47, Rajendra Nayak wrote:
> In some SoCs we have to force clear the counter/irq clear registers as
> they are not self clearing after they are written into.
> sc7280 seems to be one such SoC, handle this with a quirk flag.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
