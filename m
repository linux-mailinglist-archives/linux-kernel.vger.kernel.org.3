Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA74C50B916
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448258AbiDVNw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448220AbiDVNwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:52:41 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F75A08E;
        Fri, 22 Apr 2022 06:49:45 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v65so4372008oig.10;
        Fri, 22 Apr 2022 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2hUCjoSiiYLWYN4sO8hPNgzy9FEp85DUf4TVxMg+qtc=;
        b=j7I7wgEyCK96dFdHlTflQZpkiMaIXyl8LrmU5uN53qjQYC2nuoO9InsQ8rI7UWVim5
         19M/825BdaWJdBPrx6vMWlkxE6elHL9NBUESvA9BMeOogUrCOLqpDvKF71nY8zUuq9KP
         bgkpiTAoytUInIcPPwhiCFaOTrdyDTVSucxjGxYc+qhAz+TJkgcn52/99o4SHsbjIIHR
         JmKlqDLSwEKTZHrATeVlEj4kpjP50B2gFv/Tbk2jXFOBnJVTOM/UEOwOkKoGWq9Q5dLm
         SjcPoQS8sCfXEssRvSwBqho/xDCrvMaBRi75yuLdMBSasVBPV6yrdZL2JWOQo99HE3Ku
         odmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2hUCjoSiiYLWYN4sO8hPNgzy9FEp85DUf4TVxMg+qtc=;
        b=mLhiw/1htt6WgchyKe+qt+7fO0QZOmKNIxOHYci97w3txILa88VR/d7olKQcy70wwR
         IzhUWg3g4SmCDfRIaP6SQePUkQkwQeTOQ588Auv9RI6F7/+QFyHIPbTgt4JyaQOKJaZi
         q8gE/b+BgZVhRP2nUxa5JfLCty6Lk5vM+7wyX5Oqo7dHcglrq1Fy0DbhC8xJkIgwdNHD
         ezXGzoyO0flFgcpoNW2dhEKhp14ZNcmL4B8uFhQH5SuU1zouq+Dvoc4yhHV/udnVov1C
         Z0InuUCQYdjn81UdA6Z9fffmqGUtuXc51lWGlI8am9VEl+mo0GHngykwUqL14AE4Z8cD
         IAfw==
X-Gm-Message-State: AOAM530hj+2nHGLbxYrxBFPUI6v9nbKCiuNQKu/jrcsSg6RxY+S42Os+
        4cNYbwTALS/78WQbgcGA1x+MxVhKkcl4Pw==
X-Google-Smtp-Source: ABdhPJxddqTbRoZu2gSCeYOY47XWWQUyiqKP1ieP9KSSEDZyHym8S2cs9G/4D1hqv2wwu6wqQeOVvg==
X-Received: by 2002:a05:6808:1384:b0:322:2bcc:42c0 with SMTP id c4-20020a056808138400b003222bcc42c0mr2287933oiw.11.1650635384561;
        Fri, 22 Apr 2022 06:49:44 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t3-20020a4a7603000000b0033a53c11f82sm799425ooc.20.2022.04.22.06.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 06:49:43 -0700 (PDT)
Message-ID: <18d61fa0-358c-6051-56e6-abce9c2b1403@gmail.com>
Date:   Fri, 22 Apr 2022 15:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] Correct power domain for encoder
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220421035111.7267-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220421035111.7267-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/04/2022 05:51, Allen-KH Cheng wrote:
> Base on current mediatek encoder driver, we don't use larb driver to
> control power. Add power domain to mediatek,vcodec-encoder.yaml.
> Alos we pick missed PATCHs from 20220117070510.17642-14-yong.wu@mediatek.com
> and add power domain to encoder nodes for mt8173 Soc.
> 
> Allen-KH Cheng (1):
>    arm64: dts: mediatek: mt8173: Add power domain to encoder nodes
> 
> Irui Wang (1):
>    dt-bindings: media: mtk-vcodec: Add encoder power domain property
> 
> Yong Wu (2):
>    arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
>    arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes
> 
>   .../media/mediatek,vcodec-encoder.yaml         |  7 +++++++
>   arch/arm/boot/dts/mt2701.dtsi                  |  2 --
>   arch/arm/boot/dts/mt7623n.dtsi                 |  5 -----
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi       | 18 ++----------------
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi       |  6 ------
>   5 files changed, 9 insertions(+), 29 deletions(-)
> 
Patch 1 got pushed to v5.18-next/dts32
Patch 2 and 3 got pushed to v5.18-next/dts64

Thanks!
