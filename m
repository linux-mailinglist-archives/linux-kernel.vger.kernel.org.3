Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4114848E288
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiANCa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiANCaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B47C061574;
        Thu, 13 Jan 2022 18:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AF1CB821C9;
        Fri, 14 Jan 2022 02:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBEEC36AEB;
        Fri, 14 Jan 2022 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642127420;
        bh=2ebsmgfl6HWYNDrMyMRyrSK/7zuFiBDF852CKK3RFbM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CbJiS7xqwlh/Tmvl1k7CfBigp+Hlddx9tMbNU7j7mC45tXH6eR5/Plox5+57J6vkM
         HY9oPVjz4B0j/aeecyawTEGabbfamGx54bTYdBlNBUcpUnABKyvgWOGoutK5Nv6ikQ
         4dE7YwUl7JUSHSZ6dDoMXqfz2GegvbV57Ro4FaGtQ7qgBl518cKL5ECupBSoe2+Hr7
         A73ubqQuOeYTW1bDfPLwqu2vUUyxseydasYVyMLLy4qiH0W1rp05UTZxeogARIrVfr
         LXzCVLQXeQMinvc2iXRaodm8MKQ1U7VaXW2/1qUxaaGGFo3z6zUZcQTwJD5Op8S+nZ
         +hpW5z4lGbqYQ==
Received: by mail-ed1-f53.google.com with SMTP id a18so29967303edj.7;
        Thu, 13 Jan 2022 18:30:20 -0800 (PST)
X-Gm-Message-State: AOAM533mgtxRi8xR8drCUDIzpBMyzw1Anx49RNqUwWZnQ+F0Ka67+aPW
        9qlxmKE1W65WdVVZYl+4rA0xrcK4pz86n3+ZQQ==
X-Google-Smtp-Source: ABdhPJzQuUwTo+YAUp1MFy3Egme1Ft6/mg5bXZAFRg77QALC/m2dtKghKRICRPO7KkebK3UcJQYTEAYyEl4ueCZ9/bs=
X-Received: by 2002:a05:6402:3456:: with SMTP id l22mr2575585edc.280.1642127418656;
 Thu, 13 Jan 2022 18:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20220113085208.2636517-1-michael@walle.cc> <3072e2f28b4f2569f5861093768398c8@walle.cc>
In-Reply-To: <3072e2f28b4f2569f5861093768398c8@walle.cc>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Jan 2022 20:30:07 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+NDje8TTPWAKPKKuA6bMHEO17LFXfKJPxgbE_394bkdg@mail.gmail.com>
Message-ID: <CAL_Jsq+NDje8TTPWAKPKKuA6bMHEO17LFXfKJPxgbE_394bkdg@mail.gmail.com>
Subject: Re: [PATCH 0/3] of: base: of_parse_phandle() fixes and new variant
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 6:22 AM Michael Walle <michael@walle.cc> wrote:
>
> Am 2022-01-13 09:52, schrieb Michael Walle:
> > This series is a result of the discussion in [1]. Rob suggested to
> > convert
> > the index parameter to unsigned int and drop the check for negative
> > values
> > and make them static inline.
>
> Oh I haven't thought this through.. If this is going via another tree
> than
> the nvmem patches, then I'd need either wait one kernel release, or
> there
> need to be an immutable tag, right?

I can pick this up for 5.17-rc1 if we can get it sorted soon.

Rob
