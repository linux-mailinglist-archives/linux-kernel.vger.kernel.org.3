Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0AF4F878D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347066AbiDGTAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344697AbiDGTA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:00:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5388622C1F9;
        Thu,  7 Apr 2022 11:58:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bx5so6432183pjb.3;
        Thu, 07 Apr 2022 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=yKgPeVJkTTlWR029OHJcWm7UBvWngodu9rlPvPCMr6Y=;
        b=jomUKr/FmOEincstQR4oMTygKKFGXBM4cSjfY4PjaAdmrEohbp/FJlBg9sLG8u7QZV
         goOfSMhBZQ1UWgB/2lZ6nOe7KD5lKYNtCu6AZejkOAgd5W1asEK/20/C7Q1yJn6lQjMt
         bLotFTz543CCq2jlpC4vNusHqjChc31S8q2Lr0dbEApz4DZdk4DdeYb9iwrJcLWC6mg1
         hcKZ6yHSe0WKX/D4jIfKjqBEwnDoLMLUvkfccD4XEa5K2k4dYwcdC4PZeFPs8Y5MonZr
         hDwrvaP5l04k15mWPt4b4tL5YouGf4vPPIaAhu+DQNPgUt4XeNsBdlvvTbDxP/6lnR5V
         GjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=yKgPeVJkTTlWR029OHJcWm7UBvWngodu9rlPvPCMr6Y=;
        b=S6u7gTZPL3SCi1TsFv3Hggb444AJwSvgKInEAHzvTbdbVdgQCN6Nfit210Ra+DeBAt
         o3VfJb3LIGLD75Ic7m542MzE9KoDQhvyGAADFGcltHb0kHyva6sZ29/e7isDgKDNsuP4
         YllSpyA6Icf5O8DmQrwFuNuZQ16x6lq1Zjrb6N77xSJ3NnJmZ2q8jKe/+z3kDYVQK1FW
         ywc6Kn4RIttQdWWrhzzeJgzkPNNshGl6629MfbrxbxMEaSQYbDSp4yWwbPL8gTk4NIsZ
         Bz0T/arAzOUyc01yCgwLD4slhyy7vRsGIQFoktxSQLzP8WxOhKBvvw9p3B3Wn8o3aihT
         4A7w==
X-Gm-Message-State: AOAM5331x3Q1n7xQZ596sSSt5G15knSyn+zX8e5o+v0hJb8x1bKN2e+N
        JklXntDRFelCstdB+y29USU=
X-Google-Smtp-Source: ABdhPJw7RDFshyF2mZ4IAK662zZndtPImnSAASy9IyTLGW191XweGKY1oiefRDVbQWeHcPDBLNA2Gg==
X-Received: by 2002:a17:902:db05:b0:154:8219:ce1f with SMTP id m5-20020a170902db0500b001548219ce1fmr15633528plx.82.1649357907813;
        Thu, 07 Apr 2022 11:58:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d21-20020a056a0010d500b004fd9ee64134sm23108673pfu.74.2022.04.07.11.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:58:27 -0700 (PDT)
Message-ID: <b5b45fc7-44ff-57a2-0b21-a78c7cd13b68@gmail.com>
Date:   Thu, 7 Apr 2022 11:58:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] ARM: dts: broadcom: align SPI NOR node name with
 dtschema
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220407143211.295271-1-krzysztof.kozlowski@linaro.org>
 <20220407185506.2575806-1-f.fainelli@gmail.com>
In-Reply-To: <20220407185506.2575806-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 11:55, Florian Fainelli wrote:
> On Thu,  7 Apr 2022 16:32:10 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> The node names should be generic and SPI NOR dtschema expects "flash".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
> Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!

Should have been devicetree/next, applied in the expected branch.
-- 
Florian
