Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4B50AF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443955AbiDVEcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiDVEcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:32:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDC24ECF5;
        Thu, 21 Apr 2022 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=BfPZT2Vz3wYnbDUfmOP+6kCUY3zMCjody5z0Xni3vyQ=; b=SOGqVFANY4LXKKB37LWXkVQpcP
        husK5EtYaQM3Sfoz/qobNozeRDzW2S9CG6yliRVfttLCgGU96MbHEwq9vhmiidIPcz+H6bir955iy
        /mYs7jHpcv5vWJBGgTgmApy85ZQQAR25PHDhw2AA97eze/q5zCJQBhGJ4SZ9Uc75jV3HVgOvM+aJ8
        K2mqqIGiLOVnHHC+es8HQeNmx9lHyxCyO7AyalNoMWS0OoGfgxRPyMGuqz9w+TOjZfaxur9MBVtt7
        QaEN7k99fdVQpbebhCCZG+S2aZu/wdU0Z75nQAKM8Jz97XyK8zlbK7P2gOIgz+4gExo5hEZFbaNGb
        cJh9KFNw==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhkud-007bIg-5c; Fri, 22 Apr 2022 04:28:55 +0000
Message-ID: <0a338104-d7cf-a2e1-7d03-97667aa30537@infradead.org>
Date:   Thu, 21 Apr 2022 21:28:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] Documentation: thermal: Include ReST markup standard
 definition file
Content-Language: en-US
To:     Soumya Negi <soumya.negi97@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220422041427.32585-1-soumya.negi97@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220422041427.32585-1-soumya.negi97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/21/22 21:14, Soumya Negi wrote:
> Fixes the documentation compile error given below:
> 
> ERROR: Undefined substitution referenced: "copy".
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  Documentation/driver-api/thermal/intel_dptf.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
> index 96668dca753a..e3c41d96d63a 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -1,4 +1,5 @@
>  .. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>  
>  ===============================================================
>  Intel(R) Dynamic Platform and Thermal Framework Sysfs Interface

linux-next and jc_docs git tree already have a patch for this:

commit 2c2de6f2e2bc
Author: Akira Yokosawa <akiyks@gmail.com>
Date:   Sat Apr 2 08:19:05 2022 +0900

    docs: driver-api/thermal/intel_dptf: Use copyright symbol


thanks.
-- 
~Randy
