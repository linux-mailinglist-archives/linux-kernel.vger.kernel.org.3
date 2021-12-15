Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF90476439
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhLOVGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:06:37 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37226
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232544AbhLOVGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:06:35 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7C2153F1EB;
        Wed, 15 Dec 2021 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639602394;
        bh=RWzxkXzAVp/A9fejasmC/on0nYacq+ErNHO8Y6i1/Yc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=M2We8DIImoLjKFS67Q3bg6htGqMpSrjhwvUfGL0gbS5zqAQyiTIH+cQtYEPtRxccw
         4qzZsBzucrmzyuIvQBnjzS5ddn96CjQbRn1NxK+Mxy6BLPMdc0ATJDNDQimEs5jd3k
         VCix+EW1yuzmrXnDW4ciXavpJ8zJLC1UNgvA89QqLbQ+IKJoomyPTOYDSoP7grxat/
         QxO95Yon4fyslvxMXKbpQhGIfr1r89AGQ3me+maQoLbfAklzQ013GQpr9j4Fmb1QtR
         3jwvzrjSU9H5qXGUqyPkoxJdus2nB1bc6yP3VZwdIWdbZoc9oA0l1bwCOTV6ZG3b59
         633Kf6pYW/ycw==
Subject: Re: [PATCH -next] apparmor: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jmorris@namei.org, serge@hallyn.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <1637134678-81292-1-git-send-email-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <b9523142-cb9b-eac7-3ee2-5f4ae02d1f75@canonical.com>
Date:   Wed, 15 Dec 2021 13:06:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637134678-81292-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 11:37 PM, Yang Li wrote:
> Fix function name in security/apparmor/label.c, policy.c, procattr.c
> kernel-doc comment to remove some warnings found by clang(make W=1 LLVM=1).
> 
> security/apparmor/label.c:499: warning: expecting prototype for
> aa_label_next_not_in_set(). Prototype was for
> __aa_label_next_not_in_set() instead
> security/apparmor/label.c:2147: warning: expecting prototype for
> __aa_labelset_udate_subtree(). Prototype was for
> __aa_labelset_update_subtree() instead
> 
> security/apparmor/policy.c:434: warning: expecting prototype for
> aa_lookup_profile(). Prototype was for aa_lookupn_profile() instead
> 
> security/apparmor/procattr.c:101: warning: expecting prototype for
> aa_setprocattr_chagnehat(). Prototype was for aa_setprocattr_changehat()
> instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>  security/apparmor/label.c    | 4 ++--
>  security/apparmor/policy.c   | 2 +-
>  security/apparmor/procattr.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index 0b0265d..e8ada60 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -485,7 +485,7 @@ int aa_label_next_confined(struct aa_label *label, int i)
>  }
>  
>  /**
> - * aa_label_next_not_in_set - return the next profile of @sub not in @set
> + * __aa_label_next_not_in_set - return the next profile of @sub not in @set
>   * @I: label iterator
>   * @set: label to test against
>   * @sub: label to if is subset of @set
> @@ -2136,7 +2136,7 @@ static void __labelset_update(struct aa_ns *ns)
>  }
>  
>  /**
> - * __aa_labelset_udate_subtree - update all labels with a stale component
> + * __aa_labelset_update_subtree - update all labels with a stale component
>   * @ns: ns to start update at (NOT NULL)
>   *
>   * Requires: @ns lock be held
> diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
> index b0cbc4906..8357f4a 100644
> --- a/security/apparmor/policy.c
> +++ b/security/apparmor/policy.c
> @@ -422,7 +422,7 @@ static struct aa_profile *__lookup_profile(struct aa_policy *base,
>  }
>  
>  /**
> - * aa_lookup_profile - find a profile by its full or partial name
> + * aa_lookupn_profile - find a profile by its full or partial name
>   * @ns: the namespace to start from (NOT NULL)
>   * @hname: name to do lookup on.  Does not contain namespace prefix (NOT NULL)
>   * @n: size of @hname
> diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
> index fde332e..86ad26e 100644
> --- a/security/apparmor/procattr.c
> +++ b/security/apparmor/procattr.c
> @@ -90,7 +90,7 @@ static char *split_token_from_name(const char *op, char *args, u64 *token)
>  }
>  
>  /**
> - * aa_setprocattr_chagnehat - handle procattr interface to change_hat
> + * aa_setprocattr_changehat - handle procattr interface to change_hat
>   * @args: args received from writing to /proc/<pid>/attr/current (NOT NULL)
>   * @size: size of the args
>   * @flags: set of flags governing behavior
> 

