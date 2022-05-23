Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DD531941
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbiEWSdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbiEWSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:33:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D7F134A;
        Mon, 23 May 2022 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653329261; x=1684865261;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xO9+Il1COuI9460Hv2AB+G62aauLLV09YgyaLPckxgE=;
  b=Vp1hZYYg27RvoLTD3VYUiXcI55o0Qu1X/DQkWtH/TvjDMW/dMHVcoysw
   jj5QJJpPFXgTAxkGDDsQV0oQFImYmjNFf4/fO0Ev0vZ1U5M9uwduEZdZH
   Xw+E3fGDqwdh69fojk3mKd/2wTl0t6h3GD1qFkPldyO5u/YGphO62SH6b
   nwwkyar8wN8rgjx2bzO3Qn5g8eGZAfHZlmN87mEbq1Q4ftob14UFvZv6k
   uPin5boCUxmYIzxyOUFwafcwvWGuP14gP8KCxCzUQlb+2nwZu5Z0THyKk
   tV183/VQLqu1rhj0StcOC2EnFax4iBNiv1z0oRxDFDZ/E9yq64v1Pf7yJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="253183301"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="253183301"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:00:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="572227817"
Received: from ijgarcia-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.152.3])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:00:29 -0700
Message-ID: <19189e1c806bf812e41a400e826c5e23892900e0.camel@linux.intel.com>
Subject: Re: [PATCH] Documentation: admin-guide: pm: Add Out of Band mode
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, rafael@kernel.org,
        hdegoede@redhat.com, markgross@kernel.org
Cc:     lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, prarit@redhat.com
Date:   Mon, 23 May 2022 11:00:29 -0700
In-Reply-To: <871qwkb0rn.fsf@meer.lwn.net>
References: <20220523172757.2351052-1-srinivas.pandruvada@linux.intel.com>
         <871qwkb0rn.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 11:46 -0600, Jonathan Corbet wrote:
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
> 
> > Update documentation for using the tool to support performance
> > level
> > change via OOB (Out of Band) interface.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> >  .../admin-guide/pm/intel-speed-select.rst     | 19
> > +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/pm/intel-speed-select.rst
> > b/Documentation/admin-guide/pm/intel-speed-select.rst
> > index 0a1fbdb54bfe..4146a2da35ea 100644
> > --- a/Documentation/admin-guide/pm/intel-speed-select.rst
> > +++ b/Documentation/admin-guide/pm/intel-speed-select.rst
> > @@ -262,6 +262,25 @@ Which shows that the base frequency now
> > increased from 2600 MHz at performance
> >  level 0 to 2800 MHz at performance level 4. As a result, any
> > workload, which can
> >  use fewer CPUs, can see a boost of 200 MHz compared to performance
> > level 0.
> >  
> > +Changing performance level via BMC Interface
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +It is possible to change SST-PP level using out of band (OOB)
> > agent (Via some
> > +remote management console, through BMC "Baseboard Management
> > Controller"
> > +interface). This mode is supported from the Sapphire Rapids
> > processor
> > +generation. The kernel and tool change to support this mode is
> > added to Linux
> > +kernel version 5.18. To enable this feature, kernel config
> > +"CONFIG_INTEL_HFI_THERMAL" is required. The minimum version of the
> > tool
> > +is "v1.12" to support this feature, which is part of Linux kernel
> > version 5.18.
> > +
> > +To support such configuration, this tool can be used as a daemon.
> > Add
> > +a command line option --oob::
> > +
> > +# intel-speed-select --oob
> > +
> 
> This suggests you haven't actually built the documentation with your
> change and verified that you got the result you were after.
You mean I should print the result with the command? Something like
this:
#intel-speed-select --oob
Intel(R) Speed Select Technology
OOB mode is enabled and will run as daemon


>   Literal
> blocks need to be indented.
I will submit v2.

Thanks,
Srinivas

> 
> Thanks,
> 
> jon

