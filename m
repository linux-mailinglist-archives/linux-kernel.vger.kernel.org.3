Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97834F0F55
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347212AbiDDG1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiDDG1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:27:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671F317ABF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649053523; x=1680589523;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=WCWYLbvQWjRu7A6NEoSyQR8/bykm58WyIQUGyczn5Hs=;
  b=IyG80wh5toRphyd5quYkdl0HbyB8ntwbVTBSJgKdu18sIf+XvmDVe5u5
   EEdZfdKxr6Alcz2GoFxe7caUQc3eHKE/KmMSQmlvTI6J38DXKofG038Dl
   ckfyTAXN/wGWIVtTXR/VcjeD4SK3EpOhHwXLIehvP6Gm2aadapV+vUA31
   ba3F0Vac3sX6M4qNl8zzCGBMr5+qQiETR5RfDCjVD9ffUZ52C9Qu2eo7X
   6vpz4FqGFb1B/hNgVPreQsNoB1dcs9MAQ9zTVvsZ+ODSaHlgULl5NHEOq
   m23+rynXHgB79KUjdWpmuV8migQWezo2Q106+1bKSJLCkUaMjwoBKhG2S
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260435797"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="260435797"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 23:25:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="522916384"
Received: from petersun-mobl1.amr.corp.intel.com (HELO [10.209.86.175]) ([10.209.86.175])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 23:25:22 -0700
Message-ID: <faee19b5-5ee2-d6e1-63fe-c8a7fb1f9d32@intel.com>
Date:   Sun, 3 Apr 2022 23:25:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-31-kirill.shutemov@linux.intel.com>
 <7c507b609a6e742ebdcd61ea204d5f05ee0b3b35.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv7 30/30] Documentation/x86: Document TDX kernel
 architecture
In-Reply-To: <7c507b609a6e742ebdcd61ea204d5f05ee0b3b35.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 21:32, Kai Huang wrote:
> This is not the best way I believe.  I think we have two options here:
> 1) Having dedicated tdx_guest.rst and tdx_host.rst
> 2) Having a single tdx.rst to cover both TDX guest and host materials.
> 
> I don't know which way is better, perhaps 2).  
> 
> Kirill,
> 
> If 2) is better, could we add an additional level of menu to represent "TDX
> guest support" and make all materials as sub-menu of it, if you need to send out
> v8?

If the host support means that this needs to be reorganized, then the
host support patches can do that.  Let's not make this more complicated
than it has to be.
