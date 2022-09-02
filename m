Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3DB5AB406
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiIBOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbiIBOsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:48:16 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0F8F4910;
        Fri,  2 Sep 2022 07:09:03 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 57206C000A;
        Fri,  2 Sep 2022 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662127742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwleTND+oOvh2FdL5+oLza0mQuVU2huCMJekGo8cmFU=;
        b=iMcvnnJectwUQ4XiTcrylv5Pa3IwDxZzYx1X+kow2ahuIUc6EI2JV9Y4o1U5Ir/Aq2aLcy
        xjJo6S2na70zyMrDD58uV0nJwrRNAi2DkKK9Y+ZV6ijw3eukXpDTQTjktRs4LHE8Uon9xy
        Xz4TR+JREgqSAfOV3gTCQAIaDfB2+A/1G5Iz30KNDXX9V/7PNTkNcMJqz7bUGFtgpNwvmv
        H8J5cltfpRfFanV/qj3Wm4UTWOFkhKpbt4XrhP7WxiZsPz/9Ct5AypWttcZs+JWqZ6th85
        uJJYH8vov/x+yHQ5k/yzdX/wpVqwexpJZxNRmG6ioYGFZjUf6JFsSPRP4VlWEw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: ARM: marvell: include bindings
In-Reply-To: <YvKSrD3kG3rnozju@lunn.ch>
References: <20220809055729.19242-1-krzysztof.kozlowski@linaro.org>
 <YvKSrD3kG3rnozju@lunn.ch>
Date:   Fri, 02 Sep 2022 16:08:59 +0200
Message-ID: <875yi5g96s.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

> On Tue, Aug 09, 2022 at 08:57:29AM +0300, Krzysztof Kozlowski wrote:
>> Include top-level Marvell bindings in Marvell maintainer entries.
>> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Gregory
>
>     Andrew

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
