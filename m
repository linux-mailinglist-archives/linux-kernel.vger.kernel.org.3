Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD124EE4FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbiDAAHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243188AbiDAAHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:07:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDB0DB49E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:05:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j8so1006957pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=p1Kk4asKnMlrLdFRP7KKaRA1SmfSqVpzna8bIJo/9fM=;
        b=Fo+F2q273Jom1d6+49Kn4y8sS3JIWP9Hm5KfaGS7UuL7ZN/g1Qc65G1IUtU+Txwf3t
         NpieS75qeiyyqlsPakJVqEqZrH89XLxR3qd1c1Y5WDMAbmFNR6W6Fy9HGIJo62QbdoKC
         hJFWcH09JN4eisXcydwjq+0r9v2qwE9hNm7ONJIgQZYak8OJhNvsYeHj6Gey41Nqb8+C
         xdmR2Ag69ccHTmG3MpBKMewdek8eWwewZnpEJNMv6SsjQg1CY8B5FCc4iQzz19t6u7et
         btanDcsTBRfl/tQFniC6gpNnfUEIbGZFNd4n55V5agn4e0QFPklp56aqROGoZLBrCsa4
         njZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=p1Kk4asKnMlrLdFRP7KKaRA1SmfSqVpzna8bIJo/9fM=;
        b=uHLfyKu6zmMRqBbw6sZCujL5yr05go2wdVVRZU4IxdxC3OxfeyfcWKcxYDgjTFlZQ/
         oX3EKVm3g5PQzOZBI6lbS5kwtIFRp+IFSRfFooPh671rcYLaW2yjzXv2P5UZXHrj6lJg
         l3n4EDHTXzbeNVutu4GN+iHwkKQYrzAVc0SNbYe9An5zmaejKxq7IyBxx4HlL9AF1BKK
         d/WcdwJSiifjPbdiWeV0AmIh9amUN89hz+XMjf9lw1Ul1JBJE1it+wIzFDcGpddg2JFg
         3JMguW0RGA2cVPv3DUb2V2Mgr7FwEJpeg/M+Dmf9bjY49YG0mGl3AFjJL86z6E1/3S4N
         /Vmw==
X-Gm-Message-State: AOAM532njQdGMUo3dT5F3iAFxBLq97U9HDZ3T/kQnY7mDMp2FbbwXzBR
        OmsTFJsV/r+zMxQMTTH5EjJZNA==
X-Google-Smtp-Source: ABdhPJxe1BJPhMA/qe+O/I1I6VTtI0vPk9DRXRO2Bb5f18M5jyRjbCnZzywP9UowAOFfgdvjVyYn/w==
X-Received: by 2002:a17:902:d3c5:b0:154:a3b5:d918 with SMTP id w5-20020a170902d3c500b00154a3b5d918mr7696913plb.91.1648771519308;
        Thu, 31 Mar 2022 17:05:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 123-20020a620681000000b004fa7c20d732sm593121pfg.133.2022.03.31.17.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 17:05:18 -0700 (PDT)
Date:   Thu, 31 Mar 2022 17:05:18 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 16:19:20 PDT (-0700)
Subject:     Re: [PATCH] Documentation: riscv: remove non-existent document from table of contents
In-Reply-To: <20220329084428.376003-1-bagasdotme@gmail.com>
CC:     linux-doc@vger.kernel.org, bagasdotme@gmail.com,
        Paul Walmsley <paul@pwsan.com>,
        Atish Patra <atishp@rivosinc.com>, atishp@atishpatra.org,
        Atish Patra <atishp@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bagasdotme@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org
Message-ID: <mhng-cda2a9b2-2e3a-41a8-8df9-ee3d05d47a1a@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 01:44:28 PDT (-0700), bagasdotme@gmail.com wrote:
> Remove reference to non-existent pmu.rst from table of contents tree
> in Documentation/riscv/index.rst.
>
> Fixes: 23b1f18326ec ("Documentation: riscv: Remove the old
> documentation")
> Link: https://lore.kernel.org/linux-next/20220329133412.591d6882@canb.auug.org.au/
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Atish Patra <atishp@rivosinc.com>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
> Cc: linux-riscv@lists.infradead.org
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/riscv/index.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
> index ea915c1960488a..e23b876ad6ebb6 100644
> --- a/Documentation/riscv/index.rst
> +++ b/Documentation/riscv/index.rst
> @@ -7,7 +7,6 @@ RISC-V architecture
>
>      boot-image-header
>      vm-layout
> -    pmu
>      patch-acceptance
>
>      features
>
> base-commit: 1930a6e739c4b4a654a69164dbe39e554d228915

Adding the doc folks.

I'm going to go ahead and just take this via the RISC-V tree, as I just 
broke things.  I'd usually wait for longer for an ack/review, but IMO 
it's saner to just get this into rc1 so builds don't break.  My version 
[1] was sent at the same time and was CC'd to the right place, but I'm 
going to take this one instead.

[1]: https://lore.kernel.org/lkml/20220329164544.29367-1-palmer@rivosinc.com/

Thanks!
