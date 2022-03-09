Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB94D2D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiCIKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiCIKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:43:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E15965F1;
        Wed,  9 Mar 2022 02:42:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 806A761782;
        Wed,  9 Mar 2022 10:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25F8C340E8;
        Wed,  9 Mar 2022 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646822564;
        bh=rSMc4bqxAq+I7bLtI0sKbI3dBe9JJiNBmFiYMixL7Aw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eH9NtVA52YAPi+N4BSF1VamhR6QseVPKvFr/3hD6pfI9nTxRpYDYaHVSBpfsIZchr
         GqMF5ghgwYsnhNTYuGdb/gczQhBfpueA5IywR6upt3AZC4wwl2JywymtTHt0RlRPu7
         LAdQUFlUrNBGZqF156afYcJ7i6LlP4m2OhWWDb9/AL+HXe/UF2ULkPvudrivN1FeVr
         3f0nSOXk/nlI26VpmjlQ+g1suOs6/IOXIW5eNNscWRrhWCaDUlwMW53sdbN2s9QnCA
         O26Y9I5mVyFE1rud/bMJPTch2/TrhcvUuvksit8WQ0sFSnL4EZaEZ92oKjB33iW2Qf
         iwgQBxvsTj35w==
Date:   Wed, 9 Mar 2022 11:42:41 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean O'Brien <seobrien@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: vivaldi: fix sysfs attributes leak
In-Reply-To: <CAKdAkRT+X1YXGqcLTvmEyyxrkozmakR=1y8Y4nfK5=G2UYFK_w@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2203091142180.24795@cbobk.fhfr.pm>
References: <YhmAAjNeTjiNoLlJ@google.com> <nycvar.YFH.7.76.2203011531370.11721@cbobk.fhfr.pm> <CAKdAkRT+X1YXGqcLTvmEyyxrkozmakR=1y8Y4nfK5=G2UYFK_w@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022, Dmitry Torokhov wrote:

> Jiri, are you planning to send this for 5.17 or 5.18?

Hi Dmitry,

I've sent it to Linus for 5.17-rc still earlier today.

-- 
Jiri Kosina
SUSE Labs

