Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901DA4952C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377183AbiATQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377136AbiATQ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:58:24 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD439C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:58:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so5732256pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IlE4PKTqOpwGLmeHcvM3V2OxUD4byfa5I1kusdpu4LM=;
        b=BoOlO916FeueTACmIVZG6Di6cPnwL0MibCyttpptZBXLlTNcE/yoZ13RFqGVg6HZir
         awMcBlC9bJCCRwuRDsKkkqxpiNxUfmm6a4Px9DYt+aURU+4IQ6rhBvKWPsTnemgONUKC
         fUs1oHDRk5dl73ycxB9NtWBLN05sHvUPIRMLy40L2hDj2qXwIyrvJ1sIQ4Ay4S2L2cEE
         RdecNvZycqTmGJuAR//yjleMUGGnZSGkBu5dw/j+zzFgBlWdV7vFJh7WDYX5DU8zfpu7
         nCr+tjJKOf5xppKqyKLv/sA1f5stBkdvz3tyhi0Vztl2ijC0/1W2C99zIxL0f12RsniN
         FwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IlE4PKTqOpwGLmeHcvM3V2OxUD4byfa5I1kusdpu4LM=;
        b=PUs5JkChQ9vDT1z+IsT2W15KS923cwTX9mM+3Vgw0v2cdmeIofMBlyzdUFepDZntSU
         byys/mE/ZrBzbeLp0DN44J7ca5FKAb7jV6QVuqPLlCl3GC17ef7HqKmYfyMslzurnRXI
         6eCIz8M25IYxm6nRUE9NUHt+yMVP/njG2E1L1XYSlkOSX/IDajMFjJRN4yKKEDyjueQE
         60yRBn1JT4s3kglXE3f7QBkRNdO7m13nRRtVg0709CYljpbxJTizW/Q4NfyZEqsoE29I
         tmsf4u+kRkgxGTACPE2grpMYtlfFziQCGMA5u15dJuqGPuPmAXsiQJ2+Q6onwnMEYiiP
         ezzQ==
X-Gm-Message-State: AOAM531Qkn3kmAthcsJOdfctHfeJQqTNGb5mAMCzuCf516YWeKFm5M9l
        0ZEPGgFPuoXaa22sVp+G2hiXiA==
X-Google-Smtp-Source: ABdhPJz/GMEZDHsqoWmkmlnFC/P5fgMAtM7xYdj0RtuinLJoarckNRDraf406XfaKisylPQa7RDlqg==
X-Received: by 2002:a17:90b:3b83:: with SMTP id pc3mr11739741pjb.217.1642697904051;
        Thu, 20 Jan 2022 08:58:24 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l2sm4209809pfc.183.2022.01.20.08.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 08:58:23 -0800 (PST)
Date:   Thu, 20 Jan 2022 08:58:23 -0800 (PST)
X-Google-Original-Date: Thu, 20 Jan 2022 08:57:56 PST (-0800)
Subject:     Re: [PATCH 1/1] riscv: default to CONFIG_RISCV_SBI_V01=n
In-Reply-To: <20211216123538.175087-1-heinrich.schuchardt@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        heinrich.schuchardt@canonical.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heinrich.schuchardt@canonical.com
Message-ID: <mhng-ca6db968-3278-4108-b8f5-4435eb40def5@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 04:35:38 PST (-0800), heinrich.schuchardt@canonical.com wrote:
> The SBI 0.1 specification is obsolete. The current version is 0.3.
> Hence we should not rely by default on SBI 0.1 being implemented.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 09abf62ae0ad..f177ad3bee0f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -396,7 +396,6 @@ source "kernel/Kconfig.hz"
>
>  config RISCV_SBI_V01
>  	bool "SBI v0.1 support"
> -	default y
>  	depends on RISCV_SBI
>  	help
>  	  This config allows kernel to use SBI v0.1 APIs. This will be

Thanks, this is on for-next.
