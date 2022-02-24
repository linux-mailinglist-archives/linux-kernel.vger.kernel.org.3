Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02764C3330
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiBXRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiBXRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:08:16 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9413AA05;
        Thu, 24 Feb 2022 09:07:46 -0800 (PST)
Received: from [IPV6:2a01:e0a:169:7140:ce74:6df2:4b76:b230] (unknown [IPv6:2a01:e0a:169:7140:ce74:6df2:4b76:b230])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1BA3BDD;
        Thu, 24 Feb 2022 18:07:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645722464;
        bh=D2a93rPWkVKoG+sE648U0MWSh1vgQGn4Uo4Xu0sEm3c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jBNuK1nmNYi/KC7/e63HfnZG1cDRE3nntQC7BVbabJbb++KCDv9Gaae8J3ZnlsDiZ
         MyPYShK4RjDeWJuwx690bAj23fduA0nzl/tUAQ7ex4Hbl4ZopIySqDVqLHdUh0L/Bw
         0l+hoVQ4956lGlMx7FyEO7BK912Dsr5tioUmg1yQ=
Message-ID: <944bdedc-afbb-e427-bd1d-676f8ed21a48@ideasonboard.com>
Date:   Thu, 24 Feb 2022 18:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5.1 2/2] ARM: dts: bcm2711: Add unicam CSI nodes
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        rjui@broadcom.com, f.fainelli@gmail.com, nsaenz@kernel.org,
        robh+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        dave.stevenson@raspberrypi.com, naush@raspberrypi.com
References: <20220208155027.891055-7-jeanmichel.hautbois@ideasonboard.com>
 <20220223143434.71853-1-jeanmichel.hautbois@ideasonboard.com>
 <20220223143434.71853-2-jeanmichel.hautbois@ideasonboard.com>
 <3fceae58-b43e-0034-19c2-078f18010001@i2se.com>
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
In-Reply-To: <3fceae58-b43e-0034-19c2-078f18010001@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 24/02/2022 18:03, Stefan Wahren wrote:
> Hi Jean-Michel,
> 
> the version v5.1 is a little bit confusing, because it looks like to be
> applied to stable linux-5.1, which is not intended.

Sorry for the confusion, I don't want to send a full v6 now, as it will 
need to be rebased on top of the multiplexed streams series in its v11 
which is not yet posted on the ML :-).

> 
> Am 23.02.22 um 15:34 schrieb Jean-Michel Hautbois:
>> Add both MIPI CSI-2 nodes in the core bcm2711 tree. Use the 3-cells
>> interrupt declaration, corresponding clocks and default as disabled.
>>
>> Thanks to Stefan Wahren for his guidance on how to deal with different
>> RPi variants.
> 
> Can you please explain why you split these patches from the original series?

Because the firmware clocks are independent from the csi nodes and so, 
it sounded logical to split it in half ?

> 
> I didn't had the time to test, but applying these patches would
> "disable" bcm2835-camera driver?

Wasn't it already the case ? It is intended, we don't want those to be 
"okay" by default ? Or do I miss your point maybe (probably :-)) ?

Thanks,
JM

> 
> Best regards
> Stefan
> 
> 
