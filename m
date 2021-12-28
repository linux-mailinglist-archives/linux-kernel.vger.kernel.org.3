Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F5848073E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhL1IJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhL1IJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:09:27 -0500
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27356C061574;
        Tue, 28 Dec 2021 00:09:26 -0800 (PST)
Received: from p54bc6060.dip0.t-ipconnect.de ([84.188.96.96] helo=[192.168.1.135]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n27Xw-0008Jy-Rk; Tue, 28 Dec 2021 09:09:24 +0100
Message-ID: <0086fb07-c5d3-9600-4b62-d7497b192461@birger-koblitz.de>
Date:   Tue, 28 Dec 2021 09:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v2 0/5] Rework realtek-rtl IRQ driver
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>, tglx@linutronix.de,
        maz@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, john@phrozen.org
References: <cover.1640548009.git.sander@svanheule.net>
 <90a3ce57-875f-d34a-0714-f815acae12d4@birger-koblitz.de>
 <bvv98e.r4rs9b.2rw3hx-qmf@polaris.svanheule.net>
From:   Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <bvv98e.r4rs9b.2rw3hx-qmf@polaris.svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1640678967;f4735cf5;
X-HE-SMSGID: 1n27Xw-0008Jy-Rk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sander,
> I haven't tested this with VSMP, because it is out of scope for this series. For the binding, I expect that would only require N register ranges instead of one; one per CPU. I think the driver should then be able to perform the IRQ balancing based on that information alone, given that the parent IRQs are available at each CPU.

whether this is out of the scope of this series is not the point. In my experience you only see issues with locking and race conditions with the IRQ driver if you test with VSMP enabled,
because only with VSMP you can be in the IRQ code multiple times at the same time. Since you want to change routing logic and hierarchies I would believe it to be a very good idea
to test that. The present code passes that test.

Cheers,
   Birger
