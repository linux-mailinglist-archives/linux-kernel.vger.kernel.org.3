Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33153AA96
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355922AbiFAP6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355130AbiFAP6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:58:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF08753B61
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5g7mL7uWIJ9U3AKROL2hqbNL1sPeqZc3VNfONGwhli8=; b=ZZ10t6IyLYmEH7s1H1rQGy56nR
        tWSUVFU8J1jTdOhjDhh+Q2uoWbdjeVA58P4O3EyTXf/lM1ndjVU43Gq6Sb2rIx/2EKbmHADFNpGP7
        hsz3XAW9Fe3vJ/IyLy72dC5AOR/7BPj48DI+upjhFXcE/KHvAFbGOXFvAr4Z5FYAoLW7PE903FTMf
        BTvKlO7Ig7UyhgmvINVp4locg1gGsT+qZ8cRQQ5Xa6uhfX5oKYc6PnWvE1HcRp6XtpQ8ay1G+dh1V
        78scY+MRrL+DNB9uie4xGd0DG9JCi5IKYXtLYX8U7zSIbnQCvBC6V/V0lK9jbJQ4kiyXyyH9WxGgD
        2O134i+w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwQjp-003pF2-8o; Wed, 01 Jun 2022 15:58:26 +0000
Message-ID: <97352295-6527-f146-6f55-c4577a80f3a2@infradead.org>
Date:   Wed, 1 Jun 2022 08:58:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] average: Clarify the restrictions
Content-Language: en-US
To:     Jui-Tse Huang <juitse.huang@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Bruno Randolf <br1@einfach.org>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
References: <20220601071907.22070-1-juitse.huang@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220601071907.22070-1-juitse.huang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/22 00:19, Jui-Tse Huang wrote:
> There is several restrictions in the EWMA helper macro that the
> developers should take care of, but the comment does not mentioned yet,
> thus, this patch clarify the restrictions.
> 
> Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
> ---
> 
> Notes:
>     v2: fix spelling and wording (Bruno Randolf)
> 
>  include/linux/average.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/average.h b/include/linux/average.h
> index a1a8f09631ce..ff0953ba2820 100644
> --- a/include/linux/average.h
> +++ b/include/linux/average.h
> @@ -13,6 +13,9 @@
>   * precision and fall-off coefficient determined at compile-time
>   * and built into the generated helper funtions.

                                          functions.
>   *
> + * This implementation supports up to 30 bits of precition, and only

                                                    precision,

> + * the API for fetching non-fractional part is provided for now.
> + *
>   * The first argument to the macro is the name that will be used
>   * for the struct and helper functions.
>   *

-- 
~Randy
