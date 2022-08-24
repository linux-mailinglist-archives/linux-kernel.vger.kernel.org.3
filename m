Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223F059FC73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiHXN70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbiHXN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:59:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F93804AC;
        Wed, 24 Aug 2022 06:59:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so2022290wms.0;
        Wed, 24 Aug 2022 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=YnINneYYpss74fFaxA2QzFV2m8mTzk2bkrWfDISsTyI=;
        b=ilfAGLNDfRjrv7v2hXx6haQXcmjYzh4TRdLS3ADcOmG8o4XYaAXVEo6gI5Y4AxMWfr
         EE4nsM/YYdZWzWUC3lhrurWqhcSS55hSttFdJJrBMp/9Ji00cYRsoNoRSyvPY0hmY3Zp
         gNa2y0sCTZP77OjagAze+2glbFj/y/0wpQv8fsIrvWTyViJV+YxmYXCU8OfYGaRefU+L
         FJFGpr1nLr6KZpEwa419j6b3ARx9jfZHqXq2fVAHXeOBbrM3/Pln9oJlQGZ1cQgTNhCv
         aZJSnr7+bTOUBJTqvPzcQpKYue1znDw/hWgrkQuhBKWERv0hMHu/1KDpYimHiF9SQwTG
         UKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YnINneYYpss74fFaxA2QzFV2m8mTzk2bkrWfDISsTyI=;
        b=dQDbqNRfm7GMb4lo8SDdlO62pmdVY96b3lr3qwwW1zDvRYsh88k4DmOm/hQtgC83zt
         eeuJb12DD2IlQq/fbfejRBik+eot2EXeLRtDIVE0alzpClqYG+0tAbIoTjdC7+jVDewy
         zj++tseGKYBJKMk85xMJA0MaMRiWbj/5YNrmr0xlSEwkdLceRhgfxvQSHHvpQaWUwSIE
         WrpmTHKMhEfUOdpOI9kylNWWP23wo2QcV1cA5AdpvymQ8XgoAnSu1kZqP8N81ORpz8Gm
         16i/fEJrg8wFySTswSomU1PYduTk+OG91eVX1vZi+0RLMfoIhybIZIcGUxgFBSuv6vaE
         asnQ==
X-Gm-Message-State: ACgBeo32bK9nzWMbNwu9nXEFzPcZM6R7VnEv3MG3OlGU5NSyyGJ1rZH1
        qZPT+G1YR++5sVFEQk6IeK0=
X-Google-Smtp-Source: AA6agR6aunVXgh4W1vls5gdUD1YAugOnjiduggkUW4qwCv86sXjJCE4f6NzBM3Flg9r8pOFx7qRWww==
X-Received: by 2002:a05:600c:4f90:b0:3a6:2bda:dc4e with SMTP id n16-20020a05600c4f9000b003a62bdadc4emr5429153wmq.39.1661349547561;
        Wed, 24 Aug 2022 06:59:07 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6202000000b00224f67bfc95sm16842095wru.62.2022.08.24.06.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:59:06 -0700 (PDT)
Message-ID: <f8a391de-dd47-1eb9-0e15-e6a651517a6f@gmail.com>
Date:   Wed, 24 Aug 2022 15:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 1/1] dt-binding: serial: mediatek,uart: update bingding
 for MT8188
Content-Language: en-US
To:     kewei.xu@mediatek.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        qii.wang@mediatek.com, liguo.zhang@mediatek.com,
        caiyu.chen@mediatek.com, david-yh.chiu@mediatek.com
References: <20220809084457.31381-1-kewei.xu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220809084457.31381-1-kewei.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2022 10:44, kewei.xu@mediatek.com wrote:
> From: Kewei Xu <kewei.xu@mediatek.com>
> 
> Add a DT binding documentation for the MT8188 soc.
> 
> Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> v2: Resumbit the patch based on the linux-next branch.
> ---
>   Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> index 4ff27d6d4d5b..fe098d98af6e 100644
> --- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> @@ -42,6 +42,7 @@ properties:
>                 - mediatek,mt8173-uart
>                 - mediatek,mt8183-uart
>                 - mediatek,mt8186-uart
> +              - mediatek,mt8188-uart
>                 - mediatek,mt8192-uart
>                 - mediatek,mt8195-uart
>                 - mediatek,mt8516-uart
