Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31B656907C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiGFRRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiGFRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:17:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE2F2A737;
        Wed,  6 Jul 2022 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657127831; x=1688663831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k/GJ1Ocu6NSTbZWVHRMDXxNhqdLrEsXDfyhMdsiS/Fk=;
  b=BDxWCV0EK4dz8dFSd90CjRwejnvf4mqYI5mhhMHVU40Ht7BI0+JmowO4
   30mWzAjWt4PcgVZ0zlJTHwlbrpMPCzVn5kEzTt7LEGs+FShaTrc/Dr1P3
   7G739puc/lylZTUmKK9T3rNq6YcvdGOOQmroBLHxpk4zvPxPD1Jnh5dAT
   PoR3XoOWc+F6dgm/1dAnMbU+W2sm9DHCymWscMMvp6PtqQRMUCzumb8u8
   7qfCbLdeADErd0gIFVPudS8W8MMwX9Ee50BEJiynWWf9/YZDtl0/xRUad
   PS1HwjoYXVZGZEo5gZxWOSathufC8KzPQfitrTQWic3sf2CZQyTMMPaqO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="370134896"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="370134896"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:17:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="620415107"
Received: from tjsteven-mobl3.amr.corp.intel.com (HELO [10.255.228.25]) ([10.255.228.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:17:10 -0700
Message-ID: <2a2411f0-60a9-cf7d-b34d-b1756ad499a5@intel.com>
Date:   Wed, 6 Jul 2022 10:15:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/22] x86/sgx: fix kernel-doc markups
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org
References: <cover.1656409369.git.mchehab@kernel.org>
 <49f0900ca467867917182a4428b731e55608ca67.1656409369.git.mchehab@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <49f0900ca467867917182a4428b731e55608ca67.1656409369.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 02:46, Mauro Carvalho Chehab wrote:
> + * @rdi:	snapshot of DI register at enclave exit
> + * @rsi:	snapshot of SI register at enclave exit
> + * @rdx:	snapshot of DX register at enclave exit
> + * @rsp:	snapshot of SP register at enclave exit
> + * @r8:		snapshot of R8 register at enclave exit
> + * @r9:		snapshot of R9 register at enclave exit

The 'DX register' really is different than RDX.

These should all have the full register names, like:

	snapshot of RSP register at enclave exit

With that fixed:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
