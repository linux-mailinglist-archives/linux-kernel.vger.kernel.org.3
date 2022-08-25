Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD85A08AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiHYGLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiHYGLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:11:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A09E2CD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:11:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d23so22524748lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ummFVBGk0kSJ29azYUV4PMm88NyQ23LzzWJDNGG28Ko=;
        b=OFtTB6mVUJ7bt1R90wBtz2Y6zQCVFUpiOuFR6YC6KJ3Y15humtnaF40mxEMcSq4Fj3
         IeH6p4VgBaGRevW24zfAkORoqg6d9zBGd5onw0wtuYYPkQHJQpswVnr9XfDncaoaTd1p
         ZK2EXKpA3/xUw6k0OJmc5V7raAnoKDI02lHDche9JSt9hLHI0mUD2+QjMezZtQIwVU/V
         vqyuT8OcjcO+wXnsvv8i7QvZRwTkspGofiAtPDY4AXFeftS1ZNh3UKQ09+/7rp89BaR2
         su15G0IEwNyOs9QPcqpJs8W5d7Vb6KjH4Oj72OaOfYFKNcVNOvf21ELAEMX/URcT2Fow
         sYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ummFVBGk0kSJ29azYUV4PMm88NyQ23LzzWJDNGG28Ko=;
        b=3wek9uK5Gg4HUpp7NuAWOU+KW4zbqVxFAE0GmyuI1FSXHNxgJotdAvS80eH+/+eWh4
         Po8HM7iflzQGBtJoZIoBE3i48F+2WCHswS+nWeHXv/x5zWGRKCm0/zEhG2iO0TmRE3LQ
         4Lzyy6WCCOSYI1Ibuc/KIrbwE0vS37mP7CmsXRe3fFNOypiSqZLyyynLx4CeuJJyBNKU
         22iEKor9lEBLVKmW2wpEdzScwmo3RW+N2a4vYNATgb8oo8hho3aWWLj8fJQrsEmb7E7d
         +YTTgLmVCPiiodRmesj6NrkbW+2ITFfm1NK6Lgh7WaQrTWZw83YEd+VOzcese2Ro6Lzy
         AI7Q==
X-Gm-Message-State: ACgBeo2SgFimz0RARENyGsY05vFH8Niy7Uual9DDc+3QbmDUe9yMZfFT
        FOoU5oqSdBgvAyy/1jf+MJfhcw==
X-Google-Smtp-Source: AA6agR4niBBOUXc8ecge5sCF13gIkJ6mIJGsa30laM0Wak9E8xVD2qZSPleZA9pDzcn970EDeqF0YQ==
X-Received: by 2002:a05:6512:220e:b0:492:db7f:e0b3 with SMTP id h14-20020a056512220e00b00492db7fe0b3mr618143lfu.142.1661407895137;
        Wed, 24 Aug 2022 23:11:35 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id t19-20020a195f13000000b004896ed8dce3sm325213lfb.2.2022.08.24.23.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:11:34 -0700 (PDT)
Message-ID: <3ff08ae9-a4b6-2b74-23cb-69ea1d7e1033@linaro.org>
Date:   Thu, 25 Aug 2022 09:11:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: change compatible for
 MT8195
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, nancy.lin@mediatek.com,
        ck.hu@mediatek.com, chunkuang.hu@kernel.org,
        angelogioacchino.delregno@collabora.com, hsinyi@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 08:56, Bo-Chen Chen wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> pipelines binding to 1 mmsys with the same power domain, the same
> clock driver and the same mediatek-drm driver.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.

I don't see binding to different clock drivers and anyway that's not
really an argument here. Please focus in description on hardware
properties, IOW, are devices compatible or different. What is the
incompatible difference between VDOSYS0 and 1?

Best regards,
Krzysztof
