Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B048B693
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350425AbiAKTPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350417AbiAKTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:15:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBEBC06173F;
        Tue, 11 Jan 2022 11:15:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 0A3BC1F447B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641928508;
        bh=GtBWQubh7MRSfsrJwouzQ1KZLx9kkRfXx1s3sYvQ1W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqgYA820nG/BheP0MtLycz0Xh86cW9CV7nbyfTgJaj+3HrenpVEcCXZ18TCqs/7qg
         4W04n5wreMasp0sdnxAo6AmMlVk0IwAwR7Mk+IOrNPh35ATUdxiKA1RBDE3bfEsy9+
         keW7SGu4QwoyuOesqaFH2qCvd9kXw6W86G1SEgAHP1urdkjUNsqdHxa8EnSMxPw1VR
         2vHAITsjYtD29gbpqgQM6t8EhqnjuQFDdr9wWStY9uFWjfoN20RdTEeV4tZ37YR2OP
         U3gcgc9tgoOuGp7xhLW/UijDulnXXnPPjsiIRg5JgHJaCREMloJN6lu67xGZIUs/Zs
         KLcpWbJ1xvysQ==
Date:   Tue, 11 Jan 2022 14:15:01 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        chun-jie.chen@mediatek.com, devicetree@vger.kernel.org,
        drinkcat@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v2 1/5] arm64: dts: mediatek: Correct uart clock of MT8192
Message-ID: <20220111191501.dspzjabuuohinufz@notapiano>
References: <20220106032420.11544-1-allen-kh.cheng@mediatek.com>
 <20220106032420.11544-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220106032420.11544-2-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

thank you for improving the commit message! However, please see my comment
below.

On Thu, Jan 06, 2022 at 11:24:16AM +0800, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> When the initial devicetree for mt8192 was added in 48489980e27e ("arm64:
> dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile"), the
> clock driver for mt8192 was not yet upstream, so the clock property nodes
> were set to the clk26m clock as a placeholder.
> 
> Given that the clock driver has since been added through 710573dee31b ("clk:
> mediatek: Add MT8192 basic clocks support"), as well as its dt-bindings
> through f35f1a23e0e1 ("clk: mediatek: Add dt-bindings of MT8192 clocks") and
> devicetree nodes through 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192
> clock controllers"), fix the uart clock property to point to the actual

This sentence is incomplete. It is missing "clock." at the end. Could you please
add it?

Same thing for all other patches in this series.

After fixing that typo in the commit message of all patches, please add my
reviewed-by in all patches:

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
