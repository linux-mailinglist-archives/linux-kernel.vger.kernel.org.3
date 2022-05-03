Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D25184A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiECNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiECNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:00:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0FD3464B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:57:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kq17so33279545ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oHVWIHmT3rXaJWCw7EdaE9tGEpo5kLJbmB74t27e7cY=;
        b=WxTviOacb8RbEXCmV4V2QEdj59ihDchP24+Q5ofFVwEwYo+N5IlvZoWocxGL19gBEO
         9GP7A7wQYpfU1m/egluyXoXAzh6q9SnZpD1BUjqhnQFZdk3KxwYxWw0EJW41ITKUNoMF
         yxhEizTD4pG0+CxnPEHquK54Doy9UCNjMmu0YxYtHDCuPNlEMwkaQxuS6O1afCKYrmIJ
         m7E4ufuMuCRd8Q9a5PBZEYC5+OcDSwBfwQ/kxDxs/hlsT8L5iogA+IVTyOH3xLWcpXET
         hgiJMcTqySAcLR7U3PUeRaBuL8jTf/LLqCp3A02TIMfLEBjQ18RQ9dui/ju5OkXgpr6n
         /Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oHVWIHmT3rXaJWCw7EdaE9tGEpo5kLJbmB74t27e7cY=;
        b=3OK8eZewnRESbbdYptTDTDaRdOjql/VPfx6w/sxVCvF6DsYUkIj+JiTXfDYjYRsN7R
         UEuVijK9V62a7Hv3KNg8dckJCrI/jqRJT0c0i4zwRuTjkIcvHHz7NZWpXBjpU04lJS2w
         N5eI52Jjjzz+QfaKe+Saj6zrokqsSu8RH+jqm1pfhPqKr57g52WDsuwUXvytqWGCRUc2
         CAapMMpr6q+RnIygxLWT4f8PMGyKxuYYzIkYjb6q6Ee+zfZSviGztGZuZGtTNJJ9qd2Q
         wnffvxPhEZAKYnOqgP2f4DgWt2RntKfM+D7xxeg9/4O8d7RYv30MgrR60s0dtjNPSM6C
         dYBw==
X-Gm-Message-State: AOAM530gDdY5XxTvNt/Meu/yThGt5DZlwYc2EOvTW5uhlv1FMolkxzap
        VM+YT6WWkkhtKNyGAmLMF+5MBA==
X-Google-Smtp-Source: ABdhPJyV7FB552dnmsD4CpjcsIkJUNmoKVpXP4QizFokJu4ctT28NesCBD0GDTATdFIukuUc+C46/Q==
X-Received: by 2002:a17:906:c147:b0:6df:f047:1677 with SMTP id dp7-20020a170906c14700b006dff0471677mr15436567ejc.4.1651582639603;
        Tue, 03 May 2022 05:57:19 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t19-20020aa7d4d3000000b0042617ba63c2sm7860341edr.76.2022.05.03.05.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:57:19 -0700 (PDT)
Message-ID: <d371fff5-0d45-b827-2696-3862b3c5fd59@linaro.org>
Date:   Tue, 3 May 2022 14:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add MediaTek Helio X10 MT6795
 power domains
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220503105436.54901-1-angelogioacchino.delregno@collabora.com>
 <20220503105436.54901-2-angelogioacchino.delregno@collabora.com>
 <ac774c74-4577-3dfc-7bf4-3c180d45b420@linaro.org>
 <94dbb7ee-764a-5568-a044-80dbfe77c29a@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <94dbb7ee-764a-5568-a044-80dbfe77c29a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 14:43, AngeloGioacchino Del Regno wrote:
>>
>> If it is not a derivative work, should be GPL-2.0 OR BSD
>>
> 
> On that, I agree with you, fully.
> 
> Though, all of the mt(xxxx)-power.h headers provide this license tag and I
> wanted to follow that to give the same.
> 
> Should I change it to (GPL-2.0-only OR BSD-2-Clause)?

Yes, please, for this one.

For the other bindings - you would need acks from people involved.

Best regards,
Krzysztof
