Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD434B9DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiBQKyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:54:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbiBQKy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:54:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6702944CF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:54:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9933F61E09
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE436C340E8;
        Thu, 17 Feb 2022 10:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645095254;
        bh=RBEjloqI5bWV2jKUVhF99O8AoO57Xeda81kHdDCV0O0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KQI7vv4rRw5Za8/N3ot/EzucwUGord96YL2iq6z/6elVFUamrxqNZuJkEqsEZEHq/
         ORnIJslfH7LxPjKgRX0s9pQ0FEy4OOd37zgYVossUK6a+LgI9s02hNl0ODNd1iNzFm
         Gw8RnaC10GfKThq9g0FLdXqGLkQ4zRELO7d3yovyUsaTSWgLUjmx7EXtdzRzidaJ3V
         73caYanPDe/0wOModvDjcAszEWEdoF45zbuYovoO08XtG50lr1du4EnVPOkbMWnCOm
         HVnmcQ4bmOeOgxyNt3sCpCSFsRwJChKy+tUZj57iI8Vgd6be8lEhnARTYm19MNvD4J
         UEeakJcHmM1tw==
Message-ID: <754519255246ddb82d0549c3c8c8dbbf993a245c.camel@kernel.org>
Subject: Re: [PATCH] arm64: Do not defer reserve_crashkernel() for platforms
 with no DMA memory zones
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 17 Feb 2022 11:54:09 +0100
In-Reply-To: <ed4f4589f322bd3871f825239985410b535df30e.camel@kernel.org>
References: <1645056294-6509-1-git-send-email-vijayb@linux.microsoft.com>
         <ed4f4589f322bd3871f825239985410b535df30e.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, typos:

On Thu, 2022-02-17 at 11:49 +0100, nicolas saenz julienne wrote:
> If there approach if deemed acceptable, I'll test is on the RPi4.

"If the approach is deemed acceptable,"

Regards,
Nicoals
