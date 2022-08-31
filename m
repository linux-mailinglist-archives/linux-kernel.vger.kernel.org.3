Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AEA5A7850
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiHaIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHaIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:00:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4EB2A415
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:00:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bt10so18831540lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TkPqKp6gjbypc/OlKyeoW96EDJplATwLNsEk96PSFw0=;
        b=MTUOrhqogrdKBywcj6iVZObqLr9LtK41Fa7tE0ONyzIEGA2gcdnVAiT2IYoUGHFn42
         JJ1txb5RAyot1y7RhYJj8ZnUvT5Ay54NqNP2/Ym4sq74dM3Wi8Jia9wLF/Q4kJ2vKxRc
         NHkmKWXkDpQStP34F8m0RpQwddMlHTTiiK+xbK33ib1PidqTVJ4kHIOWvirVoJomGTro
         qjCtjZCuQjQCjHd1z0dpUppi8pDeU+IfgM7HN7nThSVWAwpFO33yLuob8fB0DXElZ694
         vpa/vvbV4AM6S2vsntcwqyIG++SFPpKDWcCgVlBySdtrzBXanjLX4utjh+eF/Ymem0CC
         SaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TkPqKp6gjbypc/OlKyeoW96EDJplATwLNsEk96PSFw0=;
        b=g2qexNZCkI8NSJ10mh4HUQpLqGweG97oJsYVrNwGNnVtANyK5XZpfbbWoUdtv/dcO7
         p07Q8Q9DY9ZJ+rK5YFcSte5YLu8iqEF8ZxC+DZH8i54QsFVS7moPAuwT2EsHzjsGRDBH
         T+RySUI+AdZKpWWnDG2HGyXIezXLiw9xi8vKNgiTTsrcNbRsuT0d4CB+ry2GnJb7ZMUr
         MflPHNJkH7A4URKS5hLFJp9lWq/dD0LxCPM793pnx3sNZkChqSEfLubu8ryXQI2QPiqx
         XJxcruYeFjjWtQ1rd6o9Tv/+AL70HKFxIrt3L1OPry54gCyoT2no3Osso6WdeGKLnkti
         4GVQ==
X-Gm-Message-State: ACgBeo23NX8h6jcMcCNWWyhdcj2Yba1wA60A9G0BNIke7niBK5L/fzlR
        Ezu1EiI5x0WAoAwu8KGGvRTIRg==
X-Google-Smtp-Source: AA6agR7rMAk7sMgv9IVgAja5rZ33cvoPjgDiqkWUnA14ZXoUxzCPS+ETLO9oYpWGc8dYWm5yhYqxhA==
X-Received: by 2002:a05:6512:20cd:b0:494:6f1f:216 with SMTP id u13-20020a05651220cd00b004946f1f0216mr3416426lfr.617.1661932815313;
        Wed, 31 Aug 2022 01:00:15 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id f24-20020a2eb5b8000000b0025e5cd1620fsm1175777ljn.57.2022.08.31.01.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 01:00:14 -0700 (PDT)
Message-ID: <453bce1e-e2d3-bf26-9954-774e1e267d82@linaro.org>
Date:   Wed, 31 Aug 2022 11:00:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v2 1/5] dt-bindings: firmware: qcom-scm: Add
 "allow-multi-call" property
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
 <1661898311-30126-2-git-send-email-quic_gurus@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1661898311-30126-2-git-send-email-quic_gurus@quicinc.com>
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

On 31/08/2022 01:25, Guru Das Srinagesh wrote:
> For firmware that supports it, allow multiple SCM calls to be passed
> down to it by removing the serialization lock in the SCM driver.
> 
> This patch is based on this YAML conversion patch [1] that is in-flight
> currently.
> 
> [1] https://lore.kernel.org/lkml/20220708090431.30437-1-david@ixit.cz/
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>

Thank you for your patch. There is something to discuss/improve.

If you make a resend, at least be sure you Cc proper people. Use
scripts/get_maintainers.pl to CC all maintainers and relevant mailing lists.

This was not Cced to device tree maintainers, therefore it has to be NAK-ed.


> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index 9fdeee0..e279fd2 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -70,6 +70,11 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  allow-multi-call:
> +    description:
> +      Specify this flag to remove SCM call serialization. Need to ensure that
> +      the firmware being used supports this feature first.

Missing vendor prefix, missing type.

Isn't support for this obvious from compatible?\

Best regards,
Krzysztof
