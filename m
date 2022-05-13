Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8100F525D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378275AbiEMIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378368AbiEMIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:31:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F215F7B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:31:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z19so9084173edx.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YYULx/OnPBkCECxsG7VLLrURpygBJH5ZkPirFud1SVE=;
        b=lOSafNyROulnVy8THJdx8OKlyBp0zwQHyJxgAmnLmuvlJPXUQF6yKlQzqJX+YkhqTz
         9dMeIkz0Gesa4LD/jWqEOyP4/iV/i/i+RqImeVsg8fPLrANSOZUP/8ZI0G1fI0TXuQQh
         fyOS37pzxILCdPITgn9x4MZ51yIY/pQQJN4EB21dwewt7QPRrdwQjF6h49xNK7Rhz/by
         cqXV4Amnd7jgGV4KKE87OsU26ETTVDJOXwQV9FhCQl/mted086Lzk6kV29AKolgRiAlJ
         zFeOIO3gEec5+ZuyTb+eNAjU+MY/V8YGM42itBGARoxVYbSdgRvH53x7TQGKuO2Wqrrl
         0H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YYULx/OnPBkCECxsG7VLLrURpygBJH5ZkPirFud1SVE=;
        b=OtBMa7xLcJB19k7uRt/pCsZ2CeuHT2BlQuociCTgaTuag3tVbC+r+NGFp0UGjKoN/Y
         /B8yFBYiXLqlf3l4zDRHpFeiJ7HM7NPl1OaiIWEjvwBek0XQIsOPsgj7+HLkSMygkIAS
         B6DGaX52boq0oCWRBsNrIuCYVzQEHQ486EVeVrehbmHHXQGMlyK1IexbkAyOhsxlMWf7
         YJqa7D8vBhct2lz7J5kjPerYBs5g3a3xLfS5P2z7zaexyNbMzq8/ztMX+injVnwHBWSE
         N/jcI3fqQn0qUyIBYdkHyEQEx8sRJ8cIUMgZRQ4NQoziJ+MavCJSU5G1VosMuME4nSPR
         6srg==
X-Gm-Message-State: AOAM53083T4KOkfvalaXzT36LaTtvtdWGSPYRm3oWm5yD3yo8VbP1iRy
        A3eqS5DFsAtvtVqPJIcRFcwOGw==
X-Google-Smtp-Source: ABdhPJzd8GPaDVoXg/OxBKEu0HQy+3pM0sNyGWfsDQVQO0Bh3xsbSY7T3pykqwPP6VZN+RlPSF0mBQ==
X-Received: by 2002:aa7:c6c3:0:b0:425:b13b:94f with SMTP id b3-20020aa7c6c3000000b00425b13b094fmr38756205eds.313.1652430660375;
        Fri, 13 May 2022 01:31:00 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l13-20020aa7d94d000000b00425d6c76494sm675174eds.1.2022.05.13.01.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:30:59 -0700 (PDT)
Message-ID: <e2895c7e-0a1f-b81b-25b3-0653c7e863d4@linaro.org>
Date:   Fri, 13 May 2022 10:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/3] dt-bindings: reset: mt8195: add vdosys1 reset
 control bit
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de
Cc:     airlied@linux.ie, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        nancy.lin@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220512080523.25082-1-rex-bc.chen@mediatek.com>
 <20220512080523.25082-3-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512080523.25082-3-rex-bc.chen@mediatek.com>
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

On 12/05/2022 10:05, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 reset control bit for MT8195 platform.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
