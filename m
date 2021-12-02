Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490854662AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbhLBLue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbhLBLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:50:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8EDC061757;
        Thu,  2 Dec 2021 03:47:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89C07CE2228;
        Thu,  2 Dec 2021 11:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129DCC53FCD;
        Thu,  2 Dec 2021 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638445625;
        bh=mAkqSE6JRDgqCo/z6c2OJv9J/IAIZsbeFbky52QXlMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jv2xpTTw3ljy0lrN7enWb0l2DikxFWI7dD7EUJq6TdQOcX3UdkgPFZZTRN6ZQFpP5
         Za/Ik8MkI0vIb8jpwD+344nFtkT9KYQ1zjs1XFUImjCm1jSe6FqpXy7Zq3w/TwVMLI
         xzSF72A6NlRAILJlmvvUpCqmKJR7coyO6eB1nB2g7Sgdh9PQzWET3xC5/Hw9Wf+rky
         Tnr0klt6Bc9KFMXks67SSVXtZ3RmtndRE56EndcWWEuHVs+tC3TJL0teWqv5MDOHCo
         yIVCiLoG/1DmvOvwGwAygDxBbbmOyQmgqkhlaR+xfWecI89ttl9Vh/OewCh+ZSOnoS
         2jWz7CuU3cefg==
Date:   Thu, 2 Dec 2021 12:47:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] docs: allow selecting a Sphinx theme
Message-ID: <20211202124700.7e395897@coco.lan>
In-Reply-To: <CANiq72nu9TvLzxxj64b+EwFicwGexT7VTmVYVnVDzQgwkk+9ZA@mail.gmail.com>
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
        <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
        <CANiq72nu9TvLzxxj64b+EwFicwGexT7VTmVYVnVDzQgwkk+9ZA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 2 Dec 2021 12:24:53 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> escreveu:

> On Wed, Dec 1, 2021 at 6:59 PM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Instead of having RTD as an almost mandatory theme, allow the
> > user to select other themes via a THEMES environment var.
> >
> > There's a catch, though: as the current theme override logic is
> > dependent of the RTD theme, we need to move the code which
> > adds the CSS overrides to be inside the RTD theme logic.  
> 
> Does Sphinx support leaving the selection of the theme to "runtime",
> i.e. to let users pick a theme from a few from a combobox (e.g.
> light/dark)?
> 
> I assume not, but asking just in case.

The RTD dark theme allows that. It basically places a <sun>/<moon>
icon. When such icon is clicked, it switches between light/dark.

Thanks,
Mauro
