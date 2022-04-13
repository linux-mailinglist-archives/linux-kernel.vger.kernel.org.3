Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC094FF603
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiDMLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiDMLsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:48:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BF053B42
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91CC8B822A5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7460EC385A4;
        Wed, 13 Apr 2022 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649850379;
        bh=8q3QP6n8p12GITLX+ofYGPxgrlfeIJkjWHFz6p7WaRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wb/m6Cjyy5wlkN0LIv8IgBNGBjHhDgfGaAJlWtsI3iT+lE51VpUtmJR/3SX7nI5H0
         cvn2IHTcKwMCgo4rutZuKz3+/JMJOYCGlXa/sC1ljrUCoo6TW8pjghVNWF+xKymTx5
         AT0kGnAM2dcB8wf9Rhjd56T8lXIVT/FYojJX5mxacVSQJA1c/lzGwj30WSChO/5WMr
         AvMsvYAXc+c8jKjCCK9G/b/AWIaBbCgz26nLor9eVSOi0O0qpHYOH/tiI3p3iXkvHM
         hsve7rbfwicyu9+oyfN9O67z+EMidm/T+FYIGm2uM4GIbdbiXV2WO2JTNgu0v7cwKp
         hybgrmbjmQ5fQ==
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Al Grant <al.grant@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm_pmu: Validate single/group leader events
Date:   Wed, 13 Apr 2022 12:46:13 +0100
Message-Id: <164984462805.2352727.11754227231341173145.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220408203330.4014015-1-robh@kernel.org>
References: <20220408203330.4014015-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 15:33:30 -0500, Rob Herring wrote:
> In the case where there is only a cycle counter available (i.e.
> PMCR_EL0.N is 0) and an event other than CPU cycles is opened, the open
> should fail as the event can never possibly be scheduled. However, the
> event validation when an event is opened is skipped when the group
> leader is opened. Fix this by always validating the group leader events.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm_pmu: Validate single/group leader events
      https://git.kernel.org/arm64/c/e5c23779f93d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
