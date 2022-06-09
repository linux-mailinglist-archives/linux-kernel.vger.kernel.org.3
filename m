Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70449544FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbiFIOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbiFIOxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:53:53 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA4B236869;
        Thu,  9 Jun 2022 07:53:50 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1F844E000B;
        Thu,  9 Jun 2022 14:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654786429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f976Phy9dbyp8PfTdJv/r4/TWKmZetB6K2N29VZ68bs=;
        b=oMlNSPZmrZnLNnhi2KkImi3VKLojeIwiLpBjpjbDiyOQVtdONpj0Q5u9R/z5x7F728VbNN
        bwU5IiAqaPTTUJ0l3WnliDh6Q5OcXZ1ABl+3ZAuvnA2gOJBtvvRpmmlD5QVmLhP9oOPHmw
        kE/E1kC4odTMFH1BEnozW2b3pdFcqyE9/C4QaSZC02auE6yyOF+XpIqapyZoE4YgkHBsEf
        0SQOC2Bj3R22/Qgkp6MCXP94TUzzqzHzQqQRy8pOK/RHjowU6WuKvLJI309cRyaLvGnpb3
        DXEiBOoH+9tNbmY7/uuJlhdPoeH8Y69+vbrOTJXCeh2PTwkhLs2Mx1XESKUPdw==
Date:   Thu, 9 Jun 2022 16:53:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, sgoud@xilinx.com, shubhraj@xilinx.com,
        srinivas.neeli@amd.com, neelisrinivas18@gmail.com,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH V6 2/2] rtc: zynqmp: Add calibration set and get support
Message-ID: <YqIJektBvAwOqNkA@mail.local>
References: <20220609140833.1784738-1-srinivas.neeli@xilinx.com>
 <20220609140833.1784738-2-srinivas.neeli@xilinx.com>
 <87r13x28o4.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r13x28o4.fsf@dell.be.48ers.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 16:50:03+0200, Peter Korsgaard wrote:
> >>>>> "Srinivas" == Srinivas Neeli <srinivas.neeli@xilinx.com> writes:
> 
>  > Zynqmp RTC controller has a calibration feature to compensate
>  > time deviation due to input clock inaccuracy.
>  > Set and get calibration API's are used for setting and getting
>  > calibration value from the controller calibration register.
>  > As per RTC spec default calibration value is 0x7FFF.
> 
> Where do you see that? ug1085 rev2.2 still lists:
> 
> Programming Sequences
> init rtc
> 1. Write the value 0019_8231h into the calibration register, CALIB_WRITE.
> 

This is a very weird value. Last time I had a look, I couldn't find an
explanation for it.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
