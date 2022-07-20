Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10DA57BCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbiGTRiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiGTRiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:38:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADB6FA3F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:38:07 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q7so21921913lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ICIFskbhDAxkqyFPFywjKrA2bMQUTmKy88Z9Ca4QMwc=;
        b=pU4v+a1Ih9uwueVmVnw/nnRcFBk6TOtjSs23U+h8gRjVlV7wDHKSroELFu22DOnyC0
         MyE9ToyAShxsaTpXlt+/dHrJQvJsInZpC6XHFrdQORgZmkhNz/GcLEL7aLSOnjghiFRF
         yoAig85kwvl0gdzvs1inz7BQHrpwSaBinQUgdUT2+pBtFMNJin0BEW+PLOuwnOieRzVS
         eAJFwaq+rF9flazp7+kc/D2u4tCzcGylZyCH4TsvhRfddoo6xg4QmIthqM/kEy8hQeCU
         JWHiDHl/sFzRmFD9/NxBYwUKVb7BC5bLLOH20jDlZ90DknQPvGOX7X1IVUSH0s7dKspk
         qXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ICIFskbhDAxkqyFPFywjKrA2bMQUTmKy88Z9Ca4QMwc=;
        b=wz+1FHE2hvtu/xlJhcKsfwh23ZcOv9EvEFYagu9uPzeIxGmp71t+NuBBcwSy6VPp1N
         2qwyyCIUUUtNnvm3q7pNbvjUBk6xUhPZBBYG4p89pgo03sF2qEXEcN9Oo5YuCWYdN09p
         PTifa+HsMXodC7fEQv82ggEIASvfmDeJEQAQmTdG0XHSGbBTvuqWhzC3tTCSadqP8WEV
         b1XvVRLpAZ8th6Frsq081QcAE/F+eUdjCS6uD5Trm+ogultkFW/fD0lKZizQK5uZslbD
         yt/WOag83d3FpQUZgfWM3bHDi/ngK6ah/rY8FSP3zFoDzw1cwmGl167BHNqTTgT0/ECw
         bQ6g==
X-Gm-Message-State: AJIora/glqF9TOg6BpCgpMg/AoHOZNibNia6uUyPXvMUXc0YiFIBQC11
        DBKxvEZT5GkxFIea36Hmy8k9yQ==
X-Google-Smtp-Source: AGRyM1sG7lbScHD/ieFpA/+GQ6oByCyWagIFfgC4I8Gr18ItlMyGc5wtlKO06bA6wu+LjYej5okHsQ==
X-Received: by 2002:a2e:8e28:0:b0:25d:c1b9:aede with SMTP id r8-20020a2e8e28000000b0025dc1b9aedemr5581492ljk.28.1658338686017;
        Wed, 20 Jul 2022 10:38:06 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id v14-20020a056512348e00b0047f6b8c2127sm3909309lfr.186.2022.07.20.10.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:38:05 -0700 (PDT)
Message-ID: <3fab6834-7622-a33a-dc97-9c630702b6fe@linaro.org>
Date:   Wed, 20 Jul 2022 19:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 07/21] dt-bindings: power: mediatek: Update example in
 dt-bindings
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-8-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720123023.13500-8-tinghan.shen@mediatek.com>
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

On 20/07/2022 14:30, Tinghan Shen wrote:
> Update the scpsys node compatible string to align with the
> scpsys node bindings.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Squash it with previous because logically it's the same change.

Best regards,
Krzysztof
