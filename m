Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7757C4EBED1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245398AbiC3KfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbiC3KfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:35:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB54F260C59;
        Wed, 30 Mar 2022 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648636399; x=1680172399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kunbQGKDVh2bu6wOq3lgIjbrLwadGT8XyosrnqASPBE=;
  b=XSjn8y8+foR1neglhfSDLPSfiKUxsm1wzGyRgkOwkRukrJr4JHDh9/sK
   O3GoizFcPgEBO49Rq7MftWlHCpfyu11v8hG2Zm6u0jiLFyq4AiZLO67SC
   UZF33RC3n7+m2g98dmZmq7fxhL5FOPYHVwSeovgT3jqbOelty+KHVPjbY
   jWjmALCz+ZBzGXG6Mfzbo6njJcnabxqm8OK+ObHGRqexbK+xVKGXqAbUF
   Dp72qASbw451RERqfOmrnCUE/zW23IK/XALD2Hm1YQDZO4AAkydew17D9
   Vc5NTRFU4mn0Zn1+yB6p+fAIqGM0YCtL2M1W7jBZSRwSosk/EKN8EHEMB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="239440158"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="239440158"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 03:33:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="618484605"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 03:33:16 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 9D1EA203C9;
        Wed, 30 Mar 2022 13:33:14 +0300 (EEST)
Date:   Wed, 30 Mar 2022 13:33:14 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, hverkuil-cisco@xs4all.nl, vrzh@vrzh.net,
        tomi.valkeinen@ideasonboard.com, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] media: staging: atomisp: rework reading the id and
 revision values
Message-ID: <YkQx6jk5V2/f5mye@paasikivi.fi.intel.com>
References: <20220326191853.2914552-1-trix@redhat.com>
 <YkN0w5NxLcBFes1b@paasikivi.fi.intel.com>
 <2ab474d8-ee4e-44b5-ab3c-38b72135a27f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab474d8-ee4e-44b5-ab3c-38b72135a27f@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, Mar 29, 2022 at 04:21:20PM -0700, Tom Rix wrote:
> I'll do a resend.
> 
> I use git send-mail, sooo not sure what went wrong.

The resent patch also has the same Content-type. I looked a bit further and
it seems that this is very probably added by our mail system somehow: it's
not present on the patch I received through a different route. Weird.

git format-patch only seems to add the header sometimes based on some
obscure criteria. It's the first time I see such a problem. It'd at least
help if the Content-type would always be there but that's certainly out of
scope of the patch.

-- 
Regards,

Sakari Ailus
