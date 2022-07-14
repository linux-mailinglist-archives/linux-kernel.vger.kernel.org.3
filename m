Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180F15750BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbiGNO10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiGNO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB87599D8;
        Thu, 14 Jul 2022 07:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A12261B40;
        Thu, 14 Jul 2022 14:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB45EC34114;
        Thu, 14 Jul 2022 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657808843;
        bh=chPyj8d71nEotL/dYoyx2zw6gpGSgTT1XFqCSUrWXzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/AzbcReb/+ttQRuRy2eN93Qu/iXjHNH+Qt6MKIsVVj+fGryPSvnv8Cms1WMR3ayu
         2NwFjMxGXoYob/sc/IpYHvkd00HHmqVLSvKiIAA+2l1E4Vr7zzPi6Vx+Hry1NseKPJ
         tdIlHJdtk7NfjsyBojPrVu2yZ1L0eMaYc3Hsmggc=
Date:   Thu, 14 Jul 2022 16:27:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: 8250: Add support for Brainboxes PX cards.
Message-ID: <YtAnyCXvtdtaoVkJ@kroah.com>
References: <AM5PR0202MB2564669252BDC59BF55A6E87C4879@AM5PR0202MB2564.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0202MB2564669252BDC59BF55A6E87C4879@AM5PR0202MB2564.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:35:10PM +0100, Cameron Williams wrote:
> Add support for some of the Brainboxes PCIe (PX) range of
> serial cards, including the PX-101, PX-235/PX-246,
> PX-203/PX-257, PX-260/PX-701, PX-310, PX-313,
> PX-320/PX-324/PX-376/PX-387, PX-335/PX-346, PX-368, PX-420,
> PX-803 and PX-846.
> 
> [fix for patch v1 to remove whitespace fixes and also
> correct base baud configuration for OXSEMI]

Note, this needs to go below the --- line, as the documentation asks.
I'll fix it up by hand this time...

greg k-h
