Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E657A42E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiGSQY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiGSQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:24:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D5253D26;
        Tue, 19 Jul 2022 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658247892; x=1689783892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2fyQaK2sYdxcSs4cAtsRZtPnt0Rg+OB2htHhbzwEKYA=;
  b=NC/ZXZz6UqJ8W4qeJua6VJMmkJvdhN53YXmjsSbrRlIxzv7/qdcDvFYC
   3AOyVYzjV+sjiSYzRkVyqZTL+Dtrq5d9naO9G2Ko88EDnOrqi5m2UBkSI
   p+WDz54LJv6o4EUcPs89BhqOHxBGnJWZsXSfAFf9cVGImKYq4i6A45KGK
   nKdUQElfEJFi6K+SLNWXy+81DdHWVS6S9DuhpIG68DGisUlIDXHIyKPXZ
   RHoZFIuCPgyGOVp9f9eYcGrUpdOKVAu4AvmLmKe3olklGIxbacg95lE7u
   RafeDUQzVs3y8/BOeebuFRbU/7feCt7f6PFA4+kdqYXujyWV2Z21UBSf/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="372836617"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="372836617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 09:24:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="572916887"
Received: from twliston-mobl1.amr.corp.intel.com (HELO [10.212.132.190]) ([10.212.132.190])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 09:24:51 -0700
Message-ID: <2d629999-d12a-5c95-1e91-c35fcede7af9@intel.com>
Date:   Tue, 19 Jul 2022 09:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org
References: <20220705183648.3739111-1-dave.hansen@linux.intel.com>
 <YsuMK0JIYqqjtVdk@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YsuMK0JIYqqjtVdk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 19:34, Jarkko Sakkinen wrote:
> Is this available on recent ucode updates e.g. for Icelake
> or Geminilake?

I do not believe it is currently publicly available.

It *really* needs some @intel.com Tested-by's.
