Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FCA463AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbhK3QDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhK3QDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:03:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A0C061574;
        Tue, 30 Nov 2021 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g/xfGmlOLiO0YeAnjYg/rviHNZmtsOfEjHUk5wypln0=; b=J2kSyaNfHsRnHfIj9iEatUJ9nW
        kP+DJIzXVnI+Td0wstB8mJ++IKyTTJPTpUxpGKKeK1kjc8+bXiI6oi1YiK+XB/P7fZDZTaiurNKzl
        uzOy3e3P+RHv8vLdN2vMUugplfNUkTItHT9chwxPbNXioKDpg5jQxXTfWigQrfGr7FkEDDEDmEJ1i
        oaq9N8Lx5kQGyIJrfj1wNRP5LqeMhl7SHsOP7YEjHhy3+yZw4HF5YLyXJRRa5J6uUwItwNF0dhLPr
        ANxVM/lPrEZP4BxCFCB/BD6Rw6ICO4V7qF0HA681cB4EEzK2Eg0xwkLk+Fk8pcWh7GbjAqDCHToPP
        9/IJek4Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms5YJ-0061SF-GE; Tue, 30 Nov 2021 16:00:19 +0000
Date:   Tue, 30 Nov 2021 08:00:19 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Nov 30
 [drivers/base/firmware_loader/firmware_class.ko]
Message-ID: <YaZKkx6zXjG8FLL8@bombadil.infradead.org>
References: <20211130185102.2c280cab@canb.auug.org.au>
 <3f1c5518-d31e-48cf-ab75-1266a85b7aa4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1c5518-d31e-48cf-ab75-1266a85b7aa4@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 06:47:19AM -0800, Randy Dunlap wrote:
> 
> 
> On 11/29/21 23:51, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20211129:
> > 
> 
> on x86_64:
> when CONFIG_FW_LOADER=m:
> 
> ERROR: modpost: "unregister_firmware_config_sysctl" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> ERROR: modpost: "register_firmware_config_sysctl" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> 
> 
> Just export those 2 symbols, please.

Can you provide your .config because I cannot reproduce with
CONFIG_FW_LOADER=m

  Luis
