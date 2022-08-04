Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73AA58A014
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbiHDRza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiHDRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:55:27 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD76355
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:55:26 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j11so132019qvt.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Hbjl3nNAZzAxsce6YFBJuobMzGqRGOHNPcP+9siXqBE=;
        b=Ygon3eKTgfZBTXO4e7G23ZXRLZXIP2ETyigijndRgsIyKoRei+iBusncpugnigANpl
         d6EwVc6S1sgiD1iIq1ggSGep6SGhBAUKAU4K42wcd3duO6e8Lizg8froZQUzPAxWKtdC
         kknKw/YWmb3UvH4hXMN43srLv7ZRVbjz3p9Hu8hJbv44IoIfaF9PAwHumSNBvtVCwdIk
         o8s44V9fB3sal1CQTZOHD64v10mZpzvlSrGl9aFMnsmZG/dmkPuHsc49/vpMXVjf3knF
         ZjalYHQh3fuxIOH8ZzSYu41XDiIZe3shCJNk3kHHFTLavRz+vtCj0CNiGdfxMvvUN5N/
         RTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Hbjl3nNAZzAxsce6YFBJuobMzGqRGOHNPcP+9siXqBE=;
        b=eaOu9YfwIDjJxcUD7rCknCPuXCt/S5aANrdKJL7b6uC8o1tFQQZspeJ2eAJ/GOWc1C
         BNWF5ytD/O/GQV8ReGZ0AwzRKWzbAEqY8hfE5k/dnzVKNAXgWsVeu5ebUsMxe2snNSkC
         0BFfR0nyNohcWH10RfTXOE92/eCsri/+IkGut/gwyN2tw+sfJjGbCGyYZ95D2ajs8fqk
         i01AMF0ltDJBNrtS9frI2gj2tmDiGFGsjL4x1SARewAfxlKadteHgvCB7rMqFVcTZxUt
         KOKwxjykfS0/QMLCCCNoLEajqdNtwX8TTxH5fdpmD+vUg36Gkfq+Z5zpiE8Jf7Z6CB+l
         Ceng==
X-Gm-Message-State: ACgBeo0021kSV77bbzWUdShHNo4ON73BXhIsIefZbGcRq0BLsJzkDh7Y
        1VxV90U5BFN/t7EnzVn+T1wJVjWf/O0=
X-Google-Smtp-Source: AA6agR6im+t1U/t5x9jWtYHxLrT0GXVJLmHrJztxXsznigFqDo3eQr0H9U+Ke0xQAt5CGIwLQqUyiA==
X-Received: by 2002:a05:6214:20a4:b0:476:f037:8ac with SMTP id 4-20020a05621420a400b00476f03708acmr2468793qvd.38.1659635725212;
        Thu, 04 Aug 2022 10:55:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bi23-20020a05620a319700b006b8fb2a1145sm1100682qkb.124.2022.08.04.10.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 10:55:24 -0700 (PDT)
Message-ID: <6008ef46-ccdb-ea01-f9fb-4f8fceed2d29@gmail.com>
Date:   Thu, 4 Aug 2022 10:55:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] mtd: rawnand: brcmnand: Glue driver Kconfig entries
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        William Zhang <william.zhang@broadcom.com>
References: <20220711222323.4048197-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220711222323.4048197-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 7/11/22 15:23, Florian Fainelli wrote:
> Hi all,
> 
> This patch series allows for a finer control over the BRCMNAND driver
> glue driver selection such that it defaults to the various platforms
> enabled in the configuration file.

Miquel are you able to review and apply those patches if satisfactory? Thanks!

> 
> Florian Fainelli (2):
>   mtd: rawnand: brcmnand: Move Kconfig to driver folder
>   mtd: rawnand: brcmnand: Add individual glue driver selection
> 
>  drivers/mtd/nand/raw/Kconfig           | 22 +-----------
>  drivers/mtd/nand/raw/brcmnand/Kconfig  | 49 ++++++++++++++++++++++++++
>  drivers/mtd/nand/raw/brcmnand/Makefile |  8 ++---
>  3 files changed, 54 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/mtd/nand/raw/brcmnand/Kconfig
> 


-- 
Florian
