Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A471461B47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbhK2Ptd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhK2Pra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:47:30 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1990FC061A14
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:53:35 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id w22so21600579ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1hKyX1LM+Lh/+PgCMG4HnFxPHIBs5UUU3/WHI5YBino=;
        b=fF2klS+hp3VZEBlHmIsAwe8DhUpAZG2d97ff3o9Zb7UQqYnNmbjIiSBQ1f+30WOmlV
         Ce7YSnkzqGnoiO9UBHa3vXPIsCeY/hjtlVgczL7rKxAxvLR9EbLoPeUiBChmON0jI6wJ
         YH4Gfo2gSTCzP8by5vxotfjFoY6GHNl3WcgzznlPPkbFNT+7Pp+FsNli79c6VquhTHmT
         3yV2oczD43pj+oz9xUr0iVs8rmWcBXx7VQCGGGdbiT5XEiOsyYymf0tKQenq1WjgLsdx
         Nkxpjsag+pbMu+UE+QURTkMD0aGAuuNeS5EhmdTpBgtfwn9xxIHUJjr9idkTDuHgtdrm
         Mn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=1hKyX1LM+Lh/+PgCMG4HnFxPHIBs5UUU3/WHI5YBino=;
        b=il/ZCxRCVdVJ39EBmIcCgI9eLh4tj3nd6taLNCQXHoSxkfGoXnnix7B8QcnzmZP7zF
         fd61eoM0DUippTvElx4HkBZFBoMZAN+DGjDpRqGzxMWlLddxL4YTh5XnrkqIkANoVcYh
         p+E86ppbdNnSjWOE0mBqUnpAMMPYUs0q+xA+OO3BEa8O0dwOKH00GuLBm5GN4MBCu1cu
         wG4A+3KMDJRziD7suvI24o5r/H+jgmCGwM923Lc/VRdYn76r5vjGlQzgRnEoJzwI3Jgh
         bYAzNAIe4J3NZMvfM+WN9VZxpvxR0Yf1sumnHEXXA/NSAtfCgD4bTej+O0oCO/21P5d/
         ubnw==
X-Gm-Message-State: AOAM5329cBkmCPF6V4ORRe2MbfS1L2dZr/mIAfMgqmHtaypH1HWe8X8X
        Y7D0EzQ8Itqau8Ih0jSQmcrHrRQXvjaUL4Dxjv4=
X-Google-Smtp-Source: ABdhPJyq065SvMTKnyZYnxhqwDm9HSQDKmAlXDq46eoMUMIvFmlvSBXaSzUjdAylnoaLKkq9gvwz82hDxsQq/DecsgU=
X-Received: by 2002:a05:6638:2512:: with SMTP id v18mr64743742jat.22.1638194014313;
 Mon, 29 Nov 2021 05:53:34 -0800 (PST)
MIME-Version: 1.0
Reply-To: mrmahammedmamoud@gmail.com
Sender: alimahdi687@gmail.com
Received: by 2002:a05:6622:ac9:0:0:0:0 with HTTP; Mon, 29 Nov 2021 05:53:33
 -0800 (PST)
From:   =?UTF-8?Q?Mr_Mahammed=C2=A0Mamoud?= <mr.mahammedmamoud0@gmail.com>
Date:   Mon, 29 Nov 2021 05:53:33 -0800
X-Google-Sender-Auth: 4ujSYa8jSXRqJOgmnOZU7NBoE2g
Message-ID: <CAJR5xJdaC27b8farZa-RP6jm14HvSEm-eEFRvWWAL=_NvT5SNw@mail.gmail.com>
Subject: From: Mr.Mohammed,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I am Mr Mahammed=C2=A0Mamoud, account Manager with an investment bank here
in Burkina Faso. There is a draft account opened in my firm by a
long-time client of our bank. I have the opportunity of transferring
the left over fund (15.8 Million Us Dollars) Fiftheen Million Eight
Hundred Thousand United States of American Dollars.

I want to invest this funds and introduce you to our bank for this
deal and this will be executed under a legitimate arrangement that
will protect us from any breach of the law. We will share the fund 40%
for you,50% for me while 10% is for establishing of foundation for the
poor children in your country. If you are really interested in my
proposal further details of the fund transfer will be forwarded to
you.

Yours Sincerely,
Mr Mahammed=C2=A0Mamoud.
