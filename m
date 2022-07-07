Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3686056A7F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiGGQYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiGGQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:24:10 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638813E84;
        Thu,  7 Jul 2022 09:24:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l14so23459467qtx.2;
        Thu, 07 Jul 2022 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SSJ4elnbxJxvf6QCLf7utXUCEbaIR7Lkt9U8reZ22eE=;
        b=YLOUb0hlcVdHGIx5N1A2X9na6Phm4zpbcN1Cllw2qlFkfV/HJAyftTwNOXg6wO6HKX
         8OxyJeZh8vEqvJQTHam8WVTuSghrw5Ahwrg/Zu0yoK+yIMTaJJRt9hXXtKAhZFI/50Rg
         LNBmZqjSuNA102g0U+8SQwK1N4rSpE1Y+ISNSx2+eTgdZVdHMUkQRVa/5VLHYLnFcf9R
         LDGCXJjdf9XdyVLD5LPRoLuVIKDK/dzOdjaGwKlwCoFVlfkUPFOEMxRlHx7Ou4YPYbsH
         shb+7LDcxdQugx43adsLNpnjPNgfzUaPxKuc5t2XsLBArjN8clzVL2IDW94aMhgaqxVo
         kv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SSJ4elnbxJxvf6QCLf7utXUCEbaIR7Lkt9U8reZ22eE=;
        b=YY4n1dluoX6mQOOF6WBM/T8ymm12gwLJj9Iy20wnE+fh9eHK7NyOZdW48/+YHzhn/Q
         g06QcpKWpI8GWovAUTTaeqIqSF/VEdRMAQFTTWALnEr8nZSiCXMUczMHeqGtNcW5MlIp
         qbhWCl4zymOtaNDUsoYWJlYvYpL2HFI2nnX/zLRqxlerts3/7ejSEUisKqUQrzjg9kIl
         mtSNIAX19ZzKOUZH1OLucIgvZUqV94bVEZxAEKwkz9Kzpaj2y5DLdumx/a4varkc8Viv
         zgJuU1h/X1NUoG5HXfYaXAn1DaAhKQABHt0ykbK9QBdPtvd5l5wx9cj7JbBVM2Y5CSet
         VvRg==
X-Gm-Message-State: AJIora8qybaqNokmTygDj8AHOHXuSCnXs/dm6+v41NhAbhnmAO0VB7o9
        dhem+rcEURcETWk7UKIlPk0=
X-Google-Smtp-Source: AGRyM1uCsS0iCSMXGnzmvpiI86+oUjN3r2QLeM33tCNDgPqV62RrZc+/+NtmUVyY28g98b54OnqmCA==
X-Received: by 2002:a05:622a:4c6:b0:31d:23fe:7b4e with SMTP id q6-20020a05622a04c600b0031d23fe7b4emr38746633qtx.118.1657211048605;
        Thu, 07 Jul 2022 09:24:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u5-20020a37ab05000000b006b4748535a1sm8741475qke.16.2022.07.07.09.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 09:24:08 -0700 (PDT)
Message-ID: <1e5efb9a-9355-3cb9-fee7-624e87ae9042@gmail.com>
Date:   Thu, 7 Jul 2022 09:23:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 4/8] clk: bcm: bcmbca: Replace ARCH_BCM_63XX with
 ARCH_BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-4-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220707065800.261269-4-william.zhang@broadcom.com>
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

On 7/6/22 23:57, William Zhang wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> CLK_BCM_63XX depending and setting default on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

There is no cover letter for this 8 patch series :/ it is not clear to 
me whether each subsystem maintainer will be in a position to merge 
these patches individually, yet still have all 8 (7 of them actually, 
see comment to patch 1) land in 5.20.

Alternatively, we can merge these patches through the Broadcom ARM SoC 
pull request(s) to ensure they all land at the same time.
-- 
Florian
