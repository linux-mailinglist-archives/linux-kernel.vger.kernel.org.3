Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6876F57CBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiGUNTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiGUNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:19:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2679D7AB30
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658409568; x=1689945568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1CPphQOFIKtOVzHA2NLW7txYk6ZS97cH/ky6dO4dyvA=;
  b=G3hep9FKHKeKFk7QMo6LENcv0whb+2cBVry2QtiOhy35F/0n48q5bncH
   9ryBThg40lVYP5sQ92hE9ecJ1VZGUCqr65dFGVgzn0SUgXWXQjrkIH8Zk
   MjRCgt9cHvnAvDKsyOeQ0qILrao2S5Ks3loposq+uyaqr7awSnUkNOFhx
   8ICxhOKzTBpCjSvdV/Fg4voeXK7kDXDh5cgbfLpSG0LnQFFHR75/o/Mk1
   ikcJOP2EnDGFoqV2oV9I4KlcChplb01DqkmI/sHXoDSoPaKGb2QXHD0XS
   ZjSaBtv18Z+M1y111N/kmAR4aaB1VPDLLrt/U3GasVRqSEun9xqbjkNzb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287050467"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="287050467"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 06:19:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="656739520"
Received: from mstrobel-mobl.ger.corp.intel.com (HELO intel.com) ([10.251.210.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 06:19:22 -0700
Date:   Thu, 21 Jul 2022 15:19:15 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Jason Wang <wangborong@cdjrlc.com>, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, John.C.Harrison@intel.com,
        matthew.d.roper@intel.com, matthew.brost@intel.com,
        zhou1615@umn.edu, michal.winiarski@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/selftests: Fix comment typo
Message-ID: <YtlSU5uOoGokdKjs@alfio.lan>
References: <20220716040520.31676-1-wangborong@cdjrlc.com>
 <YtlPxPZ/BWATWL1J@alfio.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtlPxPZ/BWATWL1J@alfio.lan>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Jul 16, 2022 at 12:05:20PM +0800, Jason Wang wrote:
> > Fix the double `wait' typo in comment.
> > 
> > Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> 
> Few warnings for this patch:
> 
>  1. you missed Rodrigo's r-b tag.
>  2. please add a counter to your patch, this would be [PATCH v2]
>  3. please add a changelog, as this is a single patch, do it
>     after the '---'
> 
> No need to resend, just keep the three notes in mind for your
> next patches. Anyway, thanks for the fix and as I am at it:
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Pushed in drm-intel-next.

Thanks,
Andi
