Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C768482D7F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 02:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiACBwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 20:52:01 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:57703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiACBwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 20:52:00 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N2mWA-1mPbuM05mu-0135z1; Mon, 03 Jan 2022 02:51:58 +0100
Received: by mail-wr1-f50.google.com with SMTP id i22so67102549wrb.13;
        Sun, 02 Jan 2022 17:51:57 -0800 (PST)
X-Gm-Message-State: AOAM532nrw7djO3ZVRRYV1wQ1b7GxSKXKb1qxAxyakxjH51WP7AHcbFm
        +38EarQP/lFRiNDq8esMWmjRhfIKsCZNohTH3G0=
X-Google-Smtp-Source: ABdhPJy/OLvkrfa3uca/8PNV9jtXkxIYVTA+Y3dckiQQVX+/vieDW+A7SrD0ghnDxY5JGEBk7gaoBrxcct8LDuzNqYM=
X-Received: by 2002:adf:a352:: with SMTP id d18mr36633279wrb.317.1641174717604;
 Sun, 02 Jan 2022 17:51:57 -0800 (PST)
MIME-Version: 1.0
References: <0b8bacb36e111d2621c2c0459b20b1da9f4375c0.1641137463.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <0b8bacb36e111d2621c2c0459b20b1da9f4375c0.1641137463.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 2 Jan 2022 20:51:58 -0500
X-Gmail-Original-Message-ID: <CAK8P3a2XwFveAd8nSCexZG3_UZga2PQ+EXHxQLGaWkLjCwrBxQ@mail.gmail.com>
Message-ID: <CAK8P3a2XwFveAd8nSCexZG3_UZga2PQ+EXHxQLGaWkLjCwrBxQ@mail.gmail.com>
Subject: Re: [PATCH] alpha: Remove usage of the deprecated "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, martin.oliveira@eideticom.com,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7beYpQjZxJvqVmrlRuG56y5UE/scO4Q13N8XviTEF31wr11Boka
 cBensjlgCN8p6gJO7tfJQCGANEQ5OeBqRInxkmKLTrFP5DlbODUK7oTQUPcS+8xqt8fewc4
 60nN0LfhddQmemkaenXKPhRPrXjoAo4BMMyqdr4QEuJN8dV8b5wUeTpPtKppn0gAKBVuenD
 03gLZ5Q/VdAXj5cILkWZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sXdiEJACyZI=:Mr52v0kT3eskIKkZmKQ44V
 i/A8sDDVa1akWuT5fkYTJjE4xmatJsVB0DvLkQbEkX+vIaCoV6pNDRwkL7EF8srTNyoE4P0La
 Mn/bOLyDKBfsQ0gqfQeQXPtam8W/n9tW/EigJhMY53c8j9MY8e8ic/gEgZ46ml8tRxYq6+pb+
 ufdHUlk9qRKWQaKFOZ2dV2m9ndHLRFSi9y4MZYkBPUwDQNAL+UvKfU1wU2Ur5cysXqx6rCI8K
 StT5tj6nndZKtpY/pcoJM1ObTVl2uJUPDF1K56l3dh/2pamZq6P/J/XqmUHLlYDKr1nL/CY1v
 V2eMGEQ+W7Tvue7onhdZO49bUsZNtaDM6mmIPLpEApiNHJl2AUwzaTNxHajOC/mheWcN/r2x9
 zL0Qc3FPx6InJg37rwwqMhLjYyn1Xr6NeDJD56N/3r+NDqO8RClzKO47H0YRoFdi8wpHiMDb5
 uR05j0eWrKKUPcv9almo+/DcmFEVFpXsZV9Y0yw26wTmNLwfeTxheUzH630DlDHL1Z/oL2k10
 7zIJFsLSC3losYz86tZvaQCPoXcu7y6srtXwmx63nfWOM3eE/WBW+2qS2foWLuzlP7en4fvIw
 sIMl23GowJ7dKtKnYiq2BEqw09bIZYkk1ugdN8yZuxp3hBCQRhUD2usmAQNN1JY7MqO8UFyZQ
 fuSVjdWoIFM4IUbV9r8gSba+28WIVvndHM6+nF4fc0tOnrFN6aorIYF/99Hru45jJ4xk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 2, 2022 at 10:32 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
>
> Some reasons why this API should be removed have been given by Julia
> Lawall in [2].
>
> A coccinelle script has been used to perform the needed transformation.
> Only relevant parts are given below.
>
>
> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

It looks like the number of remaining files that use the old
interfaces has gone down
a lot more since you last sent these patches. I would suggest you send them as a
series that includes the patch to remove the header as the last change, and
ask Andrew to pick up the ones that remain after this resend into the -mm tree,
possibly after the next -rc1. How many patches do you have left?

         Arnd
