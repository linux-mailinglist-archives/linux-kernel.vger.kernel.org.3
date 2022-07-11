Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0367956D304
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGKChM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKChJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:37:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9104918382;
        Sun, 10 Jul 2022 19:37:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e132so3601816pgc.5;
        Sun, 10 Jul 2022 19:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KYXBxETadIY8kHIH11CVmyV2r8MLGFf+pAjzRc0P/V0=;
        b=LfFh5qDPxy0SOn0Isaw+jHnkYNCuCN617lNenJpB51pa2M5S+zOEUEkoODtJ5DDi7X
         7MonAZt7ztiE5I/+rULZaFjkFRTaIH9fzSoTfRZgxLrRm8vvoiL4CLeZduQWE4KL+eu5
         ow3NZVXgzK2k5gtd4hbwCPNQ6XZpMv5Ftdz28oNofG529n3NOasdSmJeTaJ4xadNY3Y2
         Mmm58XXss7PYjxFLykxhO4x9p1c7yIrjHBs1x7sZLX3xQl4EYwp8T0p3ClEjtiCWeL/T
         aRYkyzp0sbq+/s39u3AZ8biyY7EIZZiJaN4zi43MAlQ+Q5FTSIwCELlqVCgXOVwX580e
         OWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KYXBxETadIY8kHIH11CVmyV2r8MLGFf+pAjzRc0P/V0=;
        b=eY60vk2zJsQUNP2H7g7wOyGsJspi1oz3G8WXqeNH9EiO9AlNFMoJGtwOs7HG2NDRNA
         UL6MhZmaCPwka4gVxQpTEoTiSpbDz9qBXdgFcNcTefeMfEx93QM1H8/TEnvY+qwc4AHX
         6DDhO3eZbzsknc0KcNACgmM5anBS27AETbaKZ1I77xxDGI4KWRXB+kyfCvyZQMaVdlkP
         ldvUYnwdSqbZ9DaTj2QWenG8EUnT241k/OwjKmieWIM3heIhfKt4Nx0MucA4NUE7L4z8
         tzChrOWLomUNJXh3hP4R42UW+NfKJM90glywNgm+N+loDNlFVkP7JJIVVWTanp1irXi8
         7uCw==
X-Gm-Message-State: AJIora8sdNOpYD76Ei010XpfEEK20Fns0RtFA6N6Z2zZIiA3PeR9AGti
        5TfWmSuhpFOcEnnKw0GWaCeguncb++E=
X-Google-Smtp-Source: AGRyM1s3jOZyBXcl7FpSAa4vlr0D6Xr/DWu4brEpCTOOs3EEwx+BOV6LRFnvaknMEht6NbxVM483ng==
X-Received: by 2002:a05:6a00:2188:b0:50c:ef4d:ef3b with SMTP id h8-20020a056a00218800b0050cef4def3bmr16056377pfi.83.1657507027978;
        Sun, 10 Jul 2022 19:37:07 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a138800b001ecbd9aa1a7sm3487069pja.1.2022.07.10.19.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 19:37:07 -0700 (PDT)
Message-ID: <1a33e931-0bf2-4eed-cc7f-718fb49f6bde@gmail.com>
Date:   Sun, 10 Jul 2022 19:37:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH v1 10/33] thermal/drivers/broadcom: Switch to new of API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-11-daniel.lezcano@linexp.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220710212423.681301-11-daniel.lezcano@linexp.org>
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



On 7/10/2022 2:24 PM, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach.
> 
> Use this new API.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/broadcom/bcm2711_thermal.c | 14 +++---
>   drivers/thermal/broadcom/brcmstb_thermal.c | 20 ++++-----

For these two above:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

and for the whole patch:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Any chance we can keep the struct thermal_zone_device_ops const though?
--
Florian
