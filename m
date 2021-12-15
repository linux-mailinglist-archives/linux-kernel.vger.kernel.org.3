Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C361D4758A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhLOMOf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Dec 2021 07:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLOMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:14:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35899C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:14:33 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxTAt-0002xm-IW; Wed, 15 Dec 2021 13:14:23 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxTAn-000J7U-O1; Wed, 15 Dec 2021 13:14:17 +0100
Message-ID: <3f019d0e27bd6d84935bc97efa84ee948fdbd066.camel@pengutronix.de>
Subject: Re: [PATCH v2] dt-bindings: reset: document deprecated HiSilicon
 property
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Dec 2021 13:14:17 +0100
In-Reply-To: <JLI54R.VHYJ34M8SSAB3@ixit.cz>
References: <20211208184149.99537-1-david@ixit.cz>
         <e013e672b500f88872b008cba7c2ddd5b4483d27.camel@pengutronix.de>
         <JLI54R.VHYJ34M8SSAB3@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-15 at 11:03 +0100, David Heidelberg wrote:
> Hi Philipp,
> 
> In "[PATCH] arm64: dts: hisilicon: update deprecated property name" 
> (v1) I was reffered to 
> https://www.spinics.net/lists/arm-kernel/msg887577.html
> David

Thank you, I'll pick this up into reset/next.

regards
Philipp
