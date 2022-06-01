Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11053A363
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352335AbiFALB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352367AbiFALBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:01:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEA880EF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:01:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v25so1644644eda.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vpsfaliuG9NS58DlyHRBXhCTZUSRtxheYp6oTpSUfy8=;
        b=hMxeBYcQAluH2FTWaiFI329As6gR7ftIzNs2gOZWcQlpzC0F/A2sx0vTo6m9P17P1s
         1LQihsl6sWEJpX+SgeEiUmgQ8mlO4Ot29b0xH82Hc6Iwgl90vW5NAVk6LsNhyfdnyxax
         8c6IJpfjcx4rBAgJagrnU5VQkhLepFE5yEAOKa+Xw//7+9VJ5hLxduZ721ln6NxfYcaM
         mS25PeS7C7ZOUJ5+Ukp1pd+zD4ryKBR8pGkYyXG8YH7rzhFndqZ52G3IuWUrCz6ES8SC
         SASu6wfYpQqPGIOlk9PhLgH783ElVao5F4B9aKyPXnNh2Xc35oEDw2ai62bFs1aIXVwb
         MfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vpsfaliuG9NS58DlyHRBXhCTZUSRtxheYp6oTpSUfy8=;
        b=Vencl8BsObFORvRKu1pHIw+UcXkfMVyCwUehxvb8y2Yae572xMnmlrMbEyc9/hzs4y
         lmJ6YfHO6ykx2OxoD5LmwD+EnBc+gVqMFSGn4nGYRfNklGC0V/6EwLtOnoMR8EKTg1PU
         eRqtIanlULWf6fTiiDSSTt32PU8/f36/2v+7LGtVXaCA/MklFXej8OoczcuaSHqW7Ss/
         wCmyY+Mw/GSN2mcD9sZfgX8J4bfQv4+rr9QxjLS1IlayscohsSMz+kmbqaZsD7dnU3uq
         KOswBW+goDpmjlixqm0NomcWIZ9KY8WEcE9Fk1bXMfIU2dm2BsFI260Ca1SOAR0/m2/Z
         wP/A==
X-Gm-Message-State: AOAM530t8YNYSmJ8lY0/XV1mMZxF5AES1f3M/rWPtXnonbszg/FFGNvY
        eWAm7QeMm3Sr2tZEx7c91Ku2DnN8S+JM5EFV
X-Google-Smtp-Source: ABdhPJxbb0xGlSdXnY3FylXuEOy3UDSMn9qg/K/QBuw5p2wgcLEu3w2FO3DZNJPOD5NnWQJHj2pZHg==
X-Received: by 2002:a05:6402:1341:b0:42a:f7cb:44dc with SMTP id y1-20020a056402134100b0042af7cb44dcmr69515379edw.165.1654081270007;
        Wed, 01 Jun 2022 04:01:10 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906bc5700b006fec9cf9237sm573999ejv.130.2022.06.01.04.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:01:09 -0700 (PDT)
Message-ID: <f2e2e870-0a09-60a2-25f4-e7a57ec21cc9@linaro.org>
Date:   Wed, 1 Jun 2022 13:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/11] dt-bindings: firmware: scm: Add compatible for
 SDX65
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
 <1654080312-5408-5-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654080312-5408-5-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 12:45, Rohit Agarwal wrote:
> Add devicetree compatible for SCM present in SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
