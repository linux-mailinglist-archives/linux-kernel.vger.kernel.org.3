Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577214769DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhLPFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhLPFoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:44:07 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F05C061401
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:44:07 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id 30so45144876uag.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x007l9CmyG5Mhhl6awj68hvF5+xlJ18gJv8C9c3RB/s=;
        b=UolJxkM+o0a/L8Ra7hSn1Ky4oY3Pka/VGcJlZdk/d4vFLX56xk+7lp61iVZ6B0j87D
         C7MkG3zg7SRMOC3y4bNwSrgoKKdTYbB/UlBqoc+CdPTDcP4w+vz+Xj/zyefXgeIzwVNf
         vr8PUqIOCoJk136IgPGjS93vbKOASExiSmFP1jd6MYz66I3+kbuh5buyl4/bvZdnXViI
         Mbpw+AoYUJoqBhIckf9koLlW8P/oWXKIDUXKxSIJB7vFeSgkrELwUK3SlJ7vwQ3QCYVz
         eYNFamX9ptAqG3w2xNUJTxXUqUjJDrUMqPsOmwiQjdwiwCpJ7aAXKJ0XACVmiu1jFb6F
         2o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x007l9CmyG5Mhhl6awj68hvF5+xlJ18gJv8C9c3RB/s=;
        b=wXYqagJzQDeIBNevHr7RJZj5J9p36ZLU/ZgF51ibiV7fHhT2Y9dZ4hB4GZ+N+/c5YR
         +yLoZsrCi/99fsMwIVkw3OwwiPoV2d861trbip4kHuKg902IEfA6Zu8X1IyEDYgMLRTV
         bOXdMGEJP2P1FHvJbETStlQfrMYEASU8llcsl6akw/yQN2RiyamnwgFhscFc61vcwC4w
         RGKroJwwLcJ/hlT6stHX1IvLvtH8kWu9/8F7NNScUYq+/A5c+duLDl10b7yd3PDqiQMV
         Sa5HSJu6CWopxDf5x9k/ZUh4onUNZclDiURIOQHkesZyLUmAVumRCm9CJHoRymmqbUCE
         9W5g==
X-Gm-Message-State: AOAM533WxWtjbyjiZKly3ltsY+x/wkPo58vQk7BTJlzxDdQMHqfNSSzt
        vwAqCWXLL9p3I3tYooeiThAc/yRLjKEC2Gzpu5t+3Q==
X-Google-Smtp-Source: ABdhPJy0wqUiatEFEWteWm06fAmno9O7xiq6EHaGvlkmy6QCOhcwxFFBS2wM3t99xh/uKjIGIG5bKPtMnvnEZtpAXFk=
X-Received: by 2002:a05:6102:a4a:: with SMTP id i10mr4847667vss.47.1639633446329;
 Wed, 15 Dec 2021 21:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com>
 <20211207054019.1455054-6-sharinder@google.com> <BYAPR13MB2503EB20A1A804BEA0D08508FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <CAHLZCaHWK_oUbnFMeZ7yeCg1XtwTzb1qYNtG8qgi_dOm4ZNafQ@mail.gmail.com> <BYAPR13MB250382B305D19D310AE45916FD719@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB250382B305D19D310AE45916FD719@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Harinder Singh <sharinder@google.com>
Date:   Thu, 16 Dec 2021 11:13:55 +0530
Message-ID: <CAHLZCaGTercyt_GOFuqjT_OmZRDhA3FGReGTf7e1vVTr1VszkQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] Documentation: KUnit: Rework writing page to focus
 on writing tests
To:     Tim.Bird@sony.com
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tim,

On Fri, Dec 10, 2021 at 10:46 PM <Tim.Bird@sony.com> wrote:
>
> Thanks for responding to my review.  I reviewed the remaining patches (v3 patches 6 and 7)
> and found no issues.
>
Do you want me add your name as reviewed by you for patches 6 and 7?
>  -- Tim
>
> > -----Original Message-----
> > From: Harinder Singh <sharinder@google.com>
> >
> > Hello Tim,
> >
> > Thanks for providing review comments.
> >
> > Please see my comments below.
> ...
>
Thanks,
Harinder Singh
