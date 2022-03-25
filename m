Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF04E7179
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbiCYKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244281AbiCYKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:45:06 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6285A24085;
        Fri, 25 Mar 2022 03:43:29 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 92094C0004;
        Fri, 25 Mar 2022 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648205008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOD+zrnA9txJY0bM10drvRtLQGqbPxHtYntQchITjuQ=;
        b=MKZi/pKC7+9rUidQuDE7+801NJ3t3rY8PIWduK079IJOi9znBcOuIVXU9sZtN+qAC4CxZS
        Hpcqq9efPT947uRh1uGsqGnM+5tnjzrjkwkeXmZkvls1+M+GUA3KOyMoISlDg3D9oiabuZ
        IIdksm0VuiyqJoTVZTph03T2idxXjJTU+Iqht+R8EaBlspUrUGpjRqlM1UO2IINLHSsuio
        KFooh77SZS3wItYcq1g+S1k+qjolczg4oR0vL+Wp0sgMNBgqRJAXmUlItiAk8dLEiO1Nw4
        iSERAQVwwOSOh/urM5g9IIdS0E4IJNOhXj6t2XcSY0bzCRX3gQOOC02CfNYGGw==
Date:   Fri, 25 Mar 2022 11:43:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4] rtc: optee: add RTC driver for OP-TEE RTC PTA
Message-ID: <164820498345.150187.420135785211936016.b4-ty@bootlin.com>
References: <20220308133505.471601-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220308133505.471601-1-clement.leger@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 14:35:05 +0100, Clément Léger wrote:
> This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
> This PTA allows to query RTC information, set/get time and set/get
> offset depending on the supported features.
> 
> [1] https://github.com/OP-TEE/optee_os/pull/5179
> 
> 
> [...]

Applied, thanks!

[1/1] rtc: optee: add RTC driver for OP-TEE RTC PTA
      commit: 81c2f059ab90b221931e78503c80dcd8fbadac53

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
