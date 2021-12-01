Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4731C4652D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351143AbhLAQiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:38:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:24635 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237826AbhLAQhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:37:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236720789"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="236720789"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:34:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="654838648"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2021 08:34:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 01D8F1C4; Wed,  1 Dec 2021 18:34:30 +0200 (EET)
Date:   Wed, 1 Dec 2021 19:34:30 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Share common features between AMD SEV / TDX guest
Message-ID: <20211201163430.2ncgynzns5t6gvof@black.fi.intel.com>
References: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 04:45:24PM -0800, Kuppuswamy Sathyanarayanan wrote:
> Hi All,
> 
> Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
> hosts and some physical attacks. TDX has a lot of similarities to AMD SEV.
> Features like encryption/decryption and string I/O unroll support can
> be shared between these two technologies.
> 
> This patch set adds infrastructure changes required to share the code
> between AMD SEV and TDX.

Tom, Joerg, could you folks look at this? Your Ack would be very helpful.

-- 
 Kirill A. Shutemov
