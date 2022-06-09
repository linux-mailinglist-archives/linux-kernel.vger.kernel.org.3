Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6122E545009
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245186AbiFIPAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbiFIO7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:59:52 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC8A1F8993;
        Thu,  9 Jun 2022 07:59:50 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C09A3C000D;
        Thu,  9 Jun 2022 14:59:46 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1nzJdR-0029HW-SW; Thu, 09 Jun 2022 16:59:45 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, sgoud@xilinx.com, shubhraj@xilinx.com,
        srinivas.neeli@amd.com, neelisrinivas18@gmail.com,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH V6 2/2] rtc: zynqmp: Add calibration set and get support
References: <20220609140833.1784738-1-srinivas.neeli@xilinx.com>
        <20220609140833.1784738-2-srinivas.neeli@xilinx.com>
        <87r13x28o4.fsf@dell.be.48ers.dk> <YqIJektBvAwOqNkA@mail.local>
Date:   Thu, 09 Jun 2022 16:59:45 +0200
In-Reply-To: <YqIJektBvAwOqNkA@mail.local> (Alexandre Belloni's message of
        "Thu, 9 Jun 2022 16:53:46 +0200")
Message-ID: <87mtel287y.fsf@dell.be.48ers.dk>
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

>>>>> "Alexandre" == Alexandre Belloni <alexandre.belloni@bootlin.com> writes:

 > On 09/06/2022 16:50:03+0200, Peter Korsgaard wrote:
 >> >>>>> "Srinivas" == Srinivas Neeli <srinivas.neeli@xilinx.com> writes:
 >> 
 >> > Zynqmp RTC controller has a calibration feature to compensate
 >> > time deviation due to input clock inaccuracy.
 >> > Set and get calibration API's are used for setting and getting
 >> > calibration value from the controller calibration register.
 >> > As per RTC spec default calibration value is 0x7FFF.
 >> 
 >> Where do you see that? ug1085 rev2.2 still lists:
 >> 
 >> Programming Sequences
 >> init rtc
 >> 1. Write the value 0019_8231h into the calibration register, CALIB_WRITE.
 >> 

 > This is a very weird value. Last time I had a look, I couldn't find an
 > explanation for it.

Agreed. I am not arguing that it is sensible, I just wondered where this
new value comes from?

-- 
Bye, Peter Korsgaard
