Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A094B4FDC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351153AbiDLKSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356896AbiDLJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:55:19 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CF32AE2C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:59:05 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e2fa360f6dso541377fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:user-agent:references:in-reply-to:mime-version:date:message-id
         :subject:to:cc;
        bh=61Zhp6cmoUliim9YwiwcZpLzWn635tX3xmuezZ/XE1Q=;
        b=i+E8+24eJSPuwFpWwnhwRcMosCQtTEQoU0qVumPFd1B/5vOrb43OnnM06scRAF73Yq
         oMByED8vyfj7h/juyKz0L3ed4WqHpCgSlskOcx+kVCwtlWgCiSRQA57g1AuGyhRftLkn
         PMcblX+TbX+MHeKj3cpATLc7zfvBTrR1JonUwOgFtW9kUMKobrEyLRFKbEi6WgtAtS6n
         FCB8ilN1nAxUZedW0P+Azc/J+6dpMpBO/s4qN2MMBBKOQNBC+cNRVDAa2Xi5cUNXXxIm
         UJfzvicRT62Wq64zodMNVExN+Gzy0MnFtlZGEVwjmhUqQKDk5bd3GuHqulcLVnv1AYsL
         SMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:user-agent:references:in-reply-to
         :mime-version:date:message-id:subject:to:cc;
        bh=61Zhp6cmoUliim9YwiwcZpLzWn635tX3xmuezZ/XE1Q=;
        b=EaILETg9ZgRXOFbE3kBa2SisBWy9WXWF5pJZcm4vJYEDkvkID/rdjftCaLSHCuy3YS
         zW5fhIkI4XnlFzOTp3hZVJE6RaC9DuvPGGJxO/Fp5XQPBA4HT2zYD722CtibpNwB+EtC
         Apfz+9mlfW6zUfNFnSPiqJCWqOkQkBWPAOVuH8gBtNCkw1j22igSwEjmcclq/r/NPFDp
         kJiwbGws4KpOa23Qj3HsqHlxOOC8y84uagryUz3Ktps3ULLYqyTKCRxZ32UZRrZ+9fTw
         7SUIP7SwJzk+VZfa7zWIbI0qHaW+1hXAnDIzadtste4SLQwu8IWXQDtOMYkZtUtxFl5g
         RjXQ==
X-Gm-Message-State: AOAM530OqKbzUbAktZuwy2fwcanHh+4Kj6CGxyuYea8QOirDRuQaWIwC
        +h0I97IHHXLeEN0O4jQzfGWqoSsba4KJQgqsF8mkrw==
X-Google-Smtp-Source: ABdhPJzgcHEvPZCp6gdbg7kDhJKlxditkMSAtxr85wga0tldVXhcDC3GVMdHj7CuZ6MWQrtRrZ1EySnMvRiS1vE8OqA=
X-Received: by 2002:a05:6870:f21a:b0:dd:9bec:caf8 with SMTP id
 t26-20020a056870f21a00b000dd9beccaf8mr1592268oao.78.1649753944968; Tue, 12
 Apr 2022 01:59:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Apr 2022 01:59:04 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220327223927.20848-1-granquet@baylibre.com> <20220327223927.20848-7-granquet@baylibre.com>
 <33212024-ae93-32c3-7890-09006057ff49@collabora.com>
In-Reply-To: <33212024-ae93-32c3-7890-09006057ff49@collabora.com>
MIME-Version: 1.0
Date:   Tue, 12 Apr 2022 01:59:04 -0700
Message-ID: <CABnWg9sckU58Ga-qUgd+pk2M75H4=XZyAyP69e5QJP0+dvsusg@mail.gmail.com>
Subject: Re: [PATCH v9 06/22] video/hdmi: Add audio_infoframe packing for DP
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, vkoul@kernel.org,
        airlied@linux.ie, chunfeng.yun@mediatek.com,
        chunkuang.hu@kernel.org, ck.hu@mediatek.com, daniel@ffwll.ch,
        deller@gmx.de, jitao.shi@mediatek.com, kishon@ti.com,
        krzk+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        matthias.bgg@gmail.com, mripard@kernel.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, tzimmermann@suse.de
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 10:09, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>Il 28/03/22 00:39, Guillaume Ranquet ha scritto:
>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> Similar to HDMI, DP uses audio infoframes as well which are structured
>> very similar to the HDMI ones.
>>
>> This patch adds a helper function to pack the HDMI audio infoframe for
>> DP, called hdmi_audio_infoframe_pack_for_dp().
>> hdmi_audio_infoframe_pack_only() is split into two parts. One of them
>> packs the payload only and can be used for HDMI and DP.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>   drivers/video/hdmi.c           | 82 ++++++++++++++++++++++++++--------
>>   include/drm/dp/drm_dp_helper.h |  2 +
>>   include/linux/hdmi.h           |  7 ++-
>>   3 files changed, 71 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
>> index 947be761dfa4..5f50237554ed 100644
>> --- a/drivers/video/hdmi.c
>> +++ b/drivers/video/hdmi.c
>> @@ -21,6 +21,7 @@
>>    * DEALINGS IN THE SOFTWARE.
>>    */
>>
>> +#include <drm/dp/drm_dp_helper.h>
>>   #include <linux/bitops.h>
>>   #include <linux/bug.h>
>>   #include <linux/errno.h>
>> @@ -381,12 +382,34 @@ static int hdmi_audio_infoframe_check_only(const struct hdmi_audio_infoframe *fr
>>    *
>>    * Returns 0 on success or a negative error code on failure.
>>    */
>> -int hdmi_audio_infoframe_check(struct hdmi_audio_infoframe *frame)
>> +int hdmi_audio_infoframe_check(const struct hdmi_audio_infoframe *frame)
>
>I agree with this change, as hdmi_audio_infoframe_check_only()'s param is a const,
>but you really should mention that you're constifying this one in your commit
>description, or do that in a separate commit.
>
>Either of the two is fine.
>
>Regards,
>Angelo

Noted, I'll add it to the commit message.

Thx,
Guillaume.
