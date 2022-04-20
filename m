Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1F508167
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352987AbiDTGuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbiDTGuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:50:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7A6576
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:47:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s18so1579422ejr.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vAFJ5Jy7fcFeVcUMp2gfVGhJtgw8jdXee9hX3koFUP4=;
        b=GVbK4VM0/4etSp27b5bmq7t/DzlSN93x9/8ZsVbOSRIrMgd8ENWgAs9lmj7YRIh/vk
         LvDGnOpAgyPWnc3HYVXZuGrkkJD3YULNrP6Qjz/BNpRv/fwLr6Rl+mMLc3E8tNx+c4cb
         lLyw4AJjzMkxykXu2lZ1ev0VbvcI5bAbjwUkkceMnva89oDw6RJxYBkyk6gEUcjnhaYn
         VQ2JRAzsIyG66cxNGyetyzEPSUic7+LQbdZQDb+shhrxJj4Gsjjcly8XRZK3yW/Aj05z
         vj1g99Fixbfcc863+p9Lvi/fhvzwLjgfVRxnYskXw5SbuSKln76cpuUtAFoRZ3dx/JJm
         aqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vAFJ5Jy7fcFeVcUMp2gfVGhJtgw8jdXee9hX3koFUP4=;
        b=ZCQ74G9aXDEodGV3Avyp0WGXK3cB50tz1Im7sHYBKKAvt+9vuxtzewldOWKPebPUWB
         IS6gN7Sff9D1LxQfE1A+pwqVnZ0i9bS7kOCniOMkamVQVrMMVCUaar1dMP0fOGJkkYJ1
         cnIbx0YkoNE/qWyJVeLW2TV/YUUOAeJa4tHK+dfp2l+yXeI+WdaGy4VosqaHOGWpvEdY
         eMQp6TG825FbYup9eDujFjcJRO+nX+TvCDuXQRKoe5yqaSfXZFPZ1ak2An3CJ3LkUFew
         YVSCEQwYXx9Nsa/FjzEeKhlCv0w/7YB8yO7jVR38BnYfp97nY6MODr67/kTM46j6OBtY
         /wyA==
X-Gm-Message-State: AOAM530QNQn8dUExvoXknUEv57RLS2vKwb2Kr9qa8HDGf2p3/itF4Mhu
        2BwByqd7iLKjIlFkL0JC0mn4vQ==
X-Google-Smtp-Source: ABdhPJzxwUOONgHqHYaO73Ouj3/x4695MZhoOW7uiVUkaAN93uoh0N43FLOs0S6pvn5pcp3OL6IlyQ==
X-Received: by 2002:a17:907:2d0c:b0:6f0:a56:1c63 with SMTP id gs12-20020a1709072d0c00b006f00a561c63mr517861ejc.72.1650437243094;
        Tue, 19 Apr 2022 23:47:23 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm5185295ejv.43.2022.04.19.23.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 23:47:22 -0700 (PDT)
Message-ID: <efc6d3ee-b060-b070-1471-af940428964a@linaro.org>
Date:   Wed, 20 Apr 2022 08:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: mediatek: topckgen: Convert to DT
 schema
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220419180938.19397-1-y.oudjana@protonmail.com>
 <20220419180938.19397-2-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419180938.19397-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 20:09, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Convert topckgen bindings to DT schema format. MT2701, MT7623 and
> MT7629 device trees currently have the syscon compatible without
> it being mentioned in the old DT bindings file which introduces
> dtbs_check errors when converting to DT schema as-is, so
> mediatek,mt2701-topckgen and mediatek,mt7629-topckgen are placed
> in the last items list with the syscon compatible, and syscon is
> added to the mediatek,mt7623-topckgen list.
>

Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml
> new file mode 100644
> index 000000000000..9ce9cf673cbc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,topckgen.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek Top Clock Generator Controller
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +description:
> +  The Mediatek topckgen controller provides various clocks to the system.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

These are not a list, so skip items. Just enum. Rest looks good.

> +          - enum:
> +              - mediatek,mt6797-topckgen
> +              - mediatek,mt7622-topckgen
> +              - mediatek,mt8135-topckgen
> +              - mediatek,mt8173-topckgen
> +              - mediatek,mt8516-topckgen



Best regards,
Krzysztof
