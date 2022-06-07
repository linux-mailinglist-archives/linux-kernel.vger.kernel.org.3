Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B58553FE70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiFGMLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiFGMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:11:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C7F939B1;
        Tue,  7 Jun 2022 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654603911; x=1686139911;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5C7CfW0dtrkUf/MoF676vs+y4VS7zCv2dMbSOjoDLDk=;
  b=Yj4Xcu6QHhlfiVeHAmDrY9EPImvVwh4uDcVwH/ZgdIfSZ/QabCBGwI9U
   TN19Q0kwaKpVkZ9PtkE3SINID9zfjeOxRpO9Q4Z5pIyCUIOrymY/jwcyq
   QBtFsp8Jug6I8HsC+kTk5+DMqenyxFu5ftX6E4643cb/LV8ww6AmDcVpj
   0TdEUC1wKWJmLBF+HgT9JDvU7hTuIlA+5UrIsiNFLWtC4rrjzaZC31G1Y
   ZZPYbOUdBtxnfbpoyo1Wn+fKL59qtPRqdpLceecstVr1rEdp7ni3lN2cc
   HK+HVFiIChp1C6dt5FjigIQCRwabYF6oUSHc1bhVG2QI1jmUjZi3hPvA4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="265110408"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="265110408"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 05:11:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="636100388"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 05:11:34 -0700
Date:   Tue, 7 Jun 2022 15:11:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] serial: 8250: Adjust misleading LSR related
 comment
In-Reply-To: <CAHp75VfK4v15HrBwwD9b7q6EYdcp3VnP5RGKVuPeSWk4TSyq+w@mail.gmail.com>
Message-ID: <e22db21a-cfc3-b7e4-3fd9-6cee9e189213@linux.intel.com>
References: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com> <20220607082934.7242-5-ilpo.jarvinen@linux.intel.com> <CAHp75VfK4v15HrBwwD9b7q6EYdcp3VnP5RGKVuPeSWk4TSyq+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-513457002-1654603896=:1622"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-513457002-1654603896=:1622
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Andy Shevchenko wrote:

> On Tue, Jun 7, 2022 at 11:16 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> 
> > only flags which were not handled). Adjust the comment to match
> > behavior and warn about which flags can be depended on.
> >
> > While I'd have moved LSR read before LSR read and used serial_lsr_in()
> > also here but I came across this old discussion about the topic:
> 
> >   https://www.spinics.net/lists/linux-serial/msg20555.html
> 
> Can it be transformed to lore.kernel.org link?

Unfortunately no, AFAICT. I tried searching but I couldn't find one 
from there (In fact, I tried even before submitting them because you 
previously told me I should use lore links instead).

More importantly though, it seems that the link was not the one I was 
supposed to use (I probably copy pasted the url from a wrong window while 
investigating all turns of it). This is the correct link:

  https://www.spinics.net/lists/linux-serial/msg16220.html

> and maybe even moved as BugLink tag?

What's BugLink? Our documentation isn't particularly helpful:

$ git grep BugLink
scripts/checkpatch.pl:              $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
$

...It seems mostly about bug trackers such as bugzilla, etc. based on git 
log so that tag seems not relevant.

I put the correct URL now into Link tag.

I'll resend tomorrow to give the dust some time to settle.

-- 
 i.

--8323329-513457002-1654603896=:1622--
