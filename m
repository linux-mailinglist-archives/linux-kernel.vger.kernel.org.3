Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F3359AE65
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbiHTNE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347147AbiHTNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:04:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7778E98CBA
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:02:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u6so3500455eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=eWS77x8zcmwRQgLrk9LSe/k1ik2BwgFAXFMFyPCWSg8=;
        b=mBCLy9+/r6AO00x60DA9hUp67TGLxyRn4fPaLAD95ZNrdR3RP5ts9vg+v3rqUHsJ0m
         ixaD7uORjgKNryXN0lg2MN77676Kd42m49eZzRRp4HVVCWoCG9x+jM2M8/11BvT8UNL5
         RCDG3mUp8O8HeKjDlYEllEIfPpyJzWCgOcpidThvRKovkZFq757vqpraz/scBGuYyv7U
         9uwkwXfXVji117KHCRlU0EFD0u+zZPUhDYzP64rD3jxTZ++XHSB1+39dvKsPSm0SJeCn
         L8Ecd46Bz4vTs09N1imUHyNfxFW6RTJ2jz8UNHnAg9qnbMahi8gi8728eMjybLaUrF6D
         zh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eWS77x8zcmwRQgLrk9LSe/k1ik2BwgFAXFMFyPCWSg8=;
        b=qS7cco5781WlcYWWi1vjV02JY9Y8XozrOR7TCvCNkkh9tZQBpeASkdAvFp+Hinw6GA
         lMq4LDsDIH5ZWiCNynILj3tLXWzve8Est0iIuGDwUwLl6kWBy/rAtblrZ1jBOUX5+O0k
         2KgILMprTsUcFmGxARw3vnB45anH4utNxctI13ZRhL8fknAoUnHuLG92LOhe4h8Z34mq
         MOrGl9JiLBd8CYlITFwdGVpWDuEvl4kZsolidaI7R8pHnL6JkpL7izX+4133RJUZluLU
         Qh5xFUXro2c4D9tFgzfxsF1lKAx4C+BEXwWxHKVnyPRRRzyIEviC/+OP7IC3IIy0LW2J
         t4zg==
X-Gm-Message-State: ACgBeo2E7LxnfX1Kmto4vFM76i3yjTscJdwWLV5mYk/npuHnYqMIkuS/
        bNvYcX2hbh0ohK6hJIv6Y9U=
X-Google-Smtp-Source: AA6agR6ZFeMHBidko9GUdCm1WxirE+DhUZnmjcA5t5+VIRAHjsfzwzgfHwApW4ZjMz4o8ryJjm+vaw==
X-Received: by 2002:aa7:cb83:0:b0:443:3f15:84fe with SMTP id r3-20020aa7cb83000000b004433f1584femr9771377edt.17.1661000527907;
        Sat, 20 Aug 2022 06:02:07 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id f7-20020a1709062c4700b0073d64fcd8aesm819673ejh.219.2022.08.20.06.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 06:02:05 -0700 (PDT)
Message-ID: <9d8ae6e3-0354-f8ea-5c4d-1a8abf48be73@gmail.com>
Date:   Sat, 20 Aug 2022 15:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/11] staging: r8188eu: start migrating mlme_linux.c
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220819125428.8412-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220819125428.8412-1-straube.linux@gmail.com>
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

On 8/19/22 14:54, Michael Straube wrote:
> This series starts to migrate the functions, or their functionalitiy,
> from os_dep/mlme_linux.c to the core/* part of the driver. The goal is
> to remove os_dep/mlme_linux.c at some point.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (11):
>    staging: r8188eu: make init_mlme_ext_timer() static
>    staging: r8188eu: make init_addba_retry_timer() static
>    staging: r8188eu: make rtw_indicate_sta_disassoc_event() static
>    staging: r8188eu: move rtw_indicate_sta_assoc_event() to rtw_ap.c
>    staging: r8188eu: make rtw_report_sec_ie() static
>    staging: r8188eu: remove unneeded initializations
>    staging: r8188eu: make rtw_reset_securitypriv() static
>    staging: r8188eu: merge rtw_{os,}_indicate_disconnect()
>    staging: r8188eu: merge rtw_{os,}_indicate_connect()
>    staging: r8188eu: merge rtw_{os,}_indicate_scan_done()
>    staging: r8188eu: remove unused function parameter
> 
>   drivers/staging/r8188eu/core/rtw_ap.c         |  42 +++++
>   drivers/staging/r8188eu/core/rtw_mlme.c       |  86 ++++++++-
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  22 +++
>   drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  12 ++
>   drivers/staging/r8188eu/include/mlme_osdep.h  |   5 -
>   drivers/staging/r8188eu/include/rtw_ap.h      |   2 -
>   drivers/staging/r8188eu/include/rtw_mlme.h    |   2 +-
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |   2 -
>   drivers/staging/r8188eu/os_dep/mlme_linux.c   | 166 ------------------
>   drivers/staging/r8188eu/os_dep/usb_intf.c     |   2 +-
>   10 files changed, 159 insertions(+), 182 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
