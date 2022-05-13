Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B47525DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378452AbiEMInI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378317AbiEMInH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:43:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6754627E690
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:43:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z2so14880993ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TjKayUeoGz9LcIPFjCuV1lUpAVC89m1KwyIymwOanYQ=;
        b=vebrQ2nEECjiJZIr4ASXEoRcwne89Vrt3XKYPxQn4Ngn5/KBA/+djvWEsFiSxvWEnR
         tOj6z+9HaqKgydCp3ETVn3UVjPDr74U92gVOBSwyUNMMnr01Nqvyxr9kC5TaEecTGl+P
         GnVOIryzImESKHkZejPJx+xOeZnC1mD6bVxdNBIDrrO8WZXJ63f3PSHy65nlekrUNvBh
         bYYTwOaC/YsdPodku2hfrHkTZhMxdDqEOnjOg/7jQlfDN/NOOaPS4MtJdQUnekPZ4Oec
         h/OsVPS0LIoLihQAZAcoiAjqxBSwgVHRKH2fFHtK3IK9FajYXNi1FCKXw/nicd7SvGp8
         sPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TjKayUeoGz9LcIPFjCuV1lUpAVC89m1KwyIymwOanYQ=;
        b=BqIhMRG58Ci3LtAvOcriNDgimbn8sl0bGzWbwSR75+ECezRyUD4PoWgEqQI1tCDtrn
         h2FxsS65sGdYsXENwPZTvKAp/yMNTQzem29Tchp9cyx69DSa2Mm+DhIgcsuz420m4/cH
         uMz0rW0xgKpbKCoUwnNUaJ1RhM3X5L/fUfbwTSJCh2yjnLw3VpYgsgtTI67/u0RuHYeH
         YWMoOmAf85jBK6mYVOQXOUAMQg7QeknvnG7rvxcpOMC+XmErpzGftJFpRHLaDjmiKW4B
         0/1wMbMCh2mXrxYN05SL/mjSeq+fD9ciEQNVXiIkVvsAkBAhcIzy/5xpmW9H+2qPhbxP
         GZtA==
X-Gm-Message-State: AOAM531LHtf3jzKpXTrbqMSH6vVp1DhnQcmnBnawzIHH8czy5e1NX/XF
        XwBCsHD7b9VcrhIP2j/MiTGJlQ==
X-Google-Smtp-Source: ABdhPJyXPkNCKq60uQ93gjwtZY8bIgP996nqib162PCEJlF7JFjR6xldyp/iixY9xzYTBoSdSBwAVQ==
X-Received: by 2002:a17:907:1c1b:b0:6f4:a763:ac67 with SMTP id nc27-20020a1709071c1b00b006f4a763ac67mr3243379ejc.252.1652431383949;
        Fri, 13 May 2022 01:43:03 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090600d600b006f3ef214dddsm533788eji.67.2022.05.13.01.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:43:03 -0700 (PDT)
Message-ID: <08e1bf5a-5ac5-ddc4-fe0e-765883709c43@linaro.org>
Date:   Fri, 13 May 2022 10:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 05/11] arm64: dts: marvell: uDPU: align SPI-NOR node
 with bindings
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220512124905.49979-1-robert.marko@sartura.hr>
 <20220512124905.49979-5-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512124905.49979-5-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:48, Robert Marko wrote:
> SPI-NOR node should be "flash@0" according to the bindings, so fix it.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

This is already done and should be in arm-soc. Please rebase on linux-next.


Best regards,
Krzysztof
