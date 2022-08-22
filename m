Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A143E59BD17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiHVJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiHVJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:44:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5BB26565
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:44:17 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M5UW4B009136;
        Mon, 22 Aug 2022 04:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=KUDNYanUr3tKoXxWjUfjw2VgStT2U7oToW0OP5HRHlQ=;
 b=CjXjRw1zYnbqukvIi6yQfPwUJLHhQKE17tJ1SoEL0h9UeuKytfrbVlXcx7aWmWrA5UyJ
 X7GALinPjybwVIrfiRkSsQXxyAMUqpLkLHsvuzsPVqYAwLQFqhk6YfwCmjIwN727343m
 VmmFOs8kelhuj1czuJ3t7UWg95Iz8m2B4BK8Bu5k67WSvaW1AFmJP96gd13gpBm3RhZz
 QIjnFJsBGh+keoC8fQU7sYmlBIqsHnOOSYHjEspVT/FeH0v7tuG3XJ83b32cKYYgpYsl
 TleE0LWqwQ4yix9XyumJc0SOMR7X4veRdKN4L+7PWPoRFKHIfVz3xezLXt48+CUNzxGB vQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3j2x1e9xsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 04:44:08 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 22 Aug
 2022 04:44:07 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Mon, 22 Aug 2022 04:44:07 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4A851B06;
        Mon, 22 Aug 2022 09:44:07 +0000 (UTC)
Date:   Mon, 22 Aug 2022 09:44:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 21/30] mfd: arizona: Remove #ifdef guards for PM
 related functions
Message-ID: <20220822094407.GL92394@ediswmail.ad.cirrus.com>
References: <20220808174107.38676-1-paul@crapouillou.net>
 <20220808174107.38676-22-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220808174107.38676-22-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: Kes5UL6EvI-fs9whM-NKReRfjB6kgFab
X-Proofpoint-GUID: Kes5UL6EvI-fs9whM-NKReRfjB6kgFab
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 07:40:58PM +0200, Paul Cercueil wrote:
> Use the new EXPORT_GPL_DEV_PM_OPS() and pm_ptr() macros to handle the PM
> callbacks.
> 
> These macros allow the PM functions to be automatically dropped by the
> compiler when CONFIG_PM is disabled, without having to use #ifdef
> guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
