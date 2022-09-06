Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEAB5AE80E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiIFM0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbiIFMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:25:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8C47D1D9;
        Tue,  6 Sep 2022 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662466926; x=1694002926;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ac6/ZnvaxotntCoR53/68zz+h1Omy7csO+/TGUoEwRk=;
  b=ILePcFT87MFjbQYIc4Fg+yotJFKziyUrAacYO0YwPD9TbpgXZEi6qetn
   LL07rUgA7GnklYtBaKMWnxqTwS6qYObMukWvLAoZC40X5hn6ILHjWpRUN
   NrLhYjwzj/R3z+UETYUi1AofOw30yZ+nx7Z9EELnvj6/y9qPocC0BAxLh
   bKEOZhmFT/91CETFiGUK67V3Iut2gdgELMzeGy/l75ulO9q3p1L1gXgHb
   NIUfUaDpvtiayhtpFDctcRdzsJzdaPnByTc7GSwLqN9SCtjiryB3astne
   WXe0cE0H3xzgP/FsPJWhJeT43PBg5XS384X8/aOMBxcE/zJy6a9R5Hq50
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="360526721"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360526721"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:21:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675668300"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:21:42 -0700
Message-ID: <030ca8bc8258a4edc1aef23b077f9b4463b24639.camel@linux.intel.com>
Subject: Re: [PATCH linux-next] tools: power: x86: intel_pstate_tracer:
 intel_pstate_tracer: Replace the relative path of the called grep with an
 absolute path
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>, cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, xu.panda@zte.com.cn,
        ray.huang@amd.com, rafael.j.wysocki@intel.com, Jinzhou.Su@amd.com,
        Zeal Robot <zealci@zte.com.cn>,
        zhanglin <zhang.lin16@zte.com.cn>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Tue, 06 Sep 2022 05:21:42 -0700
In-Reply-To: <CAAYoRsUFF=ebThB3gKUw2G1G2HO_HmBXvd-+XiwYtiKpJ41zqw@mail.gmail.com>
References: <20220829125447.268741-1-xu.panda@zte.com.cn>
         <CAAYoRsUFF=ebThB3gKUw2G1G2HO_HmBXvd-+XiwYtiKpJ41zqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-09-04 at 15:23 -0700, Doug Smythies wrote:
> Note: Modifying the address list a little with this reply.
> 

Subject can be "Use absolute path for grep"

> On Mon, Aug 29, 2022 at 5:55 AM <cgel.zte@gmail.com> wrote:
> > 
> > From: xupanda <xu.panda@zte.com.cn>
> > 
> > Using absolute paths when invoking grep can lead to serious
> > security
> > issues. 
I think you mean 
"Not using absolute path when invoking grep can lead to serious
security issues"

Thanks,
Srinivas

> > A malicious operator may create a new file named grep in the
> > PATH before the real grep file. When the program executes and calls
> > grep, the fake grep file will be executed, so that the malicious
> > operator can execute arbitrary code or even obtain root privileges.
> > Using absolute paths when calling grep avoids this problem.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: xupanda <xu.panda@zte.com.cn>
> > Reviewed-by: zhanglin <zhang.lin16@zte.com.cn>
> 
> Acked-by: Doug Smythies <dsmythies@telus.net>
> 
> > 
> > ---
> >  tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++-
> > -
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git
> > a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> > b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> > index b46e9eb8f5aa..d6fae6e51d30 100755
> > --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> > +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> > @@ -348,8 +348,8 @@ def split_csv(current_max_cpu, cpu_mask):
> >      if os.path.exists('cpu.csv'):
> >          for index in range(0, current_max_cpu + 1):
> >              if cpu_mask[int(index)] != 0:
> > -                os.system('grep -m 1 common_cpu cpu.csv >
> > cpu{:0>3}.csv'.format(index))
> > -                os.system('grep CPU_{:0>3} cpu.csv >>
> > cpu{:0>3}.csv'.format(index, index))
> > +                os.system('/usr/bin/grep -m 1 common_cpu cpu.csv >
> > cpu{:0>3}.csv'.format(index))
> > +                os.system('/usr/bin/grep CPU_{:0>3} cpu.csv >>
> > cpu{:0>3}.csv'.format(index, index))
> > 
> >  def fix_ownership(path):
> >      """Change the owner of the file to SUDO_UID, if required"""
> > --
> > 2.25.1
> > 


