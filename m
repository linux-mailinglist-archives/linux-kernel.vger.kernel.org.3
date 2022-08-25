Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D715A1031
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiHYMTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbiHYMTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:19:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D1B0B06
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:19:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q7so24284060lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SueU0ylS/DGZHRhMphFGlXlkKWtYfDHwqJySfC5KFDc=;
        b=rXY3SbT3cDcqrgjAuDNQxDR6r+z03Hgm1PNGI54Ch92dMwTsawQ93+4+2trhU4kJDJ
         lfRNvvl0nCvOmbgR7S8Mo/sXnKbKbgvfjbLYrgpp04kdhcIznUA1zie8BU1Y8/LnPZZT
         qQE6jvN9f30ECZOE8+bf1KRcH2GM1+hZ7s5IiiM1ctFgXv1FGX5UEdp+GFUxyXiPOiu5
         U3uN9i3V2zb7OADc44QfocmWjfKH7g9IChWHTkorl4miUSUvbzkHBomd74q6TdGvUpXs
         oxy78rrSsUoOoQvP45F0/6UnLimg5JGH+/jG7Q4Iudyd33LpUvQy7xcYJN+3xzqSWXUU
         Z89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SueU0ylS/DGZHRhMphFGlXlkKWtYfDHwqJySfC5KFDc=;
        b=khO6/bQmTuMfFsVavk99lMPbq+Ecsz3UJTPi/LhSymCHG3F9Of0OirIqRFFAATW/m8
         fTQj16OV7P85rGS7S0rC284sFhuPbKp1NdpNKf9ygFNTeTqFlsfSNy/0vg8xn1UEzcfJ
         MQP0s4R2sk0X6zfddPrAxQVZvXQB3eF6H+93OuAcbZPOdpK+BlRF8VXuODg3uNRjRuXW
         gszn3KvwTfavVd74ZiVT6qDkcdP2x7TfDlVGClk49haOzG63xFUK8PEZmZ5dTGv6H+i3
         5DdDXeWW3lmOZbVpb6+c+sQpP31VXZvhOh9Q5npbymV/2BwtIC9hCiZFHwOOAmoF4yfY
         AoxA==
X-Gm-Message-State: ACgBeo2/2nt/8mHlY7nSPAYFNNcyyD9dz41XcjuuVxnPrEwHeZaCbkVu
        ntl6hFcTStWsK1lv+q961FY33Q==
X-Google-Smtp-Source: AA6agR4pM2U0ex+E+y7JbIyjJJSaYib0fDTzmJk0bBUBzl9hF/aW7Gvrcig///9p44oQVBaMjMyJjQ==
X-Received: by 2002:a05:6512:31c6:b0:48b:2771:d0d2 with SMTP id j6-20020a05651231c600b0048b2771d0d2mr1029195lfe.382.1661429940494;
        Thu, 25 Aug 2022 05:19:00 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a2ea221000000b00261c30d71e5sm510243ljm.67.2022.08.25.05.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:18:59 -0700 (PDT)
Message-ID: <59ec69e7-7eb4-b50d-e6bb-6e4348b2eddb@linaro.org>
Date:   Thu, 25 Aug 2022 15:18:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND v5 0/7] Update ADSP pil loader for SC7280 platform
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
References: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2022 11:21, Srinivasa Rao Mandadapu wrote:
> Update ADSP pil loader driver for SC7280 platforms.
> 

Since you did not CC me, maybe you based your patch on some old tree?
This has to be then rebased on current Linux source.

Best regards,
Krzysztof
