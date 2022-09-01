Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6113F5A9A30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiIAOYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiIAOXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:23:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFAB7697A;
        Thu,  1 Sep 2022 07:23:18 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id p204so8816594yba.3;
        Thu, 01 Sep 2022 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yjsiVQepq35EGTK84629jF2eYJo/jmeOJnE+I0lw51U=;
        b=ZZDXAY8mRNBsgqhlnI69ATec9eNCrkYjTjm2kbQe51apRDVr60N0C4aQ1LfTfGjZPG
         GxrvhMscreJS2TgZ7hiOEdR5xQqXJT7ODJCE6O7j3sxZaE63ATsi59xSi5cdybabJV14
         o3fPD1Qy2oHwZVK3Zi8MNb9n4HXwpwoTT/Q2JSP4VuKzraxhznqIsXeMVEcFS8+W+MGw
         pIVYCt7tnymXSDcUhdrp2r/evzF7DJrgDhWc80h0NuR1XeeXJ+QI7xRdSZ4ChIJwtS2y
         MlpcR48eauVXUYOWqUqW/0KginnB4ORDkB+BSIiH/AecgS6SQEvGVPTNrhcAiZWfGddT
         lWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yjsiVQepq35EGTK84629jF2eYJo/jmeOJnE+I0lw51U=;
        b=l9vrxolZerpx35v4jkGMEKvKOx74YqXcyE6WCmsgUFmFwPw3b1UToWQNetWBLfwQFw
         sThg8Yg71wzGh57o1jnpvXZ6hm4Cm2yAqtHxScukFYY20MCWEjdz2CYStlX8Oy9DJ3CX
         c+IqXwSEAKRfN4NHARFlI0rT0+b2wm36WYqVeQtOznVQNoGYi0lphn6ei22y2oicEmiF
         b6iDz7uAVkuWReVtX/TyzHTuIlP3faEu58uLyEv4LhxcH1Cx2hx5qRlHobu72wYiKa80
         mvJ3CXs/EbwcDuNhj7byq/RB2TdDYb4mgAXC0cCbelTN9a/EEiznVrSNCCDWLLYApMn3
         D9Rw==
X-Gm-Message-State: ACgBeo0uxdmoviLj6tk22W4Y2sCbIslVnfk5NuhCqV127pGsnurobDIB
        4GWCW29tSP8Cr0NjHqr2DQEIP7B9cGYN1Bbd6ow=
X-Google-Smtp-Source: AA6agR5uTWiMTt7m10PFuJKf70QYxNEnmXqFR0fAnz57Kjx4J9qqQajusRpMBVAfZOkrYxVPaaiHDQrOBkB1DRFMahA=
X-Received: by 2002:a25:afc6:0:b0:695:8a28:1dc6 with SMTP id
 d6-20020a25afc6000000b006958a281dc6mr18836213ybj.500.1662042197300; Thu, 01
 Sep 2022 07:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220829065239.4531-1-lf32.dev@gmail.com> <87wnarnf4k.fsf@meer.lwn.net>
In-Reply-To: <87wnarnf4k.fsf@meer.lwn.net>
From:   lf32 dev <lf32.dev@gmail.com>
Date:   Thu, 1 Sep 2022 19:53:06 +0530
Message-ID: <CAOUyfw00gGT=wFBZ9O3fZdzQ8hkgjUL37F__rpuZH+9=WwjOBQ@mail.gmail.com>
Subject: Re: [PATCH] Delete duplicate words from kernel docs
To:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Awesome, thanks for merging this!

On Mon, Aug 29, 2022 at 10:47 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Akhil Raj <lf32.dev@gmail.com> writes:
>
> > I have deleted duplicate words like
> >
> > to, guest, trace, when, we
> >
> > Signed-off-by: Akhil Raj <lf32.dev@gmail.com>
> > ---
> >  Documentation/RCU/checklist.rst         | 2 +-
> >  Documentation/RCU/lockdep.rst           | 2 +-
> >  Documentation/bpf/instruction-set.rst   | 2 +-
> >  Documentation/trace/histogram.rst       | 2 +-
> >  Documentation/trace/timerlat-tracer.rst | 2 +-
> >  Documentation/virt/kvm/x86/mmu.rst      | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
>
> Applied, thanks,
>
> jon
