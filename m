Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B501C5A010D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbiHXSEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiHXSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:03:27 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0755760687
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:03:04 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id y4so13485617qvp.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QwXjWp6VPuOIeH9a6I+1cEg+zMTR92fuUCrgnYOwFxU=;
        b=WiZahHRZjssP30ci297qxHBwM/n8W74ekOBzVVtrt9VDVKx69dQJ5wT3faWxLreN4i
         Tsx4R76cpJ/VQkF6ORngMs/uatCpRwFst26t7yNsGu9aEUxlYsGH/kML7x1RFFH2rdtv
         sngPiHYn8ALDq7cvMkV4D/NQGEBedwB8fk6qb730Q30S2FG16h17bKlBFy6dtx3aU6cS
         hNt2r9yzo3s7D+UwMi/CZ5PtXmw3aQRqmVWXXusAFZUiBza8a+NIyljV17BE5N/USKsm
         J2GtLze5k1xgXPamf9n51t8Am8YndizCVx1DmUq5UYSNSmOkJQYavf6gCH7y2Y8c0KKX
         mX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QwXjWp6VPuOIeH9a6I+1cEg+zMTR92fuUCrgnYOwFxU=;
        b=fme1149bcoV7xzU4DQPaqtXtdKK8cPIrBkYyKP/pR0u5Rr9IJmfUb9cXzQrcA/5uqa
         NEEDJVGLExA88cRvyuHY6arePhu2WgPQGdbp26aH1WKq63mDtNL/2Q+JMRCIYZbmT6Pq
         qUpHW23u1ciq1614gPmSDHxnCu6Ak8waxnzijhkqr+xAzjQiV8kZ01eKh559/IXVjHgz
         4phl/Q7Fgwg5PkU1JfEPVh0Kejz2WqWexQ7dfhRpJkk4dSPMHcCMky84CjdaFZx7Ubdw
         fDC9ww2y4s2Ncc6Ywf9RoECpAK6T/LhkuRSqhmSO9TDkyhb+5Fwfjw6DT3yXLjw8f8fM
         ye6Q==
X-Gm-Message-State: ACgBeo0/wH7Om1lSFkBj2eK+I4wUod6H+9zkdYl3AvEtudN9nyTb4iGG
        cWX02dr35RXiQYYIixwDJj6JBx2Ojdk58rkhOSruacHSc2A=
X-Google-Smtp-Source: AA6agR7uHBKE7Q4G0OU7TulSniWiPaq2asRHxsMcacLYKXNNaVVJnVLYlx+eb78BOR0gnCBo/xKeWKc+xcV/bWlaCZM=
X-Received: by 2002:a05:6214:29c2:b0:497:8b2:442 with SMTP id
 gh2-20020a05621429c200b0049708b20442mr209833qvb.97.1661364182917; Wed, 24 Aug
 2022 11:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220822141930.5f43b5e7@endymion.delvare> <CAHk-=wiFRok=hU_BNEsqodjyGm=XV9LVZ1w=cm4ooEtWVpYLPg@mail.gmail.com>
In-Reply-To: <CAHk-=wiFRok=hU_BNEsqodjyGm=XV9LVZ1w=cm4ooEtWVpYLPg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 21:02:26 +0300
Message-ID: <CAHp75Vd46=Q65B4L_Lzk+HuzGpPf0RkBvfPfM2UccLQWvwwqpQ@mail.gmail.com>
Subject: Re: [GIT PULL] dmi update for v5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jean Delvare <jdelvare@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Aug 24, 2022 at 8:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Aug 22, 2022 at 5:19 AM Jean Delvare <jdelvare@suse.de> wrote:
> >
> > Andy Shevchenko (1):
> >       firmware: dmi: Use the proper accessor for the version field
>
> I pulled this, but I kind of question it.
>
> This replaces a single 32-bit memory access (and an optimized byte
> swap) and a mask operation with three load-byte-and-shift operations.
>
> It's not clear that the new code is better.

That concern was arisen during discussion, but my point here is that
when you read the SMBus specification and look at the offset 6 the
operation on it, even optimized, may confuse the reader. At least it
confused me. Hence the patch.

> That said, I can't imagine it matters - but because I looked at it, I
> note that the length check seems to be kind of iffy.
>
> The code checks that the length of the block is < 32 before doing the
> checksum on it, but shouldn't it also check for some minimum size?
> Otherwise the dmi checksum is kind of pointless, isn't it?
>
> It will access a minimum of 24 bytes for that dmi_base thing, so that
> would be the most obvious minimum value. But maybe there is some
> spec-defined size for that that only covers the header?

-- 
With Best Regards,
Andy Shevchenko
