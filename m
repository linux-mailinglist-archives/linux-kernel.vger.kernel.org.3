Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0432E55C58B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbiF0Swh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiF0Swe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:52:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623BDEB9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656355953; x=1687891953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A7ztOuMqK8/tvFrlCEBcCLu71GhWrpbUZrN88Eif/Dg=;
  b=igx6RM+Cr13r97Jtm/SEUmPojG3g+7+5PHBr/ttfj5KKBxzyfGSXOGaM
   yWc49JYu4dsslrEkgS3XyU1BUuP29wvm+oaU/S/hMLnl81Wrqtd3HA9iD
   xtdhXUiKOuqFf4WOwt6/H5kVJwcdKUKaCioShvGeMjaU+vsRMnRdvaRzw
   w+BNZ3mKsesBM1ZQTSUsK3gAV1Y7EoOR5kbGYqQaWqhDLGT2+N5noI6XG
   Fv1TQL2UYUdRCQvvvA/vkhzqBK/NmQ5sgrlBgvnMSwo8v4O40Nl9aTDuA
   pRI31GuF7CpY6U47Mog6mdUTX1hZENy7S/rvhExzWrbYjYcsR8KWof4j1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343224095"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343224095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 11:52:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732439707"
Received: from jsagoe-mobl1.amr.corp.intel.com (HELO [10.209.12.66]) ([10.209.12.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 11:52:31 -0700
Message-ID: <d9df53b3-97ea-d394-fb04-ce2c95d76d82@intel.com>
Date:   Mon, 27 Jun 2022 11:51:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 0/5] Add TDX Guest Attestation support
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9abde78c-d2c5-c762-24fe-f26669b7cc6c@intel.com>
 <2502d21b-8f27-ebe5-b677-4cc56b03ee2c@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <2502d21b-8f27-ebe5-b677-4cc56b03ee2c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 07:51, Sathyanarayanan Kuppuswamy wrote:
> In TDX guest, attestation process generally involves the following steps:
> 
> 1. Get the TDREPORT using user specified REPORTDATA. This is implemented
>    using TDG.MR.TDREPORT Module call. An IOCTL interface is added to let
>    userspace get the TDREPORT data  (implemented in patch #1).
>    
> 2. Using the TDREPORT data, generate a remotely verifiable signed Quote.
>    Quote can be generated either using GetQuote hypercall or by communicating
>    with VMM/Quoting Enclave(QE) using VSOCK. In this patch set, only the
>    GetQuote hypercall model is supported. Since Quote generation is an
>    asynchronous request, and takes more time, we let VMM notify the TDX Guest
>    using the callback interrupt. Patch # 2-5 implements Quote generation support,
>    in which Patch # 2 implements the callback interrupt support.

IMNHO, too much gibberish, not enough English, too much superfluous
information.

For instance, why do we need a quote and a report?  Why does this have
an interrupt?
