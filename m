Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31715212EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiEJLBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbiEJLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:01:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2D149F95
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:57:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ba17so19528230edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hP5Qt4iyca+XwfT38e5QSOL60aC/HqAALnLY/TUKCos=;
        b=AEfURBdjsXwWF/lcnLtglije6dm0motmFUJ3sHf/KkiBswiXy9ufjlvwlDrR8WN4PL
         XMuEpKM07Pqu9NcReVRuZc3A+BIweN6yHXQr1S3nbr8pUlcuHYBz38kRdm64sycaSvXE
         OXg1rzHEXLqcL9QRpUYewLWV2+dKqOxqw1TLTEQmvpx43S2ZTDtTH6ky3U1jzkqcqGC8
         AcKmC8TZWXCmrP/cm6i9xBgI0MmH4YIDvYb11g3Pi26OkoxNETSWljjEqQL+GQRrHofK
         YlsS4Ju/BRl2euM7KPii2RrZs+NzRZf+Ogd1545zbmABGq5xffHTMxTib7OexD0VCOaC
         Nsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hP5Qt4iyca+XwfT38e5QSOL60aC/HqAALnLY/TUKCos=;
        b=gwtg5mC6gPQy9VuacDeFoJ1uYnEWxrKMmtKjYcE4ENAQsm6S4YrsgIT+xOkdre+IV/
         cnamFnQ+7pX2RR+F5SimsqDcHD2wsey5toL+rV2irhi8KJmfKtAFJrk2Hj6bzGPdu2vC
         n5/UKPqzF2NSyY9J1I8OrNfdnDNiYKaXHCyJJEYu6z9IbPLgETlzuTPgKN7m359r9piL
         QutjU+3W4MaA8S2ArP3LqQ+QSue5QIXDUUsQChg9UaP9/3bbb3YioWSvTaxYF1AJXDBm
         2vKg95pbQNomA9BGHUl+2ni14y3P9XXTbkWroGpDAJ5FA+DCW6gBU4gRkTPJqY9XwcP3
         iooQ==
X-Gm-Message-State: AOAM533MfXyGNRQ0hI+aiX27mpqlCo6HZ3AQfuuxT3A8OCWproDhOgUN
        6+DOnWYnqY/NXXZISIp+oujemw==
X-Google-Smtp-Source: ABdhPJwV2FoRMmaQQWsKESFLsiexggF0TXhfn9LN0RLxYk94n+1r1hcpoWyyOn26z4+WeOxzmE6bzA==
X-Received: by 2002:a05:6402:b2e:b0:425:d3f7:4c1a with SMTP id bo14-20020a0564020b2e00b00425d3f74c1amr21827716edb.366.1652180232182;
        Tue, 10 May 2022 03:57:12 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t3-20020a05640203c300b00428aafb23d0sm1351992edw.57.2022.05.10.03.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 03:57:11 -0700 (PDT)
Message-ID: <0686125d-4984-5dcd-32ca-4eeece09d7c3@linaro.org>
Date:   Tue, 10 May 2022 12:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition
 for mt8195
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
 <20220509044302.27878-2-rex-bc.chen@mediatek.com>
 <a5c9e7ad-c4b5-e757-cd6d-f79de47d1ff3@linaro.org>
 <fbbbc7e6a951bdde648ddd896f1fa163dafa16f1.camel@mediatek.com>
 <1c3fd336-1450-9b68-df81-2f01cc2ba32f@linaro.org>
 <CAGXv+5EHFjqiVQbXgcJWCo+TmaTU_z4e0g85beMLCNjyx5qJcw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGXv+5EHFjqiVQbXgcJWCo+TmaTU_z4e0g85beMLCNjyx5qJcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 12:37, Chen-Yu Tsai wrote:
>> Use a generic node name, as Devicetree spec asks:
>> "The name of a node should be somewhat generic, reflecting the function
>> of the device and not its precise programming
>>
>> model. If appropriate, the name should be one of the following choices:"
>>
>> I proposed dma-controller, but feel free to find better generic node name.
> 
> dma-controller is covered by dma-controller.yaml, which references
> dma-common.yaml in its entirety, so I don't think that would work.
> 
> What about "blitter"? I think that is a generic term that is/was commonly
> used with display hardware and sort of describes the function of the RDMA
> & WDMA blocks, and if only one side is memory and the other is the display
> pipeline.

Sure, sounds fine!


Best regards,
Krzysztof
