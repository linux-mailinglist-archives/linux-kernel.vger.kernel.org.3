Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07E4838E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiACWvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:51:39 -0500
Received: from ms.lwn.net ([45.79.88.28]:51064 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbiACWvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:51:38 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 012F04A6;
        Mon,  3 Jan 2022 22:51:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 012F04A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641250298; bh=PDtL8wjyQzk+GIvSh7mLsETF6xsAerR38awapGuKR28=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eMeBKVmm/5n0yalPg+QLp6WuGrLb3SoK7BOnHc7YwVRL8rizhDcbIjX91Y4r+exJk
         j1arpedhCPYELnxA9yDedC216LkLelp0xn+vUN0hX8CN7fWhwnig+s/wvOyUvnyBOo
         t/uFsvISL0ZEc6OM/yDEF/XmfZhEtu99l8vjfubkUYjpYW7kjm3CdJfsM8FsjVg8F5
         9cBgTu7S23Ry/eDlKxGLcNWhQHlfHiOzOqcJu6GDAg1A4It2Oxy9Kv2nRgMYzS6aQM
         rujIEoi0dyj7szRvCZ95JvYNQ3Gj42xrh//Z/MOJp/EaCecHQ+jN1oouuEh21LrKkW
         009kAsM1Ld4Rw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v1] docs: 5.Posting.rst: describe Fixes: and Link: tags
In-Reply-To: <2b9c093339322e2686140a486b978c0b03476f42.1641194004.git.linux@leemhuis.info>
References: <2b9c093339322e2686140a486b978c0b03476f42.1641194004.git.linux@leemhuis.info>
Date:   Mon, 03 Jan 2022 15:51:40 -0700
Message-ID: <87ilv0xwjn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Explain Fixes: and Link: tags in Documentation/process/5.Posting.rst,
> which are missing in this file for unknown reasons and only described in
> Documentation/process/submitting-patches.rst.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
> Lo! If there is still a chance I'l like to get this patch into v5.17, as

I think that should be possible.  Send me a version with Randy's
comments addressed; I also had one nit below...

> during my work as regression tracker I noticed quite a few developers
> seem to be unaware how the Link: tag should be used. Maybe in parts
> that's because Documentation/process/5.Posting.rst doesn't describe it
> yet, which described things from a another different angle than
> Documentation/process/submitting-patches.rst.
>
> Ciao, Thorsten
>
> v1:
> - First version as stand alone patch. It used to be the first patch of
>   this series that got abandoned after RFC/v2:
>   https://lore.kernel.org/all/cover.1639042966.git.linux@leemhuis.info/
>   Patch itself is unchanged, patch description slighly changed. Might
>   later submit other changes from that series seperately, too, still
>   unsure.
> ---
>  Documentation/process/5.Posting.rst | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index 855a70b80269..e7b919070210 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -197,14 +197,29 @@ the build process, for example, or editor backup files) in the patch.  The
>  file "dontdiff" in the Documentation directory can help in this regard;
>  pass it to diff with the "-X" option.
>  
> -The tags mentioned above are used to describe how various developers have
> -been associated with the development of this patch.  They are described in
> -detail in
> -the :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
> -document; what follows here is a brief summary.  Each of these lines has
> -the format:
> +The tags already briefly mentioned above are used to provide insights how
> +the patch came into being. They are described in detail in the
> +:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
> +document; what follows here is a brief summary.
>  
> -::
> +One tag is used to refer to earlier commits which had problems fixed by
> +the patch::

I would s/had/introduced/

Thanks,

jon
