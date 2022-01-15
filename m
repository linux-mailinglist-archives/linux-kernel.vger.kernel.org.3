Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1A48F6B7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiAOM0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiAOM0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:26:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA6C061574;
        Sat, 15 Jan 2022 04:26:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0036B801C1;
        Sat, 15 Jan 2022 12:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C935C36AE3;
        Sat, 15 Jan 2022 12:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642249581;
        bh=kIRhRIhmHyuVtgrFBJFVRrB2x5jOVI1sMyRQaoKjuHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHy6IDmtSBRLvfge/vX9jilP//1kEu+ZdhBSP01xtYy42Yk7lNr3bj13r5ua3Sfe9
         vOCmFkfoB2z/qmZH0Pj3lf77sBOblIzSBaFIAag/A+XTYKLp+jwdT/QC3Xz3aV7rTy
         75NLTwEf79Wzt7g/l3L1dcgC/ulGPjj3jDZVqBGRMFkzkGDo2XYrZixaJSOHwFYdXU
         AEuqH2J6bNZhHpsVu1kBKJpfqNVpBX6H6g0r5Y5sk4P4WsM3uTsgivye3POwKTnxge
         2K7CeyJGwToomw9BUhxeHZJ6hsOV8dsmBJ5ZSxTgCyhZh7O2koBvjaivFGRI7xzKiz
         QDgSDTkj2Vxpg==
Received: by pali.im (Postfix)
        id 85C1486D; Sat, 15 Jan 2022 13:26:18 +0100 (CET)
Date:   Sat, 15 Jan 2022 13:26:18 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for
 marvell,armada-3700-uart-clock
Message-ID: <20220115122618.plhiqnjh2755bv5h@pali>
References: <20210930095838.28145-1-pali@kernel.org>
 <20210930095838.28145-4-pali@kernel.org>
 <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com>
 <20211015090937.gnt66hgugrhwnkei@pali>
 <20211015093701.pfvkighxsndj4ujg@pali>
 <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
 <20211016064210.7ahqfqcvf66wtt66@pali>
 <20220115080213.0CCAFC36AE3@smtp.kernel.org>
 <20220115115018.he4hnnhlvrb6kann@pali>
 <20220115130509.4a240730@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220115130509.4a240730@thinkpad>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 January 2022 13:05:09 Marek Behún wrote:
> On Sat, 15 Jan 2022 12:50:18 +0100
> Pali Rohár <pali@kernel.org> wrote:
> 
> > On Saturday 15 January 2022 00:02:11 Stephen Boyd wrote:
> > > Quoting Pali Rohár (2021-10-15 23:42:10)  
> > > > 
> > > > If I was designing this driver and DTS bindings I would have choose
> > > > something like this:
> > > > 
> > > > uart@0x12000 {  
> > > 
> > > Drop the 0x
> > >   
> > > >     reg = <0x12000 0x18>, <0x12200 0x30>;
> > > >     clock-controller {
> > > >         ...
> > > >     };  
> > > 
> > > Drop this node and put whatever properties are inside into the parent
> > > node.
> > >   
> > > >     serial1 {
> > > >         ...
> > > >         status = "disabled";
> > > >     };
> > > >     serial2 {
> > > >         ...
> > > >         status = "disabled";
> > > >     };
> > > > };
> > > > 
> > > > Meaning that 0x12000 node would be 3 subnodes and all registers would be
> > > > defined in top level nodes and would be handled by one driver.
> > > > 
> > > > This is really how hardware block looks like. But it is not backward
> > > > compatible...  
> > > 
> > > Sounds good to me. I presume we need the serial child nodes so we can
> > > reference them from the stdout-path?  
> > 
> > Yes, exactly, separate nodes for serial1 and serial2 are still required.
> > 
> > But dropping clock controller is not possible as for higher baudrates we
> > need to use and configure uart clock controller. Without it we just get
> > comparable feature support which is already present in driver.
> 
> What Stephen means is making clock controller out of the uart node
> directly. No need to add separate subnode just for clock controller.

This is already implemented in v7 patch series. Clock controller is
already outside of uart nodes.
