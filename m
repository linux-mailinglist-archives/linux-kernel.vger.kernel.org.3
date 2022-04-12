Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E385E4FE7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358605AbiDLSJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbiDLSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:09:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE854CD5C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649786857; x=1681322857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KAG5O+Uw+D2QHrHyu7UtILoUVvKnaKhfn+G8WwPaG38=;
  b=EFy/kufGybwAw57fsQQCOU3+yzsc2rW8KW/CLUw8aAWx0bnd+uWorh8S
   MA1COXFKhmn7lbPX1Hz6tQ7yD3E1hPx4PxFH0l6KgRw9Qn9JJcc+R0Uan
   xCzvG9w2/GnJze23olEK1qeAWkGewPOVlicF92dGc2g0cZctqErE5yklR
   ifCAMyEsRAIjlzAz+dYwiSYxkfG7gBevasL6rpGPEjanZzZ/TTRqirBWe
   s67DnExLpyfRUZVSj92Y/3LfjiNxuMGX97m1FUIdsLl3+TFL8JhaKJPQy
   +o1NYAvwq3FbVKPM6ZbAHrE4+W3FyJmEVrdh8deeBlClv+j4Gkcyp35AG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="260061244"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="260061244"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 11:01:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="526600127"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 11:01:53 -0700
Date:   Tue, 12 Apr 2022 11:03:50 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 2/3] staging: vme: Fix missing `depends on` at KConfig
Message-ID: <20220412180350.GB1236898@alison-desk>
References: <cover.1649721450.git.codeagain@codeagain.dev>
 <aab0591ac73a54059621c722a63635d43a446fd2.1649721450.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab0591ac73a54059621c722a63635d43a446fd2.1649721450.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 03:56:43AM -0300, Bruno Moreira-Guedes wrote:

> [PATCH v2 2/3] staging: vme: Fix missing `depends on` at KConfig

Be direct in the commit msg. Perhaps -
'Add 'depends on' VME_BUS to Kconfig'

That's all!

snip


