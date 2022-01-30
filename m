Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30AA4A32B7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353500AbiA3AAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:00:30 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:49486
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353485AbiA3AA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:00:28 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9B74F3F07C;
        Sun, 30 Jan 2022 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643500825;
        bh=e5WzvEWToWOPqX3/OmG5C06GGabZdWAfxa8w+ai7Ytc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=XoJcNGaA0c0tO87At0EEruVQbMb2Ipdz26unr3G4L3hNB2qGE/QyNaOGgb5lCZDSd
         nOjsKMxuOH1kboB2Re9PtyeXTy30sypnc05v0C+rsj/eECm8SfwCBNZi6ICPmFc+FK
         OyD7ergoXTlmdfSd/gZsER8GwUXKkozcR0AOaGpe6xMVfDYCTN17BRnJZuh2vW3x+Z
         aQ+Hx156Z2U73ABBTX9yIABp6X4ioK+scavhFx1d6pkYewPXyhj96N8eACYKGjokK9
         KHDxoySAamGqlj539lUUYAl+PPLYWDQoQnMyzCUC59f/cDIb/E+gcswOcWmtYD3nq9
         H5RLzJgyPseTg==
Message-ID: <d2957633-3685-b3dc-d41c-ee0948733783@canonical.com>
Date:   Sat, 29 Jan 2022 16:00:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] apparmor: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, serge@hallyn.com
Cc:     jmorris@namei.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220129025101.38355-1-yang.lee@linux.alibaba.com>
 <20220129025101.38355-3-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220129025101.38355-3-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 18:51, Yang Li wrote:
> Don't use /** for non-kernel-doc comments and change function name
> aa_mangle_name to mangle_name in kernel-doc comment to Remove some
> warnings found by running scripts/kernel-doc, which is caused by
> using 'make W=1'.
> 
> security/apparmor/apparmorfs.c:1503: warning: Cannot understand  *
>  on line 1503 - I thought it was a doc line
> security/apparmor/apparmorfs.c:1530: warning: Cannot understand  *
>  on line 1530 - I thought it was a doc line
> security/apparmor/apparmorfs.c:1892: warning: Cannot understand  *
>  on line 1892 - I thought it was a doc line
> security/apparmor/apparmorfs.c:108: warning: expecting prototype for
> aa_mangle_name(). Prototype was for mangle_name() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree


> ---
>  security/apparmor/apparmorfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 15efe4076fc4..4d7df859542d 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -98,7 +98,7 @@ static struct rawdata_f_data *rawdata_f_data_alloc(size_t size)
>  #endif
>  
>  /**
> - * aa_mangle_name - mangle a profile name to std profile layout form
> + * mangle_name - mangle a profile name to std profile layout form
>   * @name: profile name to mangle  (NOT NULL)
>   * @target: buffer to store mangled name, same length as @name (MAYBE NULL)
>   *
> @@ -1499,7 +1499,7 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
>  
>  /** fns to setup dynamic per profile/namespace files **/
>  
> -/**
> +/*
>   *
>   * Requires: @profile->ns->lock held
>   */
> @@ -1526,7 +1526,7 @@ void __aafs_profile_rmdir(struct aa_profile *profile)
>  	}
>  }
>  
> -/**
> +/*
>   *
>   * Requires: @old->ns->lock held
>   */
> @@ -1888,7 +1888,7 @@ static void __aa_fs_list_remove_rawdata(struct aa_ns *ns)
>  		__aa_fs_remove_rawdata(ent);
>  }
>  
> -/**
> +/*
>   *
>   * Requires: @ns->lock held
>   */

