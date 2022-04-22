Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB83550BC01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449356AbiDVPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376676AbiDVPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:48:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A3925D7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:45:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r13so17176289ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ykyOXYnTInWbRVW2tdNR9tYlZEHvOUFoYyQMhJhxCCQ=;
        b=UZT91yu5GBIwEX2J3y2E8rHkqeYKICR4njyNjt1hbS/JpiJ51pt8mq1tsxhKcBGuJJ
         IPtbCAHRrudZXd+XXlaHlRgmLP6KlRMEwtqycRaIzWD31OB+VZivBgADRzcu9V6w+As8
         Fc3IUVBBtrd82t1uYd/yWjJmo9PkjNtqPvr7boVFJ4wgSGexX+g1jxUi5GZSfgWMvqdt
         W1bI10XiQ+duKmP95SGJnsf6H6L4IklxnSep3tbYUV76z00NF3zrHoYMaot5GAhtszNV
         Ai30I+YVCvN6m8nbU51cMHppdiMwAyu8uYgHwCijUYATmubtJ0J4rX5hDzwuw602D2AV
         V3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ykyOXYnTInWbRVW2tdNR9tYlZEHvOUFoYyQMhJhxCCQ=;
        b=WfYvRnPDTPXMbwAELfVEgJXZ0i58lTCHrvTLYzhKS3xtvGVI5DEiiQs3TY+x1fWy4g
         G7oxSxO+W6k/GzKRE4HD6smGP+ZrhyhWCij/XdKsAcKnJ/r9LMK0dNHMLFZm2TiKy9ex
         9s6fx7qQ1xm9/v/PWrXto/+r3/Caq+0aaQopczpkSBbLddmnajc0jn+lvnj3zor8ZoYC
         9V4grf5Rftoix8CggEmQdbFIhqmeKtBkywQMVppSLjBbXWLWkg1fPg7S22L3XEKB3Syk
         aVBDCe7hgdttZD7LAG54K1YKrmHgoj3espXyACRvLgniCJFmV9zikfuy4Sy5vNCaZltk
         b7+g==
X-Gm-Message-State: AOAM5317iEDb2VSrNa3B79EtaOZr2esv90usoA9BhyoOSxD6ZPY01eEw
        ZfXo6Oyy2n+agTSrkm/2jjrrSA==
X-Google-Smtp-Source: ABdhPJwS9MbT9FvnOnbCC52CKU9LT+qeVhCDl7sfPE7OYMzTTUvU37W5sV5B7y2mMHvxZdNrWzKn8A==
X-Received: by 2002:a17:906:94ce:b0:6ef:8553:aa40 with SMTP id d14-20020a17090694ce00b006ef8553aa40mr4600515ejy.60.1650642340986;
        Fri, 22 Apr 2022 08:45:40 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d3-20020a1709064c4300b006ef606fe5easm846715ejw.121.2022.04.22.08.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:45:40 -0700 (PDT)
Message-ID: <7cd7d785-0401-fa58-8308-74e16fb677e0@linaro.org>
Date:   Fri, 22 Apr 2022 17:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] arm64: dts: mt8516: align watchdog node name with
 dtschema
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220422121017.23920-1-allen-kh.cheng@mediatek.com>
 <20220422121017.23920-2-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422121017.23920-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 14:10, Allen-KH Cheng wrote:
> Based on watchdog.yaml, the node names should be "watchdog".
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
