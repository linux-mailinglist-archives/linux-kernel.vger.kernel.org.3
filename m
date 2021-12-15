Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB8475583
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbhLOJwe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Dec 2021 04:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhLOJwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:52:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BBEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 01:52:31 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxQxR-00040y-JA; Wed, 15 Dec 2021 10:52:21 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxQxL-000AO2-3Q; Wed, 15 Dec 2021 10:52:15 +0100
Message-ID: <e013e672b500f88872b008cba7c2ddd5b4483d27.camel@pengutronix.de>
Subject: Re: [PATCH v2] dt-bindings: reset: document deprecated HiSilicon
 property
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     David Heidelberg <david@ixit.cz>, Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Dec 2021 10:52:15 +0100
In-Reply-To: <20211208184149.99537-1-david@ixit.cz>
References: <20211208184149.99537-1-david@ixit.cz>
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

Hi David,

On Wed, 2021-12-08 at 19:41 +0100, David Heidelberg wrote:
> Documenting deprecated property prevents dt-schema validation errors.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - document deprecated property instead of changing hi36[67]0.dtsi

Sorry if I'm missing context, I haven't seen the v1 for this. Is this
really what we want? I would have expected the deprecated usage in the
.dtsi files to be replaced.

regards
Philipp
