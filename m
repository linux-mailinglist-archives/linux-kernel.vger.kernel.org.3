Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0B57AE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbiGTCbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGTCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:30:58 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB27B6E890;
        Tue, 19 Jul 2022 19:28:32 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 133093F3B9;
        Wed, 20 Jul 2022 02:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658284110;
        bh=4Gy97tee+Piny7xG0AvgFw4ZwDYOWjS6fnh/UnSKTkM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FIDgjMwWggLf9HaPWWjtqnFSgbaX+ul5LuJmUqDHQnRRLv9guggUo8qStLCbf2J8g
         iE3eAV1UuqqODL5Lj3GBRGhBKYGOBgLvzj9b1UGUWAVqz2nJC1ySgqrh91cYuDao6D
         PZec74E6Iq2fl9FN6KPxoMZGTumbtWpRa6NMXchk9Q7YkK+IKN7Nl2QAMw96CHmDtP
         KoBIBYC65wrTR7nkkb4B2ObNEjYyeVaCSLhyzXqkpbqVBV5vXmRLvkZa88p1UwhbMK
         2eUC1I06spL1qrupm6EN61GHxjdbZOlykwd1bA7UPjz2nUGM/65Se0sGVH0SiilB1g
         OaL2NWgp9OhpQ==
Message-ID: <6aca407d-9c81-b460-f03e-cea0369a6185@canonical.com>
Date:   Tue, 19 Jul 2022 19:28:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] apparmor: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220718063022.129998-1-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220718063022.129998-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/22 23:30, Yang Li wrote:
> Remove warnings found by running scripts/kernel-doc, which is caused by
> using 'make W=1'.
> security/apparmor/policy_ns.c:65: warning: Function parameter or member 'curr' not described in 'aa_ns_name'
> security/apparmor/policy_ns.c:65: warning: Function parameter or member 'view' not described in 'aa_ns_name'
> security/apparmor/policy_ns.c:65: warning: Function parameter or member 'subns' not described in 'aa_ns_name'
> security/apparmor/policy_ns.c:65: warning: expecting prototype for aa_na_name(). Prototype was for aa_ns_name() instead
> security/apparmor/policy_ns.c:214: warning: Function parameter or member 'view' not described in '__aa_lookupn_ns'
> security/apparmor/policy_ns.c:214: warning: Excess function parameter 'base' description in '__aa_lookupn_ns'
> security/apparmor/policy_ns.c:297: warning: expecting prototype for aa_create_ns(). Prototype was for __aa_find_or_create_ns() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

thanks I have pulled this into apparmor-next

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/policy_ns.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
> index 300953a02a24..0ef268d6554d 100644
> --- a/security/apparmor/policy_ns.c
> +++ b/security/apparmor/policy_ns.c
> @@ -54,10 +54,10 @@ bool aa_ns_visible(struct aa_ns *curr, struct aa_ns *view, bool subns)
>   }
>   
>   /**
> - * aa_na_name - Find the ns name to display for @view from @curr
> - * @curr - current namespace (NOT NULL)
> - * @view - namespace attempting to view (NOT NULL)
> - * @subns - are subns visible
> + * aa_ns_name - Find the ns name to display for @view from @curr
> + * @curr: current namespace (NOT NULL)
> + * @view: namespace attempting to view (NOT NULL)
> + * @subns: are subns visible
>    *
>    * Returns: name of @view visible from @curr
>    */
> @@ -200,7 +200,7 @@ struct aa_ns *aa_find_ns(struct aa_ns *root, const char *name)
>   
>   /**
>    * __aa_lookupn_ns - lookup the namespace matching @hname
> - * @base: base list to start looking up profile name from  (NOT NULL)
> + * @view: namespace to search in  (NOT NULL)
>    * @hname: hierarchical ns name  (NOT NULL)
>    * @n: length of @hname
>    *
> @@ -285,7 +285,7 @@ static struct aa_ns *__aa_create_ns(struct aa_ns *parent, const char *name,
>   }
>   
>   /**
> - * aa_create_ns - create an ns, fail if it already exists
> + * __aa_find_or_create_ns - create an ns, fail if it already exists
>    * @parent: the parent of the namespace being created
>    * @name: the name of the namespace
>    * @dir: if not null the dir to put the ns entries in

