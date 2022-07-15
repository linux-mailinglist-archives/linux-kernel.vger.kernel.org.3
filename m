Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E236F5769E5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiGOW3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiGOW3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:29:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A65E13DFF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:29:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l12so4310447plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w3QF+mqIdIdR+R36va/733YMOXOaPdDML9FH6gUUqFA=;
        b=G5cuCJ891R57WGUJ1irdVBPjDVWdPoZX6NNK/l8lnWzjf8CeoC82pP621ZbLrLTyyi
         XopjQnSAGM3EOIRGcNnaBzIVCyRJnf1qvOoJz9pXB0fqu7/3cecY6JowaBFdB+w8VSxz
         RnqFa2Y6Lap7qmVsR0cZEfrp6J+j9oSiVJGUsvpBYrMq2q9edCBtVYXDPSBNX60AaO4l
         sbUgwCp/m+au6prWl6SbC3oHNNgwcZrmHRy5ILgQ+ecDI6P5xYZkKpUzth1Wb/6hHF8Q
         Kut5HGtVWlHkfZtpciNhhvT+uCtclj3d4Xq7mzBuoBb7KXJpJVfoFHZuPIyOYAQAlNEe
         8New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w3QF+mqIdIdR+R36va/733YMOXOaPdDML9FH6gUUqFA=;
        b=VcS50GiNPl4n4zMui6MXipIEehWoULcZiLZjjeP6MtfI4sZ3s4r3jQ8+hN++cmo8no
         xrDV54psyNevJ80qKgl4uGf6/hndVjEtgqhHyZGIO7MhF5y7ZekukbfUux/5OfPtuJEL
         ogPBiAHtz4odMJEtY37nn39zUXqFBvPA6TZMSdVpF5VPsLw7ojaRAnUzMMH1xCSsnjSB
         n8K1WsuabEJKztvHeaY+bXFw1YI6/k8V3MYFrbsAcxdB0vqkTej2Bsmhv11bTd062drl
         INPg+2wG0v34V18lisZfDaavmXNc8HCGtDCJ4L1JeKtFPvjeoP/wt6UoLeiOwHvEpJWn
         LbWQ==
X-Gm-Message-State: AJIora/B4E2aAKrvz2bhW6ifk08zgymxtcLpZSIyEG0/M/WUSK1SE8Iy
        RZzhlitTBglQ1kukUIjN5pw=
X-Google-Smtp-Source: AGRyM1spubbZtDmGfMgnReOERvHEBbD48Tf4BG2WcXzh3lbNLBJRwybZ1rqluyjvu4QvfKPvSAy1Cg==
X-Received: by 2002:a17:903:230c:b0:16c:4c65:18be with SMTP id d12-20020a170903230c00b0016c4c6518bemr15526720plh.138.1657924157671;
        Fri, 15 Jul 2022 15:29:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s1-20020a655841000000b003db7de758besm3714787pgr.5.2022.07.15.15.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 15:29:17 -0700 (PDT)
Message-ID: <1a96de8c-4dc9-7f94-9e14-a223aec56428@gmail.com>
Date:   Fri, 15 Jul 2022 15:29:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: bcm: NSP: Removed forced thermal selection
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>
References: <20220711222919.4048833-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220711222919.4048833-1-f.fainelli@gmail.com>
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

On 7/11/22 15:29, Florian Fainelli wrote:
> Both THERMAL and THERMA_OF are user-selectable and we should not force
> the selection of those Kconfig entries.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
-- 
Florian
