Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C454BAC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343840AbiBQWVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:21:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbiBQWU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:20:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DD2166E01;
        Thu, 17 Feb 2022 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yVkhgOMadaBnzm/XnULvKiT1nP14UmXpbBvTQigVGUM=; b=Q8GWOcRknsheImdHxLB2fottJk
        wXt/z57iH1/doy9u418kkYsVNteIxD5mK0vfMIdKUkB/j0nOx/o7poXV7yNMiiRPq23mxZXLQlCC4
        KAGQqdAyiMvKHvOCpxRB1K8MnZMTnJogeGawU7JTyWk03Waw6qE6u4ehabI2KdmWaa9paLGYRmu3Q
        4cyn1U09/qAp09QJftpMPRx21gw5kmPYbZfB/XmVJjqtVVaUE/5/ep3I9yviyzCkSue4r1cpHc3g/
        LVUhK/mAg7cWsOKznOuDanygUwc0zkIMu76wUOTv3BYzAf9yXCUOwQC5jGL6GvAWtgbIYe5xijG4z
        6jJ0lARg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKp8e-00CMdg-2E; Thu, 17 Feb 2022 22:20:36 +0000
Date:   Thu, 17 Feb 2022 14:20:36 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        patches@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, Aaron Tomlin <atomlin@redhat.com>,
        Vimal Agrawal <avimalin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>
Subject: Re: Modules fixes for v5.17-rc5
Message-ID: <Yg7KNPtnuQkMISx+@bombadil.infradead.org>
References: <Yg2C2NTphV3eMkUp@bombadil.infradead.org>
 <CAHk-=wjR67HKkrPkmHXYET5M0EVwtrfAFC+AvZPd4obpzvXLLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjR67HKkrPkmHXYET5M0EVwtrfAFC+AvZPd4obpzvXLLw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:33:23AM -0800, Linus Torvalds wrote:
> On Wed, Feb 16, 2022 at 3:03 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > So far only one fix has trickled through for modules. It is part of this
> > pull request. It's a minor build fix for when CONFIG_SYSFS=n. Let me
> > know if there are any issues with this.
> 
> The only issue I have is that because you didn't put "[GIT PULL]" in
> the subject line, the pr-tracker-bot doesn't pick up on it, so you're
> not getting a "this has been merged" confirmation email.
> 
> My own search criteria for pull requests aren't as strict, so I saw it
> in my pending queue. But then I spent time wondering why I didn't see
> the pr-tracker-bot response when I pushed out, so I actually prefer
> for people to use the stricter rules that the pr-tracker-bot looks
> at...

Got it, consider this a resolved matter for the future.

Thanks for the feedback.

  Luis
