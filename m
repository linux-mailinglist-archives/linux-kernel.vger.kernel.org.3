Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E9452895E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245015AbiEPQAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiEPQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:00:36 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E8DD2DA98;
        Mon, 16 May 2022 09:00:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6A43D8102;
        Mon, 16 May 2022 15:56:48 +0000 (UTC)
Date:   Mon, 16 May 2022 19:00:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dmtimer: ack pending interrupt during suspend on am335x/am437x?
Message-ID: <YoJ1HvIzZuir0aX0@atomide.com>
References: <YniiqM0S+hwsGFni@x1>
 <YnoK+XQiargRGUy/@atomide.com>
 <4de411aa2fc8a6f185afb8bfd5da63d4@kernel.org>
 <YoHL/+qYs47LsnCB@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoHL/+qYs47LsnCB@x1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Drew Fustini <dfustini@baylibre.com> [220516 03:54]:
> I have now done 33,175 cycles of suspend/resume with rtcwake and no
> failures have occurred. Thus, I have to conclude that mainline does not
> exhibit the problem of late timer interrupts causing suspend to fail.

OK good to hear, fingers crossed that the issue no longer exists :)

Regards,

Tony

