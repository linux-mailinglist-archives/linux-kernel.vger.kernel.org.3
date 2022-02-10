Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D884B0386
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiBJCoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:44:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiBJCon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:44:43 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A7E2409A;
        Wed,  9 Feb 2022 18:44:45 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id bt13so11526113ybb.2;
        Wed, 09 Feb 2022 18:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yae8xh6+/RqAjaPxfOanlLu1lpjK4lOMpxS+ykxZ6Ck=;
        b=PkZFlJba0ASmUM09LH0Aj6AVWyyqxqQFoEAO7Q2GzWCXVd+iWGwZmQbY9EZr4ovvYE
         hNjB3CoZahIBB+jznu8m24SjeXDCLHE5VmBPTK6Mj/DdTya4KVYwfndgQf7qvEcuYxMj
         zOGE6SzY/rScVftDHv/U1Ww9nD4W2EK5TNHpW8/o+9syMV4AK7yrgCgmBMFo1LpdPn1D
         qIuVk5HMeMg17jqAJ91r7zAF61IYaYCmCwQp1mjyCOuuybzwaW6jKC0YuzvhFqNHrCdS
         3F363h003Bp7r2hI9TCQSfnhTq2T03ioUoPqFZtbFH42OR0mY+I6mNPrFTS4Q7O7KrwU
         +6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yae8xh6+/RqAjaPxfOanlLu1lpjK4lOMpxS+ykxZ6Ck=;
        b=oNobM8n6z9vaY13IuzpvUfC1mjCtAwLQu082FE25Lt0A56/zmhfRCj73HbstLjc/8Z
         mQN6g3Y1jO1fr8r99q7hnHs6+rob58L+O/2vsjw1wpeKq3gv1gldmV7HoteFIXIjpEGf
         j5XXFg1uQ1+Wv0b2kpiruEwCwmMmwueHDeeomiOTH3mvWngU5B4ExKUmA89h6ax2CK1W
         XKJ9TghEL750L+TYsqMQPzBm1uI3FEZuPYRiz/Q6QT23dfYVbuFIVCGiwlsb/W+BUG6v
         B5sMOQY62eDFM9ZPN3QfSenHcr3gHa6RlUW242MAH2GkIjqdnUCJYylP02vi2Ly/iOgQ
         9PLw==
X-Gm-Message-State: AOAM532Or52YB98PJ5BVdh/6nuoymUeeW4h4pm2wATRKhQn+sIJ1MRj8
        t5my3dUBolEvS4JSmB6o2l/qyga1U4KeUzfmLuw=
X-Google-Smtp-Source: ABdhPJxJo9spdHYdv+eWs5mpin2D3XWhlrqvPJszbnGJ90dCoz+MsjNLGtdXa9zo3Qe6xNc5xeHQNVZlcm3halUMO2s=
X-Received: by 2002:a05:6902:114b:: with SMTP id p11mr5153810ybu.2.1644461084954;
 Wed, 09 Feb 2022 18:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20220209163029.2299009-1-trix@redhat.com> <YgPs8U85ZFbDWYlx@sirena.org.uk>
 <61a545d5-224d-86fb-2fe3-406c3ffd78fb@redhat.com> <YgP0JOilWpKU4704@sirena.org.uk>
 <CAGcXWkyCQ4JExvHv3cEL7vLMOcq_iPu0vOyOmnfzbQmMxHEp=Q@mail.gmail.com> <27a1822d798641f5bba33d7529ec02c0@sphcmbx02.sunplus.com.tw>
In-Reply-To: <27a1822d798641f5bba33d7529ec02c0@sphcmbx02.sunplus.com.tw>
From:   =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>
Date:   Thu, 10 Feb 2022 10:45:46 +0800
Message-ID: <CAGcXWkyF8FdRNP7=pcLQw339QpVX82op+zEMS7KrXXZJ8SLMQw@mail.gmail.com>
Subject: Re: [PATCH] spi: initialize ret variable
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Cc:     Tom Rix <trix@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Yes, that's what I'm asking.



>The original setting was ret=0; I just wanted to remove it when defining

>the ret, but it looks like it's required.

>Yes, it should return error at default



>I will submit new patch for this.




> The old behavior returned 0 and I am treating this as a regression.

The goal here isn't just to shut up warnings, it's to fix any problems
that they identify.  Unconditionally initialising return values is a
common way of fixing warnings while leaving real problems in place.


The original setting was ret=0; I just wanted to remove it when defining

the ret, but it looks like it's required.

Yes, it should return error at default



I will submit new patch for this.
