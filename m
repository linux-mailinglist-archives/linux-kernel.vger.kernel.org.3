Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513514EFC26
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352762AbiDAV2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbiDAV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918AA2364D8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09693619FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 21:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224EFC2BBE4;
        Fri,  1 Apr 2022 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648848401;
        bh=i7nHx2qAjWv+GVWkJdRsaDMX/zriWRbfq6bcjQ92bEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tySgF6XtvYJ6Yfk54X2gbdlKZzWtXsYJCoXxJ4yrDK9naff3SE16iA9r4bkJM0HYy
         YiwDRF+3WJfPqO1Bq6o1AGpCV/wdI01g2fktRbjdf1Ok/Kl7tM5ZLk7ffp9tOJXy2W
         WXcn7Zxzdu482Y0/vj4Gxi+QO/99OIg4wcTvTFn8nPDKk4x0ZHN2UGVVPnKoo7oy9e
         tR6nNkzfSxuunmMaf7dgy/NUYE5MZ45ze+Y8AG3hTSicxfWL5jRinZPCHKmkdoaewE
         XZR3dtTI7QP4u3Gq4dN45TnqwDsOJ3Ik69hODvIZYydMvEibsIT8cT7LnxwkIaFHAi
         PhLurufvi+ltQ==
Date:   Fri, 1 Apr 2022 16:26:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
Message-ID: <20220401212639.GA131100@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520eaf08-892e-8ce0-4dca-ad8febc3d6af@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc David, Marc for possibly archiving linux-afs on lore]

On Fri, Apr 01, 2022 at 01:50:12PM -0700, Randy Dunlap wrote:
> On 4/1/22 13:14, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > as lore.kernel.org because they use different styles, add advertising, and
> > may disappear in the future.  The lore archives are more consistent and
> > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > they exist.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> > 
> > Thanks to Joe for fixing the quoting:
> > https://lore.kernel.org/all/3e21b6e87e219d6538a193a9021b965fd8180025.camel@perches.com/
> > Sorry I totally dropped the ball -- I guess I was scared off by fixing the
> > perl quoting and didn't notice that you actually did it for me ;)
> > 
> > Sample commits for testing with "checkpatch -g":
> > 
> >   bd82d4bd2188 www.spinics.net/lists/arm-kernel/msg716956.html
> >   fdec2a9ef853 www.spinics.net/lists/kvm-arm
> >   1cdca16c043a www.spinics.net/lists/linux-mmc
> >   48ea02184a9d www.spinics.net/lists/linux-pci
> >   f32ae8a5f131 www.spinics.net/lists/netdev
> >   b7dca6dd1e59 lkml.org
> >   265df32eae58 lkml.org/lkml/
> >   4a9ceb7dbadf marc.info/?l=linux-kernel&m=155656897409107&w=2.
> >   c03914b7aa31 marc.info/?l=linux-mm
> >   f108c887d089 marc.info/?l=linux-netdev
> >   7424edbb5590 marc.info/?t=156200975600004&r=1&w=2
> >   dabac6e460ce https://marc.info/?l=linux-rdma&m=152296522708522&w=2
> >   b02f6a2ef0a1 www.mail-archive.com/linux-kernel@vger.kernel.org
> >   5e91bf5ce9b8 lists.infradead.org/pipermail/linux-snps-arc/2019-May
> >   3cde818cd02b mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html
> >   a5448fdc469d http://lists.infradead.org/pipermail/linux-nvme/2019-June/024721.html
> > ---
> >  scripts/checkpatch.pl | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 577e02998701..819e0dece5e9 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -698,6 +698,17 @@ sub find_standard_signature {
> >  	return "";
> >  }
> >  
> > +our $obsolete_archives = qr{(?xi:
> > +	\Qfreedesktop.org/archives/dri-devel\E |
> > +	\Qlists.infradead.org\E |
> > +	\Qlkml.org\E |
> > +	\Qmail-archive.com\E |
> > +	\Qmailman.alsa-project.org/pipermail\E |
> > +	\Qmarc.info\E |
> > +	\Qozlabs.org/pipermail\E |
> > +	\Qspinics.net\E
> > +)};
> 
> Hi,
> 
> There seem to be some mailing lists from lists.infradead.org that are not (yet?)
> archived on lore.
> Is there a plan to add more list archives from infradead to lore?

Good question.  I don't know how to find out what things are hosted at
infradead (it redirects to https://lists.openwrt.org/mailman/listinfo),
but in the linux git history, I found URLs for these lists that are
not on lore:

  barebox             1 link from 2014
  kexec               5 links, most recent from 2021
  lede-commits        1 link from 2017
  linux-afs          16 links, most recent 2021
  linux-parport       1 link from 2005
  linux-pcmcia        6 links, most recent 2010
  linux-rpi-kernel    1 link from 2019
  linux-um            1 link from 2020

linux-afs looks like a good candidate for lore.  Possibly kexec, too.

linux-rpi-kernel seems like it might be of interest and
https://lists.infradead.org/pipermail/linux-rpi-kernel/ still shows
some activity.  Unfortunately the only URL I see in the git logs
(http://lists.infradead.org/pipermail/linux-rpi-kernel/2019-March/008615.html)
is already dead.

The following infradead lists appear to be archived on lore already:

  ath10k
  b43-dev
  linux-amlogic
  linux-arm-kernel
  linux-mediatek
  linux-mtd
  linux-nvme
  linux-riscv
  linux-snps-arc

> > +
> >  our @typeListMisordered = (
> >  	qr{char\s+(?:un)?signed},
> >  	qr{int\s+(?:(?:un)?signed\s+)?short\s},
> > @@ -3273,6 +3284,12 @@ sub process {
> >  			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
> >  		}
> >  
> > +# Check for mailing list archives other than lore.kernel.org
> > +		if ($rawline =~ m{\b$obsolete_archives}) {
> > +			WARN("PREFER_LORE_ARCHIVE",
> > +			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
> > +		}
> > +
> >  # Check for added, moved or deleted files
> >  		if (!$reported_maintainer_file && !$in_commit_log &&
> >  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> 
> -- 
> ~Randy
