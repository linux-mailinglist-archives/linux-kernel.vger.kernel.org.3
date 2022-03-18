Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBBA4DD9C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbiCRMeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCRMe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:34:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E390103BB6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:33:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o7-20020a05600c4fc700b0038c87edc21eso852385wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IVKS+fo96/p9+Ih0mtD1prOXn3p+8FAfNSeavgBoyPA=;
        b=3GHvS5GfsxA3hWn2yBsGEk+Id9A1k83DXM7Qz7rPLPSbaLz70JZuOs7fhFKFiF/tVE
         qN72ygb18bLrX2baBq9OIxfq6pbxhprw5EJrLQ7MgevpG97wS48Iu/Ro1H+pFzl148W5
         efTpmQB1RZnXoR+Z3B2qqXC4fOeDs0oiQCnxwoDls4Ak/wqZ7VkhWEnNFXdKXlEO7/N7
         kVrFK3ZubPjJAePF0HppUIb7cZlFvs6x8nC0blI0z89RL2nWdhyiGnmHiKBNDa5W3ME2
         4RvRH3oef2qhEgsTzSr8kQCsamWAEfZinSXODgPAvG408hYTyC2gbxhyM5KEbnYO28SE
         Eprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IVKS+fo96/p9+Ih0mtD1prOXn3p+8FAfNSeavgBoyPA=;
        b=X0t6qCDQcYH7HWqQOhtUZMZMcbDvYa+kRCfPRR6tZ5kENDxSsYaupiNmXmqpa6LTl2
         rqdE9YNWk4W06sFagQ4o15tPN1EIs3M5lmcjDF4Yfk5QIvQjGSDMJqRJB6stIbmuLD6E
         MVfcelsKFGyYHPCH1vQ0enH58or4RywkGdpqOptUqxoMwny1o1BhLUlLP6jx7bSu+1qi
         7Oywah3GbeSCwIMX/2p9fpWglEwK8ODyY942Qx7YSyjY+6bcX6u0/y7RJDQkOj94ZdH7
         0F/pY+G+rbZQAnwgsCC4MqjMUZbKjUvo1szDB7FHR0URA9BVo/mO58LB8W4G6mGHfuUD
         WQJQ==
X-Gm-Message-State: AOAM53194zbczHimzo67/zpJwK0v5HlTIQP38JrDLtjQQlpmTRUoxKP1
        7qghgsxCNrRbiXaZ4N/f/0cK2Q==
X-Google-Smtp-Source: ABdhPJzwV71tEEpc6CSFgC+ZWzrTAQczGRUmTh+nKq++cYrW3WPOz/9gdoKDEDyvmVHSUi2XSLkP2Q==
X-Received: by 2002:a05:600c:3c89:b0:37f:aacb:cac7 with SMTP id bg9-20020a05600c3c8900b0037faacbcac7mr478320wmb.1.1647606786696;
        Fri, 18 Mar 2022 05:33:06 -0700 (PDT)
Received: from [192.168.2.222] ([109.76.4.19])
        by smtp.gmail.com with ESMTPSA id g6-20020adfd1e6000000b00203f8effc22sm1701999wrd.63.2022.03.18.05.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 05:33:06 -0700 (PDT)
Message-ID: <c11f65fb-a756-0233-791b-6ecc3d9f4f05@conchuod.ie>
Date:   Fri, 18 Mar 2022 12:33:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] Add support for hwrng on PolarFire SoC
Content-Language: en-US
To:     conor.dooley@microchip.com, mpm@selenic.com,
        herbert@gondor.apana.org.au
Cc:     lewis.hanly@microchip.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220307154023.813158-1-conor.dooley@microchip.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220307154023.813158-1-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an error in the probe function's reference counting.
Will fix that along with the quality estimation in v2.

Can safely ignore this version of the series.

Thanks,
Conor.

On 07/03/2022 15:40, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> As it says on the tin, add support for the hardware rng on PolarFire
> SoC, which is accessed via the system controller. While we're at it,
> add the rng driver to the list of files included as part of the SoC
> support in MAINTAINERS.
> 
> Base commit is in arm/soc branch of the soc tree as the hwrng driver
> depends on the system controller, which is to be introduced via that
> tree in 5.18
> 
> Conor Dooley (2):
>    hwrng: mpfs - add polarfire soc hwrng support
>    MAINTAINERS: update PolarFire SoC support
> 
>   MAINTAINERS                       |   1 +
>   drivers/char/hw_random/Kconfig    |  13 ++++
>   drivers/char/hw_random/Makefile   |   1 +
>   drivers/char/hw_random/mpfs-rng.c | 103 ++++++++++++++++++++++++++++++
>   4 files changed, 118 insertions(+)
>   create mode 100644 drivers/char/hw_random/mpfs-rng.c
> 
> 
> base-commit: a483b1b232e616d0095a59b987ffc739bc1b56bc
