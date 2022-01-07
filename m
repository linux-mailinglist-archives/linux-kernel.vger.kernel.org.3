Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25C9486FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbiAGB7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:59:44 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:41501 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344533AbiAGB7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:59:39 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MOiLp-1mjy1m0Wit-00QFQI; Fri, 07 Jan 2022 02:59:37 +0100
Received: by mail-ed1-f43.google.com with SMTP id j6so16310142edw.12;
        Thu, 06 Jan 2022 17:59:37 -0800 (PST)
X-Gm-Message-State: AOAM533wA5LJufOXRwkZBzeRLhNbm2eD7rqzc+Xz3rnBJi+P9t2VYdKM
        1mDn2kVfXPO2OXbzUjTurxxQodFCK6VUrcAhm+0=
X-Google-Smtp-Source: ABdhPJwNPusolPWQ0Dfm+FkLfh1W+9s6XBF4mIXZxjKoC1VGJSGdyFfgj8EhVdC8IWm5RZdDWKdfuddYhSIOwhhZCO4=
X-Received: by 2002:a05:6000:16c7:: with SMTP id h7mr5177836wrf.317.1641517284064;
 Thu, 06 Jan 2022 17:01:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr> <4c35f397720fccb6c9166fa85fa25475b0659a6a.1641500561.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4c35f397720fccb6c9166fa85fa25475b0659a6a.1641500561.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Jan 2022 20:01:21 -0500
X-Gmail-Original-Message-ID: <CAK8P3a1sESb9CYs+N=rYs3=6Sq_CZHsKB0jXgT1n9XC7O9x_gA@mail.gmail.com>
Message-ID: <CAK8P3a1sESb9CYs+N=rYs3=6Sq_CZHsKB0jXgT1n9XC7O9x_gA@mail.gmail.com>
Subject: Re: [PATCH 09/16] media: v4l2-pci-skeleton: Remove usage of the
 deprecated "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8oDH2q8ZcRAZYzpoxlwrzszTCFuRww0c7gPSMUEWwZ7ZseQZpY+
 Bd54+PKN4HMm01RUjpSFgt22EY7EkvcEAZIsHvjpqCDvEfKXJ+QksZZ4iPZb9cwobXwjJl0
 atlqcCTZrIXdy/ftSYpduzwbE/QVG/uNgABuC1WnhOuAV5fG1QGOfmvduqMMt+mm1O3i3MX
 8PmTXBNyQClB7J1/cYlsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/dDlk68fws=:Yz0m+Bpi8dsgdSUM57PaXv
 A1zljUGqyfjnFfsSNtWSu84FaVEv2I3IToPQ8One9WT9n2wsUHjh4Y44nEXoHWp5OjdbIY5og
 yoDXjc/4rTpfR7kxUhMr6vSc10Vy6OFAmYs/mCH+k4JiHTHNXkHPYoby1aD0JC1VlZCjRsvUM
 dwojnHZ7V4iAArtYmL3fMApzS9kkOB4SF2o/x1JVzSVzMLB+pedzBAQfWDBIV8N13UpxQzhGd
 IrcckBK/GSnbfRNJbCc/emWJ2iTqYarfkfn+SQ9ihYvXw58x5/dP8TYVE+dqCVd6SfeG52VA6
 4uHquQJwL4cyMGipsaTHOTN9Yd+HRWlvudHmyMap0FSJMNJGTnkVqD8L4X+DqoSxwJbndy4sZ
 Y/UN4+gj8BLkEyYF2rW7DDTedaX3WCQsW9VIrDPfjQb3qnfUWR56aLQCGkoQDkmhQZRTOlgWe
 deuH6GPFtupdbJg4KxGeMeP6E/x1dVAesRa/6+Ua8mJgm3cvMfVv5B4Yn+3159QAIBc8RMDLC
 l/6Gs6nFtTYsMw1tJxhy716Zf0MxWoMmpCEzbrIOEHYHAJeivkEymkAjTem5il+xZ/+4Olwhm
 2p6HpP2mdErESUeyTuLo3uY83sJYMIaZhg1baSaLpQ7MLfEPTFF6b5/+v7YW9CqbTSbwYMwna
 tAk2kyV9OwuNK0DgkfFG3exa+slSv56xrEyWhY86q7nuvvQvvD/uj/he0OesPJlduGXBYO66N
 yuSIiIdUISsdXcGICaRMqzbWcFPXxlyI4u55tzHg/RTRM8xy+dPsoZEiCukDllPBoB9W0gEXO
 cmrWwjwtL6+8GcTqW/pTeMh3en9MpRRcT1/imwD48AH2W4RVyw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:53 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
>
> Some reasons why this API should be removed have been given by Julia
> Lawall in [2].
>
> A coccinelle script has been used to perform the needed transformation.
> It can be found in [3].
>
> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
> [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
