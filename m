Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B80A487C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiAGSfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiAGSfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:35:25 -0500
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63376C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 10:35:25 -0800 (PST)
Received: from myt5-c81fdca3da50.qloud-c.yandex.net (myt5-c81fdca3da50.qloud-c.yandex.net [IPv6:2a02:6b8:c12:19b:0:640:c81f:dca3])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 2EC96101369;
        Fri,  7 Jan 2022 21:35:15 +0300 (MSK)
Received: from myt6-efff10c3476a.qloud-c.yandex.net (myt6-efff10c3476a.qloud-c.yandex.net [2a02:6b8:c12:13a3:0:640:efff:10c3])
        by myt5-c81fdca3da50.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 30vQDQHSJU-ZEfOHudj;
        Fri, 07 Jan 2022 21:35:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1641580515;
        bh=LfM4E//CgUEjI1DdLUtxQtDo6ENRzw5Pg0ou76vlGYc=;
        h=In-Reply-To:References:Date:To:From:Subject:Message-ID;
        b=wRHxxrAOhatPrrsmOvd3rajz+Sgy7qmskN7YJ1KunnlyhPUK4S4rhvImxbyz+ntwq
         6RoMbKXSJ6FrvcyKVp4WAjD1Olt63HYa9HVWPUN7tAyodtrbNCkaUkGT23L/keVYID
         H+IoD2x/TrmMakhFpN810ni/ir+ANSIyI2GB85tI=
Authentication-Results: myt5-c81fdca3da50.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-efff10c3476a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id KEsX1LLLoA-ZDPSYMNE;
        Fri, 07 Jan 2022 21:35:13 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <2cb9b469ab16eaad35aab9461588cfe9977eb8fd.camel@yandex.ru>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wolfram Sang <wsa@kernel.org>
Date:   Fri, 07 Jan 2022 21:35:13 +0300
In-Reply-To: <5849ab287df1b06e141d87bbffdbcd627e999578.camel@yandex.ru>
References: <20220106122452.18719-1-wsa () kernel ! org>
         <5849ab287df1b06e141d87bbffdbcd627e999578.camel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-07 at 21:20 +0300, Konstantin Kharlamov wrote:
> Thank you! I tested it (had to resolve a small conflict), works for me. So, in
> case you need it, the patch is
> 
>         Tested-by: Konstantin Kharlamov <hi-angel@yandex.ru>
> 
> By the way, shouldn't the patch include a field 
> 
>         Cc: <stable@vger.kernel.org> # 5.14+
> 
> ?
> 
> P.S.: sorry, for all mangled up CC fields. For some reason I didn't get your
> email, I found this patch in the archive. And the mbox that archive provides
> breaks all TO and CC fields, so I manually restored addresses that I have.

Restored the fields now, sorry, I found the mail, it was moved to another folder by a filter
