Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571615A634B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiH3M1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH3M1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17AAEE4A9;
        Tue, 30 Aug 2022 05:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2966061639;
        Tue, 30 Aug 2022 12:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5E3C433C1;
        Tue, 30 Aug 2022 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661862466;
        bh=PQYZ/r6Gr5Qfqj/mCk/zkVVD3syvW86HiTgqReROAuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCXeyYMV+ZpxYv+P74n6Wv9v7fRgfvYEIkpf4ztEkdfEt6DOY2U+blyTGTJFyAA3P
         weyNeOvsi8/S9qd3hpyMPamJWtj21Y+XgT1193jkIQFhn3aZQidSliABCJKT6KzDOw
         BQYglbT/m8mHjzOEzgFy9Uh9Lu8vAASrkoYeBtzI=
Date:   Tue, 30 Aug 2022 14:27:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Stephen Warren <swarren@nvidia.com>,
        Alan Cox <alan@linux.intel.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: Create uart_xmit_advance()
Message-ID: <Yw4CP8y3b9E9XV0K@kroah.com>
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
 <20220825091707.8112-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825091707.8112-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:17:05PM +0300, Ilpo Järvinen wrote:
> A very common pattern in the drivers is to advance xmit tail
> index and do bookkeeping of Tx'ed characters. Create
> uart_xmit_advance() to handle it.
> 
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> Fixes: 2d908b38d409 ("serial: Add Tegra Combined UART driver")

This commit only adds a new function, it does not "Fix" anything :(

