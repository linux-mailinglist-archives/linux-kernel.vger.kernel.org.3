Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE74EB508
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiC2VID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiC2VIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:08:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5651890D8;
        Tue, 29 Mar 2022 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648587977; x=1680123977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RzJHCbmjmJfFhs4f7385Z702T3TtRLJI9GtPCkU8DNQ=;
  b=QQ6gNiijkf3gbD1pRradtdpoxbCjKQUQ87/9+x4n09SuzvRBSSNg+i0I
   0Y8MOrXCd3/nqTUgB/oVMt+AXH3Dq8zBMQ0RsEYstqQ7Ich3MtJkZEYxg
   1fYJZyqV9IUnEkXbOu4LZAadF0wl5I1KHeq9mDd+FyX6mo15Wf9jBnYSs
   lU0maXYJ9VUUUUTGjfhDjuYb2f3mJKC9fI7x2JBQIdrOD+/chjQfdVeM3
   3rWEeoDWs78UJLTZXr4qd9GQCkgUGeseR+CFaF6wiAHEmqNhU7QbTfd1N
   DXx2XqAgw3Isg4KOGNu2sWSZY5mIZ1gFG9YdgVVdLaBb3jGVoKhATphqF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284276897"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="284276897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 14:06:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="653283314"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 14:06:13 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 3CAD6203C9;
        Wed, 30 Mar 2022 00:06:11 +0300 (EEST)
Date:   Wed, 30 Mar 2022 00:06:11 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     trix@redhat.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, hverkuil-cisco@xs4all.nl, vrzh@vrzh.net,
        tomi.valkeinen@ideasonboard.com, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] media: staging: atomisp: rework reading the id and
 revision values
Message-ID: <YkN0w5NxLcBFes1b@paasikivi.fi.intel.com>
References: <20220326191853.2914552-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326191853.2914552-1-trix@redhat.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 12:18:53PM -0700, trix@redhat.com wrote:

Hi Tom,

It seems that somehow the Content-type header of your patch  is
application/octet-stream. I.e. not text.

-- 
Sakari Ailus
