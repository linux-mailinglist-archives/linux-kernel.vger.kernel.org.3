Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91EE4ED34D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiCaFhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiCaFhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:37:47 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C5141FDB;
        Wed, 30 Mar 2022 22:36:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v13so18951085qkv.3;
        Wed, 30 Mar 2022 22:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPPWluoolsefjRE29kw2XfxgYnR3VFZ9BqTChiHjaDc=;
        b=Qc99wNlwZdznBfvr+RyTN2xb5K7b+EfmJdYLLz4irFlDLYx3JNy655578XeIj02JZs
         +nZKu+V+fyE+W0EnRMzgQ1lOA/Yyk0B6J0K6+pk8DR3rPp085P5vH1Vxa9WSVcQHlRBb
         jBiVpBoTqfaxqx8l94qrav7PSh6xOf873uvPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPPWluoolsefjRE29kw2XfxgYnR3VFZ9BqTChiHjaDc=;
        b=D627FuTmfb+fK0+LqRQ/vdFRhQwPl4mLVMCMFYeayighv4Nb4l/HJwU1zQKAo/KMp7
         kNQfIglOnLVpJS50CAN0dKcHsjMrEhXsf5vCd/cc415qe46u8mduSdr4HcoaQ8R7uTUn
         zt/5q27gRlyHto9umb5wA9SOEcbJtRWi4NCdQ96wIWXMd2lwb7zyqEkgJy5orfW7kkaj
         W5RzaX3WPQrTgDkhW8qmQIc3HcZ5bwVE8sTAf9EVKj+Aazz0KKBvS0bz+c4H975gzuKp
         fxtXOB1xm01xEgD2E9GF66B1r+RBbpm+dQORr5BUxcZc8YLFMYq7e3gmDW5O0rJf0Mrp
         kIcg==
X-Gm-Message-State: AOAM531uY6r/4UGBkICjnjpC/lLQa0O0fk7X6ixzCViynF6mT/UOwVZy
        d3JXCSR22GqecZ18Sh+8o50gKPRpMPjDx3AfBkxkqkbrOxM=
X-Google-Smtp-Source: ABdhPJxdcuy7je91kJPvXlfP/N4hkpDESw7DhNQT7hK81qPH5jv0fXFjDzghjKL72FXJlvL9etWOZlS3TWif8D3+TXQ=
X-Received: by 2002:a05:620a:2ed:b0:680:a80e:c813 with SMTP id
 a13-20020a05620a02ed00b00680a80ec813mr2213059qko.243.1648704959078; Wed, 30
 Mar 2022 22:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220331022425.28606-1-zev@bewilderbeest.net> <20220331022425.28606-2-zev@bewilderbeest.net>
In-Reply-To: <20220331022425.28606-2-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 31 Mar 2022 05:35:47 +0000
Message-ID: <CACPK8XeeFDSN8L89BPkV+UfGTYNiULyUPBTYso7Z7e+VEdgc4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: romed8hm3: Fix GPIOB0 name
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 at 02:24, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This GPIO was mislabeled as DDR_MEM_TEMP in the schematic; after a
> correction from ASRock Rack its name now reflects its actual
> functionality (POST_COMPLETE_N).

Those are quite different functions :)

>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")
Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll send some fixes in after -rc1.

> ---
>  arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> index 572a43e57cac..ff4c07c69af1 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> @@ -198,7 +198,7 @@ &gpio {
>         gpio-line-names =
>                 /*  A */ "LOCATORLED_STATUS_N", "BMC_MAC2_INTB", "NMI_BTN_N", "BMC_NMI",
>                         "", "", "", "",
> -               /*  B */ "DDR_MEM_TEMP", "", "", "", "", "", "", "",
> +               /*  B */ "POST_COMPLETE_N", "", "", "", "", "", "", "",
>                 /*  C */ "", "", "", "", "PCIE_HP_SEL_N", "PCIE_SATA_SEL_N", "LOCATORBTN", "",
>                 /*  D */ "BMC_PSIN", "BMC_PSOUT", "BMC_RESETCON", "RESETCON",
>                         "", "", "", "PSU_FAN_FAIL_N",
> --
> 2.35.1
>
