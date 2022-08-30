Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271E55A5D92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiH3IAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiH3H7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:59:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6022FC3A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:59:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m16so13030019wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=PfTHcNNyHIJD+nGjOH2sD5OMJ9tlsi2wR693y33YW1M=;
        b=AL1GR7DB8kFqACkXykURW0f4VRsZOJ0CwBb6F4d0wHJYAKDeJNc4fKpViJM2j1VNqL
         heOeufIjj7dspTgrPxOLLX5ZSxk6BnLuYBWkwEMrWWj9izy8yyQXlSOSylmuFLAPNcAy
         Gf/cx+Qjs9EKPriQvTJKBFJXVNV1DfSYP8NP3A9VqL6oA6kQXytiX5HS3c0bjzw5FuUA
         fZONx/YlfxVPd+hJp6sjRpepn3asJYXcGdPWAZkcNDa5MbRvZGxVLuk3gHkLoEAcxvjb
         AB8Y82d68kJBpf6HGGewDsTeMLgoeSSzTaQtNpQWQy6DSMH/WSLFIPLO0WX1PN8odIcL
         EnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PfTHcNNyHIJD+nGjOH2sD5OMJ9tlsi2wR693y33YW1M=;
        b=u35SgBBiK5qOJGtQyJ3eGnUda759TQKZgTpHrw7FmRaF0RacdZZe2GGa93swBBJA3B
         FdfuB4cw18O+hb8glpPkmT+DhdkAQljUbLHCcpLAF2virS2agWIchuvXhJzApXGdg+Eg
         3tUS1v2KqSCBahzyjBOf9BzCGuDCHI2ynwVIkAKLmCJ5AEMFHvy1wiLxwwZCSxxcEMOI
         OWZF5O1S4E2uO9dZuhc4A+1aSRJVgo0Cz4HtbGVmTZthLjJsu36eztOWCFFbJLlIj6Qo
         vFky0sJTNU3n9R7blGYEJ71TxOkRIXESN6fQwxC5BCxA23tTSPDgGe5KjrTDHQXYurur
         MJMQ==
X-Gm-Message-State: ACgBeo1URfQy3sazStW4L+TAgdkQ+MfFSRIDJ9bCpyi69bCRgrbf/yYF
        67G+7UUjGhYBF7/5dmzoRr8hDg==
X-Google-Smtp-Source: AA6agR5S6blYHlG/ZQ3FKm6/GupuDMufIbUfhIkh+6zlULEaWM1DuSdjLLD/+HMPKGYT5Pndi9k2KQ==
X-Received: by 2002:a5d:4301:0:b0:21b:8af6:4a21 with SMTP id h1-20020a5d4301000000b0021b8af64a21mr8543497wrq.296.1661846385373;
        Tue, 30 Aug 2022 00:59:45 -0700 (PDT)
Received: from [10.35.5.6] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d4d88000000b002253d865715sm5875817wru.87.2022.08.30.00.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:59:45 -0700 (PDT)
Message-ID: <a0425472-00ed-81dc-e98d-fbccc1e95575@sifive.com>
Date:   Tue, 30 Aug 2022 08:59:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH 0/3] Rename sifive L2 cache to sifive CCACHE
Content-Language: en-GB
To:     Zong Li <zong.li@sifive.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        greentime.hu@sifive.com, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220829062202.3287-1-zong.li@sifive.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220829062202.3287-1-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 07:21, Zong Li wrote:
> Since composible cache may be L3 cache if private L2 cache exists, we
> should use its original name "composible cache" to prevent confusion.
> 
> This patchset contains the modification which is related to ccache, such
> as DT binding and EDAC driver.
> 
> Greentime Hu (1):
>    soc: sifive: l2 cache: Rename SiFive L2 cache to composible cache.
> 
> Zong Li (2):
>    dt-bindings: sifive-ccache: rename SiFive L2 cache to composible cache
>    EDAC/sifive: use sifive_ccache instead of sifive_l2
> 
>   ...ifive-l2-cache.yaml => sifive-ccache.yaml} |   6 +-
>   drivers/edac/Kconfig                          |   2 +-
>   drivers/edac/sifive_edac.c                    |  12 +-
>   drivers/soc/sifive/Kconfig                    |   7 +-
>   drivers/soc/sifive/Makefile                   |   2 +-
>   drivers/soc/sifive/sifive_ccache.c            | 221 ++++++++++++++++
>   drivers/soc/sifive/sifive_l2_cache.c          | 237 ------------------
>   include/soc/sifive/sifive_ccache.h            |  16 ++
>   include/soc/sifive/sifive_l2_cache.h          |  16 --
>   9 files changed, 253 insertions(+), 266 deletions(-)
>   rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml} (92%)
>   create mode 100644 drivers/soc/sifive/sifive_ccache.c
>   delete mode 100644 drivers/soc/sifive/sifive_l2_cache.c
>   create mode 100644 include/soc/sifive/sifive_ccache.h
>   delete mode 100644 include/soc/sifive/sifive_l2_cache.h

Is this series available on a git branch anywhere, I have at least
one other cleanup I was doing in a similar move to rename and make
it usable as the l3 cache.

I gave the series a quick review and did not find any issues so far.

-- 
Ben


