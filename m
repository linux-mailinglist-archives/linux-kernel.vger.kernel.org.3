Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1253538A45
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 05:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbiEaDrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 23:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243735AbiEaDrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 23:47:39 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E7506DD;
        Mon, 30 May 2022 20:47:39 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id r71so11728257pgr.0;
        Mon, 30 May 2022 20:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J88H2LWRLwC+ieC8JScbnG8mP43mgFvekYycMO4/ses=;
        b=ndZB8+1IxJTuVN/IwEGpEo2glfb7X1F7oL4RYyyzZGR8nMTPf88Vv+PEz6MVwrPnl6
         EpgOzb1jPv5kStsP9MY5/Mc09/Fbsa1U9KCPZUqBQe7FTFPzns0Yg4Ze67VXjzpYjtNa
         gtORFhrB/z2GlE0DIXRXUblaTljzB+2eOyMUS11nmBHkVe0h/WyfWX3AoBU5vwT/YmYd
         OcRXQTObcBKOP8vp9Tf/QLCTsP9UPTZaPTiljxm7l7AMZljEYpvuLWsvavPZW8kbYFMy
         5ITTV006eMuFuDnVpkNi6CH7PCjY1j+nfzXZF4k3PELBcWn5uATtsQKgT9rxkXeMHRjA
         os6Q==
X-Gm-Message-State: AOAM532tmSBvslrekaR9teY2HleBAn+PoWhNzM7Hb3AsR/JENnEI+/HV
        IZqiLHs9oS8sTo7mO2l/BZQ=
X-Google-Smtp-Source: ABdhPJxAE16L0kA27cz2/U35A3Ni4sJOYW6n1ipy9pryUT7sj/V99AF3l1wrhV+18hPF5ybqLWP40A==
X-Received: by 2002:a05:6a00:1ac9:b0:518:a48a:d8f6 with SMTP id f9-20020a056a001ac900b00518a48ad8f6mr41016280pfv.16.1653968858746;
        Mon, 30 May 2022 20:47:38 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id nh9-20020a17090b364900b001d903861194sm521563pjb.30.2022.05.30.20.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 20:47:37 -0700 (PDT)
Message-ID: <f4e1d900-5755-c57f-029a-eade78a17476@acm.org>
Date:   Mon, 30 May 2022 20:47:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/6] phy: samsung-ufs: add support for FSD ufs phy driver
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, martin.petersen@oracle.com,
        chanho61.park@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Bharat Uppal <bharat.uppal@samsung.com>
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
 <CGME20220531012347epcas5p48262cae18c75bb6ed029f7cd920800b4@epcas5p4.samsung.com>
 <20220531012220.80563-4-alim.akhtar@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220531012220.80563-4-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 18:22, Alim Akhtar wrote:
> diff --git a/drivers/phy/samsung/phy-fsd-ufs.c b/drivers/phy/samsung/phy-fsd-ufs.c
> new file mode 100644
> index 000000000000..a03656006093
> --- /dev/null
> +++ b/drivers/phy/samsung/phy-fsd-ufs.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UFS PHY driver data for FSD SoC
> + *
> + * Copyright (C) 2022 Samsung Electronics Co., Ltd.
> + *
> + */
> +#ifndef _PHY_FSD_UFS_H_
> +#define _PHY_FSD_UFS_H_

Please do not use header file guards in a .c file.

Thanks,

Bart.
