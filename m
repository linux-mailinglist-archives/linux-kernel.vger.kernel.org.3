Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B8479950
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 08:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhLRHRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 02:17:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56516 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhLRHR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 02:17:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2FF960959;
        Sat, 18 Dec 2021 07:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652FAC36AE0;
        Sat, 18 Dec 2021 07:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639811848;
        bh=GUAc9RPwF0A4JUVnJuI22trHMaEz8p2x/G/1FqPCKjk=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=hk7qBMe3Od43rlMZ5yiNQIq9swdlFroJ/IPGORuKnABcQal5F47FdOfZqwg47rHV9
         I2HkWDHr25i+KCFbo/tJSS4fQ5did5zOaFLlgIoKQ3zgaTHTAPaKvMj8V3g74cvpMc
         fifu2SEOQNgFogL1OX6fijZ5mOOVC8xYPOKLVVlsYHGEtNio4PNqKGZwyEDh4N+6ET
         qRVgbFigsX+v2WllvYvF9R1KoACEEBokjOb9H1pdC5qQzAD59wXbPZa/0ae4XWOQEY
         al1icaayd5r8m7RaOeUQ+9rWnqAky5mu7W6DjWaPN/O7RW3t0iLbwb4ySKwBCAc4IZ
         deCGSMpkdbbxg==
References: <20211217125757.1193256-1-balbi@kernel.org>
 <CAA8EJpoTGyWZRfHnEEMFLVn+JtUxJ7Lv+CL2arxVxU=2vWuHXg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch 0/2] arm64: boot: dts: qcom: sm8150: enable
 framebuffer for Surface Duo
Date:   Sat, 18 Dec 2021 09:17:07 +0200
In-reply-to: <CAA8EJpoTGyWZRfHnEEMFLVn+JtUxJ7Lv+CL2arxVxU=2vWuHXg@mail.gmail.com>
Message-ID: <87h7b64c1n.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
> Hi,
>
> On Fri, 17 Dec 2021 at 15:58, Felipe Balbi <balbi@kernel.org> wrote:
>>
>> From: Felipe Balbi <felipe.balbi@microsoft.com>
>>
>> Hi folks,
>>
>> I'm trying to enable the framebuffer on Microsoft Surface Duo. Looking
>> through some internal docs, it came to my attention that the bootloader
>> will fill up the framebuffer address and size to a memory node names
>> splash_region. Adding the node, I can see the address of the
>> framebuffer. Creating the relevant framebuffer device using
>> simple-framebuffer, I can't see it working. Tried dd if=/dev/urandom
>> of=/dev/fb0 and fb-test. None of which manage to get rid of what's
>> already on the screen, put there by the bootloader (platform Logo).
>>
>> Wondering if any of you have seen a behavior such as this and how did
>> you manage to get framebuffer working on SM8150 (I see at least Sony
>> Xperia has the node).
>
> What issues do you have with the DRM_MSM/DPU1 driver? I think it supports 8150.

I haven't tried using it. I'll give it a shot next week.

-- 
balbi
