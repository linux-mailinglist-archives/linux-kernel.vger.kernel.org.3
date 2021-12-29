Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38EC4810FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhL2IeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:34:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47926 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhL2IeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:34:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C75EBB8118D;
        Wed, 29 Dec 2021 08:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2B7C36AE9;
        Wed, 29 Dec 2021 08:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640766857;
        bh=3YYTIhgtu9x2zEKV9hLL4n5kqGn91yi/zx7hbmucWnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9fhPAsFNDjc2j+nMQEzEvora6eV8/CASo2FFxz4GjgIDiU8aVbdZkjQwqt7N3VHp
         AJyN/fqklP4LJ6Xb7mZYD01xObrP2lJ6EI5kv3u4371C/ZyP3p2E0iqpshcPxfaP5j
         s0HRmkB1Ay3I6C5Jpbn2LFLuPUEYBF2wVh4AjA3Q=
Date:   Wed, 29 Dec 2021 09:34:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Subject: Re: [PATCH] nilfs2: use default_groups in kobj_type
Message-ID: <YcwdgkuScucp7ELG@kroah.com>
References: <20211228144252.390554-1-gregkh@linuxfoundation.org>
 <CAKFNMona12jPJMGveSHgVDks_EYd_ZAJ_gDRLZo=exyFD3Y8+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKFNMona12jPJMGveSHgVDks_EYd_ZAJ_gDRLZo=exyFD3Y8+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 01:52:15AM +0900, Ryusuke Konishi wrote:
> On Tue, Dec 28, 2021 at 11:42 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > There are currently 2 ways to create a set of sysfs files for a
> > kobj_type, through the default_attrs field, and the default_groups
> > field.  Move the nilfs2 code to use default_groups field which has been
> > the preferred way since aa30f47cf666 ("kobject: Add support for default
> > attribute groups to kobj_type") so that we can soon get rid of the
> > obsolete default_attrs field.
> >
> > Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > Cc: linux-nilfs@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> 
> Looks good to me.
> Please take it through your tree for your convenience, thanks.

Will do, thanks!

greg k-h
