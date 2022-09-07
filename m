Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8AE5AFBB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiIGF2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIGF2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:28:13 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821388000F;
        Tue,  6 Sep 2022 22:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ag5A/RmCropcVrgEGeSl2EI9o9geRtdOi57vqqT+CvE=; b=kQ2pBUusDPefhBlg4MGjWwa8ty
        +/GdLiFN+gF8drvcCy7WMoe4LgkhG8JbtbwxG79U6GI3M9xRam/Y7NOjUzSv5dFoNWnjwAYzAjy4p
        HVUbxizz4LyAksmsZCBTh4b/sjr9dbvOhdLXGYPzOmjaM1LfEVY1l0HyQCouemgcXGSWFaiGrx9TO
        MO3tkQhmX3tebsgXDWXjVOWEe6WYMUUV4jOWswYcYMVbxUt9GkhzSuF0JLalzUVsr2uc1/T02Vtyu
        QGrANyvBhdh991kfEx3d1v7swBspa7ftTgtWbEpoRk98smXz+uyR0OHH5aYnwFEkhTUSzOkLFpO3A
        pKKoHL3A==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1oVnbR-00Chdy-OB; Wed, 07 Sep 2022 08:27:57 +0300
Message-ID: <1dabfcbe-7729-1a96-816c-68ae524ed4aa@kapsi.fi>
Date:   Wed, 7 Sep 2022 08:27:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/8] Support for NVDEC on Tegra234
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220906132823.2390953-1-cyndis@kapsi.fi>
 <68ff1b7e-51e1-f1e5-dac7-5419472e396a@linaro.org>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <68ff1b7e-51e1-f1e5-dac7-5419472e396a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 20:50, Krzysztof Kozlowski wrote:
> On 06/09/2022 15:28, Mikko Perttunen wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> Hi all,
>>
>> this series adds support for the HW video decoder, NVDEC,
>> on Tegra234 (Orin). The main change is a switch from Falcon
>> to RISC-V for the internal microcontroller, which brings along
>> a change in how the engine is booted. Otherwise it is backwards
>> compatible with earlier versions.
> 
> You need to describe the dependencies, otherwise I would be free to go
> with applying memory controllers part.

Hi Krzysztof,

the memory controller patch can be applied independently.

Thanks,
Mikko

> 
> Best regards,
> Krzysztof

