Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC66D47B39A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbhLTTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhLTTV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:21:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0CAC061574;
        Mon, 20 Dec 2021 11:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xaowSsFIuL04q0SsGiYaPLrFC+5LoUSmWL7jcQ0l+I8=; b=1gL4PxNeJFI9rcbk4SZbFVS0oF
        4R/ic4i8xzx9KSEYCOOMC7PeKRzKtOcv0OM1KkseMgVSvjv31lPbybaWXlq5TI/OY7w/9NpMN00HW
        xL94Nw+u5bIxs98OFrwy3v5ikyhcMpl1ULfQEn1ySlpxynuaoZ73eYRzPuIjkUapGYcO3WmBCAgUe
        1g8fBUgAq2bBiMLbsJSvaiKE2A2kUuW7TfPH7TwpzcOqQEsM9s2PhWsuKPSCkqKDPYwV/Vz+jUvtN
        7EdRWcFIvyIoN1AE7X61778si4OpwGvspTqdzIBnU7/cRxEqcoHqQalOiu3iFAxsJjsV+/iSUnN55
        MmTXu34Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzODn-0043tT-BK; Mon, 20 Dec 2021 19:21:19 +0000
Date:   Mon, 20 Dec 2021 11:21:19 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vimal Agrawal <Vimal.Agrawal@sophos.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vimal Agrawal <avimalin@gmail.com>
Subject: Re: [PATCH] kernel/module.c: fix for symbol decode in stack trace
 for stripped modules
Message-ID: <YcDXrwXDw7nI6u2b@bombadil.infradead.org>
References: <LO2P265MB2671DF8D82C0C6A1504D85D6939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <LO2P265MB267173F563B0A2CA5995FA2C939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <106F23FD-3768-4CF0-893D-EDFE4A0BA2BF@sophos.com>
 <YbEIe+jxzQTFPHwk@bombadil.infradead.org>
 <DB2D69B2-B523-4626-BDCE-CE7DEFCD9268@sophos.com>
 <YbJpvT/zRBuyuNxT@bombadil.infradead.org>
 <DFAD7F0E-4D95-40FC-8FB6-D488EB81A530@sophos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFAD7F0E-4D95-40FC-8FB6-D488EB81A530@sophos.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 08:57:46AM +0000, Vimal Agrawal wrote:
> Hi Luis,
> 
> Sorry for goof up with inline replies. I found that gmail supports bottom-posting so I will be replying inline from gmail next time. I will send the next patch using git send-email.
> 
> Looks like it has been there in crash source for very long.
> 
> store_module_symbols_v2
>         sprintf(buf2, "%s%s", "_MODULE_START_", mod_name);
>             sprintf(buf3, "%s%s", "_MODULE_INIT_START_", mod_name);

Can you point to the commit that added it? Preferably if you can have
a URL I can just use to see the change?

> I will test it first on latest ubuntu which has kernel version 5.13.0-22.

No, that's not sufficient, I really want you to use either Linus' latest
tree or linux-next.

  Luis
