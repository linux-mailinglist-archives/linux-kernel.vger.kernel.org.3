Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E8486F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbiAGAyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:54:21 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38509 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344777AbiAGAyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:54:16 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3bGP-1mMmG52uXL-010gE3; Fri, 07 Jan 2022 01:54:14 +0100
Received: by mail-wr1-f54.google.com with SMTP id q8so7975160wra.12;
        Thu, 06 Jan 2022 16:54:14 -0800 (PST)
X-Gm-Message-State: AOAM532L+UAeUXywi22Hnf0S9Xe6cQslcrAEDM3CvobC0jk+qbZGOlMf
        oB5E2eNv97SumDSiEqkqsUx1LchIFCxA8kkG2mQ=
X-Google-Smtp-Source: ABdhPJzUkvG1xUIThSiIkMw0/YRz6SvnFTVggx6zEMnW3ReCQQIe6ig2yNv8s0ZDFSrXOk5a7CczVdAxmwTDPVeyzWo=
X-Received: by 2002:a05:6000:118e:: with SMTP id g14mr379844wrx.12.1641516854286;
 Thu, 06 Jan 2022 16:54:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr> <86c6275e55abc16137d316e17a8fa0af53fc96ec.1641500561.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <86c6275e55abc16137d316e17a8fa0af53fc96ec.1641500561.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Jan 2022 19:54:11 -0500
X-Gmail-Original-Message-ID: <CAK8P3a3E8aBJAfZCznbvZBjSr3-HxC8GoNn6rvS58GBLHsobfQ@mail.gmail.com>
Message-ID: <CAK8P3a3E8aBJAfZCznbvZBjSr3-HxC8GoNn6rvS58GBLHsobfQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] sparc: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JbFE8XmKaa+FjRgreSD3ATEJprRKTUF0RXpPZtXoQOO3ULFS8CF
 RrUL5P4Bci96YU92PVyIbPdP41yOpe06nSSBEt9/NeWLobKK3PhVbTniCo9oZE11vMT2Yok
 1QaHxqeg5rA0dP9gTBi6amktPtKwucblzpS5LW2leApiHivf8zNDFXJLJ3rGcJLdsvYVKwp
 JRdQEEJX3+EruOS/4UI0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UbpgZVEoDDs=:FvjQH3X63PdhB6+40ELI1p
 MyBAITaSFN5RsZG0Hkw4O1ONRRY9OQxT+pzreIQza+K/TPoMn6AKu9oyjCUAaVmCFaUUJHVYl
 GZpABlOtCIzfxnaL0LLKaQsp56ABU8wjuKNiTl+48//H0NYkHpTUYSIlrjGufNkN6AyfhPoaX
 +x6bfOzsB7SOQ6535Lj3VtFt5gF6HiozcTfZXk6Z/WQOj1CT8RvtEPCG7tcgS7N1VaE6OybA2
 SjHSEHu8JKnV8cZiE0zCA2kkN6zqCHuW0oviaXE6mNdN731r8+0YFA+YGLJasj4hoXU6HBgw6
 yVb+MqLD+VQZ33HD++xXQx9gEHdfJJMeOaobyySF848SGFQhrlVEi+4yP9meCghOGi5HW7F73
 aXXxzzSmbNfJOGj9hZcH0amHofMmMmHuz7DIRCXxw5FeCEvI79mWvq+Gc8ujfgVIWhwnEgHV1
 MBObgHTZuTXYsWBJCwK2ynfdKbDyGimdkueWSB/AVRsescbStUwoTsro4NSdHJV2NLgB+T9w+
 KDhWtFhkhlcf8S9VWj5VTFQLNiGddJx8a8K7fLU9sCLNpLZ2o/5osCMUx7bXXhgpQeYEacbZ0
 lX3F1Oq8EZ9VXoOyyYzd+QcMrWnSNWyCk/oUnfT6y26B87s47D1iLzkTSGt6ST02tqIs8AKuX
 jfcTLhvHTT3qyVWpXSqhK7ovpLvZQZ+4bI9lIdzcBSgR+4XXQtJoyuLHe0Jls1pFv1dsslTZi
 qMBKxSOqGiJrpSKjB0gcBO3xmiTMjtNK3FE48IdfvGbMFamGAAcarA1y6hF/wZyTFYpNx/i1/
 3lAdlJfLZx0ZeRpXp6nBK9a6PwHizLW4nIBRV4gXrlOvf5hilQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:51 PM Christophe JAILLET
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
