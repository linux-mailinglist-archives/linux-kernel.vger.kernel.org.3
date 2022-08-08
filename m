Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4097258CFCE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbiHHVkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243755AbiHHVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:40:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397661149
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:40:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gk3so18923521ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=hKNdrIhTcuWS4UXrsTgEmuPZ20G7qPaHjL6r2nx+HBA=;
        b=PpcVbFj6MyLtCX/UPh2e3IhwiaUKUJxB3QPlOMIGJNbI9IB1apQB949Pd+5mPwCXTD
         PzGxTwhAjHseV+Id0a0zbGHAcE+n/pCvCLJJBNToDs8/EyP0jTs7Am34u5Yz0u9ok9pJ
         wa73ngwdh1PR6fWkk3n/1wGefyW3LczhkDawGzubflTo9/nY5oyJoZn0iO0kREbGfH8H
         er3ogi9OO6eEmWM2sZ3sm/0kn53PEWWxIoca6BmlsnLgt9j3zKXDRVQPymkGYSgqG5Jz
         dRetYXxDyU+9l29Ch8BYNHiFWmpjkXmlF/Zw7Pr7HozhIqzuUjTi3BxQPuqGh3EPNO94
         f4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hKNdrIhTcuWS4UXrsTgEmuPZ20G7qPaHjL6r2nx+HBA=;
        b=ZkF/WEMWRBbVzHiCZezJuh4D23ouDYSs+82/xffwmptlZ2PrX3wKuYUG/MpL+Gbpi1
         AleAR6dNHJgaKkYZHgu0+sXXjLzGVl909JN2+5SW0UhtSdlTpukXmCbToKW7+ds+Yu87
         TQGgLotORy0d3aZRTMqJNLc8LcprfoxZ7OdEcQRBNNqarKVihZJJKXMey8WUbyZm7isl
         3+og4jJ+xQ67yS1U8hg5jVRwBXzH7fiWcltie6SBaDuYzvMeIir9odTQu5P4sOp7Dg4O
         7dLNvFBUmxM9IhDxWHkcJq4ZvCtCgFK51KoKh6Vf/oIGuurhznAgevHO9dpzODv/G+T2
         01zw==
X-Gm-Message-State: ACgBeo1IGFAulHdB/AW6ua5NRqhOSh/GEI7ock56vhzrLG7K+rmhLpTO
        hzXaW8l08abbbgijeZWn0ln2bnzAfaE=
X-Google-Smtp-Source: AA6agR5H59p1aGVsrVoSn97J02rC05KduGyE1qXbdzlwrd+6g0jhQuq9r4s7MWCJIsa1D0w6Jmg6Wg==
X-Received: by 2002:a17:907:2723:b0:731:3310:4186 with SMTP id d3-20020a170907272300b0073133104186mr8266082ejl.100.1659994805741;
        Mon, 08 Aug 2022 14:40:05 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906644f00b007307c4c8a5dsm314049ejn.58.2022.08.08.14.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 14:40:05 -0700 (PDT)
Message-ID: <56261cf8-dba2-40da-6612-bddceb402fba@gmail.com>
Date:   Mon, 8 Aug 2022 23:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5] staging: r8188eu: clean up _InitQueueReservedPage
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220808201405.68966-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220808201405.68966-1-martin@kaiser.cx>
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

On 8/8/22 22:14, Martin Kaiser wrote:
> Simplify the _InitQueueReservedPage function. Remove unused code.
> 
> This series depends on the "simplify endpoint configuration" series.
> 
> Martin Kaiser (5):
>    staging: r8188eu: remove a temporary variable
>    staging: r8188eu: make numNQ a u8
>    staging: r8188eu: change all num...Q variables to u8
>    staging: r8188eu: remove two unused defines
>    staging: r8188eu: the high prio queue is always selected
> 
>   drivers/staging/r8188eu/hal/usb_halinit.c     | 33 +++++++------------
>   .../staging/r8188eu/include/rtl8188e_hal.h    |  3 +-
>   .../staging/r8188eu/include/rtl8188e_spec.h   | 12 ++-----
>   3 files changed, 16 insertions(+), 32 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
