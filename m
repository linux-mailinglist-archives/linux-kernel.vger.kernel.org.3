Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE32571897
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiGLLcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiGLLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:32:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3699C279;
        Tue, 12 Jul 2022 04:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657625545; x=1689161545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eyKlkKRUb/bfXr6lL9b0D9L6TwSjNtrZFvzJIx/FLHQ=;
  b=LHH9cG5RWNP18fgMxRmluBtHr/sBL+eEBZSxbJQnsjXx87HsNxfr0gmM
   ZBf/VOKXYuUAvrR8EzBdQcZf68Pe0IYW1bHTXPRmq7tQmkX1l+DG3g6Dn
   7xgJiw5SyyrlEctUUkFKJiya9m/tqCuEoVVBMta92WnCncb0t5y2U5qYy
   0Ee4g8lvFjd+FPTDwVc4H6JDPrd8wUoWCrOEPb0Ljc+uF+FgL5SVYGZZo
   A27n5mz5Zl2/wg6UAOF5ThnsbcSzvVtM5hrJE/BjGY7QHNX/k9Z4E7VD2
   Vr9WhrNqlL8GbjWd5LRhY0Bm2cNcEkJ8t115aFQdq/0VWy/x+HKyQKlu0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283662020"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="283662020"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:32:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="622472632"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:32:21 -0700
Date:   Tue, 12 Jul 2022 12:32:14 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vladis Dronov <vdronov@redhat.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 1/3] Documentation: qat: Use code block for qat
 sysfs example
Message-ID: <Ys1bvhGnpz+GiJCB@silpixa00400314>
References: <20220712092954.142027-1-bagasdotme@gmail.com>
 <20220712092954.142027-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712092954.142027-2-bagasdotme@gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:29:52PM +0700, Bagas Sanjaya wrote:
> kernel test robot and Stephen Rothwell reported htmldocs warning:
> 
> Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.
> 
> The warning isn't caused by Date: field pointed by the warning, but rather
> by sysfs example that isn't in literal code block.
> 
> Add the code block marker.
> 
> Link: https://lore.kernel.org/linux-next/20220711204932.333379b4@canb.auug.org.au/
> Link: https://lore.kernel.org/linux-doc/202207090803.TEGI95qw-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: d4cfb144f60551 ("crypto: qat - expose device config through sysfs for 4xxx")
> Cc: Wojciech Ziemba <wojciech.ziemba@intel.com>
> Cc: Adam Guerin <adam.guerin@intel.com>
> Cc: Fiona Trahe <fiona.trahe@intel.com>
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Vladis Dronov <vdronov@redhat.com>
> Cc: Tomasz Kowallik <tomaszx.kowalik@intel.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

-- 
Giovanni
