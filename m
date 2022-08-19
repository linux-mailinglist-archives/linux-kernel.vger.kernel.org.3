Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E7459A849
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbiHSWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbiHSWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:19:15 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12BAD9D71
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:19:08 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id c17-20020a4a8ed1000000b004452faec26dso1033422ool.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ElEwhFKGd2FC/9X2FVtgbgG3kjrjD6bdwf8mmYydFDQ=;
        b=ei67oZ0P6p8YavAJDaTjRKO5rKLHeUQRVFLbCmNEvBQeWqtwEn+tWq+Nx0jpTknXaC
         AvJFSxHNKV7ad/HzmVXiqB0kpkAEicrfpo4oZ+WQJP8/06vsqWPaVx2bnY/+64p6Q/s2
         4at/0nIxIVqxdyY5Sdp0qhkabU5uJU/OUW/FYAfcojWG+VKOWC/QF4PCn1p2jsnfFVYT
         dvgW7scRxdk+Nu5aj0SMR3o1CDl+BHuWm9m9E0jQ5iC2dSWeAf/uy7vfwDnw0NL1T/Eh
         Y3ozMaePyh8/dBtDXJjK3RiwOlftBgLNXQTnQzLE0+utnxiSOUfckRZK8lxBB5fdG0Td
         Zn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ElEwhFKGd2FC/9X2FVtgbgG3kjrjD6bdwf8mmYydFDQ=;
        b=ELGJaXsBNryedlfc77/NvVR/6SPC/tCEaL/pAk6I+sxzCJjpsucbZeAfW+ezt9lEjl
         Kwb9Cgq6bM5bytXKddIs7iOKPgwc4GPx43cZVJGz6ZZwlwZHJs5TLd2n49gBnF1Br6fQ
         ufsANEO/D3gu97y6+bz+NIMY/nKI0mh+rzvraAVwHC2Nph/TfbTF+2ERNKRiownxvQkK
         blfpn+6ZlXxMAjp795WA5kKOdlbk7p+zhKWhUBdUXuO0RyHD2JBPn3zx91i/LvhdYjML
         CDhjH7Uqtss63UY5K9JfjyLMxODDSXHUVED4HqSguolinmwvVZPVsMj5eM1IrSLbxoIh
         KfDA==
X-Gm-Message-State: ACgBeo1i8xVfCsTVG5HANaBuh4xB20YSo+q0dB36VGZSbZBdKDl/PSlZ
        FX8LNow5EpOwhywLwyQXEFGD1mgW2gT/BHRmXV4=
X-Google-Smtp-Source: AA6agR42zS3VCTYuNVOWVg7wg9gxGvN0NIfERQyV6z575IK8vwHqfaqShMPhyK6yRmjYqCOaf8OpdILmvmOAyXIUaYk=
X-Received: by 2002:a4a:4541:0:b0:435:cf9f:1a45 with SMTP id
 y62-20020a4a4541000000b00435cf9f1a45mr3226037ooa.17.1660947547579; Fri, 19
 Aug 2022 15:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220819210112.7924-1-rdunlap@infradead.org>
In-Reply-To: <20220819210112.7924-1-rdunlap@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Aug 2022 18:18:56 -0400
Message-ID: <CADnq5_MesHnxboGboMy+DUYtBb-EAeApHVsqwaHOVdL7rxYwWg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: export cpu_smallcore_map for modules
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        amd-gfx@lists.freedesktop.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linuxppc-dev@lists.ozlabs.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 6:18 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix build error when CONFIG_DRM_AMDGPU=3Dm:
>
> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko=
] undefined!
>
> by exporting 'cpu_smallcore_map' just as other per_cpu
> symbols are exported.
>
> drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
> This is an inline function on powerpc which references
> cpu_smallcore_map.
>
> Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm,=
 thread-groups"")
> Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same cor=
e")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  arch/powerpc/kernel/smp.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -86,6 +86,7 @@ DEFINE_PER_CPU(cpumask_var_t, cpu_core_m
>  static DEFINE_PER_CPU(cpumask_var_t, cpu_coregroup_map);
>
>  EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
> +EXPORT_PER_CPU_SYMBOL(cpu_smallcore_map);
>  EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
>  EXPORT_PER_CPU_SYMBOL(cpu_core_map);
>  EXPORT_SYMBOL_GPL(has_big_cores);
