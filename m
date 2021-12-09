Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE846F290
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbhLIR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:59:31 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:41689 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234129AbhLIR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:59:30 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EBBBA3201EA5;
        Thu,  9 Dec 2021 12:55:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 09 Dec 2021 12:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=
        message-id:date:mime-version:to:from:cc:subject:content-type
        :content-transfer-encoding; s=fm2; bh=kcFShMtLQnuTVcczIb8MJVBSJf
        e3FTju+OOzJ1+OYjo=; b=y5SmmOYcYRs9hDAeyWgZi5wcZN2pH8ui0tOZ8MY6ua
        ilcY4INvMQRoRU8kd6j7N8OmAiFLlJ1Q58LytyvsPe+Bhs3+9dCcU1ORgUgJirc1
        WcDbOZ5KkTNOH8/oUaYIGXKp1z1qLXl0tTymar5r+KKJmrXR9B6IUZFS8jIbAj8H
        aqHrSDSGeg3Muchz1eD+VcfPRUF5csFLztcYmLjodj2RjZXpaiHsv+xnVScyROZm
        dSkAv9wU+cCsIKzxZwhYnJt7lXYx7/4PC7vjgI6yjZ6C7tAv3f/yMlPOlPXor4pW
        m3/1CruL3lMeVum+ijOJcvjEfE6AEBchhqGuQMG2f5Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kcFShM
        tLQnuTVcczIb8MJVBSJfe3FTju+OOzJ1+OYjo=; b=lNlDoyJPTmRHtpD6PFKyq0
        me6D082DCB1SIL3kfcVsCNYe3Hs/+xxEUy+o75b3BxseUXX8Cqv6zDTxLvTZJF+U
        0M/1CavWD0HXSjUcWUIKDVDewcSPvzJ3NxgQ/MDi0M7jVaH4J/8sdns4Zfqhg9fi
        dmyUDec22G9cxhUt6pd6EJVDOzo7hY4NyJ7zNC3znVLwQmoUPPKBgn/hy1rXciaN
        EF6aMpAQioUuZY5ITG30gCYaTo/XtMqhZNu8Sd7WgarQs8870U8dXoX9/PoAziRL
        XNRtE4sRA0dXe+c5R03rix0HnTWeVNXnhEZzG1ghDParn6fIxvJB5Rt4pKsPCk1w
        ==
X-ME-Sender: <xms:KkOyYXsYgaH2ruo3DgtgxkGF--RIKc8XekInxIEd8n9BfQB01OWupw>
    <xme:KkOyYYcKUEM57L0na5O2nwqtAY8vGqdgjOeYub44kXx4G96rK--LYCndAaTqsoH9P
    XFodqYtfRNMQbKu>
X-ME-Received: <xmr:KkOyYawdXlDFQ2kt327xmzWUsJr9NdWFEp5BuYCMNPJ9PvtBAoIUPt6GSymyuzv5R3TPCnB4s-NwVhe8Vhb5yfWpQA6ckXPa3nlyMn_7DFF4HdUyOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedtgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvffhufgtgfesthejredttdefjeenucfhrhhomheplfhovghlucff
    rghnihgvlhhsuceojhgurghnihgvlhhssehsvghnthdrtghomheqnecuggftrfgrthhtvg
    hrnhepkeeffefhhfegveefgeevhefhkeeftedtueettdeuhfeuleejgfehtdeigeevtedt
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgurg
    hnihgvlhhssehsvghnthdrtghomh
X-ME-Proxy: <xmx:KkOyYWOWLo6TfqBYJnrnEuW_woB_O-4pAUVQmLpec50SR-JNHySsUw>
    <xmx:KkOyYX--eh5i17N9LEHLMoAfDlT3g8lM3bH99PJ1_iqtQ_3g25rggw>
    <xmx:KkOyYWXSY4GIzkGTSlzveEVc-tW3ot8r4hp8eoWlUhnHWOCaHaw8Mw>
    <xmx:K0OyYaY_zLZwoHc5vdkodF5rNaTynOKvr8LpDLwmlFSDopbSRbrgEw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 12:55:54 -0500 (EST)
Message-ID: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
Date:   Thu, 9 Dec 2021 10:55:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
From:   Joel Daniels <jdaniels@sent.com>
Cc:     Joel Daniels <jdaniels@sent.com>, linux-kernel@vger.kernel.org
Subject: Time keeping while suspended in the presence of persistent clock
 drift
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have an x86 laptop whose CMOS (RTC) clock gains an extra 3.75 seconds 
per day that it is suspended (S3) or off. It keeps time quite accurately 
while awake using the TSC clock source. I use the machine about 1 hour 
per day with the machine in the S3 sleep state for the remaining 23 
hours. The machine is not usually connected to a network and I do not 
run an NTP daemon (though I do not believe this is relevant). When cold 
booting, I correct for the CMOS clock drift using hwclock before making 
the filesystem writable. When resuming from suspend-to-ram (S3), 
however, I must either use hwclock again (causing the system time to 
jump backwards and potentially upsetting programs like make) or use a 
large slew rate (absolute value greater than 1000 PPM) to correct the 
system clock. As far as I can tell there is currently no way to inform 
the kernel of my CMOS clock drift. Is this correct? I am considering 
writing a patch to make the kernel compensate for the drift of the 
persistent and/or RTC clock(s) when injecting sleep time. The patch 
would require user space to inform the kernel of the drift (probably via 
sysfs). Does this seem like a good approach? Regards, Joel Daniels


