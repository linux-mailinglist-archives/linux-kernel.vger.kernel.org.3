Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959C052D009
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiESKBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiESKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:01:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE952A709
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:01:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a23so5594472ljd.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Hbm4yf+el+tFvaYL/Hvdyk+jw+gD0Z8FpjuTi6F8CU=;
        b=P3L8qPnk9J8q7Zmcw3q2yp9RZ77/2vt5h5v0nFjmLXhTJYpiPjlsnDl5P+8MwP+NSC
         3PkYgzQ1jAQmLXEabJeL9tzRY1hXakzBjEGyaT7JJXuB8Qw/9N+Ne+AVaudI2MagqZ1v
         ti1ll9I6Y39tXbMlaqmSqRuRZFcgmfPELczHvDO/aJYVvHzHcfQ35pcnO/g2pOOlgcUw
         2x3Kxv99LTluz3noQcNDRK3caIScYCxr22H64K6hk0Z+Xbe9RxkdpvKoOVC+0G/B9MVQ
         bt9A2PyJp7/HWCA1BOLj6EBYnRqE5JbE4ZRS97Ko2wAc9MYnEOXNxUsmhnEOw+IxiIvF
         aYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Hbm4yf+el+tFvaYL/Hvdyk+jw+gD0Z8FpjuTi6F8CU=;
        b=ncT+iklZThPpukT9bg3f3oTk48MYTXPaVf7S12bBT1Q8EmNS3D7LidawWQR2W5InMI
         4dteLJSCcAOmUoARMJBCB8ll53tga99Rw0SBf93YQ3FnnYk3cFlq4dTFUCLPRrhGBIzS
         +L3jOBGmIH2Tv8dyqZ4F+4Dugtu2N9yOIIAHoiyo4g+GD4jDGBPmSqHPSoNhsYvOGC56
         EtpEk/+vICal6xIf6uGUOa2qzml8NXXF4GC6HR4nt30TE0lRJD3FVxdv1d1Zj7kZ7rD5
         11s5eQatfo1A/yaONsBzlr3Nk895f+RqvwdBnms+AVaiqavFD+GXDpsZ1C3MwsUfp134
         W3Yg==
X-Gm-Message-State: AOAM533y33bY6jU5bwXomIutVvdopw7YOAih80gZeZ+IqcpuHEOCcI/A
        EBm+zNlGCuUJ95M91xsecH81AA==
X-Google-Smtp-Source: ABdhPJwpGabBICjeLnO2G6OFpyyw8fKv8lMujCQy0oQKn4FP4GwvqoEWRaXCpGPRnFALGTLcUHV5Ig==
X-Received: by 2002:a2e:bd12:0:b0:250:d1a0:217e with SMTP id n18-20020a2ebd12000000b00250d1a0217emr2182112ljq.310.1652954501959;
        Thu, 19 May 2022 03:01:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k30-20020a0565123d9e00b00477cbc03a42sm67023lfv.84.2022.05.19.03.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 03:01:41 -0700 (PDT)
Message-ID: <3bb95350-01cc-b15b-3589-16019e3e9105@linaro.org>
Date:   Thu, 19 May 2022 12:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add support
 for Xiaomi Mi 5s Plus
Content-Language: en-US
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>
Cc:     Alec Su <ae40515@yahoo.com.tw>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519074112.25600-1-ae40515@yahoo.com.tw>
 <20220519074112.25600-2-ae40515@yahoo.com.tw>
 <3644ad8a-d5d8-8ea2-b659-029619c64f1f@linaro.org>
 <NqQY5WA6i6jOhK8lZ-YD4kWA57qJCSIGJE6_xAQmOiFJ4a-msHcn7oakouduiLhODYlfWVvgr-E5S6m43Ab6EUFa0ZPYV0kPGeYbVV7zpUI=@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <NqQY5WA6i6jOhK8lZ-YD4kWA57qJCSIGJE6_xAQmOiFJ4a-msHcn7oakouduiLhODYlfWVvgr-E5S6m43Ab6EUFa0ZPYV0kPGeYbVV7zpUI=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 11:57, Yassine Oudjana wrote:
>>
>> There is no such property documented. Either add bindings, or drop.
>>
>>> + qcom,board-id = <47 0>;
>>
>>
>> The same.
> 
> These properties are already used in many device trees; they are
> needed to let the bootloader pick a DTB, but yes they aren't
> documented currently. devicetree/bindings/arm/qcom.yaml would
> probably be a good place to put them.

Which means each person is using them and not caring about
documenting... they need to be documented. I am not even sure if they
should be accepted.

The DTS describes hardware, not bootloader specific details. The
hardware - board - is defined by compatible and bootloader should use
it. Adding new properties because someone decided "I don't like
compatibles" is not appropriate.


Best regards,
Krzysztof
