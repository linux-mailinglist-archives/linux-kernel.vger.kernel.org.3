Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22974936BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352736AbiASJAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:00:12 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55931 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352728AbiASJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:00:11 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 640B23202057;
        Wed, 19 Jan 2022 04:00:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 19 Jan 2022 04:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        VaBFyioQd1iNz90Ah83fVOuABELozkn8BRkq2wXT/rc=; b=KTEYiE/FkOiRN4kD
        QshYOEEn2DqsLY8LC8nYEU4Kzr7nGkFYIjd6oZPCWc21oI8eIYu+4olSrLFfkEr/
        DVQ8fx00WZIK9JZsdtuNekxBTVXnTCuPebmYmjtw5PYSSi+ZDpTPpDhTdio/huMo
        cTdz3ueth5Hua2xr2MHscy+LKeJHvdRdeLLIzuWfL1JDDyuSB8wboG1qIHJRyH79
        Nhbxlrgr6oxG0IEEO48J/h6RdRdUngvUFXHo4iWsXdfsBNqg/mD/rKJgq/mK9wDv
        EJquZcOqNvLO/XRBC1/ypxs2xZPHBzPR7qrF19VKWjfMY/wUXcaDkFR/gdRIEsXF
        uhFidw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=VaBFyioQd1iNz90Ah83fVOuABELozkn8BRkq2wXT/
        rc=; b=oBVZ+EDlq28Fepk52VQZUUpaDxla5oU4cFEJ7rln2bcdEs4Gtr/hvU0a5
        zBgvnV9RkUVHUo9SAh79gQgBXoeqWxYOh2ZO4OvcodlehkV3eHFGFpyft+d3If2C
        vmSpHUCrJRsEyEq+a3UHVThO1oma389Ly1lXWC6geSdcIXdjlATbEYITY0cLjOdT
        G/tZbMuRGS3BJk6JGNKHhzrNHLHXN7iUjv1z54U96qnbpz08TYhfW8OqYpR8RIZy
        qpy6Vc8yJliY0/fpvdRn4Jor6X9jhnZhg2Ln5KxOYkV/c/kI7V88I8l4qix8t47R
        AY550O+5W35J32uFsE1IW2FImsbOg==
X-ME-Sender: <xms:GdPnYWqhzTYpQCrmQ9ytsQ2DMtj4XqvNKqSbspUndpamnAIBLO0JGQ>
    <xme:GdPnYUoSQRbVMPt5bF-W1C3CpSdAgpPhZ0mBp5ba_zTeY1KE74M-HvyLKvzDZSpw4
    S2TT6UixD_z09xGz4o>
X-ME-Received: <xmr:GdPnYbOdu--T6VymbfddTtG1HBXtxGXNaciC7znSOmSnzceOFagiQVc3BYWRkAdjUmqhkRfWZbXBTySMOdu9eKElwGR_OXbBG3ZMjUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeggdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:GdPnYV5jeILlQxcC8n-HyI4DW4fkZ2xvWkryFrFUEQU49IPl07oynw>
    <xmx:GdPnYV6HdBHAojiL6Wo93i6YYVwDP465AGIlenmYfyOWo8Z8iOdKbQ>
    <xmx:GdPnYVizyu9V_TLL5cUfBX5e8ueKP_V1kwkJPbuAZiOLlIVqf-YSrw>
    <xmx:GdPnYSs17hTLusDwcHr0cp2DFl1ZaLynC9dHvBahwWD9Cw_nhiJnHw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 04:00:09 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     mripard@kernel.org, Conley Lee <conleylee@foxmail.com>,
        wens@csie.org, robh@kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v4 2/2] dt-bindings: arm: sunxi: add haoyu,a20-marsboard
Date:   Wed, 19 Jan 2022 09:59:59 +0100
Message-Id: <164258279605.29285.6847365560924211664.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_B6059C6C031E46EFCB05D5A5015B1C4DE608@qq.com>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com> <20220114163148.2854265-1-conleylee@foxmail.com> <tencent_B6059C6C031E46EFCB05D5A5015B1C4DE608@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 00:31:48 +0800, Conley Lee wrote:
> From: conley <conleylee@foxmail.com>
> 
> add haoyu,a20-marsboard dt-bindings
> 
> 

Applied to local tree (sunxi/dt-for-5.18).

Thanks!
Maxime
