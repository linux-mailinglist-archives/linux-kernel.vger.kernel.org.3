Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A79585958
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiG3JJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiG3JJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:09:04 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2561337FA9;
        Sat, 30 Jul 2022 02:09:03 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oHiSy-000199-01; Sat, 30 Jul 2022 11:09:00 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 55E4CC0193; Sat, 30 Jul 2022 11:02:52 +0200 (CEST)
Date:   Sat, 30 Jul 2022 11:02:52 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: msi-octeon: eliminate kernel-doc warnings
Message-ID: <20220730090252.GB4620@alpha.franken.de>
References: <20220724055723.12986-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724055723.12986-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 10:57:23PM -0700, Randy Dunlap wrote:
> Rearrange kernel-doc notation for 2 functions to eliminate
> kernel-doc warnings. Use Return: notation for the function
> return value description. Add function short descriptions
> for both functions.
> Correct 2 typos.
> 
> Fixes these kernel-doc warnings:
> 
> msi-octeon.c:49: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Called when a driver request MSI interrupts instead of the
> msi-octeon.c:49: warning: missing initial short description on line:
>  * Called when a driver request MSI interrupts instead of the
> msi-octeon.c:62: warning: No description found for return value of 'arch_setup_msi_irq'
> msi-octeon.c:189: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Called when a device no longer needs its MSI interrupts. All
> msi-octeon.c:189: warning: missing initial short description on line:
>  * Called when a device no longer needs its MSI interrupts. All
> 
> Fixes: e8635b484f64 ("MIPS: Add Cavium OCTEON PCI support.")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Aditya Srivastava <yashsri421@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/pci/msi-octeon.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
