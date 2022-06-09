Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E833544251
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 06:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiFIEFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 00:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiFIEFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:05:37 -0400
X-Greylist: delayed 13308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 21:05:36 PDT
Received: from gproxy2-pub.mail.unifiedlayer.com (gproxy2-pub.mail.unifiedlayer.com [69.89.18.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E095C21FBD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 21:05:36 -0700 (PDT)
Received: from cmgw15.mail.unifiedlayer.com (unknown [10.0.90.130])
        by progateway4.mail.pro1.eigbox.com (Postfix) with ESMTP id 58ED810047B81
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:05:36 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id z9QNn4X09OnjCz9QOnHdjL; Thu, 09 Jun 2022 04:05:36 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=JPj+D+Gb c=1 sm=1 tr=0 ts=62a17190
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=JPEYwPQDsx4A:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=HaFmDPmJAAAA:8
 a=dShPbfN-9lO91TPQ_oYA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:In-Reply-To:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7oizPfCnCXpicOi1usfiu5FQzBJH1HzcGmli5C//IHw=; b=fm7Mb8fB8AB3YDHvxBl8kVN9B9
        EaTH4l4MRp8+3OWu1iD9AuxKbTMuXtV/Grudf4+OXZK0XFIl+PNJyazCVSYzUlQdn4ZjYCG76s2qI
        JozYlEs+lTrBeMhVMDGN67ctKQR3keHjg7fonAdL3uDPe4xqiwJuJDKTwUlrEaYtZmtZ0OKZ+sHGe
        mQWIwBJ6I5DooQzUnXFvk4BrBvBei0tk0k9qtJv8to1I4ekjiUMGrd1rVwRD7zpLT4LRXmYGII16+
        CkWw2AGSOhkGfuV4dehQPMgwCtZfOMZ6YZVjTi1/v98c6A4FeixNO8PQurQv1JtXz8gWUJxwFcK4+
        /gbwwcpA==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:54594 helo=[10.0.1.48])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1nz9QN-003KxI-H5;
        Wed, 08 Jun 2022 22:05:35 -0600
Subject: Re: [PATCH] riscv: don't warn for sifive erratas in modules
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de
References: <20220608120849.1695191-1-heiko@sntech.de>
From:   Ron Economos <re@w6rz.net>
In-Reply-To: <20220608120849.1695191-1-heiko@sntech.de>
Message-ID: <21e02dbd-75b0-e5c6-29d8-fc853c72aa01@w6rz.net>
Date:   Wed, 8 Jun 2022 21:05:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1nz9QN-003KxI-H5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.48]) [73.162.232.9]:54594
X-Source-Auth: re@w6rz.net
X-Email-Count: 5
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 5:08 AM, Heiko Stuebner wrote:
> The SiFive errata code contains code checking applicable erratas
> vs. actually applied erratas to suggest missing erratas to the
> user when their Kconfig options are not enabled.
>
> In the main kernel image one can be quite sure that all available
> erratas appear at least once, so that check will succeed.
> On the other hand modules can very well not use any errata-relevant
> code, so the newly added module-alternative support may also patch
> the module code, but not touch SiFive-specific erratas at all.
>
> So to restore the original behaviour don't warn when patching
> modules. This will keep the warning if necessary for the main kernel
> image but prevent spurious warnings for modules.
>
> Of course having such a vendor-specific warning may not be needed at
> all, as CONFIG_ERRATA_SIFIVE is selected by CONFIG_SOC_SIFIVE and the
> individual erratas are default-y so disabling them requires
> deliberate action anyway. But for now just restore the old behaviour.
>
> Fixes: a8e910168bba ("riscv: implement module alternatives")
> Reported-by: Ron Economos <re@w6rz.net>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/riscv/errata/sifive/errata.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
> index 672f02b21ce0..1031038423e7 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -111,6 +111,7 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
>   			cpu_apply_errata |= tmp;
>   		}
>   	}
> -	if (cpu_apply_errata != cpu_req_errata)
> +	if (stage != RISCV_ALTERNATIVES_MODULE &&
> +	    cpu_apply_errata != cpu_req_errata)
>   		warn_miss_errata(cpu_req_errata - cpu_apply_errata);
>   }

Tested on HiFive Unmatched. Works good and the spurious warning is 
suppressed.

Tested-by: Ron Economos <re@w6rz.net>

