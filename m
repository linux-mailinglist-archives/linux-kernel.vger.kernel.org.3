Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07214E5943
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbiCWTkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344305AbiCWTkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:40:18 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A260334B9A;
        Wed, 23 Mar 2022 12:38:47 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id b188so2684619oia.13;
        Wed, 23 Mar 2022 12:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fz/6QMfzsAXlR0TWAXHAx7AhLj9JxZcoy2PnMbAmC1w=;
        b=1tSMLOk4ejNsXdjOYP5E64szHJD3rcKjO1NRgkSr5VNVEGCn2pcxGwVC9OY/bSMRhI
         Rvs/tVyUFvFuHYD8QWzXVcp1SRhBrHWinirrOFipAmpkxWzHJCyIE6dsbqkCuaYUgVF4
         C5lUuESxDqbISQ7dU4Z7C/N0RvVOjY2Mh3HgR/zL3kFccqddDn7qEUQFyO+Yu7x3Hz1R
         Kh61xFZ775zgX89V84PcohvKbfFZd9Y7yrR/5/9p/1BbzTkjjLBrGOwhkBit+OuXVl47
         xiA7++S7wmNIpy/LS1ZMD78lh5Ys+rZmstHgVBNJ+xPopVzRDEurZY4SqH1TnA+Kyw6N
         Vf9A==
X-Gm-Message-State: AOAM5315uzQrVaImj6OEl12RnXRvbQD70bH1GBI9LRm0FTrMwkc50IKO
        4kiKZnPV0JBoLmMthlhZpZtDJjl+GA==
X-Google-Smtp-Source: ABdhPJwNb+/W52M6+cOH8SSBzIaZDXzQJSHn4fnPGNM/yFgH0rTWof15Wse2IwJH73EgWAggBjY6fA==
X-Received: by 2002:a05:6808:23c1:b0:2da:30fd:34d9 with SMTP id bq1-20020a05680823c100b002da30fd34d9mr5469047oib.203.1648064326950;
        Wed, 23 Mar 2022 12:38:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l12-20020a056870d3cc00b000ddeb925982sm343896oag.38.2022.03.23.12.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:38:46 -0700 (PDT)
Received: (nullmailer pid 320713 invoked by uid 1000);
        Wed, 23 Mar 2022 19:38:45 -0000
Date:   Wed, 23 Mar 2022 14:38:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix dtbs warnings for arch timer
Message-ID: <Yjt3RQJ82t29ZjVN@robh.at.kernel.org>
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <5521012e957efa3c4afe2de996a1b5ac@kernel.org>
 <20220316172051.GA21737@9a2d8922b8f1>
 <87y219ybsc.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y219ybsc.wl-maz@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:47:47PM +0000, Marc Zyngier wrote:
> On Wed, 16 Mar 2022 17:20:51 +0000,
> Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
> > 
> > On Wed, Mar 16, 2022 at 11:27:10AM +0000, Marc Zyngier wrote:
> > > On 2022-03-16 09:54, Kuldeep Singh wrote:
> > > > This patchset is an attempt to resolve 'make dtbs_check' warning for
> > > > arch timer.
> > > > 
> > > > Patch 1 is done in preparation for following patches which defines
> > > > compatibles order in more clear way.
> > > > Patch 2 documents arm,cortex-a7-timer entry in bindings similar to an
> > > > existing entry arm,cortex-a15-timer.
> > > > Patch 3 adds above 2 properties in of_match list to bring them in
> > > > use.
> > > > 
> > > > Please note, this patchset is based on
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git, master
> > > > 
> > > > Kuldeep Singh (3):
> > > >   dt-bindings: timer: Rearrange compatible entries of arch timer
> > > >   dt-bindings: timer: Document arm,cortex-a7-timer for arch timer
> > > >   clocksource: arch_timer: Add arm,cortex-a7/15-timer in of_match list
> > > > 
> > > >  .../devicetree/bindings/timer/arm,arch_timer.yaml   | 13 +++++--------
> > > >  drivers/clocksource/arm_arch_timer.c                |  2 ++
> > > >  2 files changed, 7 insertions(+), 8 deletions(-)
> > > 
> > > Please use my @kernel.org address exclusively. My @arm.com
> > > address stopped working over two years ago, and the MAINTAINERS
> > > file shows the right addresses.
> > 
> > Hi Marc,
> > 
> > I have tocmd and cccmd set in my gitconfig and it generated mail
> > addresses automatically so I assume it is correct.
> > tocmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol"
> > 
> > It seems your arm mail address got configured from binding file and not
> > from MAINTAINERS.
> 
> It is a bug in get_maintainer.pl. You'll have to manually apply the
> .mailmap transformation.

I just sent a fix for this[1]. 'in file' emails were not honoring 
mailmap.

Rob

[1] https://lore.kernel.org/all/20220323193645.317514-1-robh@kernel.org/
