Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D04943FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 01:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345020AbiATAG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 19:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344841AbiATAG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 19:06:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDB0C061574;
        Wed, 19 Jan 2022 16:06:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF26D61456;
        Thu, 20 Jan 2022 00:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD47C004E1;
        Thu, 20 Jan 2022 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642637215;
        bh=r4bINdjoOTnEU/UYxNN2T4b77oF6UWi884STkiJNMhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrlMGGnvNIAwtjHyYDxmlQVpDYOsczv97GeteddoOdjqAro80WlhkzE4b3lRVNxoM
         c4HXMJjtZWqBxSbK+k1ZqBgTaaYUXJAmx4/uhyyr6pN92//p3QIly3t0cX8vjHjZMd
         L9SNnz5cDcaNzl9A7ZD0UC5UC1IaBLHzdZSdUxQs1OG4Ue52WfaQILP/00JKS+/GUf
         Bq40dkTEwSqZUiIZU75owstSUs1RFxxZX+N9nAvmlErwnNKZmfUfcC0uQCbECOh71Y
         v1z78h6gqDS1d7G5/9UfmM+X+dFBXp2KqrIClOz096U6imXl7CTA8HaRCPQWOfR7eM
         EWVTmmbcKwTzA==
Received: by pali.im (Postfix)
        id 1EBC07DF; Thu, 20 Jan 2022 01:06:52 +0100 (CET)
Date:   Thu, 20 Jan 2022 01:06:51 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
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
Message-ID: <20220120000651.in7s6nazif5qjkme@pali>
References: <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com>
 <20211015090937.gnt66hgugrhwnkei@pali>
 <20211015093701.pfvkighxsndj4ujg@pali>
 <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
 <20211016064210.7ahqfqcvf66wtt66@pali>
 <20220115080213.0CCAFC36AE3@smtp.kernel.org>
 <20220115115018.he4hnnhlvrb6kann@pali>
 <20220115130509.4a240730@thinkpad>
 <20220115122618.plhiqnjh2755bv5h@pali>
 <20220119231655.EFFF3C004E1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220119231655.EFFF3C004E1@smtp.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 January 2022 15:16:54 Stephen Boyd wrote:
> Quoting Pali Rohár (2022-01-15 04:26:18)
> > On Saturday 15 January 2022 13:05:09 Marek Behún wrote:
> > > On Sat, 15 Jan 2022 12:50:18 +0100
> > > Pali Rohár <pali@kernel.org> wrote:
> > > 
> > > > On Saturday 15 January 2022 00:02:11 Stephen Boyd wrote:
> > > > > Quoting Pali Rohár (2021-10-15 23:42:10)  
> > > > > > 
> > > > > > If I was designing this driver and DTS bindings I would have choose
> > > > > > something like this:
> > > > > > 
> > > > > > uart@0x12000 {  
> > > > > 
> > > > > Drop the 0x
> > > > >   
> > > > > >     reg = <0x12000 0x18>, <0x12200 0x30>;
> > > > > >     clock-controller {
> > > > > >         ...
> > > > > >     };  
> > > > > 
> > > > > Drop this node and put whatever properties are inside into the parent
> > > > > node.
> > > > >   
> > > > > >     serial1 {
> > > > > >         ...
> > > > > >         status = "disabled";
> > > > > >     };
> > > > > >     serial2 {
> > > > > >         ...
> > > > > >         status = "disabled";
> > > > > >     };
> > > > > > };
> > > > > > 
> > > > > > Meaning that 0x12000 node would be 3 subnodes and all registers would be
> > > > > > defined in top level nodes and would be handled by one driver.
> > > > > > 
> > > > > > This is really how hardware block looks like. But it is not backward
> > > > > > compatible...  
> > > > > 
> > > > > Sounds good to me. I presume we need the serial child nodes so we can
> > > > > reference them from the stdout-path?  
> > > > 
> > > > Yes, exactly, separate nodes for serial1 and serial2 are still required.
> > > > 
> > > > But dropping clock controller is not possible as for higher baudrates we
> > > > need to use and configure uart clock controller. Without it we just get
> > > > comparable feature support which is already present in driver.
> > > 
> > > What Stephen means is making clock controller out of the uart node
> > > directly. No need to add separate subnode just for clock controller.
> > 
> > This is already implemented in v7 patch series. Clock controller is
> > already outside of uart nodes.
> 
> I mean to combine the uart node and the clock-controller node together
> 
> 	uart-wrapper {
> 		reg = <0x12000 0x18>, <0x12200 0x30>;
> 		#clock-cells ...
> 
> 		serial1 {
> 			...
> 		};
> 
> 		serial2 {
> 			...
> 		};
> 	};

Ok, now I see what you mean.

But problem is that this is not backward compatible change. And would
not work per existing DT bindings definitions, which defines how
bootloader should set configured clocks.

As I wrote in emails 3 months ago, this new "proposed" DTS definition is
something which I would have chosen if I had designed this driver and
bindings in past. But that did not happen and different approach is
already widely in used.

To support existing DTS definitions and bootloaders, it is really
required to have current structure backward compatible like it is
defined in current DT bindings document. And my changes in this patch
series are backward compatible.

To change DTS structure, it would be needed to provide uart nodes in DTS
files two times: once in old style (the current one) and second time in
this new style.

But such thing would even more complicate updating driver and it needs
to be implemented.

Plus this would open a question how to define default stdout-path if
there would be 4 serial nodes, where one pair would describe old style
and second pair new style; meaning that 2 cross nodes would describe
same define.

For me this looks like a more complications and I do not see any benefit
from it.

It is really important to break backward compatibility, just to try
having new cleaner API at the cost of having more complications and
requirement for more development and also important maintenance?
