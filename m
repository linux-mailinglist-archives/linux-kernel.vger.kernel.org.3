Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239B9590F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiHLKRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiHLKRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:17:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD5AB4D2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:17:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v2so732661lfi.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qm3oHgt5B13dIjYKK6eUU/A8/VtmFj0ol7g7oapz5+M=;
        b=aOencBwV+DRKMGzaTWY9nQs7BhWYTejYgu5UodVpEblmBJNb5EYZhiRiB4RxisO3t/
         DqI5RFBHIqiaA2CxhMx8BOzLfxU3R5RryOtugh9oV5bVEy7DASKRA9JnNdP5jyYQegaQ
         2TYYCvHtqqXBNugUXhAliD5AeKb304UoXaSadntpjPYB5nB9awlWLYUcqJH07kDyRw0L
         PBSF1QudtVJ66W6zwMs9H+VN9uA0H9NgMqXviwFRf0/d4Uo/LXUxfZbuU9XPl0hBP6+r
         QKGrfgct0FLxBPKcRgflHVRddQ9NHdmGqChqvDJ2bLOi2OVIim+VtKIOWzzb1yL3jQkC
         BO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qm3oHgt5B13dIjYKK6eUU/A8/VtmFj0ol7g7oapz5+M=;
        b=q0uGS+UjERhSykgdHwzmGIEV/Xm9R2vlZJMZoUWXD7hg/rxRtXaBVyVV3XAkseaSy5
         031I3CLj+gvyT+rN6Zsdly2SeFA5BlCtO1e9VsCSOcv4ZRdlLgcunFhw8byBmyZuYy4H
         dde6WOIXR+qTCJ+nvvuquwrgfm0rOjgTxR/lEdAvmKPNAPpt25/z7yw2ZcQd2KtUEfLJ
         Xkb1eo6MfUZ2YCK1lOL+oHddnkqNP4ddnlV/rgXEAfWPEgsFQ7kHcwhnAbr4GsCSFbLr
         NO2D6zUJ1bRDvJGmL8x5Trkyrp+hg7zjg3vKPcUDUMRRdAeHepLW8Eh9+r79vdBs1fdb
         7ZBg==
X-Gm-Message-State: ACgBeo0NKb6RNe6bDCUM0UZcRO1MsGhoUiugtU0U0pmj0zuBRT+OIDGO
        nT9enoFbSONT4rXTwmxzdH5Tz4Qx6MqKhzzo
X-Google-Smtp-Source: AA6agR67Uf6uHs6jnfE+zi/DcgB5VjCC8K0ChXMUtLdanDW6TqBgzyBms8UJvqdyIX+xw1vvIVOLdA==
X-Received: by 2002:a19:c506:0:b0:48a:ee19:a820 with SMTP id w6-20020a19c506000000b0048aee19a820mr1168029lfe.38.1660299446952;
        Fri, 12 Aug 2022 03:17:26 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id a20-20020ac25e74000000b0048cc076a03dsm160597lfr.237.2022.08.12.03.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:17:26 -0700 (PDT)
Message-ID: <2ebd89b5-1c12-d833-4303-099c9db94ccd@linaro.org>
Date:   Fri, 12 Aug 2022 13:17:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sdm845: Add the RPMh stats node
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
 <20220812101240.1869605-3-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812101240.1869605-3-abel.vesa@linaro.org>
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

On 12/08/2022 13:12, Abel Vesa wrote:
> SDM845 is a special case compared to the other platforms that use RPMh
> stats, since it only has 2 stats (aosd and cxsd), while the others have
> a 3rd one (ddr).
> 
> So lets add the node but with a SDM845 dedicated compatible to make
> the driver aware of the different stats config.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
