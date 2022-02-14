Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316A44B4342
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbiBNIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:08:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBNIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:08:19 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB115F8E7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:08:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d187so27885493pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=56W7FW3d2YQP4s0rwZDFp5xphOL7Nyc7P1QxkUB2iqM=;
        b=y9XgUKB1iGK/QkLywtzU1ltCMoxyUeURdvdRqdC+54fM33esphESWPShK5Y6zb6eSY
         tn/cwGuMWZJFKiAM3yfVuL3yERpDUgpw2Rg5/EzuKT2GrkVikgwFETOhK2taBwzghcUJ
         iNXWN2zGDvTM1CV7k56WTm7pMJtuN0Re4i58/tcUYb7xFj4P3swqUounq06DAG6ttqGN
         QQsdxvtEyoptINBAa8/mFeEUkxQZeyMLP7733ktyHDgh4tVqPSFIjS/2pJOBQVQ/Bv5Q
         eiUkygVs0uJCiZm+YKm7A6ylBkkGt5CpLF5k3ke+JCg0W47yqgnVyJ9SfYmeoAm5XTDP
         GExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=56W7FW3d2YQP4s0rwZDFp5xphOL7Nyc7P1QxkUB2iqM=;
        b=SHhC87JslfLJJOm+QaW+6anggIJwgag4F9U18hIW1fwG4lpAaPMrke0tB02ZRDkk4f
         Z1HM2cK/vOURZesfuYNKuXk1ZtxbPyYUJbX2/1sqcjMp4Nat7eKL2uDbgPYiJlfEiPB5
         zPo0fjl7mHxJ2b9oMEMCKNDwgtAnVzrSHFl+aK4ygGKk7TIb2jFc3khJM85qC7iPC2NP
         s4AlfFi5Mh+2bUmMC5eAswUnJQgaW96+eYkCsXFft/KX6n9ZPztlvF8cBLSWSAtSlJMG
         s5ubaKPfXHf5p+PYWZwAskqNFp8Uofvfx4LATUG9srR7atDb00wapGFB6s7XL6pQlq+X
         xPoA==
X-Gm-Message-State: AOAM532XT6L1uc1zZCzC1EscUo8sJxLo6m0kqhySEciEWIUIW3VCR/Lw
        iD4fix+os450BwUJ+b8WkuJnTqPXwYkinbbLh8mL3w==
X-Google-Smtp-Source: ABdhPJy4Z+JLlYYMU4cCyJ5vx3/ZKTD9+2/JwTdyd1UIFlXHKEYvwCMUeMCAAcz2Zmpq0a6uBSE/Dpey0PKRNniOhRU=
X-Received: by 2002:aa7:85c3:: with SMTP id z3mr13104120pfn.70.1644826090449;
 Mon, 14 Feb 2022 00:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20220214010348.129251-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220214010348.129251-1-yang.lee@linux.alibaba.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 14 Feb 2022 09:07:59 +0100
Message-ID: <CAOtMz3OqPCF6ykBAaO-gYTkDpjcaRnq5pDietXYmY6_eASj95Q@mail.gmail.com>
Subject: Re: [PATCH -next] i2c: designware: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 14 lut 2022 o 02:03 Yang Li <yang.lee@linux.alibaba.com> napisa=C5=82=
(a):
>
> Eliminate the following coccicheck warning:
> ./drivers/i2c/busses/i2c-designware-amdpsp.c:248:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/i2c/busses/i2c-designware-amdpsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-amdpsp.c b/drivers/i2c/bus=
ses/i2c-designware-amdpsp.c
> index 752e0024db03..f589d3a1a19e 100644
> --- a/drivers/i2c/busses/i2c-designware-amdpsp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdpsp.c
> @@ -245,7 +245,7 @@ static int psp_acquire_i2c_bus(void)
>         if (psp_i2c_access_count) {
>                 psp_i2c_access_count++;
>                 goto cleanup;
> -       };
> +       }

Thanks. While fixing this, please do the same for the 'switch' in
check_i2c_req_sts() function above. Isn't your tool reporting this?

Best Regards,
Jan
