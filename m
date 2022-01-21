Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16031495FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380783AbiAUNxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:53:04 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54113 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350479AbiAUNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:53:04 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 355215C017F;
        Fri, 21 Jan 2022 08:53:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 21 Jan 2022 08:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; bh=E
        /aRI1zfgR2kllXwrKq4YlOKAvrqWI1O7a4EaQdHg5U=; b=Wb2NSsIE4wwAxBMtR
        ES8omR+gxXK9c/GnbdkzB/GFyIfEwLDuA0dM7bl89xobrwvWGjuFMqPV5BTjPKyZ
        VnrtPlfX5zqllLU45E/ixUJOJbda036sVUzHjYoPWF5Ul65+p3ik1vz7QtX55DHQ
        WWkI/2dxaSj5BnJYnyHTRA6LVx4uNRNAIfdvlG7P4NGPWMiUUoKE/Y2eSoLYb5Zm
        4O3xOSKwlBoagbawrX89RAkr1fJfagjp7tZiU0iWqJ29AmwMMlpafIJiE/roqOhy
        ubVFHeaqt+uE29dcorfu8XwyLXZ5RQEsoTxZvPGWBD6MEuvzk6b8Y7/zHMYYG5xe
        DDH0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=E/aRI1zfgR2kllXwrKq4YlOKAvrqWI1O7a4EaQdHg
        5U=; b=iAwnIayoT3eCJQkYy3y9BXu3T+t46VjKWPUSX2vRsy9QC1WunyXbHJgot
        eDgtXS/SMo3NJkecEavt+HQru/Pqdh3nGny9h2vbHDbCk27gZIxFdrh+/n6YlRSc
        Xie2DUK8jwSygnH7cB5YhVdj0h53qSu3NGkR4xe0SHABFD8S0dCouJLULwpRrC8C
        AWAt12cVRUZu2glHaouKTzQXOztVVN3GFXOnjNvhI0VkcR+3uVqblfvpKKH41Ytk
        CS4y+gu0+rHannDv5g3Qq3ZkkzYysX/EXKfd6UynQg5CX+XkW6889T48aWjycP9g
        +2HQUz8vVPygegeA37g1UIlnKbGxA==
X-ME-Sender: <xms:vrrqYVuZGzxuwIFipmdbKcJQT1pfONJ1aWmlCVKvAI6FMi1aAzFK8g>
    <xme:vrrqYecpYvU7tGW7ud4JUp7Ud0VSWKextKNTuTjkYBv6iXXUZwlfZ2T6v0_XjMrlP
    CHSqI6KfEBJlQ>
X-ME-Received: <xmr:vrrqYYy5xZYDJqiFWD-0FleWt5eMUwyj0ODy9WfOcZf_Snfndpp9US41DJ1u62CcjwCyUzVSf81SQ3te4FIb3yHj1pFc79Oc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvddtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcu
    oehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepvedugeeuffelge
    ekhfehtdefhfekffdtgedvteeitddvieduhfekheekueehleelnecuffhomhgrihhnpehk
    rhhorghhrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:vrrqYcM015DlWt3OyobniwiQu2bGbtXP9RtfJuh7u8toQQA5BjYYTA>
    <xmx:vrrqYV9tEP_uVZNSehopCjtVI6IFfoSmztT1ixq_CUrZufJEpf52BA>
    <xmx:vrrqYcWHvBKPsLr_2szJ1qFbbMEGZT393V5ZSZ7sLiRtcZ53u7vRiA>
    <xmx:v7rqYRazPJHcW-Wrm8nkesZbuDqcPDcxg0Z4nsWLZKMDMgMmsLWSrQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jan 2022 08:53:02 -0500 (EST)
Date:   Fri, 21 Jan 2022 14:53:00 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Matthias Gerstner <mgerstner@suse.de>
Subject: usbview 2.2 release
Message-ID: <Yeq6vM/m3JFAdmg7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a new version of usbview that is now released.  If you are
building/running from source, this isn't that big of a change, but if
you are a distro packager, this is a big deal as it fixes an issue with
pollkit that could cause bad issues due to some root privileges being
needed for the program to run well.  This fixes CVE-2022-23220 and many
thanks to Matthias Gerstner of the SUSE security team for finding and
fixing these issues.

The package can be downloaded at:
	http://www.kroah.com/linux/usb/usbview-2.2.tar.gz
and the git tree can be found at:
	http://github.com/gregkh/usbview

Note, the requirement of root access for this tool is a story of how
systems evolve over time.  When this tool was first written, back in
1999, 'devices' file in usbdevfs (now usbfs), which was readable by
anyone.  Then that file moved out of usbdevfs and into debugfs, which
was mounted at /sys/kernel/debug/ and still readable by anyone.

Then, distros started to lock down debugfs and would only allow programs
that had root access to read from it, which required usbview to also
require such access.  This really is silly given that the same
information, if not more, is available to anyone who uses 'lsusb' or
libusb as usb device information is not restricted.  But usbview was
never touched, and so it still required such access, which was noticed
by SUSE and hence the security audit.

I have a hacked up rewrite of the tool in a branch in the git tree that
does not require root access, and will be polishing this up and should
do a new release with that change in a few days.  But for now, the above
security fix should be sufficient for distros that currently ship the
package and use the polkit configuration file.

thanks,

greg k-h

-------
version 2.2
        - security issue fixed with polkit (CVE-2022-23220).
        - copyright year fixups and updates
        - tooltip added to explain red devices have no attached drivers
