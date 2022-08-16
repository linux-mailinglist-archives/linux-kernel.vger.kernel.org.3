Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B3359566A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiHPJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiHPJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:30:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D4E11B4D4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:49:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by6so9832097ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SAejUFFCQNt+j+xwuoW3jHwPOH/rVvouLgiRHal72RA=;
        b=Nd2fhV/VaL72FFIo/is9YPIp+d0tc2VTysn21/EE9oHq/0P5hgLRZLPHm0D/XsgD7Z
         VlbcMgMpbi9+7DL8jKr/9Xz82BEpQhfGShqRHvux+OZ1GDa3EsdJdFIQk7lpP0TFhYo5
         SvvjG+YbDchXeCdt9Ch9HdM9O9py6p+ZAZfU7TulURI/uSAeG4BHkM+dlHlDpNydENvo
         Yfy5j1qpm24DloGUssQGnDXTnIMs8JhNn3OC9G/SPKf5hGlXAX2Cb3HMBrNpvMFQymRP
         WHRBVcOxZs/eLBBnnI6RfVPc9kl74chja5g9sfdMdJTZTiwT3OB7ZMpa72Pvfkl3e6w9
         yVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SAejUFFCQNt+j+xwuoW3jHwPOH/rVvouLgiRHal72RA=;
        b=6s0r4hkHtXd+xpqX2XyQXIhfQlH3warLLPDcwPWyDVoXPRp7aV8ASjUSzisGeXziFR
         teKG+oJ9L6ESOkVWPhPO8NMx8ez7yE+OHznaRF78YkiVeqkEPZ0JdA3qCI47rEJIp/yH
         rk72bWevR8PQwuqxC6XvbzOgrShRmogiVHNkyQtCqpnE6p9Lo9KDgpHDDT/PLWpsoAId
         TeGi8wdNO9TwoCeRsWlWzlBtgMGJPVKd/UBtBWxBcPmD1FhEx+YLEtlDWnmecvweH0T0
         HJGqs6WOAAZFMh8r7oNkm52aw5vzxBqDpdSVhEjJA/8LYYZRc2wpdDlFusA+YS3HU2OE
         qqbQ==
X-Gm-Message-State: ACgBeo04ORtGGQplW9vxfMX3moKuHAddcUd6gPtx8MTY2ykeKUAIMmM6
        63DTQnFUarRxMDlZno8Hm0RFAg==
X-Google-Smtp-Source: AA6agR7YnhFNe5Ed7tGtyQ+mDj1iuRvb65JZjphfZX/S5+f6iom4DkcGLIDIQitAULHttjSS/F3bFg==
X-Received: by 2002:a2e:9950:0:b0:25e:5777:a17b with SMTP id r16-20020a2e9950000000b0025e5777a17bmr5992650ljj.32.1660636196351;
        Tue, 16 Aug 2022 00:49:56 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b0025e4fcadc72sm1692421ljo.92.2022.08.16.00.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:49:55 -0700 (PDT)
Message-ID: <338f2929-aa67-bf63-2d66-5de48f6af1c4@linaro.org>
Date:   Tue, 16 Aug 2022 10:49:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 7/7] dt-bindings: firmware: document Qualcomm SM6115 SCM
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Adam Skladowski <a_skl39@protonmail.com>
References: <20220815100952.23795-1-a39.skl@gmail.com>
 <20220815100952.23795-8-a39.skl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815100952.23795-8-a39.skl@gmail.com>
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

On 15/08/2022 13:09, Adam Skladowski wrote:
> Document the compatible for Qualcomm  SM6115 SCM.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
