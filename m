Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C54E44C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbiCVRLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiCVRLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:11:32 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE7478059;
        Tue, 22 Mar 2022 10:10:04 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id c62so2977166edf.5;
        Tue, 22 Mar 2022 10:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xgLpXYKrGRM0LPMxrUU/nWjLzhk/XDVmKUWyNC9e+2s=;
        b=QGNmG+YDXM8tS3npRaoXcBab0tK96+y7yJIWSUGcgacsmx4+IdshoxorgxR5E4k9rK
         WzKM+OTxUURACO2iy2YC+Cg7IZbapp/G5cCh/zeyqzV4iqtf8nHxwLwXqLKAto8xkyX5
         TR9OCsEMaGVS0THoKuHUuFosxzsXvifvH7gMocWrvUN4Qujs0NEs/A38eDTJJHFnUXQm
         7gIiITvOvEhDLNHAXNH9uBFaXfG2R+nppdfxB4wEbsy4VIW+40EMfxAjiz43Y+0IqiBt
         YYQkeafo+xDdoCvEs872QDrVxg3dfhpMS72JwMQ91SqO+bguX+HIY6tpFRSC1KTfkniL
         6X/A==
X-Gm-Message-State: AOAM5324+SQvMJMO4rGV09s5ec4aWRi/ZxAjRTGFKNI8Jauwxm8bPv/z
        Vg4y0WsR3PKUxgDLFi5wWBs=
X-Google-Smtp-Source: ABdhPJxVSiGCUR2u9o3p68s+gMYV2ZChhCYnEeRkVV3BdjnI7U4sMC2OGOYza3FR+oduALIcCEu7VA==
X-Received: by 2002:a50:cc89:0:b0:400:8f82:99e8 with SMTP id q9-20020a50cc89000000b004008f8299e8mr29768149edi.7.1647969003077;
        Tue, 22 Mar 2022 10:10:03 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id o2-20020a50d802000000b00410d7f0c52csm10124565edj.8.2022.03.22.10.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 10:10:02 -0700 (PDT)
Message-ID: <ad877924-68bb-f029-258a-0cf9094265eb@kernel.org>
Date:   Tue, 22 Mar 2022 18:10:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
 <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 09:59, Daehwan Jung wrote:
> This driver supports USB Audio offload with Co-processor.

One do you need one more XHCI driver? How does it differ from existing
and why existing cannot be extended?

> It only cares DCBAA, Device Context, Transfer Ring, Event Ring, and ERST.
> They are allocated on specific address with xhci hooks.
> Co-processor could use them directly without xhci driver after then.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/Kconfig       |   9 +
>  drivers/usb/host/Makefile      |   1 +
>  drivers/usb/host/xhci-exynos.c | 982 +++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-exynos.h |  63 +++
>  4 files changed, 1055 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-exynos.c
>  create mode 100644 drivers/usb/host/xhci-exynos.h
> 

Please address all the questions I raised in your v1, do not ignore them.

Please use get_maintainers.pl to CC all necessary people and lists. It
makes me very sad that you do not follow the kernel development process
(as mentioned in submitting-patches.rst and other documents).

Best regards,
Krzysztof
