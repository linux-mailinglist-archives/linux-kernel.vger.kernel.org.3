Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15EA57ECBA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiGWI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiGWI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:27:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1312F2A732
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:27:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p11so6134408lfu.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2n2UJ/+3iJaUYMgrHfASASdjwSo9Al6kqw/c32WAOhk=;
        b=gggpmFdg2nW17a0F0lgCxdcV/m0aNWCH/44I1cZQ4tBjdIHa15wT6MEaG5CFTle8L+
         lXOMPyFJK5YXen51QZiezL+tWgOsHfIVtIoBIycw3MDx2cGu7q4y3tyhi6CdkCkyUMeA
         a6QHSt1pyjlXZxNlXBUlxAfY4DH4Xh2gC2QnhZEbdEKwxjHG3DfMMd8AiyCjF88/RmOI
         LfOlMj1sMzwjD1OhmlrFycKGjrgBa56BcVCfdVojy1yZebKyskUUBhwldaMhZoikkeBX
         wS2jPIojNtKnTz9h4qGv1Yr3sY6IMzAHaA0W91RfSqdUObIfwBwssHwEcVlUxbqS6hD4
         yksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2n2UJ/+3iJaUYMgrHfASASdjwSo9Al6kqw/c32WAOhk=;
        b=QfPkm+oZYcRKTfPMZvYlpijX3d/id5eHOn+So+puuw5s29ww/2MighYoOBD50oSGJb
         OT3R4BB3vLx3AhlUk0E0pE7aURrMhUzKm/LEdcBVCDbgYFTbQRJes9HPkJpk5KoWx7Re
         LUxMIFyWTmA62ytt2W5fNB/UHYGtDNXhSwLnvVNyYmN2CH9Jn7ENiawes1EL/0oeiKkS
         0itsEJQa71b6bhbaNO5R9GLET95JRRzplC+eowdzskrAgCWepekg69njUIE6566thY6J
         3g2Y98Mn2J3FeT/v+cBYBBSpaW4epdTBKYthcTdGenQ6TpT6buA7zMV352hoMNioz19f
         jzcg==
X-Gm-Message-State: AJIora8ITI9JtteOy1zACN1PnvfEP/37+il/7TRQ7X+B3+gahXZdtor1
        HEJK4QCypYvH6PckMNnv1iwxGJ/whuJbi9Oa
X-Google-Smtp-Source: AGRyM1vWWS9caJHUIUqf6CAjbWuVstmpc/HF70UbNoGAQZ14kTKxjW7UUNcvdsq2OZy6dhKnfxp4Hg==
X-Received: by 2002:a05:6512:3342:b0:489:e36b:4149 with SMTP id y2-20020a056512334200b00489e36b4149mr1388490lfd.588.1658564868434;
        Sat, 23 Jul 2022 01:27:48 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f08000000b0047f65b60323sm837988lfq.3.2022.07.23.01.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 01:27:47 -0700 (PDT)
Message-ID: <3b5bf57d-632f-7b6e-7c7d-9a4cd39b317b@linaro.org>
Date:   Sat, 23 Jul 2022 10:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: smd: reference SMD edge
 schema
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220723082358.39544-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2022 10:23, Krzysztof Kozlowski wrote:
> The child node of smd is an SMD edge representing remote subsystem.
> Bring back missing reference from previously sent patch (disappeared
> when applying).
> 
> Link: https://lore.kernel.org/r/20220517070113.18023-9-krzysztof.kozlowski@linaro.org
> Fixes: 385fad1303af ("dt-bindings: remoteproc: qcom,smd-edge: define re-usable schema for smd-edge")

To be clear:
This is a fix for above commit (which got changed after applying, maybe
because of merge conflict), so should go via the same tree - remoteproc.

Best regards,
Krzysztof
