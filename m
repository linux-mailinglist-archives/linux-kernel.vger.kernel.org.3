Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24E549DA36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 06:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiA0Fa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 00:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiA0Fa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:30:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75492C06161C;
        Wed, 26 Jan 2022 21:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1393B6187C;
        Thu, 27 Jan 2022 05:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D87C340E4;
        Thu, 27 Jan 2022 05:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643261457;
        bh=ZO8QqAPZhk4/Am2PeI6dAhQraFlAnTUockNeGMJ5AnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oynhwJHZxAzSkIlGqTnRzpmotg+LpoytKcCepNeuBy6Zud8c+PrpnsBjlxItGSSvI
         DWYwtvjes8OxUSxrIL5eJZh2PQX666F9HOISUx4fkAeSmsUFzBph+aMCuJd8hObQOi
         8hY85kh47b7klzZgjFZhDhsoNjDmw4V1XfDYezIu/4iFEsC046zgA7scAh7LSm546P
         Fjj8boFNXUUOmC5crgEX6SOuvnNZ/XmwmPn79SXAf074FrDv/55h7K/jMuc0yDVxO8
         5oSm2C8mymUF+UIqdJjbj5kgyoRvSo3fisgnvagJHirkeEQSOakbqedhXqeA4Uumj4
         /gOWZO0Fz9AEg==
Date:   Thu, 27 Jan 2022 11:00:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] phy: qcom-qusb2: Add compatible for MSM8953
Message-ID: <YfIuDkVs2WqAwikk@matsya>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-3-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-3-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-01-22, 20:40, Luca Weiss wrote:
> Add compatible for MSM8953 QUSB2 device which reuses MSM8996
> configuration.

Applied, thanks

-- 
~Vinod
