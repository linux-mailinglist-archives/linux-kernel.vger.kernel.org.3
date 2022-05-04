Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8E651A2A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351522AbiEDO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbiEDO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:56:29 -0400
X-Greylist: delayed 25244 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 07:52:51 PDT
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A521B120A9;
        Wed,  4 May 2022 07:52:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D5E7C419C2;
        Wed,  4 May 2022 14:52:45 +0000 (UTC)
Message-ID: <e0445aa6-0c96-b80d-154e-274be0c1a025@marcan.st>
Date:   Wed, 4 May 2022 23:52:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] MAINTAINERS: Add entries for Apple SoC cpufreq
 driver
Content-Language: es-ES
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220504075153.185208-1-marcan@marcan.st>
 <20220504075153.185208-2-marcan@marcan.st>
 <20220504101750.wmuicq3dytnxrw5o@vireshk-i7>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220504101750.wmuicq3dytnxrw5o@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 19.17, Viresh Kumar wrote:
> On 04-05-22, 16:51, Hector Martin wrote:
>> Splitting this commit, as usual, to facilitate merges via the SoC tree.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index edc96cdb85e8..39bfa478fe55 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1835,6 +1835,7 @@ T:	git https://github.com/AsahiLinux/linux.git
>>  F:	Documentation/devicetree/bindings/arm/apple.yaml
>>  F:	Documentation/devicetree/bindings/arm/apple/*
>>  F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
>> +F:	Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
>>  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
>>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
>>  F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>> @@ -1844,6 +1845,7 @@ F:	Documentation/devicetree/bindings/power/apple*
>>  F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>>  F:	arch/arm64/boot/dts/apple/
>>  F:	drivers/clk/clk-apple-nco.c
>> +F:	drivers/cpufreq/apple-soc-cpufreq.c
>>  F:	drivers/i2c/busses/i2c-pasemi-core.c
>>  F:	drivers/i2c/busses/i2c-pasemi-platform.c
>>  F:	drivers/irqchip/irq-apple-aic.c
> 
> This should be the last patch instead, or should at least be added
> after the files are merged first. If someone checks out at this
> commit, the files won't be available but still linked here.

Isn't that backwards? If someone touches the files, we want them to be
able to get_maintainer.pl, so the MAINTAINERS entries should come first.
It doesn't really cause any issues if there are entries that point at
files that don't exist yet, right?

Though this is mostly a moot point because the purpose of splitting this
out is so we can merge this one patch through the SoC tree, at which
point the ordering isn't guaranteed (unless the whole series goes
through SoC). It's a minor issue though; we've done it like this for
other series and it hasn't caused anyone trouble.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
