Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659E24626C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhK2W5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhK2W5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:57:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4CC0C20EA;
        Mon, 29 Nov 2021 09:29:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so12943687wme.4;
        Mon, 29 Nov 2021 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snUyZmX49ru2DxVA1QAuDQ2irOH1QZcg7Kt2R5LKKWA=;
        b=Y6AcF3jqLTQfik4x4LzAlDhqYQEGVK/QibQuHs0n/w1FmHLhdAIimow51Xk6wvo9Dd
         +j1Ki3GuabZUY7f0fwMnuMM8SmAomLcMRHXZorpK451L2d1AwLPaPIfVefkyglDvNLQc
         ANiRYra38Sj9dEAcAFjQeo+yCn73kVy1iutaiq6MvzsOpDQwc4Mud47Br9qBqnr2eg85
         p8qVMr2pO8dqHem46+AQxYgSPK1ZpnNq2MJiHjDy8r9JYgjpfyQrw4NHTxyi3/sAyNVo
         Lvy6RyoEyA7su2D185Pz/xkFTv8cDIEbbNzN8wND1uCgf+8+YbZgljL989B+lRYuELHo
         57FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snUyZmX49ru2DxVA1QAuDQ2irOH1QZcg7Kt2R5LKKWA=;
        b=32/gz+TV2ZPvEpEbNYTbL2QAWgTRN9LzDBfkf3TGNiwDl5Vv1/q2GJO2e5ho3MoYyN
         zk85v6J+M4EsiXFzc6Xck3Zs39SUgtLZs4iZi/NTHIQE2DJuHWZbP1Sb5LF5gZqwHpOZ
         loAFx3vGRWqJ1rojOZHTdDexzvsJNudl8XXYX5fBAM4fPiHvx/vhistKN52FkXiYB9r9
         dWGjF51lrTXOQjD94JoXW+kZTqmoSMyWkHS5N+F633k95cYBacxWi2DFvAs1uyk0vX2t
         DRlw1jErqiAHyjYiPVntK12Eo990bOIYhq1iq8Z7EJ+e1bb57H2ev93oaI7SrUX2GWgk
         FJoQ==
X-Gm-Message-State: AOAM530BI4w5S9m09ULciAtLUaNHjb2s+PZ0SAPcToRb19z8aRtRmESE
        3EuYLqcZzWIdw2mMT52ESrs=
X-Google-Smtp-Source: ABdhPJyYfAAl2JWSuMRXT7tjdS//D0XTqPX2pxL3Jw8TBUDKfnIv56MLGMyEa4sMII81Uq6dT3Oubg==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr37736357wmq.111.1638206947141;
        Mon, 29 Nov 2021 09:29:07 -0800 (PST)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id f15sm19025488wmg.30.2021.11.29.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 09:29:06 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     wens@csie.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Klein <michael@fossekall.de>
Subject: Re: Re: [PATCH v2] ARM: dts: sun8i: Adjust power key nodes
Date:   Mon, 29 Nov 2021 18:29:01 +0100
Message-ID: <5516984.DvuYhMxLoT@kista>
In-Reply-To: <CAGb2v67M2Qi5tUq0BNbgahTsY4bbYGQeqzjoH8RZ6fYWzrWsYA@mail.gmail.com>
References: <20211129165510.370717-1-jernej.skrabec@gmail.com> <CAGb2v67M2Qi5tUq0BNbgahTsY4bbYGQeqzjoH8RZ6fYWzrWsYA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 29. november 2021 ob 18:16:31 CET je Chen-Yu Tsai napisal(a):
> On Tue, Nov 30, 2021 at 12:55 AM Jernej Skrabec
> <jernej.skrabec@gmail.com> wrote:
> >
> > Several H3 and one H2+ board have power key nodes, which are slightly
> > off. Some are missing wakeup-source property and some have BTN_0 code
> > assigned instead of KEY_POWER.
> 
> It might have been that after shutdown there was really no way to
> "power on" the board with these GPIO power keys, so we didn't use
> KEY_POWER for them?

KEY_POWER is actually processed by userspace, so it would still make sense to 
power down board if power key is pressed. Correct me if I'm wrong, but in 
combination with wfi it could work before SCP FW was available?

> 
> > Adjust them, so they can function as intended by designer.
> >
> > Co-developed-by: Michael Klein <michael@fossekall.de>
> > Signed-off-by: Michael Klein <michael@fossekall.de>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 

Thanks!

Best regards,
Jernej


