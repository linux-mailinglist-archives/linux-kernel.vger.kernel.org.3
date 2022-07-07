Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA039569B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGGHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiGGG7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:59:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0A6DFE1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:59:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e20so800737lfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=iD4mGg+qM8HG6/1MdfbFXBy3mtObyupuyZ17+Do+v7o=;
        b=ONpy15sjpZhrdm7lyMQyfqEirPUf4QXweXCqJDoF3TmiXGQBcXclsdsNCXlcl8/U+7
         DHpIipWoFQ2JGNOTVXBFjUvRiXX+brHFVQw8VAqi+cqWUBrcnRSHcuuubuR7WylgjEUT
         W06VefkS0KRN8y7Xd5+RYq7YlxaY6rVJFYxsccYJVMzwiREVouKmUB0Vz3SiNdExmagD
         7LpZ1RJHWjIPqKx0E1eONMR9prhM8FrLTy9c7lR9slmEaI6LhQNJIo67MldHHf87cekH
         4rOck3CrGYOAexdyBOYaJspX7yERoJnZxnOurumSYlJtITEDcY6heba9W0bFQOI0Vt3F
         7wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iD4mGg+qM8HG6/1MdfbFXBy3mtObyupuyZ17+Do+v7o=;
        b=zSreeJoN8d93dol0vFW5Z1Oar7tWX1nIajMRatT09hdi9wrn1vRcR0OZigI0naY+55
         ikE616in1XDot3zMFzse5WO5xwCZ0GQsDOGaLBCg/4xY21zNZoLkeyWj3wovq0Gi+fAH
         KWBVKKOU8wK4eeF2ZLb7EVeUMChEIKVWQxWGs0ICotkx/zshFwlsQ3exiaE4H+CTK6Ao
         5txQqrwiC4rY2E2/BUCkSGyT241jMrlOUTbFnKYnE+DP6fV7W2SNK38+ZQEta6/yGtnC
         HyIX2E128sSeFtLRAadxOPwxdv8m3Rs2g4vec4d1mCIbe6sttQFb+u4Ebj3F0LorZclS
         ozMw==
X-Gm-Message-State: AJIora+3ASxtbMLcxn/QIWE6HR112yw6umdth717IrPkj5RZIJK/GIkn
        /Po6m7vIRafU0R1xaVOKkfFmLQ==
X-Google-Smtp-Source: AGRyM1tMrmU5392DvadV6XBmRrqfiY+I0d31ph62y1mTwXDIkZJ91YrBcx12opHaqwcWL7mnx0+fZQ==
X-Received: by 2002:a05:6512:3146:b0:482:e8c8:1a7f with SMTP id s6-20020a056512314600b00482e8c81a7fmr9900182lfi.62.1657177163289;
        Wed, 06 Jul 2022 23:59:23 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bp23-20020a056512159700b0047f65b60323sm6681329lfb.3.2022.07.06.23.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 23:59:22 -0700 (PDT)
Message-ID: <379291a5-c48d-7d78-fdec-9b67d6b71fd9@linaro.org>
Date:   Thu, 7 Jul 2022 08:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] ARM: dts: qcom: add missing smem compatible for
 ipq8064 dtsi
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20220707013017.26654-1-ansuelsmth@gmail.com>
 <20220707013017.26654-3-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707013017.26654-3-ansuelsmth@gmail.com>
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

On 07/07/2022 03:30, Christian Marangi wrote:
> Add missing smem compatible and hwlocks binding for ipq8064 dtsi
> smem node.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
