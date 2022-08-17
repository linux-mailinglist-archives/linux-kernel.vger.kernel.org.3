Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B515973AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiHQQJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbiHQQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:08:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D7548EA3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:08:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s23so6892635wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=WiGuvulnIu6q735m2OE5CFO6qdW7g2pKktoUfCm8PWA=;
        b=TOQ5vqO0wDqWf37UGVPLHGHkfXrrwW+HdW3eqcSwlmZPV4p5M8zUyKbzxp7vDRAoor
         SMDAB0c8shPJofnZ5o/0dSywV6K6xkV2uPj/607HJk9T8SASGYCoEfROK31+D5fTFcXO
         TSHJdxymtdaTlOO+ba69uBDzZ8cAXkNX6jegsDJ/eGE5ao/jYVaogkl0hUDaKlzQVvM8
         WWVlvvLag2VqF20LgdBsuC3MSE2Daijxak/CxkemRR6/wCb8wSB+V3j0kAVrUARPfXHC
         3YybOqOopcFdkevbNg0RNDUVHEnE0Id54MkojgaEFMpivu7D+WIXrg0VJam2z716Z0V1
         0b/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=WiGuvulnIu6q735m2OE5CFO6qdW7g2pKktoUfCm8PWA=;
        b=bPkFtHAwSaUhP5nFE/RRz1yUfE7tC/wKBEVYDxT2Cil/+nNaXClnLDrGq2Q/HE5ei1
         3yOSPDd9y8LtC9Ui6YyBi9us3fW49Dfilbi9AfbFickTfwEFfkH5hul+1wo1HX4rf7hH
         K8Tc6WOhWFBuA5ThPTIGos4VEn3tC4zzAhhGsYfViBx/5QrVmLo+tYRxFMOLUZEyfEVy
         cYEXbWFpDO7TEq3thnv78W4oVEqEkehIu+FkQO26Ew+uI8HlL8JzRC6b3KJ3h0aZnDHn
         pERERAlqfeh763nYDabhLEubqFX894zmK0Uvu8fBhwEFeF0n4XmOj1wyAGkYnLT/U/Ia
         SC9A==
X-Gm-Message-State: ACgBeo3mt5C+9SN3W7hqSRdoACWwnS7k9EFdWB5Z5Fbhh8wu5CbUMyui
        PwILbv4tdadOPOQmdiekGrhTrg==
X-Google-Smtp-Source: AA6agR4cCi7/KGiDIDnEU/GOl9MT2kv2He1kXfd8OFijx9fVzGe19YSnXSsG7YViIvmZJ10Q3a0DHw==
X-Received: by 2002:a05:600c:1989:b0:3a3:461a:ad4f with SMTP id t9-20020a05600c198900b003a3461aad4fmr2681285wmq.110.1660752501711;
        Wed, 17 Aug 2022 09:08:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a5c:3576:8e69:3edc? ([2a01:e0a:982:cbb0:a5c:3576:8e69:3edc])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003a5c2abc412sm3263381wmp.44.2022.08.17.09.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 09:08:21 -0700 (PDT)
Message-ID: <04115bee-5ddb-701f-ad18-d2c846155816@baylibre.com>
Date:   Wed, 17 Aug 2022 18:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] media: meson: vdec: Add MODULE_FIRMWARE macro
Content-Language: en-US
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20220817140539.150013-1-juerg.haefliger@canonical.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220817140539.150013-1-juerg.haefliger@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 16:05, Juerg Haefliger wrote:
> The meson-vdec module loads firmware so add MODULE_FIRMWARE macros to
> provide that information via modinfo.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>   .../staging/media/meson/vdec/vdec_platform.c  | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c b/drivers/staging/media/meson/vdec/vdec_platform.c
> index 88c9d72e1c83..c7750d4be848 100644
> --- a/drivers/staging/media/meson/vdec/vdec_platform.c
> +++ b/drivers/staging/media/meson/vdec/vdec_platform.c
> @@ -280,3 +280,23 @@ const struct vdec_platform vdec_platform_sm1 = {
>   	.num_formats = ARRAY_SIZE(vdec_formats_sm1),
>   	.revision = VDEC_REVISION_SM1,
>   };
> +
> +MODULE_FIRMWARE("meson/vdec/g12a_h264.bin");
> +MODULE_FIRMWARE("meson/vdec/g12a_h264.bin");

Duplicate

> +MODULE_FIRMWARE("meson/vdec/g12a_vp9.bin");
> +MODULE_FIRMWARE("meson/vdec/gxbb_h264.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_h264.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");

DDDDDDDuplicate

> +MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin");
> +MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin");

Duplicate

> +MODULE_FIRMWARE("meson/vdec/gxm_h264.bin");
> +MODULE_FIRMWARE("meson/vdec/sm1_vp9_mmu.bin");

With the duplicate entries removed, please add my:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
