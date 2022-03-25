Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B884E6C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354034AbiCYCRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbiCYCRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:17:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F068AC077;
        Thu, 24 Mar 2022 19:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648174540; x=1679710540;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o4sz/LKzGpYOK1X2HGP165kUrHUS9uWa1kxmjabLul8=;
  b=KpLspLNqq4uUqa4thGGhgtILVofx4Ggwkbp1igLcTw2Aiz2LTOMC8E9o
   q5PDf9tyzmsVhkgBBazjR88LW5TfxVGHXoKgarZaYzdYXlMv/jW558TPo
   gDGP3ybCYhI1wUhty+/WljySyvpAl5+n9w4mwBjtYP3lvH+OfgygK9E04
   SA3QI3lAMyqui4wGJDEqX188vGhGtfmY7m19E4b7isvkSmWqjOYGwwN5n
   ifrCfW4p1pQHCTcM4be6tQb+oZAdLpCh6SrbXZZ3JDcuROFXZz/xxJKus
   Slv8My/ByOWPqLGYsduuRa6WOUe9EdmCFUxXVtsTGPNnDNPSyk+o9y6fC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="238475911"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="238475911"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 19:15:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="561639626"
Received: from sijiali-mobl1.ccr.corp.intel.com ([10.255.28.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 19:15:37 -0700
Message-ID: <1c5b8eb88d8c59949a6bbd3e763c820db462979f.camel@intel.com>
Subject: Re: [PATCH 0/3] thermal: int340x: Misc acpi_buffer handling updates
From:   Zhang Rui <rui.zhang@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Mar 2022 10:15:34 +0800
In-Reply-To: <20220324190950.70486-1-dave@stgolabs.net>
References: <20220324190950.70486-1-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Zhang Rui <rui.zhang@intel.com>

for the whole patch series.

thanks,
rui

On Thu, 2022-03-24 at 12:09 -0700, Davidlohr Bueso wrote:
> Hello,
> 
> The following is a fallout of eyeballing _OSC handling in the driver.
> These changes have only been compile-tested. Patch 1 is a fix and the
> other two are cleanups.
> 
> Thanks!
> 
> Davidlohr Bueso (3):
>   thermal: int340x: Fix bogus acpi_buffer pointer freeing
>   thermal: int340x: Consolidate freeing of acpi_buffer pointer
>   thermal: int340x: Cleanup osc context init
> 
>  .../intel/int340x_thermal/int3400_thermal.c   | 24 +++++++--------
> ----
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> --
> 2.26.2
> 

