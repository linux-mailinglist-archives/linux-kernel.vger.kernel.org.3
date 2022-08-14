Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301A45923B9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbiHNQXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiHNQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:22:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08DF28
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C840B80AEE
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 16:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DAAC433C1;
        Sun, 14 Aug 2022 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660494048;
        bh=XM85mfKIn+FXdSO3yj/rQlZGPJFbG4bduPu9YQTfBwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWf4uQHoxKQpSkv6JS8ofJJupyYmwzcufwrM575UAdNSV+uEaoXsahbpm76Ssu4r6
         GneV3J7+dvdowP2rqV0tey2DJtGoL24nIxhCBdPwsBPlsjofQf1xflNJTxlTia2J4d
         I2BmyerFCNZtsgZZ4+uXwcpAAc6Q7XPRk4Y69pbKTl7kk4FCQIBaxmlUVM61pw/gMP
         r9rVUwWn0POc2CEvdLBlHR5FmokETgTD5mfGIG8OkJUBY7HKTR7/gqJ2cnsthocTDN
         rzufbMemAu5EeCDMilscMgSmtF3TIlhniTNcobjo5PQlYdz2OiK3jhk1BZOenKnRP5
         WKSZK97dtvP5A==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH V2] mm/damon/core: simplify the parameter passing for region split operation
Date:   Sun, 14 Aug 2022 16:20:45 +0000
Message-Id: <20220814162045.51995-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1660403943-29124-1-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaixu,

On Sat, 13 Aug 2022 23:19:03 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The parameter 'struct damon_ctx *ctx' is unnecessary in damon region
> split operation, so we can remove it.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
