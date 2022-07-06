Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7810E56819A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiGFIe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiGFIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:34:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86327248CF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:34:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f14so1948141lfl.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tbROXJuaUNyE9T7e97KZkKnACaJUpY/X9+QFnQ8oDPE=;
        b=VESyoTmYDvpY1bnPj2lWExak6y7KrhjXC9XSB3WmwkeIzeqLhHhJQ3c4R0doIr6u8g
         VzxVuE/8A3YCLGwVIdbgqrZIBcpt37kuOJc3WWAoZTkcqG+pywtzu1NRxyYpFH7BRmrN
         OhsHUpCYhJNivyYhWxbQVuaBv1E3ZvcOU6f+2F7fz+mz0vXwBzattxRyt0tDzpLQdpQU
         jjnXN7mnJ+xTQ11ej4W0HC7Jk4CHhePhwqtIt0RLdyNSIBiUJpua/u7Ie50shKoexWtp
         dQF2pK8BfjE6zLU74iYBmHnohevE0cB7aGOk8sTAhufV0aNvYMLaJKfSAetHGodaSPTY
         k10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tbROXJuaUNyE9T7e97KZkKnACaJUpY/X9+QFnQ8oDPE=;
        b=LfGF9N1YOKUPdIl5hBupPqLIyDWSOLvQmSadNBuNFNlhfr9IkcU273DkjsStdjUq67
         XDlVXKEuZhZ1hBuB1W0hssp9JPE5osxeled4W9TRXiPHxddpeQFMFCHJ0mbgSLpj3tHM
         ILRt8MbNqiXPn+Y3Lt5v6+nclisJlLq5UH15TkQFqEm/pVCDUtz8ygo+7ar2iNoekQHE
         1iGKZ5j1a7XhvE8L0RJVEyDvHRH9juGny4cAKEw3XVaPHEq01n+f4+vg4pgH7qnzZzt2
         yu8azUY0m9O6cyrDreZUact9d0FXQuyZWE9UoT7WwxRU8iD0B9D1R71Ugxi4o+gkHhXS
         upcg==
X-Gm-Message-State: AJIora+FC+4Ll47lyJTnhPbMCWFsXbLU22cbT3ToKPsEUbnoZuC32sLn
        FhQACdmNmCl8gbQ0DQ9hiBBalQ==
X-Google-Smtp-Source: AGRyM1tYKyycnHBZXwIlqnuzGUVSnCUQ+d11AGy1OgfLxF9toAYe0wyNzlG1FYyOsyR0wmDnMtdy8Q==
X-Received: by 2002:a05:6512:3e09:b0:482:bbd4:9657 with SMTP id i9-20020a0565123e0900b00482bbd49657mr7182196lfv.86.1657096491733;
        Wed, 06 Jul 2022 01:34:51 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id k6-20020ac257c6000000b0047f665e2df8sm6134476lfo.257.2022.07.06.01.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:34:51 -0700 (PDT)
Message-ID: <ad7b4082-fe79-3f01-eaa6-b9809a55aac3@linaro.org>
Date:   Wed, 6 Jul 2022 10:34:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/13] ARM: dts: qcom: disable smb208 regulators for
 ipq8064-rb3011
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-5-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705133917.8405-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 15:39, Christian Marangi wrote:
> Mikrotik RB3011 have a special configuration where the regulators are
> not the common smb208 controlled by RPM but they use a TPS563900
> controlled via i2c. Disable the smb208 for this specific device.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Jonathan McDowell <noodles@earth.li>
> Tested-by: Jonathan McDowell <noodles@earth.li>

This is the first version of patchset. How did the Rb/Tb tags appear?

Best regards,
Krzysztof
