Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD2546343
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiFJKMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244063AbiFJKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:12:21 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5611EC1EEA;
        Fri, 10 Jun 2022 03:12:19 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 791571BF205;
        Fri, 10 Jun 2022 10:12:12 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1nzbch-002yue-5W; Fri, 10 Jun 2022 12:12:11 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     "Neeli, Srinivas" <srinivas.neeli@amd.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "sgoud@xilinx.com" <sgoud@xilinx.com>,
        "shubhraj@xilinx.com" <shubhraj@xilinx.com>,
        "neelisrinivas18@gmail.com" <neelisrinivas18@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>
Subject: Re: [PATCH V6 2/2] rtc: zynqmp: Add calibration set and get support
References: <20220609140833.1784738-1-srinivas.neeli@xilinx.com>
        <20220609140833.1784738-2-srinivas.neeli@xilinx.com>
        <87r13x28o4.fsf@dell.be.48ers.dk> <YqIJektBvAwOqNkA@mail.local>
        <87mtel287y.fsf@dell.be.48ers.dk>
        <BY5PR12MB40335583AD9D0527DEEFC4E093A69@BY5PR12MB4033.namprd12.prod.outlook.com>
Date:   Fri, 10 Jun 2022 12:12:11 +0200
In-Reply-To: <BY5PR12MB40335583AD9D0527DEEFC4E093A69@BY5PR12MB4033.namprd12.prod.outlook.com>
        (Srinivas Neeli's message of "Fri, 10 Jun 2022 10:02:47 +0000")
Message-ID: <87pmjgyghw.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Neeli," == Neeli, Srinivas <srinivas.neeli@amd.com> writes:

Hi,

 >> >> Where do you see that? ug1085 rev2.2 still lists:
 >> >>
 >> >> Programming Sequences
 >> >> init rtc
 >> >> 1. Write the value 0019_8231h into the calibration register, CALIB_WRITE.
 >> >>
 >> 
 >> > This is a very weird value. Last time I had a look, I couldn't find an  >
 >> explanation for it.
 >> 
 >> Agreed. I am not arguing that it is sensible, I just wondered where this new
 >> value comes from?
 >> 
 > This information is missing in our TRM, as per the internal RTC IP
 > design specification document, the calibration value should be crystal
 > clock frequency minus one.
 > For a crystal oscillator of 32.768KHz(0x8000) frequency, the calibration value will be 0x7FFF.

 > Will update TRM with the required information.

Ok, great!

Please put this change in a separate commit from the get/set logic.

-- 
Bye, Peter Korsgaard
