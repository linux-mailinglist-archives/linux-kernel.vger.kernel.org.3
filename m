Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0F47E261
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347973AbhLWLiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:38:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53832 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLWLiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:38:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A4061E56;
        Thu, 23 Dec 2021 11:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C229C36AE9;
        Thu, 23 Dec 2021 11:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640259480;
        bh=YYQsw46HbqBIVqWYtDAxAXVzo5ClBLP5gwEBXoLLurw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErzEqKVvqcikkIp7Y1Fc3WaKLzAmRDXNyvfWrfe+KBcMtJqfvDe2tE/8EMq4G19/J
         wuNGWFGuI4x7hVcv3osdcQrpvwWIHMz3dRLJRbeB6rAse7j7Mh/C37RI4xV0Mf0SUW
         Asp+9ljPHib3SAdnrqw9SwnJGxO5W5JkMjYhpXcVSGcmnkbP4r1mJicu+hB7GPuqpa
         JvhM0cyWPyeHdFJ8VerEASotHuDmcnO2Xm3k8j5B+E3E8kHz6UQruHpRH4smdB02bA
         hOTy4au4S2hg+RUHYDpC0nzhrp/a620BlS/4dTw/w92ozvXrrzY9TEuKileMo+vCYl
         IU8uPAiQuPt3g==
Date:   Thu, 23 Dec 2021 17:07:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: mediatek: tphy: support
 software efuse load
Message-ID: <YcRflIupKfdPWkHx@matsya>
References: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-12-21, 16:27, Chunfeng Yun wrote:
> Add optional property nvmem-cells and nvmem-cell-names to support
> software efuse load, this helps to fix the efuse bit shift issue
> on mt8195 etc.

Applied all, thanks

-- 
~Vinod
