Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A758D85F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiHILrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiHILrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:47:07 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782E318E13;
        Tue,  9 Aug 2022 04:47:03 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 19D0D1BF208;
        Tue,  9 Aug 2022 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1660045622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sn5WOfQFWegJOVWU8kZPNtFmDgMIcjaPuOZlWUexaf4=;
        b=U1MrIO5TAKMmM1emp4U1n/4d+GT4nN4sm6seFBMkb5zUniu9xq4U+Ndmt3/LJj687hixUK
        ufP9MusDQibxL82X6nTKiC90HVBxVhxKoYqd82AcaWj3WQG2LzxvKA9EiwiL/LEw0B0U9m
        eYKcBxbMFK9ZI4TeRtiAs0RbFLAV8CWIeXeNHbzs011u/YPJrGsc8Owa3uxcSSZLarJDIZ
        GoQOwhWbJq/MTrB15kmZBPjwlBDhFCC8qOx4ihM9mqXOYk4xQvdL1Lhm6S+ISA4D8fFHd1
        paNtRhJi4Z4QEXSuulQ8N8ywpfmOazCE5TAUaZVuvc2zmf7qexYEuAKmtGJ7+A==
Date:   Tue, 9 Aug 2022 13:47:00 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, zengjx95@gmail.com
Cc:     linuszeng@tencent.com, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] rtc: rtc-spear: set range max
Message-ID: <166004560453.856732.1541589494706195860.b4-ty@bootlin.com>
References: <20220728100101.1906801-1-zengjx95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728100101.1906801-1-zengjx95@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 18:01:01 +0800, Zeng Jingxiang wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> In the commit f395e1d3b28d7c2c67b73bd467c4fb79523e1c65
> ("rtc: spear: set range"), the value of
> RTC_TIMESTAMP_END_9999 was incorrectly set to range_min.
> 390	config->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
> 391	config->rtc->range_max = RTC_TIMESTAMP_END_9999;
> 
> [...]

Applied, thanks!

[1/1] rtc: rtc-spear: set range max
      commit: 03c4cd6f89e074a51e289eb9129ac646f0f2bd29

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
