Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4BA55E7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347492AbiF1PbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346765AbiF1PbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:31:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EC1114;
        Tue, 28 Jun 2022 08:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B022CB808C0;
        Tue, 28 Jun 2022 15:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBC0C3411D;
        Tue, 28 Jun 2022 15:30:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ltAr8ZlJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656430258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bojtsft/jpTOR/W8td3S9XZNxMUNZLzjWv5tSsqolts=;
        b=ltAr8ZlJvDyA/SoV/xsJMvUMhO2WjyICCIqJ7zuShdXJfSDoEUOzlvJd5sw4ru5vtzFK7B
        L7RJfUh2Ei0r4uursGJM8DTlhfacy7ewOkrZ7NtSDOTLXnLhFLtDh+sazRthrl0Oo4wOWD
        GjOKFt+OBrM7wlJAb05JIqDCPRHW57o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f049d13b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Jun 2022 15:30:57 +0000 (UTC)
Date:   Tue, 28 Jun 2022 17:30:53 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>, robh@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] dt-bindings: chosen: document rng-seed property
Message-ID: <YrserfmdD+QH+y/X@zx2c4.com>
References: <20220627152107.645860-1-Jason@zx2c4.com>
 <CAJMQK-jGsobw7i4NjQ4oezA0rU03ECs_nY=Txr6TgsHFu2jXhg@mail.gmail.com>
 <Yrsc+50Y2UX1wlYH@zx2c4.com>
 <c8dddfe6-6385-ed34-e789-9f845c8a32bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8dddfe6-6385-ed34-e789-9f845c8a32bd@linaro.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Jun 28, 2022 at 05:26:45PM +0200, Krzysztof Kozlowski wrote:
> Instead submit a patch removing it. There is no particular point to
> duplicate bindings and dt-schema is the core here, the main one.

Okay, will do.

Jason
