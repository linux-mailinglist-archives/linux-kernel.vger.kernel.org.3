Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854A94D41F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbiCJHmu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Mar 2022 02:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbiCJHmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:42:46 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C9132943
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:41:45 -0800 (PST)
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNOZO-1nmdiv37ko-00On05 for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022
 08:41:43 +0100
Received: by mail-wm1-f46.google.com with SMTP id l10so2727721wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:41:43 -0800 (PST)
X-Gm-Message-State: AOAM532ESNJqDJmgCYQ8nXY1TzXpTRiXJttIH2qfPgc9F71megtIv+I1
        dJTjgrZ5r+izCHO2nrXgw0KJzxIanruPjL43+tA=
X-Google-Smtp-Source: ABdhPJwX9v7JLP1bHQXoXpMeLqnO24Fu7KxOIk/srayQQX7hdFG9cA9Is8x0gs4r+ChJknf39HOUrRuoCQpHszGcXws=
X-Received: by 2002:a7b:c19a:0:b0:381:8495:9dd with SMTP id
 y26-20020a7bc19a000000b00381849509ddmr10731763wmi.33.1646898103447; Wed, 09
 Mar 2022 23:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20220310065045.24772-1-yuehaibing@huawei.com>
In-Reply-To: <20220310065045.24772-1-yuehaibing@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Mar 2022 08:41:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1URfVa25Yqy_CwgiC3JY3k+-M_wqMNSXqgpgT6cPGuHQ@mail.gmail.com>
Message-ID: <CAK8P3a1URfVa25Yqy_CwgiC3JY3k+-M_wqMNSXqgpgT6cPGuHQ@mail.gmail.com>
Subject: Re: [PATCH v2 -next] perf/marvell: cn10k Fix build error without CONFIG_OF
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Bharat Bhushan <bbhushan2@marvell.com>, bbudiredla@marvell.com,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:1os8DSFDbDNCML3K0GfsvJYI8mj/jpGCCBone/3uyx5SmUPv1Mq
 srEtak+2vCWId0xqVxw5BRDcNBo2nbNEPVyRv7DYw3QkI6MYbF6KdKNY77qfmM4ov3zU+MF
 yIQA8aPHAiJj/T7l71Ih0b3gjHI/IpuQqZ0AurXiiYdHhWVKpzmCTfRKFwjCPKQh/9yS8d4
 Lpb8JGSIfkhdkTpXDesAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DEQEOAiJCu4=:a/Z47bqnhbE4w8+HU7E/kx
 Sz5HDMfkH5K9iMVlEDO3zMTIqJ0Mgyf49fq/NAfLaDHKDoiDBmUR790TL/LdnlFzD1NnM39j5
 7LTY3O6841tAHdEVJ/IP25yam9KDsRX6fwUhPNGO3ueal2+L2HvV0dunemJV3zNXwkf/XY9gx
 Amjz/GaO4T4Bpsuzc7eNiW8ruhBD4r/RzFzlzH1PXQOOoqyDfQDw+0YNZuliiFcYROll0Bka4
 PCPwd3ZP9WA/zUhNM1OeziNVVvGGTId/v4fLos0xQNrF5OYPjyp3OlfCdL9SCUz9ZQ+/paAqZ
 OdwtLEOhYftjW0VbGw+G8I4r/r4ugooQancHWnmJwRNsGZ4hdJAdxk3jCrgJehkHcKQoEx7uG
 630W0oTIw54xhZnBi/hwK1LOK2NkDWvlEV1OPGV2/ZEpahxP+nn5apfA899T7MJkd6UVR0mQz
 VkbDI4CCM9rcdi9BDXVC/26Y1hv1OBpVaMW0UDJ2QCRtfRVVqITtX5UFFXNR3FFsFqGtufCS+
 e9AXc3KAZlttYX6VJ3lNdED5HcoxW4XzBA0WNzb5EPZxsuazOgE6tAbUg6uQV6vzxwaUlQPs9
 LDXZWKqHmSz0rsMcI21fZTLxlEdX7YLi3XH6fU8I4AjTLZvvcPTOU+Zkc60TaOBaerBNCmW7k
 Jo+IIXYBTAfKJr4J6RjQUY9Heela5KREJMBYAc2I2qyOafpyLEUrgh8ZfiiuBIN3D5m1/YAjc
 u3T22FY7/apixy2R9AL9UuJCa7erFDwnBb0Waox7BzTKlxgdb4F5SceLmD+1SEzT82nQJ6Ng2
 UlmUy4MfyyzA0cfXcpdF5ndaayTifz0aR0bV1o2xngcbKcpC8E=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 7:50 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/perf/marvell_cn10k_ddr_pmu.c:723:21: error: ‘cn10k_ddr_pmu_of_match’ undeclared here (not in a function); did you mean ‘cn10k_ddr_pmu_driver’?
>          .of_match_table = cn10k_ddr_pmu_of_match,
>                            ^~~~~~~~~~~~~~~~~~~~~~
>
> Remove the #ifdef around the match table, because CONFIG_OF is always enabled on arm64.
>
> Fixes: 7cf83e222bce ("perf/marvell: CN10k DDR performance monitor support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: Remove the #ifdef macro as Arnd suggested

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
