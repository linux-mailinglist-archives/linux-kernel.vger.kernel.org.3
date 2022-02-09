Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4941E4AF342
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiBINu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiBINun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:50:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D3CC0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:50:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f17so5278084edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u4O6YDr2GYnMJAOGS//qz1G+lQenlLtONaljw5Vbcrs=;
        b=g/8I6ANlQ79U7OmGnRYKcAZc5kJddRllSYK6UXSq769HHqQnEsj2LcnDYJJcczRN9M
         WX/aUtVY7UWRqsmHyRubX2dCoWtWFd9HJMD8479oN3nU8aeu1UfKUULj1l5DeUbVnj+R
         GhwcLYI/jVNSrv6iaCDoGonoPkjT4ekMp5TucgRYp7avkDbmCDvPF5YfsfX5TeQ19AdK
         me9T30g8Z4AarJ7zrkIqoQ6kA5za/c9rCBWxdtBT2Vkmf+p6kG5D2NN57Q3IDQSvzbRZ
         50KZNxHaFhwPIiXPGttI0oTyk6qGNI6EwqILbA63iQBXS0Dl25u+H70OfMWZAzlBLlHe
         EH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u4O6YDr2GYnMJAOGS//qz1G+lQenlLtONaljw5Vbcrs=;
        b=adQjS0GioVXKvpMo2DZK217f0rgf6Gcajk5toCspnbRlBqy0Y49F4N0nfqym83QP/T
         LPoGl48vl0AcQHy4JZth9h/NorUxKCzkKmyaHVmK2Hxt564N59PuG7OTA6xSK3xJ6z1J
         eZdM5/juAfEsE1ieLa0ilCRJk73CBC8AAyLS98hZjr/uD9kyl5CFdlKaLRi7Hb+Vkwvi
         aTDtLPS7tzM1EE8mblNOaaxyMTiJJTzSgi+2tWqJd7mps4q/kRLf/SiNi/DeJo6qHzO/
         QcqD6b/gjhsJ+ckMekVniOekN6W9sB4Ubz3QUPECcBiYY8w5IyPAIyKSvDiUgm4zb3JZ
         9SCQ==
X-Gm-Message-State: AOAM533tJl3WvJtBYsbUSeKu2Z+BlR3WH68OCgdrKvj7PlmB8Zs56nNe
        jAoZqhEp31HEq6psAO3p7P+Q5q3w4rlofpzOqCYphw==
X-Google-Smtp-Source: ABdhPJyjynC2UlXBbSUdn7lYTwhCn0Y0guBYR9VrT7x0IbCfp9Oo0aHUIXx/PVv7rk5pc6AxpqjBR3GdXRo/PAkcQpA=
X-Received: by 2002:aa7:df1a:: with SMTP id c26mr2599205edy.416.1644414643289;
 Wed, 09 Feb 2022 05:50:43 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org>
In-Reply-To: <20220117132757.1881981-1-arnd@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 9 Feb 2022 14:50:32 +0100
Message-ID: <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, ebiederm@xmission.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

po 17. 1. 2022 v 14:28 odes=C3=ADlatel Arnd Bergmann <arnd@kernel.org> naps=
al:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> I picked microblaze as one of the architectures that still
> use set_fs() and converted it not to.

Can you please update the commit message because what is above is not
the right one?

I can't see any issue with the patch when I run it on real HW.
Tested-by: Michal Simek <michal.simek@xilinx.com>

Christoph: Is there any recommended test suite which I should run?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
