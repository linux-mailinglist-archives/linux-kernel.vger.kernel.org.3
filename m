Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEB74C4CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiBYRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiBYRym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:54:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9FB1BAF29
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645811649; x=1677347649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ftDuWc6MrY6q3MP1FYVTsDt8HeY9bTl9rroGTJ2zuzg=;
  b=WyZGLvf3I1fuXB6XB11tRr+eiyojgHbQCf/iB6mNf55PcwMGz5bz7iGY
   Ivgp7otZ+bnF/i8ISZJdMG5c0NbGQEDTRw0Kw9N4To04n2WMh4tI9Pqg3
   K8H3arNOK6ezM/ghHQ7QEzT70gaU3murcz0WoBXGriLXiNVCh7skcfp7T
   P6uJVNAco7O9OtPJUUlsUBlgLEPG10HT53SJCqE7c28Nry3OlKrTv9lQy
   F4SLp3qSxuQlN2a4NIpY7U+axdPib6WdDymWYdhodbISIsOVwOX8Q+FXJ
   1M6ipK58TjpPbr7rsKCpoVbbUziMNOEFwSSObrj3vpmvUn9+y9jXIe9Rm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251377205"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="251377205"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:54:09 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="533654431"
Received: from wreed-mobl.amr.corp.intel.com (HELO [10.212.247.12]) ([10.212.247.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:54:09 -0800
Message-ID: <62bb50e4-819b-a576-cfbe-e2878946de18@intel.com>
Date:   Fri, 25 Feb 2022 09:54:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv4 30/30] Documentation/x86: Document TDX kernel
 architecture
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-31-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220224155630.52734-31-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> +List of instructions that can cause a #VE is,
> +
> +* String I/O (INS, OUTS), IN, OUT

Also: String I/O != Port I/O

I'm just going to throw this into a shared document and start rewriting it.

