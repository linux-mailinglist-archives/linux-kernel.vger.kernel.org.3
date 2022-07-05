Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA4656684C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiGEKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiGEKks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:40:48 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 463E915730;
        Tue,  5 Jul 2022 03:40:47 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o8fyz-0002Jv-02; Tue, 05 Jul 2022 12:40:41 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4D8A0C0230; Tue,  5 Jul 2022 12:22:02 +0200 (CEST)
Date:   Tue, 5 Jul 2022 12:22:02 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  MIPS: Alchemy: devboards: Remove duplicate 'the' in two
 places.
Message-ID: <20220705102202.GC9951@alpha.franken.de>
References: <20220621163418.28663-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621163418.28663-1-jiangjian@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:34:18AM +0800, Jiang Jian wrote:
> file: ./arch/mips/alchemy/devboards/pm.c
> line: 20
>  * sources and configure the timeout after which the the TOYMATCH2 irq
> changed to
>  * sources and configure the timeout after which the TOYMATCH2 irq
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  arch/mips/alchemy/devboards/pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/alchemy/devboards/pm.c b/arch/mips/alchemy/devboards/pm.c
> index 73c77814687a..b17a0d199851 100644
> --- a/arch/mips/alchemy/devboards/pm.c
> +++ b/arch/mips/alchemy/devboards/pm.c
> @@ -17,7 +17,7 @@
>   * Generic suspend userspace interface for Alchemy development boards.
>   * This code exports a few sysfs nodes under /sys/power/db1x/ which
>   * can be used by userspace to en/disable all au1x-provided wakeup
> - * sources and configure the timeout after which the the TOYMATCH2 irq
> + * sources and configure the timeout after which the TOYMATCH2 irq
>   * is to trigger a wakeup.
>   */
>  
> -- 
> 2.17.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
