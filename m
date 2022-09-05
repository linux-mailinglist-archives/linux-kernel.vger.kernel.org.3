Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E245ACD1B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiIEHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiIEHqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:46:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFC3AB1E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:46:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w2so10277630edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ns0e6BF5lsSCBTPKI8hcA6JQ2wSlm+RnddxbYzGwY78=;
        b=RxePfGbUgFr9m1wzXfMcTyrFLm8VXH3Yjx/yfWE1dMrqrFq06nWkoMsCfSzy5EzaNc
         zkvReGjw1pXYSieHpawZtsbp5SfsbV0sgEO025cH+8zNr0qXEeVAKzG+nVwKkxY+Y2z6
         8PZfmamY9BII8PaTZVTkWWMzy80ttmH0L0j8Kx9BpU3sAFm2gIhnqrN4WWAMpgODdvgs
         RIWPxIUMJEyU3jyYOIWksqLB0g+IUVvJaiT/+vfXkhfHcEpFyqtgJHcd3LCsq0zrTm14
         nRFXPkAFkOEywh8Q1ncIiuWym8mfHtpF/gGHXSB4J1ahZlYtmM3Y/XO88mosIj9W6eZG
         Sy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ns0e6BF5lsSCBTPKI8hcA6JQ2wSlm+RnddxbYzGwY78=;
        b=SnkvgEmsc9Dr6LM1Bxwggz9GfJkBWjSECOA6Opc9ltme/HhsGspqMrAp0TXznP7Ff3
         Yeu9yxK4NSeR+pGJ/YbHbuCh7qMUBK0Xzlav8lj8tuxfSQWSlPrSSrvv7+LriYRJqdrV
         9asbKezs7VStxzWoFu/+7GSwDzaV015T06ScC6t8MJsoLlwqPCooTSWVui0OJFlD2on3
         BZ/L1m41/2DahWTPDYNl3lvGS3wtx1zOBu1j6q6hA5LiE3Z0cBOSF16BEcE++qkgVk+L
         I8SRp9md8sMHxNjv0C09z5XW04WFT4Bo0BV+GpLximdcXuLRE5Y+U9ERyqJ03iZNWLM8
         lhFA==
X-Gm-Message-State: ACgBeo2yHv4+OWsF0eZ68/gPJIQR6D3muQcCwANwGEPlIgl7WlCEvGJu
        BGMjqik/S1jLhDCa7PgT3RS2ZjQ/1Fj6qyyAV1c=
X-Google-Smtp-Source: AA6agR5wybEqXz4dGsViNshife/UNSpksZhb2GioQ2olydywe0lOqHmE3AnukOX3V2PeaiKO4gRc+Yv2kqPhN/RGYDA=
X-Received: by 2002:a05:6402:1f02:b0:445:f674:eac0 with SMTP id
 b2-20020a0564021f0200b00445f674eac0mr41072891edb.370.1662363980652; Mon, 05
 Sep 2022 00:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_E1BBF05904DFB73C478DCD592740AAE0780A@qq.com>
 <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com> <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
In-Reply-To: <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 5 Sep 2022 15:46:09 +0800
Message-ID: <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
To:     xmzyshypnc <1002992920@qq.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, alex000young@gmail.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, security@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I rewrote the letter. Hope it works.

There is a double-free security bug in split_2MB_gtt_entry.

Here is a calling chain :
ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.
If intel_gvt_dma_map_guest_page failed, it will call
ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
kfree(spt). But the caller does not notice that, and it will call
ppgtt_free_spt again in error path.

Fix this by returning the result of ppgtt_invalidate_spt to split_2MB_gtt_entry.

Signed-off-by: Zheng Wang

---
 drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index ce0eb03709c3..9f14fded8c0c 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1215,7 +1215,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
                ret = intel_gvt_dma_map_guest_page(vgpu, start_gfn + sub_index,
                                                   PAGE_SIZE, &dma_addr);
                if (ret) {
-                       ppgtt_invalidate_spt(spt);
+                       ret = ppgtt_invalidate_spt(spt);
                        return ret;
                }
                sub_se.val64 = se->val64;
--
2.25.1
