Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDF647E242
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347908AbhLWL2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:28:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35792 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhLWL2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:28:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DA6AB81E98;
        Thu, 23 Dec 2021 11:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAF5C36AE9;
        Thu, 23 Dec 2021 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640258908;
        bh=htCvpSaVrR8Gu/Gf+sfTWo3rQbsZZ8ATd3vQXhFLWYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byI8vGwHlAIcTpT0z9s+YkHj//vmsmN8841AogPROn1/ASF83M7dUR5eb70y19tCo
         1GRS1QoBIh4fcNd+qnx3RULTNJIH8j/TiLJ36XbVt0OnwQnyWknZ0HtXUPbCrKFzen
         b71i9fRpUX16/xmSqI8zhfuUSQl0kJjsvxJjBVRvhkazbDgHm9aPnZ0y09EuiwpOIs
         ci2ckdy3N6UEOOZs8nUScwaldD2qSurNn2mHLTow1yeAThwd22yk7vPaiitXlQztRj
         EHcp9aqB3deH0OVdNGA9b96LwuD60OiGU/PNPLhhoA7jyGl8ulrDS+pA/sbwfe7SG5
         sIgd1GgzjUOrw==
Date:   Thu, 23 Dec 2021 16:58:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] CAN: Add support for setting mux
Message-ID: <YcRdWJtREHFWXBKM@matsya>
References: <20211216041012.16892-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216041012.16892-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-12-21, 09:40, Aswath Govindraju wrote:
> The following series of patches add support for setting
> muxes to route signals from CAN controller to transceiver
> by reading the property mux-states from the device tree
> node

These look okay to me
> 
> The following series of patches are dependent on,
> - https://lkml.org/lkml/2021/12/2/423

Pls post when these are merged..

> 
> Changes since v2:
> - Fixed the bindings removing the description about
>   the arguments in mux-states property
> 
> Changes since v1:
> - Fixed the description for mux-states property in bindings
>   file
> - appended declaration of variable ret in the end
> 
> Aswath Govindraju (2):
>   dt-bindings: phy: ti,tcan104x-can: Document mux-states property
>   phy: phy-can-transceiver: Add support for setting mux
> 
>  .../bindings/phy/ti,tcan104x-can.yaml         |  7 ++++++
>  drivers/phy/Kconfig                           |  1 +
>  drivers/phy/phy-can-transceiver.c             | 24 ++++++++++++++++++-
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
