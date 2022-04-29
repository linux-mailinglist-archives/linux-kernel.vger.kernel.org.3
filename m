Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F142F5142A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354790AbiD2GzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354772AbiD2GzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:55:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F756C1A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:51:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k23so13652967ejd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mDlkYW1jOvACOQZC2hs7NlPEH41hbIy3Cee6HSyQR1o=;
        b=S0HLAOz7G2rA2yLeEvr2F3lrjjv2nPsprZHooIN2NIj88OOaU8taSdX9pKfLMuaXls
         fG7DRxmtn1K6/L4Lec5G9xzPgd+JWZ3bq2tJocG6FDdWIsXeLa7yGRb7rsqVfFYe9OHq
         gf6V9IM0lPCmra8Pn//gbNCyEGFaOVMnJ8Ut+LVJKup9ocmgqu92Idv2GOogtwh2C5Im
         JAbbUW0ygqiSA7nLeLEtxP3TOjOKidni6gZ21GG6HkdPsZx7zNG7eCaFHwRTVmx82IS2
         rZcQph3O8fdi4rQ/2hKoVIlRxSrz+4Zs/UyzVHqzQ/HW6RlsxSkxShDfRGnXGtBVWuxB
         M+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mDlkYW1jOvACOQZC2hs7NlPEH41hbIy3Cee6HSyQR1o=;
        b=g5aUDW+sS6Kp3IJUTEZ1XAAtnkq6u7ZcInRS/8mXbrpPeaZibfdtYbRTv0LkzfqrBp
         olakoTixpK5+HoAULED2/NGNG76Kg/jgn6fWhj3cLuFWvPsP6HIQzWs2gqhKX0Y9HLG3
         keny0WGZr9r4Hj1bs9LEcGPfUprM5iEb+iCOEA/nwzlxBb13Uuf8aXPMfVnEEr6/60Ee
         7oGZdUlLbzzFQubX/LBVM88eBETOBKbf/XAmtlfIvYvis2nOzvOTkkBRaQ8hei/64Dg7
         nBf2n0z10jTfyypz4Qpr1FaMNjvikW6JKctZGGGJTRb7ERIEr689a3H0v+Leurnpwmho
         vAQg==
X-Gm-Message-State: AOAM532kUVgPZqKVLsX4q+JdcfGcs6QmZBK2kdVedAxWm3dD/NCN87Cp
        MXhcVozY4Y3FXJQKEGg1ClGMtw==
X-Google-Smtp-Source: ABdhPJyKpoYsRgUvdWhjm6qmhIpd2ZkWDXaTdwpzyMQVoxXJm0Pmjoejr9XVBcOAFMWc6EkjcMA1tw==
X-Received: by 2002:a17:907:c0c:b0:6f3:8667:9be4 with SMTP id ga12-20020a1709070c0c00b006f386679be4mr26384276ejc.325.1651215106368;
        Thu, 28 Apr 2022 23:51:46 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hz13-20020a1709072ced00b006f3ef214db2sm347293ejc.24.2022.04.28.23.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 23:51:45 -0700 (PDT)
Message-ID: <e010e330-590a-780a-c9a2-0f90e5aa04b9@linaro.org>
Date:   Fri, 29 Apr 2022 08:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/3] dt-bindings: nvmem: mediatek: Convert efuse
 binding to YAML
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lala Lin <lala.lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220428132520.2033-1-allen-kh.cheng@mediatek.com>
 <20220428132520.2033-2-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428132520.2033-2-allen-kh.cheng@mediatek.com>
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

On 28/04/2022 15:25, Allen-KH Cheng wrote:
> Convert MediaTek eFuse devicetree binding to YAML.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/nvmem/mtk,efuse.yaml  | 57 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 --------------
>  2 files changed, 57 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mtk,efuse.yaml

No, we discussed it already two times, so now third time? You are
wasting my time. Please read all my replies again.

NAK.

Best regards,
Krzysztof
