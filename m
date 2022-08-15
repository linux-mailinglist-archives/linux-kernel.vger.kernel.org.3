Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1982594D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbiHPAk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 20:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344968AbiHPAj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 20:39:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA2C18D5AF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:38:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t22so7916212pjy.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=WqMS7jx91IQ3kLNSPQa4j1WOze61V/lVS2Xj9Cco1ro=;
        b=nE6p1fueMlFHETmgXLfezqagStbO3vFdONzYeDpjSJjbHo9DIEY4cM6BVNhMlkpUIq
         IdpQEA07MBpqgh80L9iiiX8Q6vy0XF9P/enM/Y/mgNlYJJ+ghXEk47iOXSlUqi/guRw1
         nhv5H6nCRrl3pDYe14JxlFpzajgwSzaQtBnCMHFZBrTgCFWEJv7eWAUtVisEwh3+g1AG
         W4F0Wukdvy7bZ7NVulYgVdq/u3z4ivav2Jmqa1E9CC1WaRKqAxV4CgRgWVvrzSZ3CMmb
         pebq0PharuqKPmi0PZ+tPoIeF4YJslt24nJixe1Gw7/HGeCUiCTqnr4+k851twZg9NiD
         tn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=WqMS7jx91IQ3kLNSPQa4j1WOze61V/lVS2Xj9Cco1ro=;
        b=BjuvuyYuTz8LWms0x4qRYsFFZ2HhbfUkqLs89VBzfz+zeZRGnq3O562SmF/7A78BRO
         bNeLUtz23AwUqiEcEtxWB5nrDuEx7ASEOmWrTaZLDvs6X87dGL8WvNueK43OaLmzWhCs
         /M5TPULONsUL0WF0AW7rhihXtfvaTW1shUV4DalymxxN2O3Vgu3E7ChlTMZdqRPzWnDH
         Lpno3qGzxgLv4Gg3nL6oorgCBNaosg/n8BkmI0vjVvcOuJlYIU2icVutz3j71wS/KCWh
         G8Hq42CPcczpLO7l2x+8l2vUnoIHP+4x+Qv2jMVbYQKgS0hFxxEVmHc0pnA8jTG6WYLY
         4j5A==
X-Gm-Message-State: ACgBeo1auhByIseVwJLL6PF1cue8ePlDKhoQQXFZ2rpjIqw/mEFU3AKD
        pPSW/2+546uizuDgaSF8nvU=
X-Google-Smtp-Source: AA6agR63BOmqlpzqvhHlfX4I32k4NEOM1A1DYNyfdiUee0X12w4OAnaqWd3mT6QLZ84516A1l+pq5Q==
X-Received: by 2002:a17:902:e548:b0:16f:93:2f97 with SMTP id n8-20020a170902e54800b0016f00932f97mr19379423plf.130.1660595931381;
        Mon, 15 Aug 2022 13:38:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b0016a111c83cdsm7455167plh.119.2022.08.15.13.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 13:38:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Aug 2022 13:38:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815203849.GB509309@roeck-us.net>
References: <20220814212610.GA3690074@roeck-us.net>
 <20220815054117-mutt-send-email-mst@kernel.org>
 <20220815154920.GA4027315@roeck-us.net>
 <20220815120007-mutt-send-email-mst@kernel.org>
 <20220815182254.GA3241114@roeck-us.net>
 <CAHk-=wjWN6Wh1t5g48=ue4Ti6ig2P7u5nXBcQjLf=oiAZibk6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjWN6Wh1t5g48=ue4Ti6ig2P7u5nXBcQjLf=oiAZibk6w@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 11:37:54AM -0700, Linus Torvalds wrote:
> On Mon, Aug 15, 2022 at 11:22 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > I ended up publishing several of the syzkaller reports because I could
> > not figure out how to test the proposed patch otherwise. Sorry for the
> > noise on the mailing lists, but I just could not figure out how to
> > trigger test runs without making the reports public. Various test runs
> > are now queued. Hopefully we should get results soon.
> 
> I actually think that the best "test" is to just test the revert and
> see if the problems go away.
> 
> You may not have found a way to reliably trigger one particular
> problem, but apparently you can easily enough trigger some random
> issue with enough tests.
> 
> If it's some random memory corruption, there may simply not ba a great
> reproducer, with the oopses just depending on random layout and
> timing.
> 
... and the environment. So far we have only been able to reproduce
the problem on Google Cloud VMs (GCE), and there is seems to happen
pretty much all the time.

Guenter
