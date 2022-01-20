Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0650494948
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359146AbiATIRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:17:42 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:48349 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiATIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:17:42 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 77D0122247;
        Thu, 20 Jan 2022 09:17:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642666659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUSKoJKnfr9VtGdXeTwdINopXvfCSmlllrWq+Z4vsNs=;
        b=P3xM356wk08R6UjXhlYdqVg5BFs6bGhkJ2DaHSxsF7jbeY0vXXExbRRSgoEaO8g/Gut+wk
        JP/58O832a6+xsiIqfeVcNRpCPh0jKZLOpIPT6OMeUzPyOzH9djngMlnsNVNpA4VGgZEzE
        AVgrwAQbhW5H+jPPaqYYjBBDRPcQaHw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Jan 2022 09:17:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH 2/7] arm64: dts: ls1028a: move Mali DP500 node into /soc
In-Reply-To: <AS8PR04MB89460673836CDB9AEFC0C09A8F5A9@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20210831134013.1625527-1-michael@walle.cc>
 <20210831134013.1625527-3-michael@walle.cc>
 <AS8PR04MB89460673836CDB9AEFC0C09A8F5A9@AS8PR04MB8946.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <ad65d1782c051a51534ad0197cc374d8@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-01-20 09:06, schrieb Leo Li:
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: Tuesday, August 31, 2021 9:40 PM
>> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; 
>> linux-
>> kernel@vger.kernel.org
>> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
>> Herring <robh+dt@kernel.org>; Vladimir Oltean 
>> <vladimir.oltean@nxp.com>;
>> Michael Walle <michael@walle.cc>
>> Subject: [PATCH 2/7] arm64: dts: ls1028a: move Mali DP500 node into 
>> /soc
>> 
>> Move it inside the /soc subnode because it is part of the CCSR space.
> 
> I just noticed that the dp0_out label has been changed to dpi0_out
> besides the move.  Is this an intentional change or a typo?  If
> intentional we probably should mention it, otherwise we should change
> it back as it is breaking build for off-tree patch that uses the
> label.

It's intentional, because dp0_out might sound like displayport. And
from what I've found the output is a display pixel interface, hence dpi.

I agree, that this should have been two patches, must have slipped.
But this series was merged months ago, so we can't change anything
anymore.

Besides, given the fact that there is no support for the DisplayPort
PHY in upstream (yet, I'm working on that), I doubt there are any
out-of-tree device trees, which don't use the proprietary NXP
driver.

Also, if there is an out-of-tree device tree, it should be easy
enough for NXP to change that :)

-michael
