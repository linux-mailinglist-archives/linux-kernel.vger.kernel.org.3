Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79394E4D47
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbiCWH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiCWHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:25:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1803DF20;
        Wed, 23 Mar 2022 00:24:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a1so758084wrh.10;
        Wed, 23 Mar 2022 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdIn2rq09mVC2hmd5LhNrpHlnS0ToShO47iRud1Ea6c=;
        b=LQJUGLXcu5/E7O3GD54pxVvr0AD1QbQqLyTHQqG6f7HzxbijNSsPE5KIgrXR9lVlFO
         P53GqY+bpMOASJHDf5NSobUl0Bh2KCcnCfzGCadcn/h8Utr+9duCtZMs+0lZr3QWWrPv
         vKVjwk2JCoRrv/q6YdvZRYsUh2/xiDHlG2bSNECIOOMAiA0Cf1kRKfBBVHwEEBoGhnVR
         El38tOHBv+jmq6aakpIrpsLJhTMxz40lvmViOO5uNAl8tJ0fKQUoRQns8oFrdwczOS50
         0nCphazmXZNOrBIA4H0I5St06PQFJy6FsvBGY5TWlI/E53tLX3V7HvmvviZkYiB9GjYY
         +uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdIn2rq09mVC2hmd5LhNrpHlnS0ToShO47iRud1Ea6c=;
        b=IrOII13YhoziVruvin/rLW+61d0pFn1aPzrjGc6gprmga9jnyW79uoJNdI7MTBPcIw
         ojT04yePKo2dlauDlLu+8RUX1Fcf8rTwAVWV2WCeAUM+iIOu+kM4Y15PNZBg/QRsahS+
         GsiHGpwyJe4ICzJcvobvaFNkx6Du0EBzbL/gvggj0Sozw0DcOyDRe1YQdxITwk57hksW
         9eHcF71liJKTcLyTi/e74pT9yMRwobU+SUWGPHg0gFWoD+ClgpOBgWFYDrXtjboR4yoZ
         oA3n2keo2ruKUTAH9GIo1NSZbqltLCAqc9ksV/GjRKMt0oC3g2xVnSWXFFBV4BUzN0oC
         E6vQ==
X-Gm-Message-State: AOAM533Q7nC8GEudJqHjmzmzI1OoTullzHNO+DjYrr/jOUyizN1rhXJl
        qnHDZgkGl87MHrZ87AiFHyoWRr+3nDMr5qNwwgCQHan/JXc=
X-Google-Smtp-Source: ABdhPJzNc9NL8Hp1qvXqAwTF0Z0cFBm5fh7bnM9E6aH3yKhObYNU4SO8/9PcevsVKBXPOBpiinIBq5CVH+6OgUttWHA=
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id
 c10-20020adfe74a000000b001f025cb3ad5mr25704592wrn.231.1648020267110; Wed, 23
 Mar 2022 00:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220323054001.17344-1-diego.viola@gmail.com> <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
 <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com> <641a417b-acac-6b0f-c330-b94b6ed97b99@opensource.wdc.com>
In-Reply-To: <641a417b-acac-6b0f-c330-b94b6ed97b99@opensource.wdc.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Wed, 23 Mar 2022 04:24:16 -0300
Message-ID: <CA+ToGPEAhWDwFLNHqXvtuumvdLQb=kzme7fdrgBfb4zojVvDNQ@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
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

On Wed, Mar 23, 2022 at 2:53 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 3/23/22 14:52, Diego Viola wrote:
> > On Wed, Mar 23, 2022 at 2:45 AM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 3/23/22 14:40, Diego Viola wrote:
> >>> Use the contraction "it's" instead of the possessive form "its".
> >>
> >> Well, while at it, let's use proper formal written English, so:
> >> s/it's/it is
> >> s/isn't/is not
> >
> > Fine with me, do you want me to send you another patch with those changes?
>
> Yes please.

I sent a v2 patch changing those things you pointed out, however, the
whole comment[0] looks informal "But wait.. there's more" and I don't
think replacing "it's" with "it is" achieves a lot in this case.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c#n1399

Diego
