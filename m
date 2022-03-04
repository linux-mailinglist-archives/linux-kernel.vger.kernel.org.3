Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9E4CD443
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiCDM3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiCDM3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:29:32 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778EA76672;
        Fri,  4 Mar 2022 04:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646396924; x=1677932924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=po1qEIPBx+LHNA5JD0QMTNVIPUOOEPZ9s5Y5DQOpUQU=;
  b=HMbqyRL9adUEksLKPXp5gvikSGDkuFh5AxztPBrlM2mZisTqK+KV59IJ
   6RECqcNX44JMgyC9uprPFlygdas0dWjUBnh+lXmniLKcaSaOPF/MAMgFJ
   ySXqt7tZSMYMyXPqQ0jcAAQvZeVdwOamdf7VdVDcw29ssgzAV6wukfsRa
   YxbgHRH2qxDRxzo0kW229myfnVA71mUcdU0O0h94eMx3U5C8id6lVFRqV
   fBkf++TVsE6ZdMt7hrMymaIrclxNR+RoF9nR0awlg3W+KX/wCrxgGtG8Y
   lHU0Rsae5OWqtRCUas+2SAlQBFqnU+j9Z3+HEpKpjroL7QLN5AKdK0TdT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="314681017"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="314681017"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:28:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="686865242"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Mar 2022 04:28:41 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 04 Mar 2022 14:28:40 +0200
Date:   Fri, 4 Mar 2022 14:28:40 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <YiIF+PpuIeJMY+/T@kuha.fi.intel.com>
References: <20220223102353.3833578-1-xji@analogixsemi.com>
 <20220223102353.3833578-2-xji@analogixsemi.com>
 <Yh9dBlrWm3OicQWa@kuha.fi.intel.com>
 <20220303024757.GA4159259@anxtwsw-Precision-3640-Tower>
 <YiC+/ccRvR/+mAkT@kuha.fi.intel.com>
 <20220304022936.GA4164495@anxtwsw-Precision-3640-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304022936.GA4164495@anxtwsw-Precision-3640-Tower>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 10:29:36AM +0800, Xin Ji wrote:
> On Thu, Mar 03, 2022 at 03:13:33PM +0200, Heikki Krogerus wrote:
> > On Thu, Mar 03, 2022 at 10:47:57AM +0800, Xin Ji wrote:
> > > On Wed, Mar 02, 2022 at 02:03:18PM +0200, Heikki Krogerus wrote:
> > > > Hi,
> > > > 
> > > > This does not apply on top of Greg's latest usb-next branch. You need
> > > > to rebase this. There are also a few more nitpicks below.
> > > 
> > > Hi, I didn't found tcpci.h in include/linux/usb/
> > 
> > I'm asking you to create the file.
> > 
> > So create a separate patch where you move the register definitions and
> > command definitions from drivers/usb/typec/tcpm/tcpci.h to
> > include/linux/usb/tcpci.h
> Hi heikki, I'm confused, do you mean move total tcpci.h to
> include/linux/usb/ directory or just move our driver patch used register
> definitions and command to "include/linux/usb/tcpci.h"?
> 
> And I think the other way is, our driver patch just include
> "tcpm/tcpci.h" is better(no need to create new file). What do you think?

I would prefer that you just introduce the global header for them.

thanks,

-- 
heikki
