Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24D4C97A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbiCAVUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiCAVUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:20:20 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686213584B;
        Tue,  1 Mar 2022 13:19:38 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0ECBD5801CB;
        Tue,  1 Mar 2022 16:19:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 01 Mar 2022 16:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=irkPueAiCfILIlzGGrxDq4dAsI7OyDyYXO5rJi
        ZUrTM=; b=nUBYDx1r98toHBQHQnjBoT1UWSlb2c+Q/aegWeKvBa4e80FeMy7qZf
        gpjuryM+h/jy8lxKhZvcsIm0qY29GpWWqD3uVS7oUX/XLWmbA2a2moHyG0t4J9Qi
        lgMAaKf6pcVLgZdzSrukZwdkNY+AmDHVfI+OI41DZzlsxRUz8CIxQ/1PQI04QS2t
        SNoaPGqEJyDASzDICDiP8hlmyeq40JmAtWEQaCxsY2+T4pRlKch+8vogQjXHDEk+
        0yql1lEFCFeSe0i5fJyxhm3wVzRpV4xLb2a5vn2DzI7ZObSePGRfEf+4JHSjgpys
        3lopO3iT1ggNi8Xwje8nDfw/+Ldb05YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=irkPueAiCfILIlzGG
        rxDq4dAsI7OyDyYXO5rJiZUrTM=; b=oL+UTYByN2j14PQWQ5sQ06BoSof3xj7En
        EtgBehgZxHWqAAkUI3ZK+ZIvCDaMLGUTprlJ+Yw31Jz+AdarhGz539duKh+APMfT
        s0E4YjLJYcoPCeOAcr2PEJGB8PVaEEmxct/NtqWgfOKulxdo6IJYjtQPyO4MGf6s
        sx/WmyPH4t5oli117uJI+PDO7j3XqErpfoO8LMV1pKmBYt7dV5PM2fwzpwpQu5QJ
        0MFsz3kR6udPVmtUqZv9qSqkpJKNCSHsDYIMeb9NfZjTigNq9AdilnbjJpOQpFfo
        VVNmtwLkEIsujhIQ5XsQW/ETA4aZQJjgRTQxfvIgpRcpRHKP3HhrA==
X-ME-Sender: <xms:540eYmzqjA4fvjOAXE8TrWwGgnthUZTRqYZIHZvtyCcvrHQRwFAdFg>
    <xme:540eYiT0ItjMp0cC_MGjomeezo0d2wI9XVtRaZnu5DzfaBdugVuwTKJqNcoXFayex
    zOWcQ_NBs4PLg>
X-ME-Received: <xmr:540eYoWjyq6O0HlIrj_H61MfEszUvhRuJg-kOaAUBeSoLuOlv5Fhfdn2Kq_voNhBXVFEwk8jko1LQtPeCdvPtyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepueelle
    dtheekleethfeludduvdfhffeuvdffudevgeehkeegieffveehgeeftefgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:540eYsiJsNSzuhiwfFzWknUf6WKOWwa3mm-pASJ_UCpqf3BwR3YSvA>
    <xmx:540eYoAemNtfqlxLSpoUpn8u3W4zTaWKpEoYLf5WfjaIb-fswNJhPA>
    <xmx:540eYtKYEspi5AXjEuHrK8FRzJw9AAvG1jEF3rsfioXKXgGbvIkm0A>
    <xmx:6I0eYk7rylAeHS0FxImKd1xGVeOaViRlYwnzMvMh-b1O9KGHdka4QQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 16:19:35 -0500 (EST)
Date:   Tue, 1 Mar 2022 22:19:30 +0100
From:   Greg KH <greg@kroah.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <Yh6N4mWCfHtlBM07@kroah.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
 <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com>
 <YhzENKPtY+WOp566@google.com>
 <Yh09/r/nT2LeE82n@kroah.com>
 <Yh3pZXQPP9kmcSSx@google.com>
 <Yh325S5PyPiJf4F5@kroah.com>
 <Yh37gTCPaESkgNzV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh37gTCPaESkgNzV@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 10:54:57AM +0000, Lee Jones wrote:
> On Tue, 01 Mar 2022, Greg KH wrote:
> 
> > On Tue, Mar 01, 2022 at 09:37:41AM +0000, Lee Jones wrote:
> > > On Mon, 28 Feb 2022, Greg KH wrote:
> > > 
> > > > On Mon, Feb 28, 2022 at 12:46:44PM +0000, Lee Jones wrote:
> > > > > On Mon, 28 Feb 2022, Greg KH wrote:
> > > > > 
> > > > > > On Mon, Feb 28, 2022 at 09:01:49AM +0000, Lee Jones wrote:
> > > > > > > On Mon, 28 Feb 2022, Stephen Rothwell wrote:
> > > > > > > 
> > > > > > > > Hi all,
> > > > > > > > 
> > > > > > > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > > > > > 
> > > > > > > I did ask for this *not* to be merged when it was in -testing.
> > > > > > 
> > > > > > Sorry, I missed that, I saw your ack on the patch so that's why I took
> > > > > > it.
> > > > > > 
> > > > > > > I'll follow-up with Greg.
> > > > > > 
> > > > > > Should I revert this from my tree?
> > > > > 
> > > > > I did try to catch it before a revert would have been required.
> > > > 
> > > > My fault.
> > > > 
> > > > > But yes, please revert it.
> > > > 
> > > > Will go do so now.
> > > 
> > > Thank you.
> > > 
> > > > > The Ack is not standard and should not be merged.
> > > > 
> > > > I do not understand this, what went wrong here?
> > > 
> > > The "Ack" you saw was just a placeholder.
> > > 
> > > When I provided it, I would have done so like this:
> > > 
> > >     "For my own reference (apply this as-is to your sign-off block):
> > > 
> > >      Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>"
> > > 
> > > REF: https://lore.kernel.org/all/YQ0fYe531yCyP4pf@google.com/
> > > 
> > > The majority of maintainers I regularly work with know this to mean
> > > that the set is due to be routed via MFD (with a subsequent
> > > pull-request to an immutable branch to follow), since MFD is often
> > > the centre piece (parent) of the patch-sets I deal with.
> > > 
> > > I appreciate that this could cause confusion, but I'm not sure of a
> > > better way to convey this information such that it survives through
> > > various submission iterations.
> > 
> > But what else is another maintainer supposed to think if they see that
> > ack on the patch?  Ignore it?  I took that to mean "this is good from a
> > mfd-point-of-view" which meant it can go through whatever tree it is
> > supposed to.
> > 
> > Are you wanting this individual patch to go through your tree now only?
> > If so, you should say that by NOT acking it :)
> 
> It's not quite as easy as that.
> 
> It wouldn't be fair to the contributor to start reviews once all the
> other patches in the set are ready to be merged.  So how would I
> indicate that the MFD part is ready, fully expecting some of the other
> patches in the set to be reworked and subsequent revisions are to be
> submitted?

But from an "outside" observer, this patch series seemed to have acks
from all maintainers, yet no one was taking it.  Which is why I picked
it up (someone asked me to.)  Having the subsystem maintainer ack it
implied to me that there was no problem.  Odd that you later on had one :)

> > How do you want to see this merged?
> 
> The plan is for the whole set to be merged together via MFD.
> 
> All of the other maintainers have now Acked, so it's ready to go:
> 
>   https://lore.kernel.org/all/20220131133049.77780-1-robert.marko@sartura.hr/
> 
> Looking at the diff, I'm not entirely sure why you took it in the
> first place?

As I mentioned above, someone else asked me to as it was sitting around
for quite a while with no movement.

thanks,

greg k-h
