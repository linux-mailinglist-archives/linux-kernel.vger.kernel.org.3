Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565935A5EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiH3JON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiH3JOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:14:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8FBA14C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:14:10 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id by6so10652507ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Id/5R3SN5Vasbdfkyu32JE/b1ZpOrfARzpy5Arox7pY=;
        b=x3Z1WUVhu4xg47PIApO+cX+zwhRzwA+njtOgqoSildHAIg08K/nVqB9X9BHRkev87C
         PoxejF0zgcYiy1vMP3I0uLUV7+Pyj+s6ICl1MdsT0rbizM9e3WRD1rgK/Zv5K2GQmZjq
         xxM6djO+rM6ZCXgJWP/gYiG1XXYJrnov9mBz2OtnCYg2mRtx1OtEu9iMT1o/4F4S/4rl
         ye2fYgO250MKcrqenhfd07rN+i+GxOWaqMEICpRAAJNBPw5y90UwVGwFdNVEkMpEzPMx
         zBRqq4fxGJFvt/m6OrprCAnux4xNRkQOzj/MGit0tLIrn2viN9abqhmUhIZIn11wP2gM
         o1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Id/5R3SN5Vasbdfkyu32JE/b1ZpOrfARzpy5Arox7pY=;
        b=Gqt2qsIxUvQWKj8gA36vuxpmbOEdBwLpKy8Af4YumVw39s7PI+m6wrhwZk6wIoVDgy
         p8odpbPz3wYE0R7+UgB9xuwWQWdKS6fqn1CJZ4MWUyymbQbOL9D9HMXCTvjZRoZlJub2
         YZPC3xvSEkBsw4yOQpkLqcGkFSA749A5jnyvXaM6HKpwJK50d7FvwQqiGPdhmoICzZkq
         oWgmA8GDkGhqT7TACYSrvCzHkwkRUg8ly/9C8GVKtFOnrcFtJ+xoR4XyN83HOZb1eycU
         Kwf7TVAv9Rt9MzNB59dPXyvCa56BHEp/CsN8GT5mr5s6e7AvviNeGcq9r+Pkl2alov0B
         AMUw==
X-Gm-Message-State: ACgBeo2nIJ99qeCjI66WGX4LMhVOIXkFwY3x14lAw0izRcsW1Jjs1RPO
        KvjTnqdTtUcGBRgZMpnYsELwnA==
X-Google-Smtp-Source: AA6agR7oE93NC6EWXvqYn7rZxHpQ4vfMbRipa3YWZuHHRuE6y7fwDMunhCl6aZf9PcaDGYKkB94LKw==
X-Received: by 2002:a2e:be9e:0:b0:261:b228:ed8b with SMTP id a30-20020a2ebe9e000000b00261b228ed8bmr6589653ljr.226.1661850848523;
        Tue, 30 Aug 2022 02:14:08 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id s8-20020a195e08000000b00492dadd8143sm484862lfb.168.2022.08.30.02.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:14:07 -0700 (PDT)
Message-ID: <bf2b277e-8b02-6a44-e463-6b7c4a697ce7@linaro.org>
Date:   Tue, 30 Aug 2022 12:14:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/3] arm64: dts: Modify gamma compatible for mt8195
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "zheng-yan.chen" <zheng-yan.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220830063929.13390-1-zheng-yan.chen@mediatek.com>
 <20220830063929.13390-4-zheng-yan.chen@mediatek.com>
 <a209aea3-bf23-4670-91d0-e7f41ac57833@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a209aea3-bf23-4670-91d0-e7f41ac57833@collabora.com>
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

On 30/08/2022 10:49, AngeloGioacchino Del Regno wrote:
> Il 30/08/22 08:39, zheng-yan.chen ha scritto:
>> Modify gamma compatible for mt8195.
>>
>> Fixes: 16590e634f1d ("arm64: dts: mt8195: Add display node for vdosys0")
>> Signed-off-by: zheng-yan.chen <zheng-yan.chen@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Please also perform review on the commit msg and backport status.

Best regards,
Krzysztof
