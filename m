Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14578544FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbiFIOuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiFIOuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:50:14 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE2A64DC;
        Thu,  9 Jun 2022 07:50:10 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B9B4B60007;
        Thu,  9 Jun 2022 14:50:04 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1nzJU3-0028mh-Kr; Thu, 09 Jun 2022 16:50:03 +0200
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
Subject: Re: [PATCH V6 2/2] rtc: zynqmp: Add calibration set and get support
References: <20220609140833.1784738-1-srinivas.neeli@xilinx.com>
        <20220609140833.1784738-2-srinivas.neeli@xilinx.com>
Date:   Thu, 09 Jun 2022 16:50:03 +0200
In-Reply-To: <20220609140833.1784738-2-srinivas.neeli@xilinx.com> (Srinivas
        Neeli's message of "Thu, 9 Jun 2022 19:38:33 +0530")
Message-ID: <87r13x28o4.fsf@dell.be.48ers.dk>
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

 > Zynqmp RTC controller has a calibration feature to compensate
 > time deviation due to input clock inaccuracy.
 > Set and get calibration API's are used for setting and getting
 > calibration value from the controller calibration register.
 > As per RTC spec default calibration value is 0x7FFF.

Where do you see that? ug1085 rev2.2 still lists:

Programming Sequences
init rtc
1. Write the value 0019_8231h into the calibration register, CALIB_WRITE.


-- 
Bye, Peter Korsgaard
