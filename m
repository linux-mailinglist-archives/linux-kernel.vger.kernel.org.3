Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F058655B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiHAGr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiHAGrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:47:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE3B4B3;
        Sun, 31 Jul 2022 23:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659336317; x=1690872317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cbqXcDjp4IBB8KsWVje8p2Ad+jjJ0kLCJwU06mgi6Z4=;
  b=LHF4HuYLXytjwY/cWGpyOVbf+Ly60vBhkG+wbJvkg0k3FumDyAYEj7hT
   YT5RLX9osV1Gb7IZ0eevMdCVI5Eu5+ch4sOwVE49NJCVb/2GIBrJ8whya
   amZJOk7Kec72Qo8pZbR2pEW97vRm1HiKH4fC2t8gmVjYExpTicZ8nHgVI
   sMFRHFVI7eTLlLZ3GabMh/WA/CTO+TKPM+1uUIAjOn8E+LDwyk0HW87+F
   qpc3ZgQehXTj+C9Qu8iFxubo6PjIePNGK2fGFSrPTDKyMkHrLeEOIiUlO
   elf/m6CsRQ9fem7QtOti2Bs+k8bpgecTF+UDp7NF74+liwGFG1uuXFVZ6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="314897901"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="314897901"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 23:45:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="552410211"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 23:45:10 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id F071A2019B;
        Mon,  1 Aug 2022 09:45:07 +0300 (EEST)
Date:   Mon, 1 Aug 2022 06:45:07 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] media: atomisp_gmin_platform: Unexport and split
 camera_sensor_csi()
Message-ID: <Yud2cwiCCnq4x50L@paasikivi.fi.intel.com>
References: <20220730162027.1011-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730162027.1011-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 07:20:27PM +0300, Andy Shevchenko wrote:
> The camera_sensor_csi() is not used outside the module, hence make it
> static. While at it, split it to _alloc() and _free() to clearly show
> the idea behind the last parameter @flag that is passed to
> gmin_csi_cfg().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
