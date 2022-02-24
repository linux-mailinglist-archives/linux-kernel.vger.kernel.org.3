Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676DD4C22E6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 05:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiBXEIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 23:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiBXEIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:08:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876B835DEA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:07:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2138E61747
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA19C340E9;
        Thu, 24 Feb 2022 04:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645675668;
        bh=RXbuaGAWoYDu4/DJaRsCxnBFQVeV8135g45SZLFpu9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dqb2UagG8Z+ewkVnFDULM4ZF/u/BR6Jk76eBkwIgqbtRuFBmDSp8eTqTWu/bvduWv
         TfqIviA3mvIqX1Vt+DzQFLb450Kf1j5rXtZIYA61SeZDDffe6ez90vYY8Bx1v/BNQS
         LsR+4hFw3W7be3GHfOYn8BrBYd7LZb4Neppx/FVo=
Date:   Wed, 23 Feb 2022 20:07:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] kasan: update function name in comments
Message-Id: <20220223200747.2487235367d74255d8e13ba9@linux-foundation.org>
In-Reply-To: <CANpmjNMyuQh-G0kLOdoFWXyhw31PJsjXgbv7Qy+774v8iq9NWw@mail.gmail.com>
References: <20220219012433.890941-1-pcc@google.com>
        <7a6afd53-a5c8-1be3-83cc-832596702401@huawei.com>
        <CANpmjNO=1utdh_52sVWb1rNCDme+hbMJzP9GMfF1xWigmy2WsA@mail.gmail.com>
        <CAMn1gO7S++yR4=DjrPZU_POAHP8Pfxaa3P2Cy__Ggu+kN9pqBA@mail.gmail.com>
        <CANpmjNMyuQh-G0kLOdoFWXyhw31PJsjXgbv7Qy+774v8iq9NWw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 00:35:32 +0100 Marco Elver <elver@google.com> wrote:

> > I thought that Cc: stable@vger.kernel.org controlled whether the patch
> > is to be taken to the stable kernel and Fixes: was more of an
> > informational tag. At least that's what this seems to say:
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#reviewer-s-statement-of-oversight
> 
> These days patches that just have a Fixes tag (and no Cc: stable) will
> be auto-picked in many (most?) cases (by empirical observation).
> 
> I think there were also tree-specific variances of this policy, but am
> not sure anymore. What is the latest policy?

The -stable maintainers have been asked not to do that for MM patches -
to only take those which the developers (usually I) have explicitly tagged
for backporting.

I don't know how rigorously this is being followed.  Probably OK for
patches to mm/* but if it's drivers/base/node.c then heaven knows.

