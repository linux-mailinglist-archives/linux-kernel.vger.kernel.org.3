Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8D5AFC3D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIGGOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiIGGOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:14:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522779DFB3;
        Tue,  6 Sep 2022 23:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662531243; x=1694067243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tKD7dcQrTgQ5yRktwcwRD+zn41Oh2clj3ui4dG0kocA=;
  b=CvNbLaMNMMFv77f/fZyjX2jd4dpRnZPFm6MR9rRcFkVHYOHYfvcLEbnO
   gF5qElYss/DzHfGZFjiyzPSkc62pxHA50t3X0gI9hd/pImK9dhnj+3V+K
   viXKNgGZC4vRnzdbMvbmzbQpyd9OLMzLJugQGENCfGH6/jPbOKK+1Ojp4
   qvr4J6hxIoQTrZRwmv/C1P4WPLVPBRMrPJfNKc9slvw5OnUkOKbSgWdZ+
   jRVro7tBAyHBxz/HXjr8LsqAlwSm4FYx8d0sGnujAexmdhBVzOWzz0uDT
   fcE+acLoEuD4Qa1iAPhWUGzj8GLPjzxGKKRMO5qcPSNLUuURgDhu34VjK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="295525532"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="295525532"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 23:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="676034182"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 23:14:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1524BF7; Wed,  7 Sep 2022 09:14:16 +0300 (EEST)
Date:   Wed, 7 Sep 2022 09:14:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] thunderbolt: debugfs: Fix spelling mistakes in
 seq_puts text
Message-ID: <Yxg2uHEBdwMkbbBI@black.fi.intel.com>
References: <20220906140314.194565-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906140314.194565-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:03:14PM +0100, Colin Ian King wrote:
> There are a handful of spelling mistakes in seq_puts text. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to thunderbolt.git/next, thanks!
