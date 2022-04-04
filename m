Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555DB4F1EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357788AbiDDWLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384643AbiDDVgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:36:16 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AC331220;
        Mon,  4 Apr 2022 14:26:42 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id q129so11429860oif.4;
        Mon, 04 Apr 2022 14:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAP1OWdT/qDUoPVv9G7nl7G1PXDxStBen+UYZx6kZGo=;
        b=iSW2wiO9Qn9cCOceFIYj+ng9O7b+rTvJ7wTz2DN1xXNm23xTzmS87qpR1msg6cNU3N
         lFRn9bLEKtjwD/GxhfEjPbkbxilXHftcUFmTdvNnUHFOjfs8FV7AJKId03DhSfntHMXO
         3nWCR0IbM421ld/IenO3AnoEuHhyltwHlvjWo3IgJA+I804co+hxVoVbycCc6YCyvpbK
         JdOtRYD4zh2UeoZLrAtYGoh92vv3k2uf6JeYS4YX/hgmygnxiqFULXKlddqpqwgE4ulE
         hhNL0HmAQy1DLVEEm/tWXcPTER9icIkg/ysZuAwKd06Ce7T2czNtsW9AI3+uVmNohMTF
         kbSw==
X-Gm-Message-State: AOAM533r5O8HrrbovJEiMJS+WEEYtvHGpp5osJ+k/A/Z1YxSe/QhWHCv
        QcAG52uYuuJcPiskwUqWXA==
X-Google-Smtp-Source: ABdhPJxW2wscvKlm8gcJbXbRc0IWjFTIyDNUVIdjjAxIIjjxENxn2/s77BAwtbGe6+K90UrYW/lvlw==
X-Received: by 2002:a05:6808:1a9b:b0:2ec:9c38:185 with SMTP id bm27-20020a0568081a9b00b002ec9c380185mr105502oib.165.1649107562121;
        Mon, 04 Apr 2022 14:26:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n66-20020acabd45000000b002ef6c6992e8sm4569111oif.42.2022.04.04.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:26:01 -0700 (PDT)
Received: (nullmailer pid 2010240 invoked by uid 1000);
        Mon, 04 Apr 2022 21:26:00 -0000
Date:   Mon, 4 Apr 2022 16:26:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/85xx: Remove FSL_85XX_CACHE_SRAM
Message-ID: <YktiaO4n62O7BqXZ@robh.at.kernel.org>
References: <9949813a6b758903b7bee910f798ba2ca82ff8ee.1648720908.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9949813a6b758903b7bee910f798ba2ca82ff8ee.1648720908.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 12:03:06 +0200, Christophe Leroy wrote:
> CONFIG_FSL_85XX_CACHE_SRAM is an option that is not
> user selectable and which is not selected by any driver
> nor any defconfig.
> 
> Remove it and all associated code.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  .../bindings/powerpc/fsl/cache_sram.txt       |  20 --
>  .../powerpc/include/asm/fsl_85xx_cache_sram.h |  35 ---
>  arch/powerpc/platforms/85xx/Kconfig           |   9 -
>  arch/powerpc/sysdev/Makefile                  |   1 -
>  arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h     |  88 -------
>  arch/powerpc/sysdev/fsl_85xx_cache_sram.c     | 147 ------------
>  arch/powerpc/sysdev/fsl_85xx_l2ctlr.c         | 216 ------------------
>  7 files changed, 516 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cache_sram.txt
>  delete mode 100644 arch/powerpc/include/asm/fsl_85xx_cache_sram.h
>  delete mode 100644 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
>  delete mode 100644 arch/powerpc/sysdev/fsl_85xx_cache_sram.c
>  delete mode 100644 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> 

Acked-by: Rob Herring <robh@kernel.org>
