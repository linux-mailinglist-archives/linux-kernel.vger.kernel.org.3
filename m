Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0889A58D75C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbiHIKXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbiHIKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:23:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A61A39E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660040608; x=1691576608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=99bJJBFxy4MkV4BgWrDoeaYr4KHpjKS2Iv7tuS49adw=;
  b=ObbiLIV264pGoLPUqKMsOv2CQeUQWvbUFsPx5ijp/b+pekqnM3w4CEst
   j0zKFwiWzrmkkkriEsHsBcgEZsuk1OinOX7/Dc7YiAvO0/Y3NhyULULg/
   lBFur2MWYESwEwlGFWsHwINhadd1qQc6kQGhz3LMQLAsv5MIsi/7WQHgH
   PKxGoCJcT2TZnzUabAD+5bfuv7GI+jIKVwZrqQUtOVfup6CpY/IjaufGD
   aCWVE2+dxDZ3/S42OhPxD/QJ2/jyBNniBUHDNHSuBUm4jY1JxSDmy4yhp
   rMlLwhexj+QWQ87QoDrd+DP/U0yQzWrS6A3W9wqVEmIKoei4GTo7IfvKI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="352532742"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="352532742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 03:23:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="731081953"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 03:23:20 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 09 Aug 2022 13:23:17 +0300
Date:   Tue, 9 Aug 2022 13:23:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YvI1lQh+C0SJiG73@lahna>
References: <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
 <Yu0nWro4xXURbSX6@lahna>
 <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
 <Yu4Gmkous7asng6h@lahna>
 <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
 <YvDcudE5BRtZAtfM@lahna>
 <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
 <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
 <YvEFtPF7SBIwNG/o@lahna>
 <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 08, 2022 at 09:27:24PM +0800, Brad Campbell wrote:
> If I don't authorize the PCIe tunnels and just leave the DP enabled it
> works fine also.

But you say that it fails on boot when the driver discovers the tunnels,
right? So there is really nothing to authorize (they should be already
"authorized" by the boot firmware).

If I understand correctly this is how it reproduces (the simplest):

  1. Connect a single Apple TB1 display to the system
  2. Boot it up
  3. Wait a while and it hangs

If this is the case, then the driver certainly is not creating any
PCIe tunnels itself unless there is a bug somewhere.

An additional question, does it reproduce with either TB1 display
connected or just with specific TB1 display?
