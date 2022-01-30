Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506214A32BB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353507AbiA3ADJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:03:09 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:49772
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353476AbiA3ADH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:03:07 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4647D3F07C;
        Sun, 30 Jan 2022 00:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643500986;
        bh=7k+y7PJ3gcJlzXgorU2zNnjUpve3rlNlya9TVwYp4hk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jENINqRqw3pqbJmZcbRC9FDajyZ8MAcWWeoUZJOf8ZlWcSzM3o6dXNdkxgL53QmtH
         1coGNJop/zo/HWBCHCN4IkbM6FKfz/YsdWp43KqLKDfVGH668cEREXFKO4WSABTrIn
         vYvuL3w5QlTrVm38J5bX/v6yXvverFoBmfFcIscq/lTwhIpJJUcfT1PmFMmkiJz+ge
         +BEipTyTjA2LrxJe23wa79vmXMHfCcqKi7BZlFay+/E5oJf6gZdw4gMCeNw6Iappzb
         iqRkDOintBf2DiavnqexfcmXbjY/iWYq6rhpiQ4LH5W00yGE8j3/rbG+N3JV5YP3/6
         wknNkY6kYzWRQ==
Message-ID: <9836f3d4-186f-7a6e-448d-8e94be5f634f@canonical.com>
Date:   Sat, 29 Jan 2022 16:03:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next 3/3] apparmor: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, serge@hallyn.com
Cc:     jmorris@namei.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220129025229.39663-1-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220129025229.39663-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 18:52, Yang Li wrote:
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

just for completeness (this is a dup of [PATCH 3/3] apparmor: Fix some kernel-doc comments)

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

