Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C63B5066F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350024AbiDSIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343528AbiDSIdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:33:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C043611C19;
        Tue, 19 Apr 2022 01:30:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u15so31300570ejf.11;
        Tue, 19 Apr 2022 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OiFs7ulzkmKAramSw5U/UagtmvyMZLn6GtNwoWbozk=;
        b=QthceWOYPQDs1AOg0WckUxHDyE14D6jg6NVqJeea2fBLKkqyrVqIKoYdtOKtjDyjtp
         lLTTsYiQgFJpnVVjtsj+rjKiEXZ296YfiEGnqNC31aKreLmnHNOcOHAbwiZXmCJu+lri
         Y6U2ZOB48vPGFFhbjSOtOMJjuX1A5qHTCWxc8irzIRCzvlWHKAa3Yym3f5IxMesK1vSl
         J8Cek9lXtPzhmCV8SjODmgVwPYvSphXMUCfIXBibnzgo4jP6QIJhcPAlJv5KulLU+wVj
         6hzpRMGeBqKgat8hF5YkEKo0MiXwBucxR8wDXWRGiEZADmknKRicABFkfcEwyrdssL9y
         9IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OiFs7ulzkmKAramSw5U/UagtmvyMZLn6GtNwoWbozk=;
        b=VJYKokzEmQM2PY4GgLNF3hlIDGoB5OZEk19RS8rrjpHy3LAdVRgErT2JG1Rum/0kZj
         EWX2W4OhOWkxy+10DK4VS0SAD3Gpkt8jMco73mMfhYdIX+A4OYKKcs5jGJwp/q/kurVX
         U7+YpnK7MgBQpQXyIiHLh6UG2iabRCayGPtr/iVmOQ6QZ3KU8AGmriGIQvHW3gCxG8mr
         AeaQFJtcB80yiZy2/uZh+day35NmjK3iDWDm7qWX/6j82rfM2NpF3/8zr78DbmSl31dM
         Un0lBhmcBnP+gGf2wde/kWHwfKWBfPkxHlSZEVXQOXuVgzU0rGMc0NiOr5AaMTk05VXB
         WVCA==
X-Gm-Message-State: AOAM530zxnE0uzkircGW5drcCc2bVQhjc375o2ss2XLqjWi4h2U8b7/b
        WNXpZYXDYv7Lwuvv2EQ4iBE8V5qAxXyDEM36rzM=
X-Google-Smtp-Source: ABdhPJwuFgKeG5m9W8LUoWssPxFYUalbeGcev7sYoZsXiC2tgMwSWkKX6pCKIsldjIeRBrc2nK/Hpu2DY7UfXHOvZq4=
X-Received: by 2002:a17:906:1cd1:b0:6ec:c59:6a1d with SMTP id
 i17-20020a1709061cd100b006ec0c596a1dmr11671524ejh.77.1650357035349; Tue, 19
 Apr 2022 01:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220415130005.85879-1-andrea.merello@gmail.com>
 <20220415130005.85879-13-andrea.merello@gmail.com> <20220415174808.3b81baa4@jic23-huawei>
 <CAHp75Ve_f2txO8izFzjFUCRiP6SkT2wVHshy5EtU8LGtjzDAkA@mail.gmail.com> <CAN8YU5PeDd8BQYHQVAzfkni_v55UjaJsRJ4ATs0FAVFt1KKX=g@mail.gmail.com>
In-Reply-To: <CAN8YU5PeDd8BQYHQVAzfkni_v55UjaJsRJ4ATs0FAVFt1KKX=g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Apr 2022 11:29:59 +0300
Message-ID: <CAHp75VfENRuhUEp2Pj09qv6u-4Ze=GLwzCiSS+s2sTgt-aNE_g@mail.gmail.com>
Subject: Re: [v4 12/14] iio: imu: add BNO055 serdev driver
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

On Tue, Apr 19, 2022 at 10:48 AM Andrea Merello
<andrea.merello@gmail.com> wrote:
> Il giorno sab 16 apr 2022 alle ore 10:45 Andy Shevchenko
> <andy.shevchenko@gmail.com> ha scritto:
> > On Fri, Apr 15, 2022 at 7:40 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Fri, 15 Apr 2022 15:00:03 +0200
> > > Andrea Merello <andrea.merello@gmail.com> wrote:

...

> > > > +CFLAGS_bno055_ser.o := -I$(src)
> > >
> > > Via a bit of grepping I can see other instances of this pattern which point out
> > > that it's to do with allowing the tracing framework to see trace.h.
> > > Perhaps a similar comment here would be good (if nothing else I doubt I'll
> > > remember why this magic is here in a few years time!)
> >
> > Can be done better way, see dwc3 or drivers/base/ trace point implementations.
>
> May you elaborate, please? It appears that both dwc3 and driver/base
> use this same trick of tweaking the CFLAGS in the Makefile in order to
> fix the header file thing. What I see is different is that they both
> use an (almost empty) trace.c file. Is this what you are suggesting?

There are two differences in your code:
1) no separate c module, which...
2) is built depending on CONFIG_TRACE.

Hence, no need to have a separate ugly config option.

-- 
With Best Regards,
Andy Shevchenko
