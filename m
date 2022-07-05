Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E985672E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiGEPne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiGEPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:43:29 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674FC26F8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:43:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id i17so10250134ljj.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OuB7MAKhSmIm/m8EdDuaNR26xSu28x25kqPsH5I+hYc=;
        b=FowVvSFkDQgEiH92td3TKZ1rmVAqpNuFv3/zwst9W7djOLp0+zPsMDxEsGe6KnaTx9
         6EIHypwF+Z7L+RlbZQvXSmuidbKz580rcMt02c9ZewoTKjjHKlJ9DDTV+6ZWY9pRKC9w
         OXdC4g70ec1NqsYCyvBZ7YE0N/y5lfICdQJjETtsRRX6twA2zsn74t7apF1MSdF2Vgt8
         qCzDPmeL6l31WUpFIiRnZ0BDKtwhtDXr+smsCKI+cWh0LXnrLRgI6/SCTGJg7VzQXBN+
         YK+VFrk/Y95XQ6wpPQwfYweQUu607jZjvP39g6gZjzYVNEeEMwUgJAqcLgycnlT99qBL
         gT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OuB7MAKhSmIm/m8EdDuaNR26xSu28x25kqPsH5I+hYc=;
        b=QcOI6HLonDkkAgQUUWFJZGji0PS7PEMQ2tLamqkcHjk8qypDTwiRdr6MuLQXI4S2cc
         oLLMjLeN+xuIadIhbbojvo1oqMm3jTJm4+LNpWx3UZoRQqFFWklxXlPNBciKJKM4ISYL
         kmYigYJ8NxJxpgYKaxOoG25av35d7v4A/0NYJ55hM4H3ng6ALYZHf494Uw99UaDwApEL
         Y8DFdG9qHYup+lWQs/adI74HNNxa86CHZtpps6kKv967mxgpdyCEXvnGMKmEKxioiFDH
         DFLS0G0CNBo2Ta31rlxKTSHv3nJsypuMRmpRdBPqXOOaXlTeM/4SVkJRlHFC2d+h7RKZ
         djVQ==
X-Gm-Message-State: AJIora8rpqF65a1TLo59WdIa2sXdtVoX4D2c5rbVBToDGJhfTJYNlYAO
        gorfqpGV7AcYxkX0qYqzSkVvjw==
X-Google-Smtp-Source: AGRyM1vQQ5FSkKjbRJkOJeIKnxuG8GcyJkRO7uJHtCcAUMEyDW+cq168TZcMvQiSGXaBHhMvEoPIhw==
X-Received: by 2002:a05:651c:508:b0:25b:b0e4:8a0f with SMTP id o8-20020a05651c050800b0025bb0e48a0fmr20639827ljp.72.1657035805680;
        Tue, 05 Jul 2022 08:43:25 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id u12-20020a2eb80c000000b0025d38d13eeesm275060ljo.98.2022.07.05.08.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 08:43:25 -0700 (PDT)
Message-ID: <49c46093-e43c-59cb-6df3-f3456e413e3b@linaro.org>
Date:   Tue, 5 Jul 2022 17:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] dt-bindings: hwinfo: group devices and add
 s5pv210-chipid
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
References: <20220703183449.12917-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdUnH0oRQg3i1VorZOmNSKKXRP91BiQEgBaV5W5ig+YH2A@mail.gmail.com>
 <20220705145108.GA2083998-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705145108.GA2083998-robh@kernel.org>
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

On 05/07/2022 16:51, Rob Herring wrote:
> On Mon, Jul 04, 2022 at 09:18:31AM +0200, Geert Uytterhoeven wrote:
>> Hi Krzysztof,
>>
>> On Sun, Jul 3, 2022 at 8:35 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>> As suggested by Rob [1], I organized a bit bindings for SoC devices having
>>> similar purpose - chip identification.
> 
> What's the base? It didn't apply for me.

The Renesas bits should go via Renesas tree. I'll split the series.


Best regards,
Krzysztof
