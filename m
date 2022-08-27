Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2375A3798
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 14:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiH0MSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH0MSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 08:18:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6373A901A5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:18:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z2so5008644edc.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JGaIku7+RSF/y1hvI5LNhxo4Hg3VWD2CcfC8Jmj90IU=;
        b=mNjmxixskyL3QDVulUysZilIj6VwhFFmo1y39Mn/9Qx6JeehdLaA2U9aAtwpC7Q2wh
         ZkoABaXXgq9aUFkdcn//ENYVOGUVcpQK8MtDqhDNxQyqvL1vi6ABThbgEfwMhpyb2kQM
         7sqZIXyAtam5A/6dpImNu8NPgfRg4md/Vf8zq2A9XpGQMHbv6F6AYCp6l6g9X+FnJEja
         ixs1D2KHZPHVJohWa0yBiVXm0vrHqFk/Ow4u5OhEeCx1LjX8hCmzJteK8HQ/+lVOx7SU
         T9dQjTos1qJjTZooEL6O39RUT5X4RLY/pRgWUem068ZyTjPuCn37f7gRcBQcBsJfI8J8
         oobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JGaIku7+RSF/y1hvI5LNhxo4Hg3VWD2CcfC8Jmj90IU=;
        b=hJo5I0wEvYPPmtlLh2APDDEaqYusBuobxS+OTy2kneGzCzkXYjFTWREIJr4i29UMt1
         0OKhtFLW86jQjDZZn0uHAcpP6tzCwcBNvQQqMUcYOGKRwT3N0WR6CmZ2QA1TNpCCpChH
         NPQiPrfdTpxxKEO25WzoK1WdLnvUvIlcpdR2egjPJ1q47RwC/FCCwYtWo+5XdVSldQQ8
         3MUXcG02lr7d70ZYkVsoyBLEtEMIkJ+D8emmJwiSKg1JrTKcwzLc3LhxxdPPSr96fGIV
         RISKzE+zNQJpAitJ5ENr+PMvsTIFAI1Yk9zrlXuu0PpiBxutG+HVIEZlIikZiV2ob1JM
         N8iw==
X-Gm-Message-State: ACgBeo0h55L2sUprGD6iyHa+YSiapkuAQXKibBW8MAd0qhtdPkvLuVaG
        iVq0N6Xr5Ca/2Ec9NT7vZmk4/wCULkqxYK0mlQ==
X-Google-Smtp-Source: AA6agR6/JB6okNR3w8D+aC2OgeUIm9S4PU4skjbrmBiidvvCsgPA+IjAhC4bgDbjbdiL8RA0TCIMfsibaItbMkwQeCE=
X-Received: by 2002:a05:6402:19:b0:447:901f:6b28 with SMTP id
 d25-20020a056402001900b00447901f6b28mr9781327edu.392.1661602683876; Sat, 27
 Aug 2022 05:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAC8pb093n-OYJf8kpwyV7eDrCJZ+10oY=NeqbtPBDaTzAxGRjw@mail.gmail.com>
 <4e88d9a9-0897-8ec9-a344-b6df3f75a428@acm.org> <CAHk-=wiVFWD8+L8qH1o9OM8rxPrV2FO4Ds8XWQefJJ0idN_sVQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiVFWD8+L8qH1o9OM8rxPrV2FO4Ds8XWQefJJ0idN_sVQ@mail.gmail.com>
From:   Fabio Comolli <fabio.comolli@gmail.com>
Date:   Sat, 27 Aug 2022 14:17:27 +0200
Message-ID: <CAC8pb0_FWP2_iWeb8EwLTfenwuGLqe8pFXdnevRUMYAuKEzKbg@mail.gmail.com>
Subject: Re: [BISECTED][REGRESSION] Kernel 6.0-rcX hangs on resume on Sony
 Vaio VPCM13M1E
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All good now. Thanks everyone for the prompt response.

Il giorno ven 26 ago 2022 alle ore 19:33 Linus Torvalds
<torvalds@linux-foundation.org> ha scritto:
>
> On Fri, Aug 26, 2022 at 6:37 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 8/26/22 00:24, Fabio Comolli wrote:
> > > Please let me know if you need more details and CC: me as I'm not subscribed to linu-kernel.
> >
> > Thanks for the detailed report. A revert request has been posted here:
>
> .. and I actually got the revert with the SCSI pull this morning as
> commit 785538bfdd68 ("scsi: sd: Revert "Rework asynchronous resume
> support"")
>
>                   Linus
