Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5305F5B1DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiIHNC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiIHNCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:02:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B21DB99CF;
        Thu,  8 Sep 2022 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662642172; x=1694178172;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=bYJujfPS+g+aa34Nnzz9+iwWbbOaoF9iNefXjiuxe/0=;
  b=FlUgaLENoZrqTIgmc8DF36grfcAxqicM/hB7OcY477u6ahcmfgr+rA6y
   rm/6CAU3gvlZ6K/Z6r9j0/iuTO2IiGO/kaenNq116auu6szZsYz5lbfFn
   tm6B191LIqScVv4nOqIe4rE5MwRqOudDUR+FT3hnOLroq8pV3Hs+NpWIn
   oPb8ZR+nmK9hXKTRN4yThVQvAcoJNUMrU6fJfd4ttqdmDt/E9kBME6mxs
   sBOTJDOFFILY4GlKCnYJkEQW6+t5gAIlvWmBrh6ay5kgVbBmF+X3oiMph
   GN3oSGSXcCgtQ4wFSb3oqc6cMAevrq+79uN5drJKFCEp0mqGN8igy70LS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297159500"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="297159500"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:02:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="592154862"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:02:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWHBA-00A8A3-1B;
        Thu, 08 Sep 2022 16:02:48 +0300
Date:   Thu, 8 Sep 2022 16:02:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Group cs_change and cs_off flags together in
 struct spi_transfer
Message-ID: <Yxnn+Puts9Bv2f+a@smile.fi.intel.com>
References: <20220908125444.30727-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908125444.30727-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:54:44PM +0300, Andy Shevchenko wrote:
> The commit 5e0531f6b90a ("spi: Add capability to perform some transfer
> with chipselect off") added a new flag but squezed it into a wrong
> group of struct spi_transfer members (note that SPI_NBITS_* are macros
> for easier interpretation of the tx_nbits and rx_nbits bitfields.

Besides some small issues with the grammar above, I would like also to
reshuffle the documentation part. Hence, please wait for v2 of this.

-- 
With Best Regards,
Andy Shevchenko


