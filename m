Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8914154AF66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiFNLjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiFNLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:39:42 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CC9419AC;
        Tue, 14 Jun 2022 04:39:40 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 86651240004;
        Tue, 14 Jun 2022 11:39:36 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1o14tT-0006Mp-9e; Tue, 14 Jun 2022 13:39:35 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>, <srinivas.neeli@amd.com>,
        <neelisrinivas18@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>
Subject: Re: [PATCH V8 2/3] rtc: zynqmp: Updated calibration value
References: <20220613125836.523449-1-srinivas.neeli@xilinx.com>
        <20220613125836.523449-2-srinivas.neeli@xilinx.com>
Date:   Tue, 14 Jun 2022 13:39:35 +0200
In-Reply-To: <20220613125836.523449-2-srinivas.neeli@xilinx.com> (Srinivas
        Neeli's message of "Mon, 13 Jun 2022 18:28:35 +0530")
Message-ID: <878rpzwk20.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Srinivas" == Srinivas Neeli <srinivas.neeli@xilinx.com> writes:

 > As per RTC spec default calibration value is 0x7FFF.
 > Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>

> ---
 > Changes in V8
 > -None, just swapped 2/3 and 3/3 patches from V7.
 > Changes in V7:
 > -New patch
 > -TRM not updated yet, Internal design document contains 0x7FFF as
 >  default value. TRM Will update in next release.

Maybe add this to the commit message so it is clear where this comes
from. If possible specific the TRM version number that will contain the
fix.

Other than that:

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
