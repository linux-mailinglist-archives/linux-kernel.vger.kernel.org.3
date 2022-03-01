Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB82C4C8F6F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiCAPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiCAPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:50:27 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B348465F5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZdRx/1DXGgxAEKibLBKrBbS6gSz9WiPqg2uGs+P6fS4=; b=YkDlN4KfV4wMBwk/FyRAKFlvN0
        yzKguLu7NTFntQ7M1Ssi9FS29Q9pTZnTJ7sshhQK3np0DKgzkWXp+OOe+ihAXwpNmxzHOfbenKqda
        2pLI007bDEZ8ZlL6ltE+djUDDIPHU7Wb8Ey483ZItdbjTVg9rkpWCp0ruxu4MzloKbpIHtJabYWVe
        j/bbIzM9B2Ty+w0Wuh7pLcPjKZHiOFA34MSTG5++o5QTin60ocXoezTocNU5defNVRJzl+XmK/eyJ
        yjlUt9U7aq5OWDlFLSGe6V8mRtpp86ZMDeRRNnBVhCgFXVQbaWTBqwQ5CmI/Qu1ZpUQW+UbYbFm9p
        CulDj8fw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57582)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nP4kw-0001TV-6q; Tue, 01 Mar 2022 15:49:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nP4kv-0007IW-KK; Tue, 01 Mar 2022 15:49:41 +0000
Date:   Tue, 1 Mar 2022 15:49:41 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: boot flooded with unwind: Index not found
Message-ID: <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
References: <Yh5ASXVoWoMj7/Rr@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh5ASXVoWoMj7/Rr@Red>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 04:48:25PM +0100, Corentin Labbe wrote:
> Hello
> 
> I booted today linux-next (20220301) and my boot is flooded with:
> [    0.000000] unwind: Index not found c0f0c440
> [    0.000000] unwind: Index not found 00000000
> [    0.000000] unwind: Index not found c0f0c440
> [    0.000000] unwind: Index not found 00000000
> 
> This happen on a sun8i-a83t-bananapi-m3

Have you enabled vmapped stacks?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
