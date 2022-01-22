Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E465496E06
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiAVUu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiAVUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:50:54 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCA5C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 12:50:53 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j14so5353410lja.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 12:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqozJPV1D6gDaO3RkMhPdjT+XwjdXWS8FI4A8iAaD+U=;
        b=eN78gVKxQ1AD2cAufVLznvI3NH8zMy5lI1KlX3SpB76vOPwj/a8Kg4HwxhKvOPmQNe
         CWxGQrd+5vhqBDns+rVAeRvP3CdhGLttwj+AYURXoGd+0KxfCq6ALs5Bg1Nv/rFG16I3
         5VU6VxYiigGU2GNXRFtyg1iy3JBRH1Po4ZbIDhYuy3QjL16Rs70Zva76m8sgs80HNLLB
         QLUcrUudXwokKN1Vf6xwhkk2viWp06N6hYtPrQYW82dEgkaMNta/Gbw+wje+KUYa+T5/
         B6Nc9zHE93DqTZg3fGHdDQ2IR+CdWu2kialefTs/c7t/Y0kh3z1cdR/ln4xyaBmj1TT1
         Vr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=TqozJPV1D6gDaO3RkMhPdjT+XwjdXWS8FI4A8iAaD+U=;
        b=q1DGdj7Gso8TzFn6dKToqEVnIBj+P5xWik0cZFJ1ngOXVlA13ETdwxR/Iqe9A8MHiu
         aYn/J2Sn4CRLTUDOt/44BqEj1M/UfdoTSgXJAfT9HJXwLxh8QzgKRUTvY5fxztOMMRX2
         2XPb86ah3/KvgcnivqVFZxucRtkfw5H24cHXpJO/GYhYnDWUBdnph0rZMPXRelKyBBs2
         xc0cIRBGnEJtiTsj2YaNpr+vlsKx9dSS38Eib94aqJp+JfQcTHaFKJ3ptXTArowmSenG
         i0aAVG7sGjEKDAc2iXrZF/BY8+RGGaqGJi1OPOB5I8iivV0Djy5Ozrw5TophEluLtvUE
         KO9A==
X-Gm-Message-State: AOAM532Fvbb67JmexGmg6yJczTlLqNWkKe9W5KRorqElItzURxdb89/G
        f/zaSF6Hw45UGm7dKVYL0rE=
X-Google-Smtp-Source: ABdhPJymFVebkr7sX/AHQbDCGqAw97NF1kcWQ/NhCsiXfiCg9pY1AvWa6h0Kol9M+OzRgz05o1PLzw==
X-Received: by 2002:a05:651c:198e:: with SMTP id bx14mr223136ljb.46.1642884651614;
        Sat, 22 Jan 2022 12:50:51 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id cf10sm661509lfb.72.2022.01.22.12.50.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 22 Jan 2022 12:50:51 -0800 (PST)
Date:   Sat, 22 Jan 2022 23:56:37 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jeremy Szu <jeremy.szu@canonical.com>, tiwai@suse.com,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        PeiSen Hou <pshou@realtek.com>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855
 G8
Message-ID: <20220122205637.7gzurdu7xl4sthxw@localhost.localdomain>
User-Agent: mtt
References: <20220112201824.qmphnz2hx4frda6e@localhost.localdomain>
 <s5h8rvk85uy.wl-tiwai@suse.de>
 <20220113183141.kla37mbqmo4x6wxp@localhost.localdomain>
 <s5ha6fy46jt.wl-tiwai@suse.de>
 <20220114183720.n46wealclg6spxkp@localhost.localdomain>
 <s5hsftp3027.wl-tiwai@suse.de>
 <20220115152215.kprws5nja2i43qax@localhost.localdomain>
 <s5hilugw0l0.wl-tiwai@suse.de>
 <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
 <20220122190522.ycaygrqcen7d3hj2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122190522.ycaygrqcen7d3hj2@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 10:05:24PM +0300, Alexander Sergeyev wrote:
> I'm not sure about kernel log buffering or maybe the device support for 
> pipelining, but is it okay that alc_update_coefex_idx() seem to overlap?

Given that the CPU number is the same in alc_update_coefex_idx(), it seems 
these calls execution is interrupted and interleaved on the same core.

And, actually, there are two LEDs to set (mute and micmute). Am I onto 
something here?

[4.043235] alc_update_coefex_idx(codec, nid, coef_idx=0xb, mask=0x8, bits_set=0x0): entering
[4.043237] CPU: 0 PID: 18 Comm: kworker/0:1 Tainted: G                T 5.16.0-rc1-00001-g5c38c8c84e47-dirty #18
[4.043910] Hardware name: HP HP EliteBook 855 G8 Notebook PC/8895, BIOS T82 Ver. 01.06.03 09/17/2021
[4.044559] Workqueue: events set_brightness_delayed
[4.044559] Call Trace:
[4.044559]  <TASK>
[4.046289]  dump_stack_lvl+0x34/0x4c
[4.046289]  alc_update_coefex_idx+0x34/0x7a
[4.046289]  coef_mute_led_set+0x48/0x56
[4.046289]  set_brightness_delayed+0x6f/0xb0
[4.046289]  process_one_work+0x1e1/0x380
[4.046289]  worker_thread+0x4e/0x3b0
[4.046289]  ? rescuer_thread+0x370/0x370
[4.046289]  kthread+0x145/0x170
[4.046289]  ? set_kthread_struct+0x50/0x50
[4.046289]  ret_from_fork+0x22/0x30
[4.046289]  </TASK>
[4.052793] alc_update_coefex_idx(codec, nid, coef_idx=0x19, mask=0x2000, bits_set=0x0): entering
[4.052794] CPU: 0 PID: 171 Comm: kworker/0:2 Tainted: G                T 5.16.0-rc1-00001-g5c38c8c84e47-dirty #18
[4.053363] Hardware name: HP HP EliteBook 855 G8 Notebook PC/8895, BIOS T82 Ver. 01.06.03 09/17/2021
[4.053364] Workqueue: events set_brightness_delayed
[4.053366] Call Trace:
[4.053366]  <TASK>
[4.053367]  dump_stack_lvl+0x34/0x4c
[4.053790]  alc_update_coefex_idx+0x34/0x7a
[4.053790]  coef_micmute_led_set+0x48/0x56
[4.053790]  set_brightness_delayed+0x6f/0xb0
[4.053790]  process_one_work+0x1e1/0x380
[4.053790]  worker_thread+0x4e/0x3b0
[4.053790]  ? rescuer_thread+0x370/0x370
[4.053790]  kthread+0x145/0x170
[4.053790]  ? set_kthread_struct+0x50/0x50
[4.053790]  ret_from_fork+0x22/0x30
[4.053790]  </TASK>
