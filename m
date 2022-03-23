Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDF14E512E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiCWLVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbiCWLVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:21:31 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E1D2AE2E;
        Wed, 23 Mar 2022 04:20:01 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id dr20so2144222ejc.6;
        Wed, 23 Mar 2022 04:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8NQwjInQeHX4PNBQH9WRkcIExVlhXjtH5bBsP3hUUow=;
        b=rsmRF13+szGJjK74EX3UkoYGPxvponNSH/MTschx7TUpNFbfZCezKQoVkHseddkMee
         NyDvaHi/XRHWfWuhGvs3qMZ/6lqK+Yh8OSq4gn8Ml4AP2TNkWkEU4Ol9Dl6eYb/l1M43
         R/lGeCiTbVeFLeznRCzC+vKJu+pYMDw+Zf1PSlOnBBl1FBzJM4Yh0xW4Uca3QfedddyN
         he3NLddOQ3SQ/A6cOOhZ64fjdspy91/nWgUeVclN6qm4hdY1tuEa8y1k7v4gbz35frUI
         R0ZPJ3ovlKw7D18YAjQltfhs6Xop/iJtVihL7hyfn/x6cWmzjAxs+/1/5aUHkVaFAS9e
         EtRg==
X-Gm-Message-State: AOAM530JtDL/9Ivc+2QF1nfntxf5tljZRYNlvO7pod79j0JAMM2UlaTY
        bNimD6zILEzlVE/Ad4ABaF8Au0BZNQZpRw==
X-Google-Smtp-Source: ABdhPJyggNgkzWof95iHK2BBBMKkQTe1ofpITUi/c6gBiK4dbd3/biJiEJrfNyHqAUzhektMkOESWg==
X-Received: by 2002:a17:907:16ac:b0:6e0:1646:9121 with SMTP id hc44-20020a17090716ac00b006e016469121mr14215917ejc.194.1648034400203;
        Wed, 23 Mar 2022 04:20:00 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm9582171eji.67.2022.03.23.04.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 04:19:59 -0700 (PDT)
Message-ID: <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
Date:   Wed, 23 Mar 2022 12:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321165049.35985-6-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 17:50, Sven Peter wrote:
> Apple SoCs such as the M1 come with multiple embedded co-processors
> running proprietary firmware. Communication with those is established
> over a simple mailbox using the RTKit IPC protocol.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/soc/apple/Kconfig          |  13 +
>  drivers/soc/apple/Makefile         |   3 +
>  drivers/soc/apple/rtkit-crashlog.c | 147 +++++
>  drivers/soc/apple/rtkit-internal.h |  76 +++
>  drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
>  include/linux/soc/apple/rtkit.h    | 203 +++++++
>  6 files changed, 1284 insertions(+)

Isn't this some implementation of a mailbox? If so, it should be in
drivers/mailbox. Please don't put all stuff in soc/apple, that's not how
Linux is organized. To drivers/soc usually we put drivers which do not
fit regular subsystems.

Best regards,
Krzysztof
