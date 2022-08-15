Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1335927EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiHODAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHODAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:00:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019FA112A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:00:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u1so9014283lfq.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=lLH+4U/nmqJY+3ZRkJiCK+ww0mcXmU14+V5BSemiXN4=;
        b=XBt+rbP5bxlohZwGC6+Hfh7vpls4QE5X2e7Pp+EKs3u6h8Uq/+rQPEo9Heux22PegZ
         anZZDio8OCC1YNEYQZfDi9yheFgRDIQ3hWxUEqHGiLf+STtnvu7RAOinaqNACtkfHOrJ
         2Y4mGIOzq7MP9Fwg6dKtxbYcsr3qf5AUAdX+TwTcqcKdQ3lZXS1E+OFSQ9cqg7leFLeX
         iaK1SvD6Vu2eNXZp3tFDZLlHH5twbVQgEjM138OmmdLL7DF/kkFRU8L3i7Kt6hcqcIfl
         N9HvdqHHX1JriSpyc2guIN/8K2nXvL/MhwR8lvjZ7X/eMCb0jkLR6gSTC3fkRZ06Zpfj
         TpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=lLH+4U/nmqJY+3ZRkJiCK+ww0mcXmU14+V5BSemiXN4=;
        b=pGzNTzAqAPSNfaJ9DhtBKIh1EX50NimpSVXZxi5AM43WZKd6CR7B+g29bzjzkwAdKp
         Rju9c4aDDJdC2TIf9wabyQwc7n4Dmb1UYQQ4F3uJdrHsddLd3IuCarBGTyrvpP9RYQsX
         /KqTTgWkTQrNX3cUOyJWI06WKkGwBKKlupfWsxJvrky/P4bbushmfFA9IGEtsCSw5Ply
         i9SwmKprF9PVSuusLsMz7sdmlX4avVImi5Z7jxG1Es6XyEp3GC6SdwErc9JsXfD6kOIQ
         4VckaiP2IPTbe4NMZgLn8k3Gy6Mg/6mH7EhTH6MqPGHiwAJ//cdsZUQfqH88+IoEBws8
         13tw==
X-Gm-Message-State: ACgBeo3b4BeUxNCsZax6pNHX1q+hg5+847jqFODHntwjD2I3XxktLjfu
        O6xyIEPKF0ns1cIP2yzojak5Jqni6Lk81AFiYeDj4g==
X-Google-Smtp-Source: AA6agR5mVpID9u+JDtI82NiW88kTDIIbQbS7S/gF0AhEIVdT1EQ2q0x+chO+/7/RyLkaGxluPNqIWqlBtjPa3b5AGsI=
X-Received: by 2002:a05:6512:12c2:b0:48b:a139:fea with SMTP id
 p2-20020a05651212c200b0048ba1390feamr4509125lfg.46.1660532434262; Sun, 14 Aug
 2022 20:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220815025006.48167-1-mie@igel.co.jp>
In-Reply-To: <20220815025006.48167-1-mie@igel.co.jp>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Mon, 15 Aug 2022 12:00:23 +0900
Message-ID: <CANXvt5osmx+iFdVXYQhGcdBiz5VsA60jzdKXg42c_zSDuxoHxg@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: fix Kconfig indent style
To:     Jon Mason <jdmason@kudzu.us>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question, not related to the patch. Could you please tell me
why the ntb related patches are managed outside the pci branch,
Helgaas's branch? It confused me a little to find the ntb branch.

Thanks,
Shunsuke

2022=E5=B9=B48=E6=9C=8815=E6=97=A5(=E6=9C=88) 11:50 Shunsuke Mie <mie@igel.=
co.jp>:
>
> Change to follow the Kconfig style guide. This patch fixes to use tab
> rather than space to indent, while help text is indented an additional
> two spaces.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and =
EP")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  drivers/pci/endpoint/functions/Kconfig | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoin=
t/functions/Kconfig
> index 295a033ee9a2..9fd560886871 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -27,13 +27,13 @@ config PCI_EPF_NTB
>           If in doubt, say "N" to disable Endpoint NTB driver.
>
>  config PCI_EPF_VNTB
> -        tristate "PCI Endpoint NTB driver"
> -        depends on PCI_ENDPOINT
> -        depends on NTB
> -        select CONFIGFS_FS
> -        help
> -          Select this configuration option to enable the Non-Transparent
> -          Bridge (NTB) driver for PCIe Endpoint. NTB driver implements N=
TB
> -          between PCI Root Port and PCIe Endpoint.
> +       tristate "PCI Endpoint NTB driver"
> +       depends on PCI_ENDPOINT
> +       depends on NTB
> +       select CONFIGFS_FS
> +       help
> +         Select this configuration option to enable the Non-Transparent
> +         Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NT=
B
> +         between PCI Root Port and PCIe Endpoint.
>
> -          If in doubt, say "N" to disable Endpoint NTB driver.
> +         If in doubt, say "N" to disable Endpoint NTB driver.
> --
> 2.17.1
>
