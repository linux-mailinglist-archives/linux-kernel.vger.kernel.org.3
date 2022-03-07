Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB14CFC56
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiCGLJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiCGLJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:09:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFE474DDC;
        Mon,  7 Mar 2022 02:31:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BC17B810A8;
        Mon,  7 Mar 2022 10:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C359C340F3;
        Mon,  7 Mar 2022 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646649113;
        bh=Lgr1PxuWQUaLcGiy4CPxnWCoWa8OOlsa4U4rZyLS3yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIT2QDi9yIgAgOBoQYDDyCFuprOeJSa/U5/Ui2geEat6f0BFPQR12RwfitVnb0Jas
         98/X66PvGpGLhnzIsaTXFYR3a9wOhtmUrEjuSftziCZ4uV6ih8vJiiH4sY23Mac7Lt
         uJxyphwLkyU7NmO0zYFToLCMBclG6BIy/IAIOmek=
Date:   Mon, 7 Mar 2022 11:31:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v2 4/4] usb: host: add xhci-exynos module
Message-ID: <YiXfFnDCRWIJEZGo@kroah.com>
References: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220307101852epcas2p2639761a90e794f0b4a4a842a17ba534e@epcas2p2.samsung.com>
 <1646648256-105214-5-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646648256-105214-5-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 07:17:36PM +0900, Daehwan Jung wrote:
> This is for reference to introduce usb offload as seeing how a user does.
> We only care DCBAA, Device Context, Transfer Ring, Event Ring, and ERST.
> They are allocated on specific address(SRAM) for Co-Processor.
> Co-processor could use them directly without xhci driver after then.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/xhci-exynos.c | 2025 ++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-exynos.h |  150 +++
>  2 files changed, 2175 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-exynos.c
>  create mode 100644 drivers/usb/host/xhci-exynos.h

Please test-build your patches before sending them out :(

