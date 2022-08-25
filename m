Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FA5A0F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbiHYLdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiHYLdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:33:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2A2AD9A5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661427220; x=1692963220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GwcZIZzJ3cjAlviejeflyVof5LVzCO69sURjMGdXh2g=;
  b=SW+bNCh8zAvtKcBREZ67rIjKfaR6X7rqLHoi/fU+4qeJhuDCZCAAP0+z
   jsIxihNtu/MC9ASrWnB3qGpAjPpsFbZI7iD6oS6s3R8CEo4SZx1VlnarX
   SdoZiGizgc/V9haaFj3XITMaEZ2R9n9Iev7/3WtAy1XM3A1AkAL+IvMhj
   L8PmJMs7Zveg0P2Tm+22dn9bSWsPMvRAYxBiz1BXhFEejd44Pah/zOpou
   DbRaQ0NDQ8SDvXtrc/BMcdpNkyh8MoLhpYRewx5QPihLnqE39Me+C8xGW
   BMF5ZFJWCj8BKGEsQuTr7Jwp92eRZmbRD6W74zwI/S/WR0PDm4N+Iuu0u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="277233772"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="277233772"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:33:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="785975052"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:33:39 -0700
Date:   Thu, 25 Aug 2022 11:33:45 +0000
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode: Remove ->request_microcode_user()
Message-ID: <YwdeGWuTOXVeOW6J@araj-dh-work>
References: <20220825075445.28171-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825075445.28171-1-bp@alien8.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:54:45AM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
>   181b6f40e9ea ("x86/microcode: Rip out the OLD_INTERFACE")
> 
> removed the old microcode loading interface but forgot to remove the
> related ->request_microcode_user() functionality which it uses.
> 
> Rip it out now too.

Nice, I had this in my cleanup pile too :-)

> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/microcode.h      |  3 ---
>  arch/x86/kernel/cpu/microcode/amd.c   |  7 -------
>  arch/x86/kernel/cpu/microcode/intel.c | 17 -----------------
>  3 files changed, 27 deletions(-)
> 
