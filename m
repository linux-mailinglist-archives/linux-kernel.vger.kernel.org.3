Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA93A58A1C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiHDUM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:12:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E676AA16
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:12:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f22so1016553edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QYSwK07kFYzHOiq05oaaTeiTGf8E7cSSTShc3Z35lBI=;
        b=oYPswzpRQ8j5186pmGEAPZmY0GHoRqo5vI88nI3j3AC+yaQgLaJCVrcW03HDfUodnq
         RkWnnepiaAN5KEMhlv1hJJMu1F9fmj9qMXQ/+tPyDaT0KIsG1afxH1P0ZHLmxvnKjwf4
         X17shsq4aCMV3gKXDrGlts4a79oysHvVvbtbOo/GlKj4cErk1OdvGKdU9LgmAZj8p9ei
         YsZYet5GrBPEJvUQDbYYLRsIk04Ue/6tAgjVzFFVgiPdvxNetrtPYcdpBHLVz/3kJ9Rh
         kwABJnXKKaXu00bVU7bVkXq8L61k9lC7jd9MWgBQrgwj7LkizXs1DqkvxCecKO/F68vy
         igFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QYSwK07kFYzHOiq05oaaTeiTGf8E7cSSTShc3Z35lBI=;
        b=IqJMon9TPrTS9swJhYlAzWe0Z0FXdLfpPQoz000zkAQk4FXCn3gTLJPH9SYdBRXUie
         vLcuSEhCOma6cMsyidQ78Y1yiXBcQ+AuLh5nj4ZpDlvUx3bpcUgbvwuKKaorL5ANW5+R
         HutpN0SGkKj87b3oU0EHLE7uZcSogih/uDuFfHuZt/vnce+KXxFcafPQzG98aXm4LRP3
         1KSKSYoQ+7FxQ/HSao2+SCW3n8rgcd2QeLHyc8CCtbwZnj5Q38CW3DOu++HZM0AXRGaC
         1es0JpbjsGC1zRbC0W6vtGEl7Gbtf6D84KDV+JbYzRQ+T0DZ+IXDhOaeq+2fQSapaNLC
         KccQ==
X-Gm-Message-State: ACgBeo3MLHJDmbIXjmf2kpXj34vN2CorY1GHrYIzvw9XI/7KkZpRjxIW
        tK+ngfDwyuJzWNdlhwJS5ZQ=
X-Google-Smtp-Source: AA6agR5X18L1PXXInZNRdf/HPlE0O/+hdC7bx/AQSVQkty4CikFF5AaTlfaNHNI8kYsDj+NyYcaTiQ==
X-Received: by 2002:a50:fb99:0:b0:43c:d008:d4f9 with SMTP id e25-20020a50fb99000000b0043cd008d4f9mr3614188edq.13.1659643975435;
        Thu, 04 Aug 2022 13:12:55 -0700 (PDT)
Received: from [192.168.1.103] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906539700b007306a4ecc9dsm706630ejo.18.2022.08.04.13.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 13:12:55 -0700 (PDT)
Message-ID: <b5301b5b-9f6e-f3a4-4d0a-a01cca29c940@gmail.com>
Date:   Thu, 4 Aug 2022 22:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: make some functions static
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220804105532.7532-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220804105532.7532-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 12:55, Michael Straube wrote:
> This series makes some functions static what allows us to remove the
> files hal/rtl8188e_xmit.c and hal/rtl8188eu_recv.c.
> 
> Michael Straube (2):
>    staging: r8188eu: make handle_txrpt_ccx_88e() static
>    staging: r8188eu: make rtl8188eu_{init,free}_recv_priv() static
> 
>   drivers/staging/r8188eu/Makefile              |  2 -
>   drivers/staging/r8188eu/core/rtw_recv.c       | 79 ++++++++++++++++
>   drivers/staging/r8188eu/hal/rtl8188e_xmit.c   | 22 -----
>   drivers/staging/r8188eu/hal/rtl8188eu_recv.c  | 91 -------------------
>   drivers/staging/r8188eu/hal/usb_ops_linux.c   | 14 +++
>   .../staging/r8188eu/include/rtl8188e_recv.h   |  2 -
>   .../staging/r8188eu/include/rtl8188e_xmit.h   |  2 -
>   7 files changed, 93 insertions(+), 119 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_xmit.c
>   delete mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_recv.c
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
