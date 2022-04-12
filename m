Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C104FE7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358624AbiDLSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiDLSNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:13:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4ED22B3E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649787053; x=1681323053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dDaXrLDw4lgEJumSnzdhY5w+I+hBHbc9J2e6IHG1N5I=;
  b=GYtX0mqd5+rDtA/ePNumTS/+VPRIBQXh6aZDyaMbpzmB5b85+RjeyIoh
   PW8h0pSs4ReixYZqNIhE2T1fqtEOHLkTCX+rbzOqsrY6UEJIYiWE4Ks/S
   GJhVROzwgqdDrJIHsDePuvYZxqQ2xyZWZ80fPhq5X4RhkyAaUr864YEUn
   lsv6NDG3ilYCmVGxCVYuhq1uaLCcCpbfGxLt/hYVAIaJpq9beK3ghue+l
   IhpFa6F1UoATrSVe1o1oPyPnqb0Od7t+hvG5fQoOfijQInEWpYaxaKFXn
   NYbCLNGSBObCvJFGvIEXTH1y3A0TZWpMoKf6Rzfa9vjVnkjOv4q2aIrag
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="348904094"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="348904094"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 11:10:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="526605347"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 11:10:29 -0700
Date:   Tue, 12 Apr 2022 11:12:25 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 3/3] staging: vme: "drivers/staging/vme" tree cleanup
Message-ID: <20220412181225.GC1236898@alison-desk>
References: <cover.1649721450.git.codeagain@codeagain.dev>
 <142698e3761c1e7ba8b17cdd9dc077472ef81668.1649721450.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142698e3761c1e7ba8b17cdd9dc077472ef81668.1649721450.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 03:58:25AM -0300, Bruno Moreira-Guedes wrote:

> [PATCH v2 3/3] staging: vme: "drivers/staging/vme" tree cleanup

Only the commit msg again ;)

staging: vme: Move drivers/vme to drivers/vme_user

I think that's the whole point here.

That's all!

snip
> 


