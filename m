Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D906158CE3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbiHHTDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiHHTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:03:03 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954461151;
        Mon,  8 Aug 2022 12:03:02 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 216A72224F;
        Mon,  8 Aug 2022 21:03:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659985380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjApsE527+vjxy7MifBLDB/wEE1m9NLBNYusyTH6zIM=;
        b=YY5Cqyqi2EXeYlfcC9qpn/yJNyvMbXG3M2UtWZJSeo25KELerGFutoO+3mf3N9CtQFu8Qm
        G8StE/1G12VyjBwrLSY/LEvnRJYkaMMx9d9kwsVQ5xb1zzqbrvqpDx9btq0TShItZ33jID
        WHEAZutf0MGGyXpnbNjjerL7fw/BCz8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Aug 2022 21:03:00 +0200
From:   Michael Walle <michael@walle.cc>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, dan.carpenter@oracle.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/4] thermal/of: Return -ENODEV instead of -EINVAL if
 registration fails
In-Reply-To: <20220808180915.446053-2-daniel.lezcano@linaro.org>
References: <20220808180915.446053-1-daniel.lezcano@linaro.org>
 <20220808180915.446053-2-daniel.lezcano@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0b684e5cb8b97227cf2f5e2c2dc6d039@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-08-08 20:09, schrieb Daniel Lezcano:
> The previous version of the OF code was returning -ENODEV if no
> thermal zones description was found or if the lookup of the sensor in
> the thermal zones was not found.
> 
> The backend drivers are expecting this return value as an information
> about skipping the sensor initialization and considered as normal.
> 
> Fix the return value by replacing -EINVAL by -ENODEV
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Tested-by: Michael Walle <michael@walle.cc>

