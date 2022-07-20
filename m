Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7630F57AE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiGTCbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiGTCbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:31:00 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594FC47B9B;
        Tue, 19 Jul 2022 19:29:12 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2D5763F3B9;
        Wed, 20 Jul 2022 02:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658284150;
        bh=9j/ZqHLMNdT5QMf1JvgP7iBoNYWJdux7J9tU03wREIM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rDojAGkctKN4FpCk51sLeFbhP9LNM4q0qtwFwbV9eMs2c61IFkE5c/xXsVBnmepjM
         SN5k5docgU8Xo6hw5MInmVYAUk0bU6strqyRLN65/t9q2NWd2E0GFm6KKGuDo4yUXC
         8Y3i8NNLA6eM24Tnh6FiOK0ZAko7pcq+VVhXWo6JS88T47M6B7xFbOcCXF7PxseSZt
         Npr5sU9j8ZVfUt4YReZP6NdwWHULL9cAGaJGw1wqqm1wbwiLWOb1IwdIH50RVdFOWB
         IF8Ijsrqcu0jeOkOJ3QUQKGensqtNbWg+2P6lITj7F7TgYF28EDWvbXnVJ9rS+bFJv
         1onzKBGzmICZg==
Message-ID: <110d78bc-d1f4-0b69-9562-c6758b39279d@canonical.com>
Date:   Tue, 19 Jul 2022 19:29:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] apparmor: Mark alloc_unconfined() as static
Content-Language: en-US
To:     Souptick Joarder <jrdr.linux@gmail.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220719021218.6807-1-jrdr.linux@gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220719021218.6807-1-jrdr.linux@gmail.com>
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

On 7/18/22 19:12, Souptick Joarder wrote:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> 
> Kernel test robot throws below warning ->
> security/apparmor/policy_ns.c:83:20: warning: no previous prototype
> for function 'alloc_unconfined' [-Wmissing-prototypes]
> 
> Mark it as static.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>

Thanks, I have pulled this into apparmor-next

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>   security/apparmor/policy_ns.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
> index 300953a02a24..4f6e9b3c24e6 100644
> --- a/security/apparmor/policy_ns.c
> +++ b/security/apparmor/policy_ns.c
> @@ -80,7 +80,7 @@ const char *aa_ns_name(struct aa_ns *curr, struct aa_ns *view, bool subns)
>   	return aa_hidden_ns_name;
>   }
>   
> -struct aa_profile *alloc_unconfined(const char *name)
> +static struct aa_profile *alloc_unconfined(const char *name)
>   {
>   	struct aa_profile *profile;
>   

