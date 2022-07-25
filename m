Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864825806CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiGYVbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiGYVbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:31:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7124974
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:29:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q16so11485125pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hjH/x15kF4vievgUYxvBLMSjt7KRqmoWwdq7tek7XBI=;
        b=YYelzTNHADuDdMqEj6hXPvqeLqog9iZchp4/aKMc+rsdN+Yrf70fJsu4CiUKIyWg9P
         NesFwROVwrRmyUi+fW1m7HsG7z7UOiq+mjgFZfUTtAkE9j7DJfmKZ5RT20RJJlgK9lEG
         GEob/BbOSxdL9t00UmE2BXB7qLim3eixq3dV6QaaKgYxPzPw3pPjdCy0Pz8aJL1Rxs6P
         2WOi+ukByWxZlnJUY4SGPwXt2z91oPxmRWLLv4M290azGbZfUdE9o0+FyeR/eSYmXDtY
         GHbuvJBKWqBtFTFxO6AMF5mB1fbXf5H/ECrqI0XpdStwIA5dZLPg/X023iPP14iLLcqs
         H4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hjH/x15kF4vievgUYxvBLMSjt7KRqmoWwdq7tek7XBI=;
        b=7J/MCiZH0kiGFKTFTjOEdLg42at4HEbvS207Cwoi/4a6dbE+s6b5n9dB7o0k/sytnq
         hx4DaVW9XWMSE2Mva0SgYgo1gQEXJ5bM10O0HLIKiwIHOXFewuh2uZjpxY6hHhY2CtoZ
         2hKIzw7Rjs+aCmwhG21cilh+7oA3Ik01yKu5nUZbi0rFdsXAETS2uMBj+KEGjYDqEgmp
         OC0Km4IHIT/DijisZvfz7S60aRAfWFfvWSqc1EIQPoNm/b7dkAKABVEm7rDBlP3zR1e7
         MhPmcWdBochnx471yM/DPfWWqiyplM/M0hbfs+KvWtyv/StshSY64gp20NQlqDNaUfIo
         BsJQ==
X-Gm-Message-State: AJIora80bUSbPqII0jbsPasykGjmTva+eypIegM5EzcaUdvxfE2lCqnt
        h3awiw2MeboekDJHpe4L6xM=
X-Google-Smtp-Source: AGRyM1t9wJSixY9rq6ip84lBJ8+/PcZ4uPRWlDd4fHc2aEynQWeHyDwhD6AIRiUqwxRslvGMjQzxOQ==
X-Received: by 2002:a63:4e24:0:b0:41a:4117:5fee with SMTP id c36-20020a634e24000000b0041a41175feemr12658004pgb.414.1658784551276;
        Mon, 25 Jul 2022 14:29:11 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id z15-20020aa79f8f000000b0052c02d8c65asm1440806pfr.123.2022.07.25.14.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:29:10 -0700 (PDT)
Date:   Tue, 26 Jul 2022 06:29:08 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH -next] x86/cyrix: include header linux/isa-dma.h
Message-ID: <Yt8LJMR8WBSZ+4pd@antec>
References: <20220725202224.29269-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725202224.29269-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 01:22:24PM -0700, Randy Dunlap wrote:
> x86/kernel/cpu/cyrix.c now needs to include <linux/isa-dma.h>
> since the 'isa_dma_bridge_buggy' variable was moved to it.
> 
> Fixes this build error:
> 
> ../arch/x86/kernel/cpu/cyrix.c: In function ‘init_cyrix’:
> ../arch/x86/kernel/cpu/cyrix.c:277:17: error: ‘isa_dma_bridge_buggy’ undeclared (first use in this function)
>   277 |                 isa_dma_bridge_buggy = 2;
> 
> Fixes: abb4970ac335 ("PCI: Move isa_dma_bridge_buggy out of asm/dma.h")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/x86/kernel/cpu/cyrix.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/x86/kernel/cpu/cyrix.c
> +++ b/arch/x86/kernel/cpu/cyrix.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/isa-dma.h>
>  #include <linux/pci.h>
>  #include <asm/dma.h>
>  #include <linux/io.h>

Sorry, I missed this, I did test several x86 configs, but I guess the cyrix.c
compilation was not picked up in my tests.

FWIW, I think this should go through Bjorn's pci tree.

-Stafford
