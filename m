Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8CD57D8F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiGVD10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGVD1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEB19368C;
        Thu, 21 Jul 2022 20:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 767FB6204C;
        Fri, 22 Jul 2022 03:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D125DC341CB;
        Fri, 22 Jul 2022 03:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658460438;
        bh=0kud9t0bSGX6LH3lAFGBiZxJakXfvMCPDfHsTrwsWls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PlI8iwv/cYYK2/q9cX5I/2XLYk4OAB1eExDxVvVvPckKB1mDZK7RjhIunySGBPUPp
         qVKDPDTPVbh9zNn42de+IodVElf6hvytBSpNkT1Q/L0WMD1qoNCHWBP4BiQMBOYF/K
         SQGQZNNpjbc9NRoPyyKdy60kuPJtN4pxF2EWvpE+Sm6wxaTn2Q9Tmz5JP060Ck4i2H
         vPMstTrnqvl/1JHBCnXGdVAk/YQ8xVKOSre7jPjdd5mUKj/0A7GRX9wjAeVMykmbbS
         07s4fJ8Q9QEMyyWUBZUTQJ3KE9XQjCipszR+lkK0p4Zyz6CGXIkb/3IYR59AE7Yyt2
         MdCfI07oswkHQ==
Received: by mail-lj1-f170.google.com with SMTP id r14so4033498ljp.2;
        Thu, 21 Jul 2022 20:27:18 -0700 (PDT)
X-Gm-Message-State: AJIora8go/sowIo1Ai8ZnEFNkp9kbWh0YsIZ6omyabFAR2iUwFodLmzm
        7GEsV5dQ6+cUqJ9e8K6rP+TKTC7bNkEVlucQRQs=
X-Google-Smtp-Source: AGRyM1sPvmZAdYE8RJApTJ2iZR4eU/PciiRzo0oOh4jbwHo6incGUu3B3Xyw70xlIQwX2mlUQRTN8zPQkxfKDQIWM2o=
X-Received: by 2002:a05:651c:897:b0:25d:e574:b64 with SMTP id
 d23-20020a05651c089700b0025de5740b64mr462817ljq.203.1658460436858; Thu, 21
 Jul 2022 20:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220721134924.596152-1-shorne@gmail.com> <20220721134924.596152-4-shorne@gmail.com>
In-Reply-To: <20220721134924.596152-4-shorne@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 Jul 2022 11:27:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT1iWj-xoZYAYwawQkjTZkJfVL+tGb68gu0iB_ZP2XTAA@mail.gmail.com>
Message-ID: <CAJF2gTT1iWj-xoZYAYwawQkjTZkJfVL+tGb68gu0iB_ZP2XTAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] csky: PCI: Define ARCH_GENERIC_PCI_MMAP_RESOURCE
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Thu, Jul 21, 2022 at 9:50 PM Stafford Horne <shorne@gmail.com> wrote:
>
> This looks to be something that was left out on accident on the csky
> port.  Add the definition of ARCH_GENERIC_PCI_MMAP_RESOURCE to keep it
> inline with other ports.  Adding ARCH_GENERIC_PCI_MMAP_RESOURCE enables
> the definition of mordern pci_mmap_resource_range functions which is
> generally what new ports should be using.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Since v4:
>  - New patch.
>
>  arch/csky/include/asm/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
> index 5c02454ec724..875bc028f8f6 100644
> --- a/arch/csky/include/asm/pci.h
> +++ b/arch/csky/include/asm/pci.h
> @@ -15,6 +15,8 @@
>  /* C-SKY shim does not initialize PCI bus */
>  #define pcibios_assign_all_busses() 1
>
> +#define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
> +
>  #ifdef CONFIG_PCI
>  static inline int pci_proc_domain(struct pci_bus *bus)
>  {
> --
> 2.36.1
>


-- 
Best Regards
 Guo Ren
