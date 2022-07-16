Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2B577050
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiGPREn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGPREl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:04:41 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4A7FB1E3F2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:04:40 -0700 (PDT)
Received: (qmail 73717 invoked by uid 1000); 16 Jul 2022 13:04:39 -0400
Date:   Sat, 16 Jul 2022 13:04:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, inux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/host: fix repeated words in comments
Message-ID: <YtLvp/AhC1p4x0No@rowland.harvard.edu>
References: <20220716133129.40575-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716133129.40575-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 09:31:29PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'to'.
>  Delete the redundant word 'the'.
>  Delete the redundant word 'then'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/usb/host/uhci-platform.c | 2 +-
>  drivers/usb/host/uhci-q.c        | 2 +-
>  drivers/usb/host/xhci-ring.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> index b2049b47a08d..c7ef58c05276 100644
> --- a/drivers/usb/host/uhci-platform.c
> +++ b/drivers/usb/host/uhci-platform.c
> @@ -20,7 +20,7 @@ static int uhci_platform_init(struct usb_hcd *hcd)
>  	if (!uhci->rh_numports)
>  		uhci->rh_numports = uhci_count_ports(hcd);
>  
> -	/* Set up pointers to to generic functions */
> +	/* Set up pointers to generic functions */

This isn't a mistakenly repeated word; it is a misspelled word.  The 
second "to" should be "the".

>  	uhci->reset_hc = uhci_generic_reset_hc;
>  	uhci->check_and_reset_hc = uhci_generic_check_and_reset_hc;
>  
> diff --git a/drivers/usb/host/uhci-q.c b/drivers/usb/host/uhci-q.c
> index 35fcb826152c..e7f4c1f28349 100644
> --- a/drivers/usb/host/uhci-q.c
> +++ b/drivers/usb/host/uhci-q.c
> @@ -345,7 +345,7 @@ static int uhci_cleanup_queue(struct uhci_hcd *uhci, struct uhci_qh *qh,
>  		goto done;
>  	}
>  
> -	/* If the QH element pointer is UHCI_PTR_TERM then then currently
> +	/* If the QH element pointer is UHCI_PTR_TERM then currently

This isn't a mistakenly repeated word; it is also a misspelling.  The 
second "then" should be "the".

Alan Stern
