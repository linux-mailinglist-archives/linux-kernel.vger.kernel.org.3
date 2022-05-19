Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99A52CEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiESIxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiESIwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:52:55 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB19CF4C;
        Thu, 19 May 2022 01:52:53 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 076133F772;
        Thu, 19 May 2022 08:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652950372;
        bh=nv2aYgsqLrcfkBftEjGmPU9Khiz+v8yeJ6QN6I+2278=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PVHotn9HvK3R8kdYeONbfIuxtLlfbc1tYxn0fMMitiMpTAEUWDoHJSTEmfeVaXzMj
         9SkyTgiC/g6dq1hOpGQdli9CiEhy2LjY4r2Xb2aX0ahuPqWhpiSCNQnH2myBawCJNG
         /fhZe69xKqY7t2dtn4eM/ZEXV7DFclzuC4LdynxrQGCZSO+p61WQmNfwQQH06D9rAx
         s42YS9L3MseAjkC4fIv+8Kz9hy/49DiAZJAODsZfS4gnVG6uqIYrnSMmr5dJLHSyID
         lVBHdiyUUDMW/eH5wvBS/LSBVBArcjHsLcD8cUB6mcWbDZfauPLaBMWBp1uwIilHNl
         TBbUsikMYw3pw==
Message-ID: <61824a01-0c03-7c74-1101-a30d3ae99f32@canonical.com>
Date:   Thu, 19 May 2022 01:52:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] apparmor: Fix aa_str_perms() kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jmorris@namei.org, serge@hallyn.com, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220512075350.31163-1-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220512075350.31163-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 00:53, Yang Li wrote:
> Add the description of @start and remove @state in aa_str_perms()
> kernel-doc comment to remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
> security/apparmor/file.c:260: warning: Function parameter or member
> 'start' not described in 'aa_str_perms'
> security/apparmor/file.c:260: warning: Excess function parameter 'state'
> description in 'aa_str_perms'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

sorry, for the delay on this I have pulled it into my tree

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>  security/apparmor/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index e1b7e93602e4..137c99bb5d4a 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -247,7 +247,7 @@ struct aa_perms aa_compute_fperms(struct aa_dfa *dfa, unsigned int state,
>  /**
>   * aa_str_perms - find permission that match @name
>   * @dfa: to match against  (MAYBE NULL)
> - * @state: state to start matching in
> + * @start: the state of the dfa to start matching in
>   * @name: string to match against dfa  (NOT NULL)
>   * @cond: conditions to consider for permission set computation  (NOT NULL)
>   * @perms: Returns - the permissions found when matching @name

