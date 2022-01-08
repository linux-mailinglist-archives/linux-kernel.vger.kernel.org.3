Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAF488418
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 15:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiAHOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiAHOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 09:51:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E98C06173F;
        Sat,  8 Jan 2022 06:51:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q25so25412320edb.2;
        Sat, 08 Jan 2022 06:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJNvP81kDD3Aq8VqWSnfW17jNjOma0D87q13FaA8B+4=;
        b=j/nPbsw+RhbBku9yHWRED1dLHMmsmmd95cjBfGoit6rXk19xi6SEFe7eL5Muke+Lcr
         a/LkWOMP9hb3Jl4iIq0w8+exDViLl71k7TFIS9E/FmTk/MYaoMuJB78LCvj3e7IW5L6+
         dbkNWNGHnKeEIfzk0t8eMi8YVjDF4uKjuvlWm2agIKL6rhRO1W+z0xCmnyeuMd6jjG+P
         mh/4Ax1CnVydDlB2LKqvYLyJarBcZ+a1TH0NNdMmNJuxZ9oU4X4JezpfJ2m24sQah5Hl
         LReARQRLqofXCPpOxUaAPECrNEQJuTnuk18z4cEcsuKX0uZGm7upMX3jgIcZs4atcmfM
         cing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJNvP81kDD3Aq8VqWSnfW17jNjOma0D87q13FaA8B+4=;
        b=U381hAbEiXdalz81B97727Wvlis7POuI+FTIUq5oRhnU27Tf64tpSkJKMLkqiC2/d1
         R5vxvLWoVikCSwnbWbpb1sKYI/7UUmR0Xx6rNhjxelbiD67j6KsWhMCpFIvz3NtffPEu
         w7M9DOhNU9ST3p4Jo5bp65PZtUdc54XpLATd3HRzhwcdlSezJJFwwqH+QtBGumyVEDHO
         sKkWIfLWFJOlT6r5og/IZCRntX05y1hQ6d7ye+6g9+Mt45cwSlMheYyecVbsihTup2Y5
         PzDs++2fOq/lwTEgx3h95kIlpWK6PYwzyemxLDdYUDhJBi9Abqnl5ZCBpLz5dl2o9L9n
         uRQg==
X-Gm-Message-State: AOAM532oB/RYBAsa1751SMsiGHFysxyCjWyldbOdJBgrx2Me8uLIej+P
        Szrnc7EaXH7d9YPg6gGQg/zRSCWQd4cgUnAFPvsNvww=
X-Google-Smtp-Source: ABdhPJwwM8bk7yCYdYEfadjoAbD/C6WC+irnLfxO0bZZszQJjfTeN/PPr28VLUyg0DOAynxeGpZJBERPJThdrEc6oHg=
X-Received: by 2002:aa7:ce88:: with SMTP id y8mr8952343edv.303.1641653512070;
 Sat, 08 Jan 2022 06:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20220108182538.362c8e29@canb.auug.org.au>
In-Reply-To: <20220108182538.362c8e29@canb.auug.org.au>
From:   Rob Herring <robherring2@gmail.com>
Date:   Sat, 8 Jan 2022 08:51:40 -0600
Message-ID: <CAL_JsqLZd59vyYdpcJ_Xwu5ypO9ksAfEtd8RV40oJ7LUNxB4Ag@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the devicetree tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 1:25 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   86ce070ce00a ("of: base: Fix phandle argument length mismatch error message")
>
> Fixes tag
>
>   Fixes: af3be70a321 ("of: Improve of_phandle_iterator_next() error message")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Thanks, now fixed.

Rob
