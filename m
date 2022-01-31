Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B2D4A49ED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376476AbiAaPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:13:41 -0500
Received: from out0.migadu.com ([94.23.1.103]:39974 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377316AbiAaPNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:13:35 -0500
Date:   Mon, 31 Jan 2022 16:13:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laumann.xyz; s=key1;
        t=1643642011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fftDqzCUqepXXOmzDrcegnW4RXPMjtb1ypzG8ycj4+A=;
        b=ASKw4k/Tz4HIiTpBHk+RQSEAOqjpltT0xABE7b10Q3ZwG695Ba0MMkdXz6w7k59lZBOZUA
        zTI2poRfnSTkU6Vucui2IyTH5MsX2LbDRYtzJHbs4LUhlpIURTNsCz6ezzR+8gFvghIKHh
        zEyYRn89K2LlylOYR7LCTpKhFXuPC+KZshBTxDLKaiTovhThDOr6AytC+wyEcNU+xXAAhY
        JRuX+15I7WsLXkh1lJKexLaDBWne7MwSb60JyAaMkzlIXhmJ7apl3hV0LTV16XoQlHu3+l
        wvXH8Wt4Xlgpnq93kmVmIiu1S5F+SxQvQRxjeIOonWX1s8Uw0Mer3keSPWRvvw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Thomas Bracht Laumann Jespersen <t@laumann.xyz>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/dtc: Call pkg-config POSIXly correct
Message-ID: <20220131151330.wjoc7p7qhyosljjr@sofaking>
References: <20220131112028.7907-1-t@laumann.xyz>
 <CAL_JsqJ=OBDgemXxa6vH_t-SVr2JKUGdQ2+VoHTZSodyUiPROQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ=OBDgemXxa6vH_t-SVr2JKUGdQ2+VoHTZSodyUiPROQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: laumann.xyz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It's actually 067c650c456e ("dtc: Use pkg-config to locate libyaml")
> that you are fixing.
> 
> I can fix when applying.

You are correct, my bad! Thanks.

-- Thomas
