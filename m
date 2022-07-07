Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC456A807
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiGGQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiGGQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:25:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C672CCBB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:25:31 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a15so20379606pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U/+6cC0+/ItPqI6+5sthjmspnkck/QqrsfY6aZUXXyg=;
        b=ljeYlSrsTv0URuOoEuitafDdmNQdeoP2d78/j6EM81A1OiFNrI0We4LKAru10dAco4
         KgPmWu9E0RJyos/fkqmeMabFSwGqPl2vPCkommc+860d0tRFMz6UWFpFCHOMr2cxwDoe
         /UYBhoI/MBIVvaI9PeahzpNh497R4sUHO40l1mS4VsQYX8wi8o3750RFsndq5lvxnN29
         +Z+enqqdyNm6GGkhwRdZxwJmxyvEjUHOJnITqaIYetgw6j24FZh3eguQ5tijr6jAaUOa
         VKfUOJcAegxSRzgDDAG3kDwoVb+p+68DeP+POuy90jHfnvTgDsE9ZrGQseft+iLbEXxt
         wVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U/+6cC0+/ItPqI6+5sthjmspnkck/QqrsfY6aZUXXyg=;
        b=4t+fha/i4kh3nmvmtNcLDYmaUezOTrqJwyN4Erkh8nmfXjg9hfsSoS4symnad5iNuh
         Fkub7hkgebrpJY7cSuWjzLfcYSRiAUCGMZoCpMp9ALtBy1zp+fDlGGo8k4dLJiBvlzua
         sdWUgNWPrWxVduCdi1unQ3v6qJ+Tg5dravOomItTW6io4q+Udzknbg3olByCXtgRE4CL
         Bun3nrTzSTaHugZWnnP7hIffSDsCaPhJcQxWvz+cHOPECwv6WWCIDcC/GY4jNLQw3WmH
         55pjqCk28iecgMv2Pyx8ZVHKS8q8ysD+ZfobqVNW1lgKvrxhiDFf8+72TX2lWlAo4gmc
         TTyw==
X-Gm-Message-State: AJIora/P8KgactOWbtKZTD8rgg1t0AFbxGcQt5yKe7gwxkf9B+rdklIi
        g1DvVS4k4A+MHQ/eOrgpHGM=
X-Google-Smtp-Source: AGRyM1tXdnavP9xjwY38EBgMlgaeoM15ly2ZYFWWz3C2dv3JFmaIDveOJbyCIOGfcDnOXxmLs9ROwg==
X-Received: by 2002:a17:902:f646:b0:168:e2da:8931 with SMTP id m6-20020a170902f64600b00168e2da8931mr53099064plg.84.1657211131064;
        Thu, 07 Jul 2022 09:25:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a13-20020a63e40d000000b0040d48cf046csm26139887pgi.55.2022.07.07.09.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 09:25:30 -0700 (PDT)
Message-ID: <d4e3d8b3-16c3-5fc4-c1c7-c2e346514aa6@gmail.com>
Date:   Thu, 7 Jul 2022 09:25:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 6/8] phy: brcm-sata: bcmbca: Replace ARCH_BCM_63XX
 with ARCH_BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, Vinod Koul <vkoul@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-6-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220707065800.261269-6-william.zhang@broadcom.com>
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
> PHY_BRCM_SATA depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

There is no cover letter for this 8 patch series :/ it is not clear to 
me whether each subsystem maintainer will be in a position to merge 
these patches individually, yet still have all 8 (7 of them actually, 
see comment to patch 1) land in 5.20.

Alternatively, we can merge these patches through the Broadcom ARM SoC 
pull request(s) to ensure they all land at the same time.
-- 
Florian
