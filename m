Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D9A4EC391
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbiC3MTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbiC3L7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:59:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA7E33881;
        Wed, 30 Mar 2022 04:55:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3103B81C36;
        Wed, 30 Mar 2022 11:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1580FC340EE;
        Wed, 30 Mar 2022 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648641310;
        bh=e7Hpe6pe/bkh9zgngUqGH0/rJO5XpAtyl/RsoigW28U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ipBYqvL6BPEW0v3grsTWUn/RjdwysHV+C5/pXhLgDVpQLHJnj6teX7Vzb6QdUGQvU
         WGAOSpEFl7gw9P80k5SV5KB5dSVWQlbxNAQLfzkNgh0nUrkv5CXe5h0V+Beu/wYtrM
         C2zmX6yvQsChzIjuRAuPm+HdnyeU1BsldjtED51lNl3hH2sKe4FB9MrKnQQzdqACUi
         u+NuC29pT3gQOrRX8L78/OqIXzsqUd1O3qcwTQycWdHZls87ly/2k+AfWsRe2qEGMl
         n8xLJtOW8PU+wzesp58WlAsTQL9nS6j53xYJYkwOrem7bH4P+iZk05DLhqJPLCqkRu
         7J5fA1fUJf7eg==
Message-ID: <71e82477-16fb-2e7a-e5a9-e22327f31e77@kernel.org>
Date:   Wed, 30 Mar 2022 13:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v10 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        shruthi.sanil@intel.com, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
References: <20220322130005.16045-1-shruthi.sanil@intel.com>
 <20220322130005.16045-2-shruthi.sanil@intel.com>
 <7e711327-bcb8-4c7f-5537-425ba1a79e62@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <7e711327-bcb8-4c7f-5537-425ba1a79e62@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 13:44, Daniel Lezcano wrote:
> On 22/03/2022 14:00, shruthi.sanil@intel.com wrote:
>> From: Shruthi Sanil <shruthi.sanil@intel.com>
>>
>> Add Device Tree bindings for the Timer IP, which can be used as
>> clocksource and clockevent device in the Intel Keem Bay SoC.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> 
> 
> In order to pick this binding I need an ack from Rob or Krzysztof (added 
> to the recipients)

Rob was looking into this and there were some comments around v8, so I
will leave it to him.


Best regards,
Krzysztof
