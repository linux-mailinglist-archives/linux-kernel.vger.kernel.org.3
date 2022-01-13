Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7948E022
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiAMWQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:16:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:42551 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbiAMWQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642112174; x=1673648174;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EA/29RwgHtifPiR/m+ps61Bq+rc5YlzOLPB5+L9ANHs=;
  b=IjOieHSujqGzOXEUOJfvpYh+ziaeiqrl/Pe3p4o4OqmSjVrKgs15xKyI
   80bP0jJlS8fQpH5DXiRllED5UrwLooHKQVdK8qlBcFHX89S3vbIkUeB8y
   NFmrN6uDnGwQ9HX4uqttMAlwDWGoNWFQdg0TL3KfZEdXBrFNMGBwKGvQZ
   VzvNEMIn/fViJ3vkFp7vSw1EtP4ZlKjcO2FlKlGMwogVH+oVq+NwWIAL5
   GKKCtCxXNX/PEv2JY/oNfEVfGaZE+fhqgSp+gSFckh1g+M6xIRtHeXhmY
   3SUHzYHqIAuLgrU3FHhvw9/YXfBIlG1HVWZJhzIDrr8NxCgTdPGhlrPls
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="268485658"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="268485658"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 14:16:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="475511498"
Received: from nlabrum-mobl.amr.corp.intel.com (HELO [10.209.104.247]) ([10.209.104.247])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 14:16:13 -0800
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, ebiggers@kernel.org, ardb@kernel.org,
        x86@kernel.org, luto@kernel.org, tglx@linutronix.de, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v5 00/12] x86: Support Key Locker
Message-ID: <215bc107-aa47-62bd-65ad-f76e65ee75d5@intel.com>
Date:   Thu, 13 Jan 2022 14:16:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112211258.21115-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 1:12 PM, Chang S. Bae wrote:
> A couple of other things outside of these patches are still in progress:
> * Support DM-crypt/cryptsetup for Key Locker usage (Andy Lutomirski)
>   [2].
> * Understand decryption under-performance (Eric Biggers and Milan Broz)
>   [3][4].

I really like when contributors are clear about why they are posting
their series and what their expectations are.  This posting leaves me a
bit confused as to what you expect the maintainers to do.

Should the maintainers ignore this series until those in-progress things
are done?  Or, do you expect that this could be merged as-is before
those are resolved?
