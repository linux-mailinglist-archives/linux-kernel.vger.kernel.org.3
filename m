Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03498522D15
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbiEKHV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbiEKHVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:21:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01EB61625
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:21:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z2so2216166ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RXqalM416ApPrla/4DErz/ii+vIxKRe2oyKQomPkyMU=;
        b=weKbfzvbT5aLuUAztiVaLWv9yObZ4ovS1g0mJE8aTbCrP+3IqUzozCgtA/QxA8liBW
         xlSkA3NAx45i+qKkSJyNGEIM8KOU+jFeBkHHlhAgMVfq/+TLcFlAfJm7dNrr6GFk7bG0
         kopTrFWc0gM92nLNI340RBiRcX1j5oofa6vOdJFFnie2Cp0DErgv++KsgG6PoI7vQ+a+
         McjpZqGE8bfJilA5FZ7akhW2HlHFiQxJaBl6rt3iWNUHE9h27q34eX69Bktzx/mDZO/u
         o/kJY1T+JpaXqfyD2HgBcDyomJlXPrGER93rAJdfCyph8ENxOnQV+GYcMU33YM+lGve9
         LyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RXqalM416ApPrla/4DErz/ii+vIxKRe2oyKQomPkyMU=;
        b=VPphGRVuhMW/Rm9+lHq29SD/DSfi9eGPtnT+sIhCXz0790IkYLLjwYCGiCykecfBvV
         WfX3e+VVoD0XxtnfXdVPt7+23VM60iuDqXQyNft+ukf7g6xX308pCavHysZR+/FIKQdc
         WKJTBNPrW031IVpfGZ0LtypVh9JNr09a+4J2s+easZz4UX151EOb5kFfvpxjDBQg5GZ3
         DWNtrP9FKQ1jVPWIvZwHepvWF43K9zrDotF0/pG5rbD/a55gywANkJqMwGH4xJmwD0Gl
         CISzQjiEbC9IxLsZo3LpEikXV1AZVoiWlxa1fcTTZ420VkVcYcd1nu5olNLpQuhJE4+h
         aY0Q==
X-Gm-Message-State: AOAM530TkJ/t5WuFLV0vinxZ+cF43q9qednkpdP+WttLwoKHMGrbG0oW
        3j8sx35EHRwVcuDQKQr5IqhABA==
X-Google-Smtp-Source: ABdhPJxcrj0KplZqqraMGc5jXewWMW7uSDQbjHFyf6/MFSIOrKtW7ZaBrpHpJK+X1+Ie2x65n6aXqA==
X-Received: by 2002:a17:907:1c82:b0:6f4:d2ee:2f8e with SMTP id nb2-20020a1709071c8200b006f4d2ee2f8emr23589094ejc.714.1652253705131;
        Wed, 11 May 2022 00:21:45 -0700 (PDT)
Received: from [192.168.0.253] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b006f52dbc192bsm633470ejy.37.2022.05.11.00.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 00:21:44 -0700 (PDT)
Message-ID: <b6ebc33b-dd42-fe01-27be-c0d312548f8f@linaro.org>
Date:   Wed, 11 May 2022 09:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA definition
 for mt8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
 <0686125d-4984-5dcd-32ca-4eeece09d7c3@linaro.org>
 <4d2b1c2c4ab27ba96d59b9a0e3adcdab311ec897.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4d2b1c2c4ab27ba96d59b9a0e3adcdab311ec897.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 04:26, Rex-BC Chen wrote:
> Hello Krzysztof and Chen-Yu,
> 
> Nancy thinks our IP is more like rdma.
> Blitter may be somthing for reading memory and writing to another
> memory, but we don't have the function of writing memory.
> If we use rdma, is it ok?

Sure.


Best regards,
Krzysztof
