Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD559FA70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiHXMvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiHXMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:50:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145D95AD4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:50:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m3so18169790lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=VIvn4cn38mqmq8WvF2X7y/SBiSVMfGMJeaVNH0qHe9o=;
        b=myWHpRkE0JHF+tTboHvgSdeq4hDDIDzW3o2/kG40uIP8wBe5Qtf8c4eWWvLeA3qGB+
         5+VAi70dRsuwNRjXlXFZRRi5152W7yHHCTd9A1cYQ07kRzRQCkkDDqdLcsSal9TXUimu
         WHNESwCDBoMe2T4PirwFphqC7jnVY6GXoosXkLj1Qhspt+curOhozmhJWQHIYWA49J0H
         j9ZakInDkVu8bPFMvSuVGx6I5kzlN789kKmwoGcwachUCYbC6KVA8KcaDUH/UksnAdj1
         mtX81dBWvW68wBRbsLgyobXiZ2di4NmNtBQkRko+eStRHi6/WYVFVLyJhlURXaOmSLrE
         IFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VIvn4cn38mqmq8WvF2X7y/SBiSVMfGMJeaVNH0qHe9o=;
        b=UX/dr4P130V38e6BITNvZwJ2KquwRJS4ybkW9hczQORDxjZ5NNcnoffK4wnXnmlxHj
         cvLVEatzRILlgobEhNHb+mO0k5cnPfWoIPXE3AtC/RdCzQDfAkaIgzmvNgAfKJ16JALc
         EMmXYcxvINDuUw+cogoNZ4boL0asNmuzCMPBe+C048yMMnak4GWfugMpWGKyB5dBmB2O
         eCloY6oZgsecDgHUjH8Scg5Dk9+X+QD4h4TFUPep9imPhESjccw4n3dJXwUAlJmuSz1I
         9IIdL3b5mbyRPwORmt0m4LXzlOkxZgJYf1KdRRMOcGR7hZeL5kzm207jAFLLIm0BEI5Y
         4Hag==
X-Gm-Message-State: ACgBeo0HCW1ko6GsId89nK7F+drle3hdUbM+TX+ghSFrrGL7ZBMVbKMI
        ulgP8ZCIF25e9XP8vthxMPYGZg==
X-Google-Smtp-Source: AA6agR7Z/1jGW7Q8B9kfMwTIdCYPqqO+/2YBvt8cNU59/7t5/M6VcYqdYuJNjpfmZf8K+b4Uz38cuw==
X-Received: by 2002:a05:6512:3084:b0:492:f04c:8a3 with SMTP id z4-20020a056512308400b00492f04c08a3mr3618630lfd.199.1661345453600;
        Wed, 24 Aug 2022 05:50:53 -0700 (PDT)
Received: from [10.243.4.185] ([194.157.23.230])
        by smtp.gmail.com with ESMTPSA id v23-20020a05651203b700b00492f294f06bsm1028184lfp.110.2022.08.24.05.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:50:53 -0700 (PDT)
Message-ID: <58a694df-fb33-dac9-0dfd-eb2efb9abde9@linaro.org>
Date:   Wed, 24 Aug 2022 15:50:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for SOF
Content-Language: en-US
To:     Chunxu Li <chunxu.li@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, matthias.bgg@gmail.com,
        jiaxin.yu@mediatek.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        project_global_chrome_upstream_group@mediatek.com
References: <20220824122319.23918-1-chunxu.li@mediatek.com>
 <20220824122319.23918-3-chunxu.li@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824122319.23918-3-chunxu.li@mediatek.com>
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

On 24/08/2022 15:23, Chunxu Li wrote:
> From: "chunxu.li" <chunxu.li@mediatek.com>
> 
> Add SOF related field.
> 1. Add a property "mediatek,adsp", Only when adsp phandle could be
> retrieved, from DTS, the SOF related part of machine driver is executed.
> 2. Add a property "mediatek,dai-link" to support dai-links could be
> specified from DTS
> 
> Signed-off-by: chunxu.li <chunxu.li@mediatek.com>


Usually first name(s) is separated from family name(s) with a space, not
dot. Looks like you need to configure your system.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
