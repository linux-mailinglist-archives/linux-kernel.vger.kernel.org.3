Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F400557C9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiGULst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiGULsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:48:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CCA8213C;
        Thu, 21 Jul 2022 04:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 893E061C61;
        Thu, 21 Jul 2022 11:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB39C3411E;
        Thu, 21 Jul 2022 11:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658404125;
        bh=JTMyejOti6w6vxB7oO98F/1xGgPNOKOcBtobYLK8O24=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Yk6KK4DzU4Ng4AwnWv96vLV7llVZFQ5agAqVWOkqUcqVEs/XFmNm6TtTE/tpnevvf
         Lu2Yo8MXoC8t9qaMIhXGFS42trekjXqzX+mFiNtlBRKuuaQ71mcD1DbpmBfRlNflZS
         ZaCZf/7j8LECtUdtD+SMaILQuLKiiYR/+yWkp/BvMxFICZnrp7FIHI8vLDgcaUY8be
         x7ZvuPJUvT1FVWsmAPLpss956S/AuRscKplHTZr49Dnra+UgyABm6akAL1SXxuThYU
         6urpdV44FhLe4ZK+W1YzS710Y0nHAhP2VnkVYHPSvWAD4VDkoeH4ZvK1urPZkhCxA0
         ASTVHYIAGGaog==
Date:   Thu, 21 Jul 2022 13:48:41 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Guenter Roeck <linux@roeck-us.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nergi Rahardi <nergi@google.com>,
        "Daniel J . Ogorchock" <djogorchock@gmail.com>
Subject: Re: [PATCH] HID: nintendo: Add missing array termination
In-Reply-To: <Ys33FIuNEsyZw8EF@google.com>
Message-ID: <nycvar.YFH.7.76.2207211348340.19850@cbobk.fhfr.pm>
References: <20220712221705.1847793-1-linux@roeck-us.net> <Ys33FIuNEsyZw8EF@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022, Dmitry Torokhov wrote:

> On Tue, Jul 12, 2022 at 03:17:05PM -0700, Guenter Roeck wrote:
> > joycon_dpad_inputs_jc[] is unterminated. This may result in odd warnings
> > such as
> > 
> > input: input_set_capability: invalid code 3077588140 for type 1
> > 
> > or in kernel crashes in nintendo_hid_probe(). Terminate the array to fix
> > the problem.
> > 
> > Fixes: 2af16c1f846bd ("HID: nintendo: add nintendo switch controller driver")
> > Cc: Daniel J. Ogorchock <djogorchock@gmail.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> I'd recommend tagging stable on this one.

I did so and applied, thanks.

-- 
Jiri Kosina
SUSE Labs

