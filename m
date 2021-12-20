Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94A47B3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbhLTTXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhLTTXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:23:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A107C061574;
        Mon, 20 Dec 2021 11:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lGpSvmp68Zms4Ia/79KWDn+Yql2uJzZ9o851j4mJ5y8=; b=wr3qOHe4y1Sjyyv7VHFamHkSfi
        2jZKYB+Vy4K41aPPW0lOi4Ldd1AMwdzoB+cl4G7HaTO5sd+8Q2gGaln2FsPW+LDmqOh/94GUANBfg
        OB1u9Xig8aHEHk3bA8C5otEK4/9Vm4vlzvjsK9vyCKC2+eRopjS229/EG+z9Eyv/ia7vQG3mMlCbZ
        0+H+WMu77EoOuLYEDlZ8NlMZqlL+OJTKsTne0KJaiJUEzHfea8PBlKTVmokg9BukUS3uLkIvbfwms
        +Nr1BPAkyre1+YdZJNC7ijffzy953Ib9CGhR0hs9VsHPHsrhlUWIartU8hDwnqi+Gxco81lQFoNB8
        A2GjREXA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzOFu-0044Rn-Me; Mon, 20 Dec 2021 19:23:30 +0000
Date:   Mon, 20 Dec 2021 11:23:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen <allen.lkml@gmail.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <YcDYMtglav7T2CIi@bombadil.infradead.org>
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
 <CAOMdWSKzH2uzD6XDN21x_R7_iThBko75s9tHTTMKxbG2pdFYMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSKzH2uzD6XDN21x_R7_iThBko75s9tHTTMKxbG2pdFYMg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 06:30:07PM +0530, Allen wrote:
> Aaron, Luis,
> 
>    I have some ideas and did some work on it. Let me know if we could
> work together on this.

Patches welcomed.

  Luis
