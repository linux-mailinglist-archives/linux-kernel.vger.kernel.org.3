Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9559CE56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiHWCLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiHWCLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:11:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E444D14C;
        Mon, 22 Aug 2022 19:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2E43B81A3C;
        Tue, 23 Aug 2022 02:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5EBC433D6;
        Tue, 23 Aug 2022 02:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220708;
        bh=c8yjdxQHEEIT0eSO6SawNYH6Dw/u9o+9BlM0G/6qXE0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gWznI177FZE6q7pzoUGsIy1kNvkCoURpygs05rZgfbVtvkQtrfshF2qkzHE+ttosN
         TMrubEbkXIE7xWcnt2O2dWxLnqAvlraUDn4uFIznWosG0ca+l7LvFKx6jGoKi8oBWd
         p8vE3T3bVj7A52fZ8AHawZFY3z2OrzRSLy5iRHvzvNY0kjmh+3HnojyRbd61aOZ2X6
         Mg4Jgtz3kSwFVRwRfMr6o/tNHq0Tg4JaaBUAr+S+7de4G9kL6jnAT/HWL43HTeLxA8
         IkmDws83faf8J7zC0YDK6uArvpR531V5ATfdCLE+zTL33WSKgbe2PE6bvywWZbAfSu
         T3EIWS9R5IfXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220811140030.28886-1-wangborong@cdjrlc.com>
References: <20220811140030.28886-1-wangborong@cdjrlc.com>
Subject: Re: [PATCH] clk: Fix comment typo
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Date:   Mon, 22 Aug 2022 19:11:45 -0700
User-Agent: alot/0.10
Message-Id: <20220823021148.5C5EBC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Wang (2022-08-11 07:00:30)
> The double `to' is duplicated in the comment, remove one.
>=20
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---

Applied to clk-next
