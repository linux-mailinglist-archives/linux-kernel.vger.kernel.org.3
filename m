Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36648DA83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiAMPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiAMPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:12:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B905C06161C;
        Thu, 13 Jan 2022 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3bx833r6RpZnMzrPl+Mmdeh1bsazWa4CUEpQNSO0/VI=; b=0FA/wbVVAigVPO8SxjsQ6d3WTp
        /8u6lEqBk4csz9dttKO2RGPXqiyaUsWk9YW+2+3ORS2KWP6pRJx3UbosxOqhRwjTOQ1oWavRtmhlV
        siF+k6KCZf5nang7MytiaMBjv5Bzfv+iYYq0/T/8UfhsEsNTnHKtipl/JPrzyXqsfs1VjcwJh0DFq
        aabLrOZeMA7oCF56oUV6xz74h9YYZ9CCx3wgsoaYSryFLvEoYL3q8Wc7/vcMQ6s99vGTlherxMvNN
        +G48sk2vikUXsTYte2vzw8tiMnHc0QeXXgNXjc9E39S/ZqNxvzD6hvlYdkJ5UwGZQDJ9UPZQBtu/8
        Gc0smJ6A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n81lj-006Mxe-B0; Thu, 13 Jan 2022 15:12:03 +0000
Date:   Thu, 13 Jan 2022 07:12:03 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Vernet <void@manifault.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Aaron Tomlin <atomlin@redhat.com>, cl@linux.com,
        pmladek@suse.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, ghalat@redhat.com,
        allen.lkml@gmail.com
Subject: Re: [RFC PATCH v2 03/13] module: Move livepatch support to a
 separate file
Message-ID: <YeBBQ+W/UaU06Fd5@bombadil.infradead.org>
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <20220106234319.2067842-4-atomlin@redhat.com>
 <Yd8j/Q2H0zYrAA2c@dev0025.ash9.facebook.com>
 <20220113103531.sn76g34tfkxscs4e@ava.usersys.com>
 <20220113141654.74lllshgujatnopg@dev0025.ash9.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113141654.74lllshgujatnopg@dev0025.ash9.facebook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 06:16:54AM -0800, David Vernet wrote:
> Aaron Tomlin <atomlin@atomlin.com> wrote on Thu [2022-Jan-13 10:35:31 +0000]:
> > Who should I specify? I'm not entirely sure. If I understand correctly,
> > Jessica was the original author of the majority.
> 
> Personally I would just remove the whole copyright as the SPDX identifier
> should be sufficient. I'll let Luis weigh in here as the Modules
> maintainer, though.

Technically every contributor to the file has a copyright entry added,
one does not need to add the name to the header, that's just common
practice though. If someone goes through the work of at least adding
the name of the main author, that a nice effort. Tons of files don't
have authors listed, so I'd be fine with that too and it keeps things
simple. What we should not do ever is remove the copyright notice so
code which Rusty wrote should be maintained with the notice.

  Luis
