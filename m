Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10904D8C08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiCNTFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiCNTFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:05:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C343205D5;
        Mon, 14 Mar 2022 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647284662; x=1678820662;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=PNzzvElMYhcdd3vhB6j7BCV76LtdDotevXpkmgFC8c0=;
  b=nj8vdvP5mLbw8zOAOtjA3puJaFBJmcc/4lvjZkKap5gVQL3eEmu/7ayF
   xZmL4c1M3y+k/NX/QyXZ7a1SvmXMXb7biHE+2zOI9Ubc/nik9PYR8z/4Y
   mkHUJ3ibaI9IK0gtuh3SP9NWCWQPKt9gG9kM4FGqIiMdIMcfIN6KiqMNN
   PWzwzO95IOhKWRxIkN9ceYwJDtFw5/2AobQtY9hWNvuVnaZSQBLHWTtC0
   OvKXZ74At1Za7oqKU/uuR9LHLj4aKGZJuvtUaH8p9xejwNi5o1v14cv9s
   mtfXtXIlmblUUa7HCC04fWqJJGWrq7y4LLLUlCNWZ5D++er19pxHAC1ox
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256074867"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="256074867"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:04:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515567652"
Received: from zborja-mobl1.amr.corp.intel.com (HELO [10.212.239.199]) ([10.212.239.199])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:04:21 -0700
Message-ID: <053f23ab-cc87-a313-d9cb-39d6c17a1a81@intel.com>
Date:   Mon, 14 Mar 2022 12:04:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v2.1 01/30] x86/sgx: Add short descriptions to ENCLS
 wrappers
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 01:34, Jarkko Sakkinen wrote:
> From: Reinette Chatre <reinette.chatre@intel.com>
> 
> The SGX ENCLS instruction uses EAX to specify an SGX function and
> may require additional registers, depending on the SGX function.
> ENCLS invokes the specified privileged SGX function for managing
> and debugging enclaves. Macros are used to wrap the ENCLS
> functionality and several wrappers are used to wrap the macros to
> make the different SGX functions accessible in the code.
> 
> The wrappers of the supported SGX functions are cryptic. Add short
> descriptions of each as a comment.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Jarkko, what *is* this series?  There's no cover letter, all the patches
look like they are from Reinette, and the series is free of any
sign-offs from you.

Was this something you expected to be merged?
