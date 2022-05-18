Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1829952BD47
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiERNec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiERNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:34:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73E7BA56B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:34:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq30so3688116lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ah9AxJVzSaQ3+r9Loj2Ovb9Rw/v+KatzxO1BMfL+FaY=;
        b=nFiI0A8F+bpe92lCYMZLjOahTBeLPTF7XoP3i/HugpXGpP01LeQ+Da0HOCdk1J/fV3
         a5yB5CyBDxg1uaDGpxPC8rQgswKxkwHw7ZcV/e67uw/uONgEfI1d+AWYM0jY5iw8T05S
         3TKoSH0uqQSR+FgCmnQAWUsHrXDaM4+SNjsMVZ63+5SJWJwUhmJZ5+jz8Ewaw5cTcXiY
         wujJxKC3cjeYM9MigEjX6p8X11yvnaQd/LoAR1kD53l3HAXgMIpqhSP5DOyed5RGOI84
         Rnymh3L840T62/uX5g4OjqLFC7wACi1j1+8PNcl+rF665jt7VRbwEpHAm4Bwq5OSqaTr
         HEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ah9AxJVzSaQ3+r9Loj2Ovb9Rw/v+KatzxO1BMfL+FaY=;
        b=Ag2nWWcjONoI9PZ6TyaGXHNDNC8BZO0j7LBqpuxwLCpIVgbmgHELdASE2BLawJn1MA
         tPHR6uETGry6MHoy5Eqz6uYIK5bMC7STUaiz7/pcDAEpD4a9aG1v+wWVtCBM1E2Q9/Oh
         sd5afZi7rOJIRI3acFisdJK+VMW3JwUVXPcNMvBSM6OoniIu+wDFC7sR7a1JWGsxA19c
         AwPsGC6ieslIHg/Z7uDpD6+CcxMoL27el1QgeknGwt3SF9Y5tM3xjY7Yx39ZBLPRmTfZ
         iCuJLiwS5o6X/hGQPKH+SKz71+O/FZ2EFK73vij7F1srcOi7VLut+1RQ8t5YFnnaYxWA
         nc0w==
X-Gm-Message-State: AOAM532v1FyY730k84LobH356Rx3qSHWaiyuy9RiK66ZJCMo3/7mHdFK
        s//K/dNavOqHJdxTevpMXADGDg==
X-Google-Smtp-Source: ABdhPJy6a4PUHZ2TmWJGHb6uoS9F6DhW9demiYpT4UUbMNLedvB+yPMrdBxn6atjBxVouRAXtP807g==
X-Received: by 2002:a05:6512:554:b0:472:1891:a14b with SMTP id h20-20020a056512055400b004721891a14bmr20246331lfl.677.1652880865160;
        Wed, 18 May 2022 06:34:25 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v14-20020a2e960e000000b00253bff9ded8sm219930ljh.21.2022.05.18.06.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 06:34:24 -0700 (PDT)
Message-ID: <bc13e57f-9701-80c9-8c7a-e491fbcfd181@linaro.org>
Date:   Wed, 18 May 2022 15:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/6] dt-bindings: regulator: qcom,spmi-regulator:
 Convert to dtschema
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
References: <20220517205341.536587-1-robimarko@gmail.com>
 <2905b9ae-df66-eb12-60fd-306ea2d3d626@linaro.org>
 <CAOX2RU4dH-iUMY8yebEEgdJRqm37AHBMH135YkNsnDJMPZCbPg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOX2RU4dH-iUMY8yebEEgdJRqm37AHBMH135YkNsnDJMPZCbPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 15:25, Robert Marko wrote:
>> I think we misunderstood each other. Old bindings indeed did not require
>> the interrupts, although if present they should be always defined.
>> Therefore here you should specify number of items and their names.
> 
> Yeah, I think we are misunderstanding each other.
> 
> Old text-based bindings specified the interrupts, but no naming or
> number was enforced,
> so I looked into the driver to see what is going on.
> Only pm8941 has interrupts defined in the driver and DTS, so I added
> those based on compatible
> matching, the same as with supplies.
> My logic was that it was only valid for interrupts to be described if
> PM8941 was used as describing
> interrupts for other regulator models will do nothing.

Indeed, you're right, thanks for explanation. Your patch in such case is
correct way of conversion but allows any number of interrupts with any
names, so it's to relaxed. Maybe then better go to previous version,
where these interrupts were defined only for one variant. For other
variants they would fail on as unevaluated?

Best regards,
Krzysztof
