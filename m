Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02C5A2B43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbiHZP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344582AbiHZP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:29:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6BE13E22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:28:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id az27so2210409wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=IRiL8nVKf9q/KYGvbAx61vmtk80TSfbBKt0e+CxOfpE=;
        b=pcfdx/FNHPtFGtypx8TKgBd0IvUGbICnTfjQEAxa3PIEiy0yhB4BoUgkvDHXMlfiLn
         FdB8eRT3udDg3xTAsbRyICL+h/9LDEE2K8Z7T5fVxmzkbsOJRtz5uI0Egn365RrGqusC
         lz3JlQpzVRMNsJbjTMJsyPavEIKJPayMwUt697cbblQP+xMunN+vIIXFqHXVogIyJSqy
         gqatMMxX7oeZJ9Y+a6smXM55J1kjggVgFp+iJaHgVZgtFqgdz+B8PLhct2dSMuNb3kAs
         1tr1wVaZ20NWr2vbaUsRZUTwdTtFARZnWdyMiFcyjWSfYVh+QBbHOKdQpWBjQRtRn47R
         OUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=IRiL8nVKf9q/KYGvbAx61vmtk80TSfbBKt0e+CxOfpE=;
        b=QmYOSJn0FVFLkknoUrmwJc86K+ihUIFlpFQSLPrhbKf1tY2729uKVrEX1wiTM3O5ch
         Sjc+eDZI/7iEUilIsTGOCKf9x/yXKokDqVGIqFBqHdkjuzUZNuJ4CNe+IrSZ3yAe1A3a
         BbXpZWwTiQSG7uOkH642SCJRp/vPDNUa3/6aQDvLQFqxPkKkMvRoN6tZRFuDKaBKSOET
         TEXjx5hSSidePUIiNFprr5UA7AhtNM+iUTYk9JiX6qQU2oItsHQrt+qb40dcnNeoEA2P
         myA7Kzl1TCNZYoh6mfJtJQ59a9eLmXOSRAUZSU5OG5U7djFKs8VeJPhG96efE8lwIJ/n
         yKtw==
X-Gm-Message-State: ACgBeo1JhEk73sEFxTL3R1ZcLzuYjsUid0VUmduVX0ESaNo8gA6lC1Ov
        dR/SPWXqkTk+pXMZws0+I90=
X-Google-Smtp-Source: AA6agR72HaF88Vx+BOAHjQKp8mO58YoHYIOnzG+QYlPkgSalEAKX8gBJ6IMXigK3dI1FNUcr3LG9lw==
X-Received: by 2002:a05:6000:1d82:b0:220:5f9b:9a77 with SMTP id bk2-20020a0560001d8200b002205f9b9a77mr106442wrb.622.1661527681017;
        Fri, 26 Aug 2022 08:28:01 -0700 (PDT)
Received: from [192.168.1.130] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c4-20020adfef44000000b00220592005edsm25693wrp.85.2022.08.26.08.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 08:27:59 -0700 (PDT)
Message-ID: <4f1d3e02-0b40-cd29-5339-df1715bed84f@gmail.com>
Date:   Fri, 26 Aug 2022 17:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 0/2] soc: mediatek: Cleanups for MediaTek SVS driver
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     khilman@baylibre.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, roger.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220825184616.2118870-1-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220825184616.2118870-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/08/2022 20:46, Nícolas F. R. A. Prado wrote:
> 
> This is a cleanup-only series for the mtk-svs driver, enhancing the
> usage of standard Linux macros for bitfields for better readability
> and register set/get safety, switches to devm_ functions variants
> where possible and other general cleanups, getting this driver in a
> better overall shape.

Both patches pushed, thanks!

> 
> v1: https://lore.kernel.org/all/20220726141653.177948-1-angelogioacchino.delregno@collabora.com
> 
> Changes in v2:
> - Rebased to not rely on mt8195 and mt8186 support, as they haven't been
>    merged yet
> 
> AngeloGioacchino Del Regno (2):
>    soc: mediatek: mtk-svs: Commonize t-calibration-data fuse array read
>    soc: mediatek: mtk-svs: Use bitfield access macros where possible
> 
>   drivers/soc/mediatek/mtk-svs.c | 260 ++++++++++++++++++++-------------
>   1 file changed, 160 insertions(+), 100 deletions(-)
> 
