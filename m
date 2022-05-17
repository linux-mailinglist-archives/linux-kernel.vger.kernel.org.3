Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD6752A37E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347886AbiEQNe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243021AbiEQNe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:34:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF14B1F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:34:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h14so5149110wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zENm4m7v3jmHevxy6zbVD9ZWKHm7pY9Rx6cLLJz8FF8=;
        b=JgChqh4QTXIA48MUJqB/UqQimt2Bhq6cVURNDui3KnYietQ+1pedhParg/KfUVa9jq
         3WLOM5s95bDqqYsQJjua7y4622+pNDviCOxwTXvpuWQ40xXM+0AReXscClOMPNh9ocwk
         /miMGSzoYnwWbd5GQ7VfDGWud8IUyPcEiOihD0WIUndyifk5X5/COiyHK17Yh+Z+w3Kx
         pluQdGkN3WTw1ePQuBAhYlhI3i7yKnVojg4RM2+d56dUupBBTMH5uKYQ16HIjasx12yU
         pbUlrYpD6MrCTyXyYjDVaocuJWrE4YwpY37MkVBZ2tAIro6iCH2tJgbFCEi/o3VfTpf6
         eSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zENm4m7v3jmHevxy6zbVD9ZWKHm7pY9Rx6cLLJz8FF8=;
        b=SHm8FsIiwCx5CBHmYOm/lMAb9e6h8pYkeUFs7Esez3ksOs+/ErG1vBSGayNtVAAZC6
         oDHfw0EXWjC27bpA+FxM09X6YO7ua06LU8A8blfFYZUgeAc6UVt4QSSHQTYGh+/5nOgM
         hFKzwOYPa9AvV0K08VKfsN3epy76uL/ty+fpZ9Ih3ZdQgOvpnZShORx+wc/7ZYOo/L8F
         RWSJlHUmgK7eCdeln80J9XuAHUpbxf6BVg9pCe2+CJV4unSXfdqZmGCE95dzprpKcsUX
         h4/AQPFi+JfGqO/9x0WvGQGRDGTb79QQJfBw2Z39nweRwi+O6mIIhDR3CPU8EPeSa54T
         fSeQ==
X-Gm-Message-State: AOAM533uhAjLF/dmUfRUp1zcCQ9jd1/37ZZR4p3uAn/50bhGoNfxxZZE
        fsVfGUhNpbfgPUuExRgIccY=
X-Google-Smtp-Source: ABdhPJylGTnXGOZlqlu6Q5VjENj7HaWzMWHJrXzR20Ahexa4NBSKy3E+BJyTOig7eDYl9ApoiVQ5Pg==
X-Received: by 2002:a5d:574a:0:b0:20d:70c:3aa8 with SMTP id q10-20020a5d574a000000b0020d070c3aa8mr9479400wrw.255.1652794493326;
        Tue, 17 May 2022 06:34:53 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g9-20020adfbc89000000b0020c5253d909sm13032201wrh.85.2022.05.17.06.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:34:52 -0700 (PDT)
Message-ID: <99ed8d4e-8139-851f-47ff-7968822713da@gmail.com>
Date:   Tue, 17 May 2022 15:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] MediaTek PMIC Wrap improvements and cleanups
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com
References: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2022 12:47, AngeloGioacchino Del Regno wrote:
> This series is meant to improve the mtk-pmic-wrap driver;
> that's done by removing the custom pwrap_wait_for_state() function
> and correctly using the readx_poll_timeout macro instead, which is
> doing exactly the same as the former.
> 
> As also shown in a patch [1] by Zhiyong Tao (MediaTek), performing
> a tight loop is not desired: because of the operation timing in the
> SPMI PMICs on these platforms, it makes more sense to wait for some
> microseconds before trying to read again, reducing CPU busy time
> around these state waits. For this purpose, a ~10uS delay was chosen.
> 
> While at it, I also took the occasion to tidy up this driver a
> little by optimizing its probe() function.
> 
> [1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220329115824.13005-2-zhiyong.tao@mediatek.com/
> 
> Changes in v4:
>   - Avoided moving call to platform_get_irq in patch 3/5
>   - Dropped Nicolas' tags from patch 3/5 as it's different now
>   - Added newline for readability in comment on patch 5/5
> 

Whole series applied, thanks!

Matthias

> Changes in v3:
>   - Added two more cleanup patches (4/5, 5/5)
> 
> Changes in v2:
>   - Fixed a critical typo in patch 1/5. Thanks Nicolas!
> 
> AngeloGioacchino Del Regno (5):
>    soc: mediatek: pwrap: Use readx_poll_timeout() instead of custom
>      function
>    soc: mediatek: pwrap: Switch to
>      devm_platform_ioremap_resource_byname()
>    soc: mediatek: pwrap: Check return value of platform_get_irq()
>    soc: mediatek: pwrap: Move IO pointers to new structure
>    soc: mediatek: pwrap: Compress of_device_id entries to one line
> 
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 225 ++++++++++++---------------
>   1 file changed, 97 insertions(+), 128 deletions(-)
> 
