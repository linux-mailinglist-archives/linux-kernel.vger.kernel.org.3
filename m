Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB8F4773B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhLPNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbhLPNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:53:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438BCC061574;
        Thu, 16 Dec 2021 05:53:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03293B82322;
        Thu, 16 Dec 2021 13:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110B6C36AE0;
        Thu, 16 Dec 2021 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639662802;
        bh=Tqxxq6JCeIDIsnJGC7uBKPL5B+DxpumabyBR9p88S4Q=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=QJKpoQKNEVJgB8Ck11fKI5x/FQMmy3MyyDoTLqpgK4ZteBpYDvjowYddQfmb8Jlwt
         dcrrLsCMEvVFpYg2wJn9khb3W10+fSk42w+cfhLmh6f5p/vkX745Wl0GeSGkiTErTF
         /X/r0ASnzZjRDYTb89q22JXwtDc0r0iRFQVmr+QhwBqkVofjrtGrIJwquIzJsA6qoV
         GgChYEO5lOGruJ+iuHgceJMHZF0VqMn4OfzhBh3hb7h8M9tYNzRmV9kHPaG90NYtmL
         AkTtj/BTkYqzNtRn9TtmDOGxnPCDB0+kcFHTuIZXU3jDUgXAif5/Tav2IW6l1cJ+eA
         WKsv6LLE0P5GQ==
References: <20211216111341.304151-1-balbi@kernel.org>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: Re: [PATCH] arm64: boot: dts: qcom: sm8150: add SPI nodes
Date:   Thu, 16 Dec 2021 15:53:02 +0200
In-reply-to: <20211216111341.304151-1-balbi@kernel.org>
Message-ID: <87pmpw4pwx.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Felipe Balbi <balbi@kernel.org> writes:

> From: Felipe Balbi <felipe.balbi@microsoft.com>
>
> Add missing SPI nodes for SM8150.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>

please ignore this one. Fruit of a bad rebase :-)

-- 
balbi
