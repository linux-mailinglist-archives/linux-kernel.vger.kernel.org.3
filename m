Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC557189D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiGLLd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGLLd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:33:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B80057258;
        Tue, 12 Jul 2022 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657625606; x=1689161606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9e2S1yxz21rcIUCI6zCHSIHuKntXwSgqdeovCsE0SB0=;
  b=C7ILR7O82n1rZWSlT38JHHDjWMec1okenIQS6S5Xo+aXKC8NA+zXpFgN
   VocUNJdtvxwBHH2IV733cBCii9qYk5WPbkXXSpotPZp+3TLmARD1VX9xN
   E/6Kd8sLn8YLG3ao9oSWoN3Qf5unUQNCPYVx5KZjUE4SX4prCioa2iwmO
   4KZw7uMk0tezd0MfplAbRvT9R2JX6VOiZasuH4XGTsHL6y58HM8llZcda
   fhMvroHyCRfSspALDLA6SfJUFdSVA8uYYI0IbLidTl9M8Cv6WsnpIjCWO
   O7qR0p1025evyKfT3M0tluuAT2CKYMfDa4RcEz9f0OGnUCE0PGFl5lJPU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310524582"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="310524582"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:33:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="684741482"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:33:23 -0700
Date:   Tue, 12 Jul 2022 12:33:20 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Adam Guerin <adam.guerin@intel.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] Documentation: qat: rewrite description
Message-ID: <Ys1cAIxILX3nboqq@silpixa00400314>
References: <20220712092954.142027-1-bagasdotme@gmail.com>
 <20220712092954.142027-3-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712092954.142027-3-bagasdotme@gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:29:53PM +0700, Bagas Sanjaya wrote:
> The sysfs description contains redundancy on returned and allowed values
> list, due to the described sysfs is read-write. Rewrite.
> 
> Cc: Adam Guerin <adam.guerin@intel.com>
> Cc: Tomasz Kowallik <tomaszx.kowalik@intel.com>
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Wojciech Ziemba <wojciech.ziemba@intel.com>
> Cc: Fiona Trahe <fiona.trahe@intel.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

-- 
Giovanni
