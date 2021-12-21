Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D4E47C95E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhLUWq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUWq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:46:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B571AC061574;
        Tue, 21 Dec 2021 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h90gh4tcJW1V6SNXPxKfbHdkwYNTgO5Pfs3QrMt4cfI=; b=jlkprZSBA0/TzLU+ihi32lUFm6
        E56aTPhkdc+bB+P33zBxsHHEyi348mPILu7I3GymDwe+nvRGg4izF3/g948Jr9mWsbMEHypbOBktv
        SaI5QOZFsfPwIQMtMh3PmsQjY3z6hOAzMF+dKtF99GpIwFYUgSC3Ln+dtHElXnl+PpfI72gNRXUCR
        nn46hWLbMpSxz0qHxV2hTZMc+90RWbIL4M2eTBHylVB+rtt+FzzGi7q/2HMryX6tamrVgLLAfNwrO
        mmnB6MzgTDe3+s9bxJf2YCv9OTqQkpia0s+P8tz9w1NWp7qHYZSknu7nypYSkntLi6MkFCTklESDv
        3FQRQukA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mznuE-008f53-RB; Tue, 21 Dec 2021 22:46:50 +0000
Date:   Tue, 21 Dec 2021 14:46:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vimal Agrawal <avimalin@gmail.com>
Cc:     Vimal Agrawal <Vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/module.c: fix for symbol decode in stack trace
 for stripped modules
Message-ID: <YcJZWiQ407ZxMM+y@bombadil.infradead.org>
References: <LO2P265MB2671DF8D82C0C6A1504D85D6939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <LO2P265MB267173F563B0A2CA5995FA2C939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <106F23FD-3768-4CF0-893D-EDFE4A0BA2BF@sophos.com>
 <YbEIe+jxzQTFPHwk@bombadil.infradead.org>
 <DB2D69B2-B523-4626-BDCE-CE7DEFCD9268@sophos.com>
 <YbJpvT/zRBuyuNxT@bombadil.infradead.org>
 <DFAD7F0E-4D95-40FC-8FB6-D488EB81A530@sophos.com>
 <YcDXrwXDw7nI6u2b@bombadil.infradead.org>
 <CALkUMdSPZ2Qr8CYMpckRsjizyPapcOcd77_JOcj=73nervwOEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALkUMdSPZ2Qr8CYMpckRsjizyPapcOcd77_JOcj=73nervwOEg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 02:36:48PM +0530, Vimal Agrawal wrote:
> Hi Luis,
> 
> Please see https://github.com/crash-utility/crash/commit/03e3937ec7d1b356039433137cc6e531379ca454
> ( function store_module_symbols_v2  in file symbols.c). This was one
> of the initial commit for crash utility.

OK then I see no good reason to follow that convetion.
I'd much prefer if we use our own and make it mean something a bit more
obvious and clear as I had suggested.

> I will work on linux-next and update you.

Great.

  Luis
