Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDFA568FA9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiGFQun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGFQum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:50:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B752F2A420;
        Wed,  6 Jul 2022 09:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7678BB81E31;
        Wed,  6 Jul 2022 16:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF57C341CA;
        Wed,  6 Jul 2022 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657126239;
        bh=Wy1TRTUE8gVOdUd024/IZBro8SbqAM+LXn9G77s0fk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqTJBrNtL3EeI6QP04OGhJlyQ3OVpR9NXXJGDUWnbrHUbgxZeNGS1SL9XeY7mZLub
         bdS8IY5BNzwy/HI0UyQLsKsQDlNMp1G4rBIFcM21LqQORJyNJ8j3DxEjPj5GECIwha
         tp6/dMEz8MvkAKcO7OMq1oChb1FTIW+0o4F3Gy5SM+HDO21DmzsOgdp+QvL+ugDYMc
         BOtaLlPPCXlMYMy2nmko+uVVdVkoiMjzgjEHhqixdhZUL58wcB6vXSB9jslLiNNGng
         HGKtYPsfwBG8cDBDQWGPG5sXk1kh9vNl11uIycFD/ps7Rrr4yzDnj3qZ3QLHhYzWdg
         rAifXCv3md9oA==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cci: Use the bitmap API to allocate bitmaps
Date:   Wed,  6 Jul 2022 17:50:29 +0100
Message-Id: <165710177848.2545023.16989792085835227804.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <fbde85a5e8ae99b10a2115d8ea1e69320a62947f.1657084786.git.christophe.jaillet@wanadoo.fr>
References: <fbde85a5e8ae99b10a2115d8ea1e69320a62947f.1657084786.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 07:20:15 +0200, Christophe JAILLET wrote:
> Use devm_bitmap_zalloc() instead of hand-writing it.
> It is less verbose and it improves the semantic.
> 
> While at it, use bitmap_zero() instead of hand-writing it.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cci: Use the bitmap API to allocate bitmaps
      https://git.kernel.org/will/c/0e35850b341e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
