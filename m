Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFF487EB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiAGV6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiAGV6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:58:13 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBFCC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:58:12 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l15so5897441pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YwXvl9LyxPLT5KXmkZnhb1YhT1RhoPjqa4mfsaDtNLk=;
        b=vCOx5mxoPf5yDaezl0FLUSox3TvjNiTFVaS3YESthdUcIUX2XkP1LEQJz3KCfNEu4/
         dr5dFPmSJwo6+a60TPNeMwGKmfG7+V/ijQpoV2zFmRm0wjKZZQeE1wzBcPTixDmEUqxK
         M3ypkkcyHDB1SjRF+HkryUIKAQgySodaHoKr9XKCrzpAhx541sqP5yAtg/aMBhjtZnXV
         xG5GcMJEBdig7xMx6p8UF2xXquE5hd0GemBXAylcSEmp8+UsAeVGCmK2HRmUEHMa1UnB
         QBxfIj9gqYF22D5wyzqcSBBOQ3MZ/yxtk6O7W3G2Q4NsA1GN9MduSokiAeTfowGE15Pf
         SXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YwXvl9LyxPLT5KXmkZnhb1YhT1RhoPjqa4mfsaDtNLk=;
        b=XutBHN/Edq8tlhj5DBiH4DwBwiOCiFKskX+OD/W0/jMWt0LwQM9UFL1KW25ULI5XdA
         FsKScBoTpq9qkm6yR3jwDK/Bc026GySvRvUZx3WNUvypwrI6P1rWP5nFi/YcMqEGpr1Y
         5IX2uhsv9BBStFLuCa5EQeo7y5QFuabqLr+XD5cC/ITkj+0bc0V5vHm3QEMm/DfzyR5k
         uY910qEoNvwjj0VS8eDstXqiYZf2XFLpooQU5Wj2uA+EEh1Qp7CG45lqG0dHVszy+Hgb
         jgTU07juaouhyKJdghoGsC9/Y7qntyh/kTn+fpFSaVJZwm50PU79vTsF854tR2GPGQGT
         Hbrg==
X-Gm-Message-State: AOAM531IyK9oeDXpEyc3JDDyQUH0q/IiD0UzuDMY09TMHNvGQlYOd9QS
        uSKdXcFpmhb2GbSCtnnh2TYk+LzNNmD8Nw==
X-Google-Smtp-Source: ABdhPJwjdYvL9KC4dQqmY1X2DJSMm1IhfC/WV0RmK9svOcjiOdVLZeVIvOciLmiFA1ZiydXONVBgwA==
X-Received: by 2002:a17:902:a589:b0:149:dc8c:76ad with SMTP id az9-20020a170902a58900b00149dc8c76admr13027341plb.94.1641592692055;
        Fri, 07 Jan 2022 13:58:12 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p32sm5500061pgb.49.2022.01.07.13.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:58:11 -0800 (PST)
Date:   Fri, 07 Jan 2022 13:58:11 -0800 (PST)
X-Google-Original-Date: Fri, 07 Jan 2022 13:57:44 PST (-0800)
Subject:     Re: [PATCH v1 0/2] Provide a fraemework for RISC-V ISA extensions 
In-Reply-To: <20211224211632.1698523-1-atishp@rivosinc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, anup@brainfault.org,
        damien.lemoal@wdc.com, devicetree@vger.kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-791652b4-53f0-48e4-a640-f4c418c9926b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 13:16:30 PST (-0800), atishp@atishpatra.org wrote:
> This series implements a generic framework to parse multi-letter ISA
> extensions. It introduces a new DT node that can be under /cpus or
> individual cpu depends on the platforms with homogeneous or heterogeneous
> harts. This version of the series only allows adds support for homogeneous
> harts as there are no platforms with heterogeneous harts yet. However,
> the DT binding allows both.
>
> The patch also indicates the user space about the available ISA extensions
> via /proc/cpuinfo.
>
> Here is the example output of /proc/cpuinfo:
> (with debug patches in Qemu and Linux kernel)
>
> / # cat /proc/cpuinfo
> processor	: 0
> hart		: 0
> isa		: rv64imafdcsu
> isa-ext		: sstc,sscofpmf
> mmu		: sv48

IMO this is the wrong way to go.  I get that the ISA string is very 
complicated to parse, but we've tried to come up with other 
representations of this we've ended up having that interface break when 
the ISA string rules eventually change.  We should just stick to the ISA 
string for these interfaces, as that's at least something everyone can 
agree on because they're defined by the spec.

That said, we should add the spec versions into this interface.  At 
least the user spec version is relevant here, but given that we're 
passing through some other priv-level details we might as well pass that 
though too.

> processor	: 1
> hart		: 1
> isa		: rv64imafdcsu
> isa-ext		: sstc,sscofpmf
> mmu		: sv48
>
> processor	: 2
> hart		: 2
> isa		: rv64imafdcsu
> isa-ext		: sstc,sscofpmf
> mmu		: sv48
>
> processor	: 3
> hart		: 3
> isa		: rv64imafdcsu
> isa-ext		: sstc,sscofpmf
> mmu		: sv48
>
> Anybody adding support for any new multi-letter extensions should add an
> entry to the riscv_isa_ext_id and the isa extension array.
> E.g. The patch[1] adds the support for sscofpmf extension.
>
> [1] https://github.com/atishp04/linux/commit/a23157264118d6fd905fd08d8717c7df03078bb1
>
> Atish Patra (2):
> RISC-V: Provide a framework for parsing multi-letter ISA extensions
> dt-bindings: riscv: Add DT binding for RISC-V ISA extensions
>
> .../devicetree/bindings/riscv/cpus.yaml       |  9 +++
> arch/riscv/include/asm/hwcap.h                | 31 ++++++++++
> arch/riscv/kernel/cpu.c                       | 16 +++++
> arch/riscv/kernel/cpufeature.c                | 58 ++++++++++++++++++-
> 4 files changed, 113 insertions(+), 1 deletion(-)
