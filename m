Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3819D4D5540
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbiCJXXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbiCJXXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:23:32 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0D21BC;
        Thu, 10 Mar 2022 15:22:29 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so8662892ooh.8;
        Thu, 10 Mar 2022 15:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QxaQQz9lOMso9LFniZ3e9gms+zpAX5bMoBiGaq2NQ80=;
        b=PFElRQYGPOh3vw7twASS65kLbVEGmpv1hKe8jqdIFZb3iscFnSO9bsO0Xh82iiS4K0
         0HoiG8nBkgZ9nlEsFUr5AL/BDqjufpSaUmGv3NgNN2FEPGhvun14Wr2ozW42Im3b+NG3
         cBXOMLwT7hyG/kAOXKnu3E+JYuZDS6SZLev7xA9jSwWnOmnunJ9FIrHSmQbYjQqZJlry
         wX4JD1fDbywcBDcLBrCujIIysB2eVCj0RnWYuj2a4BKIAGtgpFPCzg5pZA3/k6MvssiX
         3fkM6P3L+jIteRoWdrjw/oH4ziZC/+9uCz4hlgiQ4ueMN5KFUntxupm+riMqckqxhFGU
         zakA==
X-Gm-Message-State: AOAM531RLMwsKDgJ92LlNVNXfJLUUPkp9Vdcs4PSphLou37YDFD4arUk
        Pc3AJjJfeqOLxcuTxKoHVA==
X-Google-Smtp-Source: ABdhPJwFNsTJVQACKTaShwctSIDZiz2m99HjBzfGEBRTiXcYlYBa4o1rP9aU6sHuo0rtftWCEpnoWw==
X-Received: by 2002:a05:6870:a2c6:b0:da:b3f:2b2a with SMTP id w6-20020a056870a2c600b000da0b3f2b2amr9626676oak.201.1646954549150;
        Thu, 10 Mar 2022 15:22:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n6-20020a9d6f06000000b005b266e43c92sm2567768otq.73.2022.03.10.15.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:22:28 -0800 (PST)
Received: (nullmailer pid 2287090 invoked by uid 1000);
        Thu, 10 Mar 2022 23:22:27 -0000
Date:   Thu, 10 Mar 2022 17:22:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     trix@redhat.com
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, tmaimon77@gmail.com,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        avifishman70@gmail.com, venture@google.com,
        benjaminfair@google.com, linux-stm32@st-md-mailman.stormreply.com,
        yuenn@google.com, tali.perry1@gmail.com,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        paulburton@kernel.org, linux-arm-kernel@lists.infradead.org,
        krzk+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: clk: cleanup comments
Message-ID: <YiqIMxCBFY8Aq5p4@robh.at.kernel.org>
References: <20220309222302.1114561-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309222302.1114561-1-trix@redhat.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2022 14:23:02 -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> For spdx, first line /* */ for *.h, change tab to space
> 
> Replacements
> devider to divider
> Comunications to Communications
> periphrals to peripherals
> supportted to supported
> wich to which
> Documentatoin to Documentation
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  include/dt-bindings/clock/alphascale,asm9260.h    | 2 +-
>  include/dt-bindings/clock/axis,artpec6-clkctrl.h  | 2 +-
>  include/dt-bindings/clock/boston-clock.h          | 3 +--
>  include/dt-bindings/clock/marvell,mmp2.h          | 4 ++--
>  include/dt-bindings/clock/marvell,pxa168.h        | 4 ++--
>  include/dt-bindings/clock/marvell,pxa910.h        | 4 ++--
>  include/dt-bindings/clock/nuvoton,npcm7xx-clock.h | 2 +-
>  include/dt-bindings/clock/stm32fx-clock.h         | 4 ++--
>  include/dt-bindings/clock/stratix10-clock.h       | 2 +-
>  9 files changed, 13 insertions(+), 14 deletions(-)
> 

Applied, thanks!
