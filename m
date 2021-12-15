Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20220476437
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhLOVGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:06:24 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37206
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232544AbhLOVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:06:22 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1529F3F1EB;
        Wed, 15 Dec 2021 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639602378;
        bh=D0DDBMYppB7uzxzFJaFo6S/xEHFMOvYmG90YmtCZOJw=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=taDzMVP+jVnh0PMpJGuO3EB5Gr/0bE9kr7ylJgB1lXLpQEuMm2KKwyHUgxhdvr07I
         snLNrBCtdka/Kc7W/vS+PYhnnLRsvxVwPZ+tsv3Lh4DfKv0IHkUTGZFqGWG5S4pjCk
         pc+LQfz1eBGkKHrwWy1k3IND42eh6ihuHZNyp47Zsi6AUlZDUEgES0LSKZpo0qrrb4
         /goCYAT5qCkB8Gces0cdpr60eXpgwS1aOJuZPKkiu9g00Jf/XWMQSTr0DVGneutLKS
         L45WJ3aJ2y2wCrseITWk/QvUwToZlxmWE9G7jeELyZWgFUutPjHYtA4eBADIfLk33A
         WQauGU9df9Lkw==
Subject: Re: [PATCH -next] lsm: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20211210055712.16949-1-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <6f704cb0-cafd-f28b-a6cb-66717645d6b9@canonical.com>
Date:   Wed, 15 Dec 2021 13:06:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210055712.16949-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 9:57 PM, Yang Li wrote:
> Fix function name in lsm.c kernel-doc comment
> to remove some warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
> security/apparmor/lsm.c:819: warning: expecting prototype for
> apparmor_clone_security(). Prototype was for
> apparmor_sk_clone_security() instead
> security/apparmor/lsm.c:923: warning: expecting prototype for
> apparmor_socket_list(). Prototype was for apparmor_socket_listen()
> instead
> security/apparmor/lsm.c:1028: warning: expecting prototype for
> apparmor_getsockopt(). Prototype was for apparmor_socket_getsockopt()
> instead
> security/apparmor/lsm.c:1038: warning: expecting prototype for
> apparmor_setsockopt(). Prototype was for apparmor_socket_setsockopt()
> instead
> ecurity/apparmor/lsm.c:1061: warning: expecting prototype for
> apparmor_socket_sock_recv_skb(). Prototype was for
> apparmor_socket_sock_rcv_skb() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>  security/apparmor/lsm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 4f0eecb67dde..ce7d96627810 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -812,7 +812,7 @@ static void apparmor_sk_free_security(struct sock *sk)
>  }
>  
>  /**
> - * apparmor_clone_security - clone the sk_security field
> + * apparmor_sk_clone_security - clone the sk_security field
>   */
>  static void apparmor_sk_clone_security(const struct sock *sk,
>  				       struct sock *newsk)
> @@ -917,7 +917,7 @@ static int apparmor_socket_connect(struct socket *sock,
>  }
>  
>  /**
> - * apparmor_socket_list - check perms before allowing listen
> + * apparmor_socket_listen - check perms before allowing listen
>   */
>  static int apparmor_socket_listen(struct socket *sock, int backlog)
>  {
> @@ -1021,7 +1021,7 @@ static int aa_sock_opt_perm(const char *op, u32 request, struct socket *sock,
>  }
>  
>  /**
> - * apparmor_getsockopt - check perms before getting socket options
> + * apparmor_socket_getsockopt - check perms before getting socket options
>   */
>  static int apparmor_socket_getsockopt(struct socket *sock, int level,
>  				      int optname)
> @@ -1031,7 +1031,7 @@ static int apparmor_socket_getsockopt(struct socket *sock, int level,
>  }
>  
>  /**
> - * apparmor_setsockopt - check perms before setting socket options
> + * apparmor_socket_setsockopt - check perms before setting socket options
>   */
>  static int apparmor_socket_setsockopt(struct socket *sock, int level,
>  				      int optname)
> @@ -1050,7 +1050,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
>  
>  #ifdef CONFIG_NETWORK_SECMARK
>  /**
> - * apparmor_socket_sock_recv_skb - check perms before associating skb to sk
> + * apparmor_socket_sock_rcv_skb - check perms before associating skb to sk
>   *
>   * Note: can not sleep may be called with locks held
>   *
> 

