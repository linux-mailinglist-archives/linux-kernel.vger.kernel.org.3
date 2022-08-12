Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C47F59160F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiHLTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHLTnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:43:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6FB284C;
        Fri, 12 Aug 2022 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660333391; x=1691869391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xqK/+icunJCZt2VI8tuzs8qaXCK4YP5dQGeyPsd/HYA=;
  b=O/iS0YN//9zZfXhB/RihAZDn94qEfVVqkZayG5Cl47tnNGzvdmLeNNdM
   2d059jubx+lY75sthQeCLg9EomTbRTZr0inHOqsmvdiNI6eSITMm0C2qr
   8hwQmJsIefwb76dCi1F8ZQOUV6RDdLtVxJSqaR1SMF96cfhUE7eVN8Cna
   kiWNzn2rsJSsTCZQ70nW7nPmQujK5UWn/Ho4HtUdmEM7svuhZHOb9PwwQ
   e1NB0uQdpuCX110R1zqkr4X+D2JGpHur5DW34jm5YyDm1W5pjVNsqpdFM
   z7z5xHdU0IMgmJrks+FWMDi7k5GEl7iYowOrx1NMfUesFwdHFXQkBXx5C
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="377966326"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="377966326"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 12:43:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="851672941"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 12:43:08 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B962B20371;
        Fri, 12 Aug 2022 22:43:06 +0300 (EEST)
Date:   Fri, 12 Aug 2022 19:43:06 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ACPI: Property: Fix type detection of unified integer
 reading functions
Message-ID: <YvatSoqXEtI7oqUO@paasikivi.fi.intel.com>
References: <20220812130645.14710-1-sbinding@opensource.cirrus.com>
 <YvatIg1ywD5EkxTk@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvatIg1ywD5EkxTk@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 07:42:26PM +0000, Sakari Ailus wrote:
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Should have been:

Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
