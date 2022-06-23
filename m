Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392EB558952
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiFWTlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFWTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:41:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9694EF68;
        Thu, 23 Jun 2022 12:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36F44B82506;
        Thu, 23 Jun 2022 19:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F7DC341C7;
        Thu, 23 Jun 2022 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012725;
        bh=d35Z6CE+PAFQtDQJVOGzEF5E6GnLg5YFEH3tFV1T1Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNA+9hK3I1egI1fCJTewcgKvgbU+8RhS9LdHIlx4OJeU2Shdc/A/2XnZOmQpoZbGY
         xG6ZHgL5OQoXXPjYTy5sh3C06nAeavAx5iyvj5JrBVlAoBbRDrD4H35ieSiV+NHt4k
         9VoPyK4Yc4D7A+4klG6ACFCEZCCq6XqSDrqLfXxoZ2c3HnEXaYYwZQ1UjfHL/fj479
         MWOf4EBfvrG4SQ3BOg6alw/4bkNXW0ht9JsVINqegsSfZppzz+k98rCV2x8xsGKTbc
         lY4geIbEkOw0lKb4NuSQE0aP4rziFB7Nc5jxn/GgavHq+fWKLcBDaxgyuT2eAUE2X3
         Dr3h31M573ypg==
From:   Will Deacon <will@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cci: fix typo in comment
Date:   Thu, 23 Jun 2022 20:31:38 +0100
Message-Id: <165599550005.2982456.5407132591322932192.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220521111145.81697-67-Julia.Lawall@inria.fr>
References: <20220521111145.81697-67-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 13:11:17 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cci: fix typo in comment
      https://git.kernel.org/will/c/9ba86a474635

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
