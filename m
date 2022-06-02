Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EAF53B80F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiFBLsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiFBLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:48:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC7299791
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:48:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fu3so7972658ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=shtQh66+bKE1caS4jMSRSwf+vIlH6pzW/iS7K92y5Eg=;
        b=dc99xUHQThcX6ryKAYXNpafER9Kk4IqWJ4hIN06w5R5rjWA84E5p4P72DZDYGBswsI
         kl3C21BvdXefH2LnJlT8rU/+JezOsqjRAd7tVk97vXLFhMeDIOIeP+/Hp1s8R6ceOle7
         uJyWHNIybbL9JlE7dlJkzTO14TjU88UJAYcAbnV1SoMbJUDCi4gpZvk1mcW9ONfryXbq
         ORVmAj8kEwf7k8Tdd5l7Rqpt5iQBFZoY0eQzfumt+hDyJ4nLrjHN3GpDX20gJiG5a5se
         RMEgmqvFaNz8hsnSvQNIVgD2JYnNez5HZ+pn120+o00MrgoJA0GpTygS1KP0PIywXThn
         JVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=shtQh66+bKE1caS4jMSRSwf+vIlH6pzW/iS7K92y5Eg=;
        b=GqmwsCza0Zdw6p4uFvughnUwr+NWLrjnJL+rcQB0yl7MSoepSQLYIzy3QT5bkp3tGV
         ZOiW1qVexerlZ6rzAIitP1W12DyWNnLZKPSaM22klTNykj1A8IAd2udQ1Ioweg7lWfRI
         kf7rbWJkirX8oKYnBWC7N6CPYLmqecgWCut2BAIHPlIuxTfE7Gp4U2CP7O79Z5eu7+dh
         ZYZSU77PtRhm2Le+1fpzPbhl9fzLwuqfmYclLH7bqXRwVep/blH0nKqUPf8ku/nla6zs
         OAOd7Se+f184pGBlm9SriOg+uOFZ7GVnbwhEJ6KQuEvIp10OLmCQ6SORphpkpLZ33lYM
         lfTw==
X-Gm-Message-State: AOAM531yXvH+mJJdvE70l7q9uA84t/W1hii6ifixmkOHzi7Ivbr6Owtk
        JQddQzQeZCHxT4wKSG+v0fQN9i4MiAL7JLKJ
X-Google-Smtp-Source: ABdhPJxtzQcCHEhLjniV51EOj16IsDhDJgdLjg8JxuGS0HDjPnelZO6FqkSKvw60weMLoHwb6tlJqQ==
X-Received: by 2002:a17:906:12d3:b0:6f5:18a2:176d with SMTP id l19-20020a17090612d300b006f518a2176dmr3728521ejb.474.1654170502863;
        Thu, 02 Jun 2022 04:48:22 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c18-20020a056402101200b0042dc6e250e3sm2329738edu.81.2022.06.02.04.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:48:22 -0700 (PDT)
Message-ID: <cb8c7e28-dfef-78e2-c97c-11b9dee02fed@linaro.org>
Date:   Thu, 2 Jun 2022 13:48:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Update email address
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org
Cc:     agross@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <1654130923-18722-1-git-send-email-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654130923-18722-1-git-send-email-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 02:48, Sibi Sankar wrote:
> Update email address to the quicinc.com domain.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 2 +-

Thanks for updating the email addresses. All three patches should be
rather squashed to one (and taken by Rob for example), it's quite a
churn. Anyway:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
