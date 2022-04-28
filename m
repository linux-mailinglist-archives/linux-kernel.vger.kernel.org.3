Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12000512DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbiD1IEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343515AbiD1IEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:04:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E29245B5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:01:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so7880467ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N3zGC1wvB/nv29USBZmgr41Ud8zfxazlWsebIt8ip4Q=;
        b=alOVobKdRyJlxqUq5m4tQ+rLDAJA7KXpBB2ytou6HHFpDfB3f5kv+zQalrik8copss
         r1LItmgyw22vCY2WbxQviTHxqrVO9zGDeP19mxvGGOWSsViC039ZIJtfWuSpK7+ntt7j
         sCYwOm0atELLB7BV1Q+c3DVfueRMW+41ISUWXROy+lTX0VvobJoYCMKKpXveTJxFSJxk
         /RWoLfVl9SGr2M8IG1erfZzq/fQSxN40+x10Ch7IpqCdSSQFPWIHJPhmiHekkHot3W4w
         Uo6Rgxm9orwY9a6EpcUK6k+8DH7yXc2/6vgWLzV481iPLPuPR8A7dmZXJrBUoUvAloZR
         ybXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N3zGC1wvB/nv29USBZmgr41Ud8zfxazlWsebIt8ip4Q=;
        b=Ck8K8tDcQevKK/ZCUdgyiMs8Nxkxufz67eJCyaOLRFqFCwmuMNBV6hE6B6yzYwrXkU
         /lwbEuSBFt+ur39fWtUVKZBiIqtt3S8Iucp0beyGqzSu4dZCHVCbUoUESocikMeQ9NwY
         FPo2oitH7esF32SvsWigb+FmP7zCMfMZbGrcIFbXj3o4TJefTANs630s8wtS7squldCX
         kAsMrbfaZTJkNnMw5r2rI+08W50Oz4wh064WLEMpk3EM8xVuXXw7II6xaRvbsbeHU9VR
         TBHgohMtTsM7bzWkQBsRzXWdUBs0PlXGRdkh5LMiNcOXNBQa5x5KOKT8YtnS/R9+v7Ww
         +5Sw==
X-Gm-Message-State: AOAM532ByiaGQctgzBNchtQut2a6sz+bFXCI9vVvHUDYD7txoykT0KAn
        Ol2WNxKBVwBfzzfhFj1f7DnKHg==
X-Google-Smtp-Source: ABdhPJworzFD0TJcsIvHlg66JrAELoo4MwLAYTdDemevzuTQhZHWIqepHbmVFR5ZuQxbvYQj2P1hnw==
X-Received: by 2002:a17:907:97d3:b0:6ef:f445:dd96 with SMTP id js19-20020a17090797d300b006eff445dd96mr30238068ejc.416.1651132884946;
        Thu, 28 Apr 2022 01:01:24 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090690c400b006f3c15eefb9sm2784318ejw.17.2022.04.28.01.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 01:01:24 -0700 (PDT)
Message-ID: <6a2917b8-90a7-55dd-d814-5f4dd515c908@linaro.org>
Date:   Thu, 28 Apr 2022 10:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] dt-bindings: display: simple: Add DataImage
 FG1001L0DSSWMG01 compatible string
Content-Language: en-US
To:     Philip Oberfichtner <pro@denx.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.winker@de.bosch.com
References: <20220427135229.2339865-1-pro@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427135229.2339865-1-pro@denx.de>
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

On 27/04/2022 15:52, Philip Oberfichtner wrote:
> Add DataImage FG1001L0DSSWMG01 10.1" 1280x800 TFT LCD panel compatible
> string.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
