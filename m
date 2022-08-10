Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB27D58E8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiHJIZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiHJIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:25:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC826113;
        Wed, 10 Aug 2022 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660119944; x=1691655944;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5ATw0VTrbYx/w/efXJbAdex8AhTtbEgFmRBtW+ZH5hI=;
  b=bGc3rXDxyor+pjYx78m+WvV/XBGnhcD/8sqflFk/NPmo3KfUf5IWO+uj
   K/YTPVRS9cVIpKXN1yRmFmrhCp4xMKkFU5iAlJz2qyXpr4YcdFyCMa52Q
   NOkRiMvYYvwhZaBrlCWI/Ed8wyOesAVEiMIC7qeGrr0HheLjApi2cUU6g
   bZiUwqs6a05hGEQ29PhDLVqiE828tUsR2PIcZG/DxylG2KP/WzxIC5usH
   jpAq92PM7/dVMq4l+sGeiHCrHk7OETsKzYh+Noazve6vbZAaenUn89rt7
   JLA/4N6WkHtty8tv2OWTxCArJoUPknB7NR6de9QlJFKCSmZFW1KHi+d92
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="316975943"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="316975943"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 01:25:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="664801047"
Received: from vaslau-mobl.ger.corp.intel.com ([10.252.62.177])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 01:25:42 -0700
Date:   Wed, 10 Aug 2022 11:26:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] serial: pic32_uart: Utilize
 uart_console_enabled()
In-Reply-To: <20220806225643.40897-1-andriy.shevchenko@linux.intel.com>
Message-ID: <7fb01d46-b67-2eff-d54d-c96b079dc5c@linux.intel.com>
References: <20220806225643.40897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-726611098-1660119969=:1755"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-726611098-1660119969=:1755
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sun, 7 Aug 2022, Andy Shevchenko wrote:

> The serial core already provides a helper to check if the given port
> is an enabled console. Utilize it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> ---
>  drivers/tty/serial/pic32_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
> index f418f1de66b3..1562c2a48467 100644
> --- a/drivers/tty/serial/pic32_uart.c
> +++ b/drivers/tty/serial/pic32_uart.c
> @@ -943,7 +943,7 @@ static int pic32_uart_probe(struct platform_device *pdev)
>  	}
>  
>  #ifdef CONFIG_SERIAL_PIC32_CONSOLE
> -	if (uart_console(port) && (pic32_console.flags & CON_ENABLED)) {
> +	if (uart_console_enabled(port)) {
>  		/* The peripheral clock has been enabled by console_setup,
>  		 * so disable it till the port is used.
>  		 */
> 

--8323329-726611098-1660119969=:1755--
