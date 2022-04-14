Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0D501F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbiDNXdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347728AbiDNXcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:32:53 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18195A76F3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1649979026;
        bh=TPcqwIRvfuDk2Qwm6BTs6G3vahsLIZFdldODm3sklMk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ZxPjQ+F7plFCcKdotqrCwi/s/FNlCDJMV1r0eQdm3t3Rlkgo7v45EfXAocRWrLcGd
         4XTsJg5e9GuiburSyTtswK0SPWHEBnHkE1IB9HsabtrxOKocBLkEuNi03hKnMhEupb
         tRwtJVcGaDHcU6hewfTKMD0a72M/xmsWdlqKWiFg=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 57715128A06F;
        Thu, 14 Apr 2022 19:30:26 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NpbvdN0xVR-D; Thu, 14 Apr 2022 19:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1649979026;
        bh=TPcqwIRvfuDk2Qwm6BTs6G3vahsLIZFdldODm3sklMk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ZxPjQ+F7plFCcKdotqrCwi/s/FNlCDJMV1r0eQdm3t3Rlkgo7v45EfXAocRWrLcGd
         4XTsJg5e9GuiburSyTtswK0SPWHEBnHkE1IB9HsabtrxOKocBLkEuNi03hKnMhEupb
         tRwtJVcGaDHcU6hewfTKMD0a72M/xmsWdlqKWiFg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9B7AA128A06D;
        Thu, 14 Apr 2022 19:30:25 -0400 (EDT)
Message-ID: <3119c35ba1fa7247e87d7acb56e85ea99092d0a4.camel@HansenPartnership.com>
Subject: Re: Plumbers conf presentation on -fanalyze?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Apr 2022 19:30:24 -0400
In-Reply-To: <CAKwvOdmXYa-A76CGitoAFNQz3rab37AJafQVN-=QSRVDA8y1fg@mail.gmail.com>
References: <CAKwvOdnb-DiAnq4bT7XiJpFtqyJYpWNw1shEp8gWYpVmUpRBaA@mail.gmail.com>
         <8c5012c88989a8f05a3b67540b9172336c57ddf7.camel@redhat.com>
         <CAKwvOdmXYa-A76CGitoAFNQz3rab37AJafQVN-=QSRVDA8y1fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-14 at 15:13 -0700, Nick Desaulniers wrote:
> On Thu, Apr 14, 2022 at 3:08 PM David Malcolm <dmalcolm@redhat.com>
> wrote:
> > On Thu, 2022-04-14 at 14:42 -0700, Nick Desaulniers wrote:
> > > Hi David,
> > > Jose and I are currently in the planning process to put together
> > > a
> > > Kernel+Toolchain microconference track at Linux Plumbers
> > > Conference
> > > this year (Sept 12-14) in Dublin, Ireland.
> > > 
> > > We had seen
> > > https://developers.redhat.com/articles/2022/04/12/state-static-analysis-gcc-12-compiler#scaling_up_the_analyzer
> > > particularly the section on The Linux kernel and were wondering
> > > if
> > > you'd be interested in presenting more information about
> > > -fanalyze to
> > > kernel and toolchain developers there?
> > 
> > Thanks!  I'm very much interested, but am not yet sure about travel
> > (both in terms of (a) budget and (b) possible new virus
> > strains).  Is
> > this conference going to be purely in-person, or hybrid virtual/in-
> > person?
> 
> I didn't see an answer to that question on
> https://lpc.events/event/16/page/185-faqs.
> cc' James + Stephen who might be able to answer that more precisely
> than I could.

It's going to be hybrid ... I thought we actually managed to announce
that but forgot to put it on the front page.  However, there is a
caveat: to minimize the risk of technical issues, we'd very much like
the content producers (speakers etc) to be in person.  This won't be a
blanket requirement but we'll be unhappy if you try to have a MC with
mostly virtual speakers for instance.

Jaems


