Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDE34E4A80
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiCWBdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiCWBdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:33:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8137933E1C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:32:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so323783pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1tdwMzgNU3+9ty6xkH9fMGGweeCwRgg1Dr+d/9eH3Qc=;
        b=Gb0kqmLT129jUYWppYcf+O0ptJfQ1chsmf0FWqDF33rRzHXnu9VU00lf82mCBhvMOT
         xEjT2gr2VnGPjBV+knw3swrECBoiOXP+IaNN3IZCyRh3fJbtolZLh24hhLZODv+yUM2N
         GFIiTiqXmm3LkBcYok5oDYtJXWYgk85zciH63XgxqfYUs5VWqb539wKbEnisMMJ9+fHX
         0fpcq6O1OMroRA0Ug9+nYbNeuaQKWOsm5Ke7a379DYXWXP67n6eeVB/IwCE/MNv+nWaK
         XUQCZ/XpQoF/T20F+m22W61xy9jzoFz/4ky/GkBcnOn9Lcp1py6ktikn1QFU79g7Rza4
         I0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1tdwMzgNU3+9ty6xkH9fMGGweeCwRgg1Dr+d/9eH3Qc=;
        b=5Iud4obIyV5XrUK6XVT1YP30FkAPVC7oeSDLsbN9rkeTxqfIb/v3LW2EkvdaUE1d/Q
         3mpyNdCG/Vq9j2pFpvG33hU1xy0SK+tQN5qzRYOJ7+Ekn+f1Y1tYThJbsRw9u72RPz9a
         3u8uk4IkXZwtKuZmqAGijIuS6fjuEyLe4ecsXet1Lv5+t7nNGhivhhGJTpVMfQnJyJX4
         V1ZlXEVancxfiDSKDWWSsYKbbP8NZ4SkOHgIqObR1gnZ6gRX/Fi29wg7c1YGll/mtWcm
         KQTplcryW0BpPdHOMl3hsthOJRqPSVCW+zKFo4pMFyb73d6WxR8F2wDxJ9ARuZqixsPZ
         GeWw==
X-Gm-Message-State: AOAM532GfDXruS6TXZzUA1OngBxtnSV1LaMzLe5k3LLtZO/dmLI/VBQP
        cKCuS3+f0rxvOS9+YNUgd6n1zA==
X-Google-Smtp-Source: ABdhPJwy3tsZpMmtKAa8Z+PP3YAuWnFssj1dAbdwrL7GGL/i9W4P1ajH89rZtTfBAzTSrLgBPMJwkg==
X-Received: by 2002:a17:903:32c9:b0:154:3a2d:fa89 with SMTP id i9-20020a17090332c900b001543a2dfa89mr17771357plr.3.1647999142958;
        Tue, 22 Mar 2022 18:32:22 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm24433562pfu.120.2022.03.22.18.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 18:32:22 -0700 (PDT)
Date:   Tue, 22 Mar 2022 18:32:22 -0700 (PDT)
X-Google-Original-Date: Tue, 22 Mar 2022 18:32:18 PDT (-0700)
Subject:     Re: [RFC PATCH V2 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
In-Reply-To: <20220303145944.307321-1-sunilvl@ventanamicro.com>
CC:     ardb@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heinrich.schuchardt@canonical.com,
        Atish Patra <atishp@rivosinc.com>, apatel@ventanamicro.com,
        abner.chang@hpe.com, jrtc27@jrtc27.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        sunilvl@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunilvl@ventanamicro.com
Message-ID: <mhng-5eb23850-e2a9-43d3-8093-2f588c71de00@palmer-ri-x1c9>
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

On Thu, 03 Mar 2022 06:59:43 PST (-0800), sunilvl@ventanamicro.com wrote:
> This patch adds support for getting the boot hart ID using new
> RISCV_EFI_BOOT_PROTOCOL in linux efi stub. While there is an existing
> solution of passing the boot hart ID through Device Tree, it doesn't work
> for ACPI. Hence an EFI protocol protocol is recommended which works for
> both DT and ACPI based platforms.
>
> The latest draft spec of this new protocol is available at
> https://github.com/riscv-non-isa/riscv-uefi/releases/download/1.0-rc2/RISCV_UEFI_PROTOCOL-spec.pdf

This looks fine to me, but we need the spec folk to commit to this being 
a stable interface before we can start using it.  Historically that's 
been "frozen" for RISC-V specs, but I'm not sure how that all fits 
together in EFI land as IIUC we also have to follow the UEFI forum's 
process.  Last I checked you guys understood that better than I did, so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # pending spec freeze

I had a minor comment about the error message, as well.

Thanks!

> This linux ptach can be found in:
> riscv_boot_protocol_rfc_v2 branch at
> https://github.com/vlsunil/linux.git
>
> This is tested in qemu with u-boot 2022.04.rc3.
>
> Changes since V1:
>   - Rebased to get the "Fix get_boot_hartid_from_fdt() return value"
>     patch
>   - Removed mixed_mode member
>   - Separated return value and status.
>
> Sunil V L (1):
>   riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
>
>  drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
>  drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
>  include/linux/efi.h                       |  1 +
>  3 files changed, 32 insertions(+), 5 deletions(-)
