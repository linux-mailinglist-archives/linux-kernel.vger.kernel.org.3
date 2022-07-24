Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F8557F346
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 06:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiGXEtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 00:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGXEtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 00:49:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2438B165BC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 21:49:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gn24so7562740pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 21:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MGeOSS7IwsrulAO7mISG9adf/2TuM6Nm2MfykxxtGL4=;
        b=nG4q9DMqu8FyzmwuubvC3drX/BWKgcBdHRf7acV94r4MXUEIjqsn4sDZmlthMnJgsW
         FmuMmDTUp1BSvVThVdT98YsQ6SV5rveZSbUqVYmi/Yv3wVAO8mKcOw3DhHWlj8ovmNhp
         vzmRrp1xZziEA/x4X8FLaC1SVDf7742BLJ/eE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MGeOSS7IwsrulAO7mISG9adf/2TuM6Nm2MfykxxtGL4=;
        b=JnflnIGl/IR4Imtpr69jEjq/2ooqAMYv0mmkC1HDBrL5P5fsaQc/XovClfJY5MR5Q5
         N9r5AEKCPKyiUFleT0zQAxKStHt7ruEcDZ/dzcQCkdUJfytCQzDOvNejzvIBHz+ZCVUM
         IlkY5ZnPDEB3D8M+prdyXyqipmBD++B43bfgGtC4coUqAMmGBPwso1fPQm8mH6qFFoX7
         2vvIAem6yjebMxCOB9yKEIgSmPZOcGPE65As8FUbHJg8WNaw1U/sPsq7yHlPV1XFG6V9
         5YaBR9JeJQM5Ew/JJhtuiKUX+AtEejFLvZ5Cy/tpp1YXkuDfT4NvlQFv6cP/QSzig2wT
         UkVQ==
X-Gm-Message-State: AJIora91YnQ3fhoZrVzhzqurjOpM66M0iuQsSnLkNc0sh65XPN9VZ3kd
        HCVERzRBsZ8ZPqmHvRnn1ep0cg==
X-Google-Smtp-Source: AGRyM1ufn/RToD4DIsXUfLSVL+hoRb/uCvpZEL0lJEAg7RsH4iG7cA6EohiG/e42jbYDw2dvgWnwUg==
X-Received: by 2002:a17:90b:4d8c:b0:1f2:396d:c3b7 with SMTP id oj12-20020a17090b4d8c00b001f2396dc3b7mr15960217pjb.175.1658638183225;
        Sat, 23 Jul 2022 21:49:43 -0700 (PDT)
Received: from 25d43a3e58cb ([203.220.223.63])
        by smtp.gmail.com with ESMTPSA id g26-20020aa79f1a000000b005256c9c3957sm6793426pfr.108.2022.07.23.21.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 21:49:42 -0700 (PDT)
Date:   Sun, 24 Jul 2022 04:49:35 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.10 000/148] 5.10.133-rc1 review
Message-ID: <20220724044935.GA1706719@25d43a3e58cb>
References: <20220723095224.302504400@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723095224.302504400@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 11:53:32AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.133 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 25 Jul 2022 09:50:18 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.10.133-rc1 tested.

Run tested on:
- Intel Skylake x86_64 (nuc6 i5-6260U)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro

Logs from: Intel Skylake x86_64 (nuc6 i5-6260U) 
nuc6:~ # dmesg
[    0.000000] microcode: microcode updated early to revision 0xe2, date = 2020-07-14
[    0.000000] Linux version 5.10.133-rc1 (docker@0dae7cb4c0f4) (x86_64-libreelec-linux-gnu-gcc-10.2.0 (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 SMP Sat Jul 23 11:54:48 UTC 2022
[    0.000000] DMI:  /NUC6i5SYB, BIOS SYSKLi35.86A.0073.2020.0909.1625 09/09/2020
...
[    0.243172] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.243178] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.243181] Spectre V2 : Mitigation: IBRS
[    0.243182] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.243183] RETBleed: Mitigation: IBRS
[    0.243186] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.243188] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.243196] MDS: Mitigation: Clear CPU buffers
[    0.243197] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.243201] SRBDS: Mitigation: Microcode
...
[    0.313120] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.313120] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.

nuc6:~ # lscpu | grep -e Vulnerability -e "Model name"
Model name:                      Intel(R) Core(TM) i5-6260U CPU @ 1.80GHz
Vulnerability Itlb multihit:     Processor vulnerable
Vulnerability L1tf:              Mitigation; PTE Inversion
Vulnerability Mds:               Mitigation; Clear CPU buffers; SMT vulnerable
Vulnerability Meltdown:          Mitigation; PTI
Vulnerability Mmio stale data:   Mitigation; Clear CPU buffers; SMT vulnerable
Vulnerability Retbleed:          Mitigation; IBRS
Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass disabled via prctl and seccomp
Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and __user pointer sanitization
Vulnerability Spectre v2:        Mitigation; IBRS, IBPB conditional, RSB filling
Vulnerability Srbds:             Mitigation; Microcode
Vulnerability Tsx async abort:   Not affected

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
