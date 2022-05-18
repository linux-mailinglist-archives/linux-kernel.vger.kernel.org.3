Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F0152BEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbiEROv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbiEROvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:51:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3A8140DA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:51:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u23so4114517lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q2kVv7m8CBuZD1Spxccpokl1oQNMGRMweenLQqgX3NA=;
        b=WSD5MDaGIePij6AavQX6fQeRh9N4oOjCJInF9gHOOt45EwT8ryHJ8ib0FXBTb0dR8C
         qrgBXXutdSRgC+VztsX9MDEBexeOcTIjJoEUkgTX/SQ1gvltiPxa7T9h8p9iCZbG8a1p
         cT+GU6GuhC21a4aJpyte/wHfhwlGcKWfy6I6dzbi6O8xC7zq3+6X8WDbZdBok45GbLNV
         1pnlPnXUoJSeK3xr2mEDkJeJoc6fHum3jCHmw6PXfKdnf9YHI6+bfugt7gb0Jm1hTu5T
         +GWJ1azbimpBoST1MQF0gPnZ+WrGROfnHAoKnQJktpVpoqeWdLGwFvBPaHIV4zWe5D7M
         fuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q2kVv7m8CBuZD1Spxccpokl1oQNMGRMweenLQqgX3NA=;
        b=5W17/y2HWVS3DrqnYGBqrEL0xmNykrTFlMalm6Ag7ZhH2r5jznCOqJmfJrgCaVfnas
         fTB42L4qCSdcwL4zYiBLRLpDNCoxiu3OALCh//BbYGAwyUELx2ypzOzhWjFCSfwANfu+
         wmHRO9nLjlV3QrneB0ldClRDXenmP103hXTL/M6oN6Mz3WhP0T3GJ9aRif0Zg/lCyuFi
         oDgcCfq0UBZmXTBCWbYUjvouO6Ht8vGxEpdFTpoP/aJygrOmZ6ZnhH2QO2i/BwlIhefM
         Znz9yuJxILZqWob1fbfrvlXtGcDoElYobh+XUKnWQUISi1Ez2BJiopwKbKTVycO5LDSG
         m8Xw==
X-Gm-Message-State: AOAM532yl2rK1N+Krd5a8s+ibYAqJgJqo01cM0+NC53LLaBfdRZ3Qrcl
        IwI1+fAWi73/5uFaukIP5Jf27w==
X-Google-Smtp-Source: ABdhPJyDjM6ZjqmxjxZktytCmCb28biT+t612+tqSzXgR/FnJIzxhkFtch4kb/cOn/WT2k9tx583jA==
X-Received: by 2002:a19:494b:0:b0:476:5917:b67 with SMTP id l11-20020a19494b000000b0047659170b67mr19048509lfj.452.1652885473701;
        Wed, 18 May 2022 07:51:13 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x11-20020ac25dcb000000b00477c0365b20sm59449lfq.188.2022.05.18.07.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 07:51:13 -0700 (PDT)
Message-ID: <cdad0dbf-2712-5710-8bea-612f3de08036@linaro.org>
Date:   Wed, 18 May 2022 16:51:12 +0200
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
 <bc13e57f-9701-80c9-8c7a-e491fbcfd181@linaro.org>
 <CAOX2RU6sW5x-Ufbgz5pxWRnOMj=jrTXqHuba5USKgBnfc+KeJA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOX2RU6sW5x-Ufbgz5pxWRnOMj=jrTXqHuba5USKgBnfc+KeJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 16:00, Robert Marko wrote:
> 
> Yeah, that was my intention with not having interrupts as the generic property.
> I will remove them as generic property and only allow them per
> compatible, cause I tested
> adding interrupts to a PMIC DTS that does not allow them and make
> dtbs_check will
> warn about those being unevaluated.

Thanks, apologies for the confusion.


Best regards,
Krzysztof
