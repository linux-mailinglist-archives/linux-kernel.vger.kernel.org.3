Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E98248976D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244706AbiAJL2y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 06:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiAJL2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:28:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC22DC06175B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 03:28:44 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1n6sqt-0006WI-0F; Mon, 10 Jan 2022 12:28:39 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1n6sqr-000AmV-Mh; Mon, 10 Jan 2022 12:28:37 +0100
Message-ID: <4b32313d0642a4043709ef98339497662dafb211.camel@pengutronix.de>
Subject: Re: [PATCH v7 4/4] staging: mt7621-dts: align resets with binding
 documentation
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        linux-kernel@vger.kernel.org, sboyd@kernel.org
Date:   Mon, 10 Jan 2022 12:28:37 +0100
In-Reply-To: <20220110111036.1380288-5-sergio.paracuellos@gmail.com>
References: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
         <20220110111036.1380288-5-sergio.paracuellos@gmail.com>
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

On Mon, 2022-01-10 at 12:10 +0100, Sergio Paracuellos wrote:
> Binding documentation for compatible 'mediatek,mt7621-sysc' has been updated
> to be used as a reset provider. Align reset related bits and system controller
> node with binding documentation along the dtsi file.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Is this patch is missing the gdma and hsdma resets?
I only looked at v5.16, there those reference &rstctrl as well

regards
Philipp
