Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87D9590802
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbiHKVXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiHKVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:23:49 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F59C2E4;
        Thu, 11 Aug 2022 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i3PEiamyjc61H2142mZCcJUViA/nZ/oFPUDn2/QLmUQ=; b=bHgiEAciM+CyZrzDswrzKBO5E6
        aaJVIPMcBwqHF036sW7bbs4FSwOdY2RoTc28VHm2nvHHV3F3oDFh2CsV+o34WFMDGfPoEXgmw6mHT
        kN5YQtsFrG0oINMCFlUqGhZEQ2gUsEQSRUcOIRkRTB6nLwceefByblqkD5C0oroilqgFFObCr2xRd
        2WTHYiI8owr9iYdFrE/iUy7dtNSasIi8xx1WGGo0UsWW+RmMvk5GBFAC6ef29SBAefBX4M1DMQLxI
        8F+BwQrR/kkHUqWjz/n8SQ/a5GGXPsq6T1imoJA65bVWxx8v35QXa4qzSU2bN2HRteZUsuFXjGfKq
        5eYgjghQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oMFeb-003Ytc-VU;
        Thu, 11 Aug 2022 21:23:46 +0000
Date:   Thu, 11 Aug 2022 22:23:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
Message-ID: <YvVzYSs1ijPLUb7N@ZenIV>
References: <20220811152446.281723-1-idryomov@gmail.com>
 <CAHk-=wifgq59uru6xDB=nY-1p6aQ-1YB8nVhW7T-N2ctK3m1gw@mail.gmail.com>
 <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
 <5d0b0367a5e28ec5b1f3b995c7792ff9a5cbcbd4.camel@kernel.org>
 <YvVzHQ5DVaPAvw26@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvVzHQ5DVaPAvw26@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:22:37PM +0100, Al Viro wrote:
> On Thu, Aug 11, 2022 at 05:08:11PM -0400, Jeff Layton wrote:
> 
> > Actually, I never got a formal ack from Al. I did send it repeatedly,
> > but I assume he has been too busy to respond. We've had it sitting in
> > linux-next for a couple of months, and he did suggest that approach in
> > the first place, but I too would also prefer to see his official ack on
> > it.
> 
> "Suggested approach" had been about inode_insert5() changes, right?
> But that's fs/inode.c side of things...  I have to admit that I'd missed
> the unlining d_same_name() - exporting the sucker per se didn't look

s/un/&in/ and I really need to grab some coffee...
