Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB8468719
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbhLDSeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhLDSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:34:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B8C061751;
        Sat,  4 Dec 2021 10:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD498B80D40;
        Sat,  4 Dec 2021 18:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59171C341C2;
        Sat,  4 Dec 2021 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638642634;
        bh=vpZJzbz83/r/7Zk6WlXuLGdQvsG896LAUclP0lH086M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fo4fIwVbOy9dzWFaBEcYV9fF/anITNia8T/lRCYT0LLdDNh8MQZqz4s2+Wx6+CtA5
         odwlAVRxtMsWxvXKoIlVGiSW1vNx52KMk3B91jLWa/dOfGL9YXKxS1pqzO3pUdYPMh
         TLncHoIQ+qYGsLeDOtKtJrZ1GXVYA4bw8/DlqC7km7vT7IRrln1QzWQcgiABL6sfE6
         sfqiFtQugpwWc11vfnNEpdsOQfXp1Uz7mvHtR3zZlqiB5qI1tYBoLaDTm1vkYjZG7E
         zi6qvarrc2cvdrbKdVMmBBeN2O8Rb9zhDfFmpOzpT+Qq4eheyV4jbVL8Z7O/MtBLui
         eNrar0Y4SLrFQ==
Date:   Sat, 4 Dec 2021 20:30:28 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] x86/sgx: Add shortlog descriptions to ENCLS
 wrappers
Message-ID: <YauzxOEmmpeGF/K3@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <fd9ab4d760a2ea7a42ab9e60b9e19b8620abe11d.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9ab4d760a2ea7a42ab9e60b9e19b8620abe11d.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:22:59AM -0800, Reinette Chatre wrote:
> The SGX ENCLS instruction uses EAX to specify an SGX function and
> may require additional registers, depending on the SGX function.
> ENCLS invokes the specified privileged SGX function for managing
> and debugging enclaves. Macros are used to wrap the ENCLS
> functionality and several wrappers are used to wrap the macros to
> make the different SGX functions accessible in the code.
> 
> The wrappers of the supported SGX functions are cryptic. Add short
> changelog descriptions of each to a comment.

I think you are adding function descriptions.

> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encls.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
> index 9b204843b78d..241b766265d3 100644
> --- a/arch/x86/kernel/cpu/sgx/encls.h
> +++ b/arch/x86/kernel/cpu/sgx/encls.h
> @@ -162,57 +162,68 @@ static inline bool encls_failed(int ret)
>  	ret;						\
>  	})
>  
> +/* Create an SECS page in the Enclave Page Cache (EPC) */
>  static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
>  {
>  	return __encls_2(ECREATE, pginfo, secs);
>  }

You have:

* "Create an SECS page in the Enclave Page Cache (EPC)"
* "Add a Version Array (VA) page to the Enclave Page Cache (EPC)"

They should have similar descriptions, e.g.

* "Initialize an EPC page into SGX Enclave Control Structure (SECS) page."
* "Initialize an EPC page into Version Array (VA) page."

> +/* Extend uninitialized enclave measurement */
>  static inline int __eextend(void *secs, void *addr)
>  {
>  	return __encls_2(EEXTEND, secs, addr);
>  }

That description does not make __eextend any less cryptic.

Something like this would be already more informative:

/* Hash a 256 byte region of an enclave page to SECS:MRENCLAVE. */

This same remark applies to the rest of these comments. They should
provide a clue what the wrapper does rather than an English open coded
function name.

/Jarkko
