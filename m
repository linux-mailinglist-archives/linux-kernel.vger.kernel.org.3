Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCB15AFFBF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIGI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:59:16 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9064BA572A;
        Wed,  7 Sep 2022 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662541155;
  x=1694077155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NCvMmfchnGPeVaarb8daTn1zsbjoZBkx6giRlsMO4Fo=;
  b=etJ4jxUEY03Tg9+tZm4yiWTGZPseq7bCGMqDUqoyRspSL8o2fSZtVCdp
   tdO0n/Ip+V5PIYoHzyihtNvBxTTkM6iLX5yDmqd3zh4B6JBe4fRNdwjn9
   uPpwYSbIBrabCI9omfhMgK5frr91eLMPERM6hp1HP91c9bml0bvszMXUQ
   +74q6FvReMEvcpaP+4myUkK144SgxieuOK9XX2PpWOOHr6pHdjC9RoVwS
   thvlCwl0aGwIbVJafaVBgKahyaqZk2eqZo3i8znLASDrESVWmMKLXIhVl
   mOp/GmU6z2t4cB8s9yylvmpBsH+OZG59oWhsJrZE85+TMEf/+7LG21oxu
   g==;
Date:   Wed, 7 Sep 2022 10:59:12 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v4 3/4] clocksource/drivers/exynos_mct: Support
 local-timers property
Message-ID: <YxhdYAmSIzUGN5od@axis.com>
References: <20220609112738.359385-1-vincent.whitchurch@axis.com>
 <20220609112738.359385-4-vincent.whitchurch@axis.com>
 <d0f3bab8-fadb-709c-7118-20e23fba1dc4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d0f3bab8-fadb-709c-7118-20e23fba1dc4@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:11:15PM +0200, Krzysztof Kozlowski wrote:
> On 09/06/2022 13:27, Vincent Whitchurch wrote:
> > If the device tree indicates that the hardware requires that the
> > processor only use certain local timers, respect that.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Daniel,
> All patches got my review. Do you need here anything more? It seems it's
> only me who reviews such code, so I don't expect more Rb-tags. :)

It's been a couple of months, and unless I'm missing something, it looks
like this series did not get merged, and nor did it receive any further
comments.  Should I resend it with Krzysztof's Reviewed-by tags?
