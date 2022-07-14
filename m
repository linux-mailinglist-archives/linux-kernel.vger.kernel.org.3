Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80419574DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbiGNMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbiGNMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:38:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC835D5B6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:38:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so2547704lfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HQulMpi6ebVv9hyML4tItyIl5xLpbKDct7PC2mpkxeQ=;
        b=Y15if/WpW0q91C2Y9DNd5hKZKCLo70vZSVfKCUyH2usUhcei6e3nSqr6EwqGa2Rlnu
         JsosEczb63gWp6i4MT/bliv1m3JVWLpCT6kGsapwxovXu2dKkLEkzDHdNLKj7GS3/NNc
         XEDmDtWX3CsctxWmhtgoxO78tV7XBl9u0oQnyGuwYKWKU0W5DgQZOH3AyW1zoaa4W2kI
         CsFf97Y2lmpVlAKkWY9AHY12N8AUEBYZGObMCQ77degYNqIM66mbTTTcK/veUUgUUBtj
         2R3g7Q4W6GAPsIHExS9egWLyPWx4EDm3RwsxnWSgLQe//GQ/eGt103J6YXBCfa3d3U3o
         /g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HQulMpi6ebVv9hyML4tItyIl5xLpbKDct7PC2mpkxeQ=;
        b=ApXc5FvssO4jphCRW+rYCj+drf+ro7eRPE2Umzc8cbTzuBYRHqRUh03Vz+YoOt3VsM
         U+YunLLZI8ngE0O39pMVqPKiJ9w3peiYru+1wAt0hWvgE4hrL6yxshmGpmGUqaeQqWVw
         6XiG3SU9BJn8m5msUEOR5XgdKR6LDchfwQM/UuT4vJJVS0kKRZ9r8ptkMkjSrw3jYG0B
         P+CviW+OwmW0cwwQqzHGpB/5cysV99bwmtfRylAF8hNyzJz2NjAsNG3iSth+KaAJG/Mo
         yrpqE0TWXvApt0aUSWIToNHkFQTDNsiDcfgUxV80/2A7ecur1bSoS8h5VAygJHu+DbzH
         ugKA==
X-Gm-Message-State: AJIora/TsDFfE4fby2YnhiuheIOrWNu25nW6d8JYazI1nDnYREFocu93
        QOl2/duWLJl/5UPmcHCNFNTPag==
X-Google-Smtp-Source: AGRyM1uPdUxesSgoWpPZ0YuLdgLiEr1sKPKCX/u7HpTO1yuLeRFIoXnMjcyv6kwZ6ag04SvqI5RDvQ==
X-Received: by 2002:a05:6512:2243:b0:489:daa1:42a3 with SMTP id i3-20020a056512224300b00489daa142a3mr4794511lfu.567.1657802294472;
        Thu, 14 Jul 2022 05:38:14 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id p4-20020a2eb984000000b0025d84b41cbasm265946ljp.121.2022.07.14.05.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:38:13 -0700 (PDT)
Message-ID: <ef67622c-859e-701f-c6c4-756954b31784@linaro.org>
Date:   Thu, 14 Jul 2022 14:38:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: Add device tree for Sony Xperia
 1 IV
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220714123406.1919836-1-konrad.dybcio@somainline.org>
 <20220714123406.1919836-5-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714123406.1919836-5-konrad.dybcio@somainline.org>
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

On 14/07/2022 14:34, Konrad Dybcio wrote:
> Add support for Sony Xperia 1 IV, a.k.a PDX223. This device is a part
> of the SoMC SM8450 Nagara platform and currently it is the only
> device based on that board, so no -common DTSI is created until (if?)
> other Nagara devices appear.
> 
> This commit brings support for:
> * SD Card
> * USB (*including SuperSpeed*)
> * ADSP/CDSP/SLPI (modem remains untested for now)
> * Most regulators (some GPIO-enabled ones require PMIC GPIOs but
> trying to access any SPMI device crashes the device..)
> * Part of I2C-connected peripherals (notably no touch due to a
> driver bug)
> * PCIe0 (PCIe1 is unused)
> 
> Do note display via simplefb is not supported, as the display is blanked
> upon exiting XBL.
> 
> To create a working boot image, you need to run:
> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm8450-sony-xperia-\
> nagara-pdx223.dtb > .Image.gz-dtb
> 
> mkbootimg \
> --kernel .Image.gz-dtb \
> --ramdisk some_initrd.img \
> --pagesize 4096 \
> --base 0x0 \
> --kernel_offset 0x8000 \
> --ramdisk_offset 0x1000000 \
> --tags_offset 0x100 \
> --cmdline "SOME_CMDLINE" \
> --dtb_offset 0x1f00000 \
> --header_version 1 \
> --os_version 12 \
> --os_patch_level 2022-06 \ # or newer
> -o boot.img-sony-xperia-pdx223
> 
> Then, you need to flash it on the device and get rid of all the
> vendor_boot/dtbo mess:
> 
> // You have to either pull vbmeta{"","_system"} from
> // /dev/block/bootdevice/by-name/ or build one as a part of AOSP build process
> fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
> fastboot --disable-verity --disable-verification flash vbmeta_system \
> vbmeta_system.img
> 
> fastboot flash boot boot.img-sony-xperia-pdx223
> fastboot erase vendor_boot
> fastboot erase recovery
> fastboot flash dtbo emptydtbo.img
> fastboot reboot
> 
> Where emptydtbo.img is a tiny file that consists of 2 bytes (all zeroes), doing
> a "fastboot erase" won't cut it, the bootloader will go crazy and things will
> fall apart when it tries to overlay random bytes from an empty partition onto a
> perfectly good appended DTB.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - remove a stray blank line
> - use generic node names for CS35L41
> - fix up indentation for sdhci-caps-mask
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 634 ++++++++++++++++++
>  2 files changed, 635 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
