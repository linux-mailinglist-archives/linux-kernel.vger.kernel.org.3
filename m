Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406A1566849
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiGEKlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiGEKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:40:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64A3B15736;
        Tue,  5 Jul 2022 03:40:44 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o8fz0-0002Jv-00; Tue, 05 Jul 2022 12:40:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7ACEBC0230; Tue,  5 Jul 2022 12:22:37 +0200 (CEST)
Date:   Tue, 5 Jul 2022 12:22:37 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-mips@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] MIPS: PCI: Remove leading space in info message,
 rename pci
Message-ID: <20220705102237.GD9951@alpha.franken.de>
References: <20220620115549.39177-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620115549.39177-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 12:55:49PM +0100, Colin Ian King wrote:
> There is an info message with an extraneous leading space. Remove it.
> Also rename pci to PCI.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V2: make pci uppercase
> ---
>  arch/mips/pci/fixup-lemote2f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
> index 632ff2daa338..790d674cd80a 100644
> --- a/arch/mips/pci/fixup-lemote2f.c
> +++ b/arch/mips/pci/fixup-lemote2f.c
> @@ -80,7 +80,7 @@ int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  		}
>  		return dev->irq;
>  	} else {
> -		printk(KERN_INFO " strange pci slot number.\n");
> +		printk(KERN_INFO "strange PCI slot number.\n");
>  		return 0;
>  	}
>  }
> -- 
> 2.35.3

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
