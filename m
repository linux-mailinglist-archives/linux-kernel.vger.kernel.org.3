Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A062058041D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiGYShj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiGYSh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:37:27 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDCD2019D;
        Mon, 25 Jul 2022 11:37:21 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ef5380669cso119583007b3.9;
        Mon, 25 Jul 2022 11:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QUTtx+0vO3maB9dE+LaXkY6OE0TD/Ru+a3YsM8WvWjU=;
        b=x7x9GKI30JCIyb11yEy4FDZzQ8pbvsZ6dzybjI5Ip+8VNOQ4cA+n3CM1x4aWQh16bb
         8O5ojw0an64t8GBKycZOow6F3+vo26vlfRlaze9f1xrZrI0reRS2DsJHbcLaBTXDoxeL
         aSeCfLlEeoGmKrSmz0dby46Tb5435Xckn9GN3mXYU7DW6AWvQE31QJeySCN3mCP2y7Xf
         wJKsYkQ5tpnWCJ582IejuZKqzMlR1xPNn5/BYt9UXOzBgUSwsVF1tVgzVZlvzBmHeTrj
         goVX+8PHOgIJwuz+9dQ1ZVdTkh7J6/iQBiQdzvCOwygWSkduIxiV5TrweW36PbVJD1Ld
         qQKQ==
X-Gm-Message-State: AJIora9I+fKwbodoHixsAzPcuE9cVEZjY9oNuD8t3VZ0KYOW1aA1CCZR
        ibUGWcz+5y2Fd+ppjrXo1ypFf/YFxGOwJHLg61I=
X-Google-Smtp-Source: AGRyM1vHSBF3A1jwFSnFt3gOA6aZOCQOiFvTVsI6T0vWjAiyUNGkj3z2WshxAm7HJuPQHK4sTHDVjaM/oudGdI1KZXU=
X-Received: by 2002:a81:f8e:0:b0:31f:4226:eb58 with SMTP id
 136-20020a810f8e000000b0031f4226eb58mr1064842ywp.19.1658774240780; Mon, 25
 Jul 2022 11:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220715015903.12537-1-rdunlap@infradead.org>
In-Reply-To: <20220715015903.12537-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jul 2022 20:37:09 +0200
Message-ID: <CAJZ5v0ixPqNidmBe=+iyhRjsJfqAuznv7bf5ZPOFC3pT-Jab_Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: loongson2: fix Kconfig "its" grammar
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 3:59 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use the possessive "its" instead of the contraction "it's"
> where appropriate.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> ---
>  drivers/cpufreq/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -268,7 +268,7 @@ config LOONGSON2_CPUFREQ
>           This option adds a CPUFreq driver for loongson processors which
>           support software configurable cpu frequency.
>
> -         Loongson2F and it's successors support this feature.
> +         Loongson2F and its successors support this feature.
>
>           If in doubt, say N.

Applied as 5.20 material, thanks!
