Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719224ECDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350938AbiC3UVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiC3UVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE1B2A72C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE37615CA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B13C340EC;
        Wed, 30 Mar 2022 20:19:51 +0000 (UTC)
Date:   Wed, 30 Mar 2022 16:19:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] ftrace: Make ftrace_graph_is_dead() a static branch
Message-ID: <20220330161950.1d12d708@gandalf.local.home>
In-Reply-To: <8c65a6fb-cd93-926d-7851-0831658dd289@csgroup.eu>
References: <8628338322fa74287ca8d432d5c0c1964acd6f2a.1648195329.git.christophe.leroy@csgroup.eu>
        <20220329220733.682172ec@gandalf.local.home>
        <8c65a6fb-cd93-926d-7851-0831658dd289@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 06:55:26 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> > Small nit. Please order the includes in "upside-down x-mas tree" fashion:
> > 
> > #include <linux/jump_label.h>
> > #include <linux/suspend.h>
> > #include <linux/ftrace.h>
> > #include <linux/slab.h>
> >   
> 
> That's the first time I get such a request. Usually people request 
> #includes to be in alphabetical order so when I see a file that has 
> headers in alphabetical order I try to not break it, but here that was 
> not the case so I put it at the end of the list.

This is something that Ingo Molnar started back in 2009 or so. And I do
find it easier on the eyes ;-)  I may be the only one today trying to keep
it (albeit poorly).

It's not a hard requirement, but I find it makes the code look more like
art, which it is :-D

> 
> I'll send v3

Thanks,

-- Steve
