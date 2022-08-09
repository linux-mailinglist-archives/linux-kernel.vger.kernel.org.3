Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE158DB51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbiHIPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244455AbiHIPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:46:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336C91162
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:46:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b96so15733098edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QsRthhxHhHAdv2PflzqQQQgkqtvZfM0EySC93SJ2rao=;
        b=Qv5q6gM5oM4bPkMzLk7a3sIgubc0hkTs096hUEXF/fGufLEe2NdLQVSwJeH0rUSQfh
         1u8UEhV2XrSoVzsshteKecixW+lWWeV4DBOhni8ODVT2ZjlkKI1dMVKpdm3zWLLq1vUc
         6BIaWDZM6wa8y9uGzr/mA7nSya0JTy2hsLcnRUIcqXkMXi3iXTJeH7BJhCSraKPL4CSi
         PX2XWW+emCoX3Ozsao6etJM/vgQcYwhkXp5j8oMQIM8P0V49yo7WhlyHw05zfMEofI4Q
         5oq2+2BDxGIIvhjEo9cu0QuLEZKedsDjNKsP+QXJzhj8Sz1kd7qesHAXBarnxie1cy2R
         PdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QsRthhxHhHAdv2PflzqQQQgkqtvZfM0EySC93SJ2rao=;
        b=d/gl/ZdVIRGeEWga+sNIe+GSxx22SdS5btS87T8mV2JZ4AxOTYalB15qOgYPuTBv9m
         TF/x9pGEqJ+s9r3bUjjVkOn6qWveFOBgdCItRts+2HppH+FXnKsiuqGjLMHpNz9Jbn9j
         yNFen0dg4BDucf2ZuktObMdJuHUasI/P507VTxGwbnIo2wnCmNOFTHKRwTmbZCgpBjlP
         21fhlNmgPCzcZ4AjriPuY3fHeC8xwVROJ9ORAz6/t2LRGIvTp5lchjbPoAl9ecBqJSyc
         Sjluj6XUVZKgPie2P+JDfMoxeyUihij3wF5kG2sPSMdhkK0jxKROVeQX76Fb1dvkpw8L
         z/eQ==
X-Gm-Message-State: ACgBeo1x/aSE5FBLWG401YBvFIW0hPpD7wjwFDL3Itr1xaZkjwx9XAdC
        GeyUrYms/LF4JwQbto7v9AI=
X-Google-Smtp-Source: AA6agR5f/v0epeBGU+rPBdpypZ4fkyy1hmxsP79gNIs3FXsoAJSQDwbs2hGUD64x/Vr70styftevUg==
X-Received: by 2002:a05:6402:2792:b0:43f:6873:7497 with SMTP id b18-20020a056402279200b0043f68737497mr20486515ede.175.1660059964666;
        Tue, 09 Aug 2022 08:46:04 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906448e00b00722e603c39asm1278128ejo.31.2022.08.09.08.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 08:46:04 -0700 (PDT)
Message-ID: <8c326964-ba0c-bdbd-d7d2-177662808e95@gmail.com>
Date:   Tue, 9 Aug 2022 17:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5] staging: r8188eu: remove os_dep/recv_linux.c
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220807181538.8499-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220807181538.8499-1-straube.linux@gmail.com>
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

On 8/7/22 20:15, Michael Straube wrote:
> This series moves the functions and/or their functionality from
> os_dep/recv_linux.c to the relevant parts of the driver. In most
> cases it's just making the functions static. This allows us to
> remove os_dep/recv_linux.c.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (5):
>    staging: r8188eu: merge rtw_os_recvbuf_resource_free() into rtw_recv.c
>    staging: r8188eu: merge rtw_os_recvbuf_resource_alloc() into
>      rtw_recv.c
>    staging: r8188eu: make rtw_handle_tkip_mic_err() static
>    staging: r8188eu: make rtw_recv_indicatepkt() static
>    staging: r8188eu: make rtw_init_recv_timer() static
> 
>   drivers/staging/r8188eu/Makefile             |   1 -
>   drivers/staging/r8188eu/core/rtw_recv.c      | 125 +++++++++++++-
>   drivers/staging/r8188eu/core/rtw_sta_mgt.c   |  13 ++
>   drivers/staging/r8188eu/include/recv_osdep.h |   7 -
>   drivers/staging/r8188eu/os_dep/recv_linux.c  | 165 -------------------
>   5 files changed, 135 insertions(+), 176 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/os_dep/recv_linux.c
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
