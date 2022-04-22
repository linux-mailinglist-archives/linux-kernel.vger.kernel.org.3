Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2840950B758
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447532AbiDVMdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447529AbiDVMdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:33:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9179E5468E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:30:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y21so5019076wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=uYpfhyLIZUoxSaL7aclvytyYyaHl2rC8E7mXVViSyfc=;
        b=uRlDT3KghQ72J48ecDEdO6TbGuBv79C9de1+zDTZgknkJmgnuE/r1vj8Pz3Rt8qy2R
         HrMpv6ImE2wqji+7uwsnk6qL3uQlr6zXL8QIjGiKTPnfXN14BI+JUnT0BpBKQTav9Wmv
         MfU06RpRMiFymu9hXeZCZY8UAdetQOws9cngYkAH9J2Goqd0yJnUVmWUqkw5ut9Htguj
         gxJmTGiY1eo4el2mxgnzb6RTc/wlYvqM21V/BQfkMg7FC2c7W+I04t/QCnxIVObffiQq
         Qi5kisx98/GiAN0p27vcH4dV1tn1mPpR2pmdCcMaIiN+sisPBq5r9N/irdTLx3xxh2B7
         5yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=uYpfhyLIZUoxSaL7aclvytyYyaHl2rC8E7mXVViSyfc=;
        b=naMnG8YIkLjOzETrB//qP6t/f7pCSZOYv3aI+2tXsVYMrq5/fVbxxGpY87bZdrMrHl
         dN6ptWn2xJXq8QXseNSkoB5fhpe7mHpWCmNob2lqoeNw0QvKehyn3RjVX2PAiuuzYi9a
         +4CpefVF2A9EMxetg+gAcLyfm+MsIzy2vUgN2dUPMBuoV8WJg/2N4zN56KStX+kelvGx
         nSV9avF3BR0jOWlOGxWgiyfOjzqwMib+n7Kxq/nmAksOQQMEM5eKxAy6bDopXdeE1S/m
         dND8vGUj5FuSwYqzV3SET5WERzkUJTmR9bezl3pIwSIGBxmlgAMuv4yxfkVwfAkj9Aat
         k61A==
X-Gm-Message-State: AOAM530UVpsbuYTg8WBUqo3WzBSza6gyLfSsBKE7vt5KFS1JrxC3iwfC
        qUFsqBcKHl4ybvOf7fksLZQbIw==
X-Google-Smtp-Source: ABdhPJz+Jz9pR1hcwEuMnRxUjM1J9wCJDr7UgRKwD7/jIw3O0t/ayEtSDbmDFocJ9N4ZPRpi3INr+A==
X-Received: by 2002:a05:600c:3ac8:b0:392:a821:7975 with SMTP id d8-20020a05600c3ac800b00392a8217975mr13087552wms.138.1650630645810;
        Fri, 22 Apr 2022 05:30:45 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49? ([2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600002aa00b0020a7cc29000sm1766232wry.75.2022.04.22.05.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 05:30:45 -0700 (PDT)
Message-ID: <3406cabe-4fac-ce1c-d710-ccd5f628aaaf@baylibre.com>
Date:   Fri, 22 Apr 2022 14:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 0/2] Add q 12MHz internal clock rate to calculate
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220422111320.19234-1-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220422111320.19234-1-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 13:13, Yu Tu wrote:
> 1.Added 12Mhz as the clock source for calculating baud rate.
> 
> 2.Added S4 SOC compatibility.
> 
> 
> Yu Tu (2):
>    tty: serial: meson: Add a 12MHz internal clock rate to calculate baud
>      rate in order to meet the baud rate requirements of special BT
>      modules
>    tty: serial: meson: Added S4 SOC compatibility
> 
> V1 -> V2: Change format as discussed in the email.
> V2 -> V3: Change format as discussed in the email.
> 
> Link:https://lore.kernel.org/linux-amlogic/20220418053202.24528-2-yu.tu@amlogic.com/
> 
>   drivers/tty/serial/meson_uart.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 05fe70dd2efd13de700c2dfe5169d3a7a5050bc2

Thanks for this v3, all fine for me !

Neil
