Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1E49C4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbiAZIIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiAZIIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:08:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D5C06161C;
        Wed, 26 Jan 2022 00:08:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22BCAB81C10;
        Wed, 26 Jan 2022 08:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1342C340E7;
        Wed, 26 Jan 2022 08:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643184498;
        bh=XN8ZU255NqtT3dXXG59OkaiN7aG9z4IlJk7nbQNu+GQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wkf5ihcdzbGwIpNoYAPpKMDJ8xGEse7fE5gRbWUNJxEXzcuu9R/2r8ZbaIvdvEa9z
         Cv/SypKpDnrEs29n0UnGvW8Jryl0hUCddaEEPGoXWoVARkXjqpoccciVn4E81LjEyX
         5zKDd8cS0u7tn5AthqAGejWxai8071ZN8/6TOVp4Bs+gTdZsrRJyg9Ugsk60HyjyZS
         /lDzdcN7y7zFQCKSdXcNN4kvDhwbDTDIGSMr4R3xHvz+zlkpcxmwE8cZuwjhfCYR+X
         Gek00rbqqW0Sxl8R8AllcNke61BLV6N5BzSyDcc8y0ieXg5CqzplR65K749ty34dxj
         f/3NtfonhL78w==
Received: by mail-pg1-f176.google.com with SMTP id t32so20474353pgm.7;
        Wed, 26 Jan 2022 00:08:18 -0800 (PST)
X-Gm-Message-State: AOAM533QJ7NkZL5jIlfuIjkgqAYkUYNreUkRbUzl2t5Wk+o+qAR2snDi
        HxdbNGPdFVqzbrNFWvnczLq1tgBTgWZAmOJVn0k=
X-Google-Smtp-Source: ABdhPJzfiJTEL7wh3VAbWPxzy9gvcrIllCO0pta1GrOhUIBtV2oFMFrvhmsoH6xav3ovUfE0jCa+rJBgVxcFM2f009I=
X-Received: by 2002:a63:8f43:: with SMTP id r3mr18309825pgn.195.1643184498586;
 Wed, 26 Jan 2022 00:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20220126093305.5726fcbb@canb.auug.org.au>
In-Reply-To: <20220126093305.5726fcbb@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 26 Jan 2022 09:08:07 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcP0ZZrmNg2X5k8WOgDqJdpOsX3dTe_DgdimPrAgh=j0A@mail.gmail.com>
Message-ID: <CAJKOXPcP0ZZrmNg2X5k8WOgDqJdpOsX3dTe_DgdimPrAgh=j0A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the samsung-krzk tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 23:33, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   1f22c720691e ("Revert "arm64: dts: fsd: Add initial device tree support"")
>   191448a71471 ("Revert "arm64: dts: fsd: Add initial pinctrl support"")
>
> are missing a Signed-off-by from their author and committer.
>
> Reverts are changes too and so should be signed off and have reasonable
> ("why did we do this?") changelogs.

Yes, you're right. I am dropping the commits (with reverts) but was
too late yesterday. I'll fix it today.

Best regards,
Krzysztof
