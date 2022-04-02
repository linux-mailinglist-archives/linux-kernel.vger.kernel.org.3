Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456994F0516
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358530AbiDBQ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358528AbiDBQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:57:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022BE160C19
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:55:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k23so8399097ejd.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nfi4NEK6MIGGOAKpFGw3ah+OgZ8k4sVFe3sjs7AcqKI=;
        b=R9o0JLcLKKFkgcjNXlnkGZo74RAn4fx6d8+oEhfEiQdz9ohinjsUMYIbHGFs8pTg72
         AeObhxIY/YhiJkekxiP4FoBpJvqI7b2cCmo03xP+S7bmFVyAWgwLI4VSyEv+3A7IaKFa
         4VxZ4zHWYR5Awejm+qzr0EC9IaiRToORoxnORkAazKg1DxPsXQmiX7/g29YO2WqRwLVq
         xwCeA43TIEdS1YhYgLLupmFZ/11cKfP+DZZpC5JTo5GPbb+3RO2dR9Ruvmxfn3pVyZNP
         X8VbolWxl2yR32EpDZUe7RMdBh9P3PVizLnoiJ7WBx/AZjlGjiEQmZLvZr9T3/8ZHz2S
         xS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nfi4NEK6MIGGOAKpFGw3ah+OgZ8k4sVFe3sjs7AcqKI=;
        b=JhdF3Uqlwookrok/tzkrb+WxEBmhQVayV2hfHgHm1mLsgeQqDvd52cY4cTNWHXGnEv
         sJpZRooo0sz4eRezycgbZ40bu3eDe12YpKHZ6MOxWC9+pHIVwmFs2ZvFi7ykp18+WcLd
         oxGWl4+g1GZxIgtRjRV7nONoP3f+dvRTXG6WzoNhNgkT8Bepnjunbbg8m26SXrjiJ8LN
         CrSTzWJoZAnfNmtTPdzk5yhy9AI/WALrAac3xJThnJlFmL+bjlBkUH2kfO0PlAYDOaRV
         0Tis912KPha3iqoSzS2Ly3n8Axyt1ykd1GCY55EkCvVU9M/RZWoMRFDzLNNh6ac+OKOb
         rMrA==
X-Gm-Message-State: AOAM531GUiXwZzS9sH8yrcGtRsSOMNorT07HSaKpSuGaRFbICx1p26Lz
        UhENAaOEwawAfSSkwRshQDr3KQ==
X-Google-Smtp-Source: ABdhPJzV97548dTgRrJlT61n1xfow5lqLQajsyqG2L4623QqUac2p7SFXZ10wARzCdQ9KlnmqK5lRg==
X-Received: by 2002:a17:907:60cc:b0:6da:9616:ecec with SMTP id hv12-20020a17090760cc00b006da9616ececmr4716491ejc.298.1648918556604;
        Sat, 02 Apr 2022 09:55:56 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ec10-20020a0564020d4a00b0041a68df1a71sm2629455edb.77.2022.04.02.09.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 09:55:56 -0700 (PDT)
Message-ID: <ebfdfed2-58c3-0b3d-b381-9160a00640bd@linaro.org>
Date:   Sat, 2 Apr 2022 18:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 15/16] dt-bindings: clock: use generic node name for
 pmucru example in rockchip,rk3399-cru.yaml
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220402143636.15222-1-jbx6244@gmail.com>
 <20220402143636.15222-16-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402143636.15222-16-jbx6244@gmail.com>
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

On 02/04/2022 16:36, Johan Jonker wrote:
> The node names should be generic, so fix this for the pmucru node example
> in the rockchip,rk3399-cru.yaml file and rename it to "clock-controller".
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/clock/rockchip,rk3399-cru.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

You received here the tag, there were no changes in the patch, yet you
ignored it.

This raises my concern that for all other patches you also ignored my tags.

Please resend with collecting appropriate tags from all reviewers. For
places you discard the tag, please mention it in each patch changelog
(under ---).

Best regards,
Krzysztof
