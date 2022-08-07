Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B158BA1C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiHGHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGHv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 03:51:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D152F59C;
        Sun,  7 Aug 2022 00:51:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t1so8762280lft.8;
        Sun, 07 Aug 2022 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dJ6lR10UqT/svxgk5HLkzmMbK4zBIcx20Yej7ar36t8=;
        b=XGMyyc5WU146GHv0QrCf1AOo0rhlUQXkxD5+jlAka0Bl8ngJ94avjqdprGhCdYBQty
         X4KVU0dP4rvH57xfRRxOQY3zGO9bsi+etLPvDmEL4tXXGTVRJZ0Fswh/dSdRMzqs3/GG
         JBylky7KzNCyMi1ZOHFlVVFWKBwMq183rp9iWKLiHRJsezL89FRtEpXNhaSEBK+lrXZv
         mTe2OjnX8x7qQ8olcn2Mo+BWzcQJiQWY0IQFedy9t0dF44zN5oQ19aBZhmYPVZ3wGRjE
         GfcN4Of7upv2NgEC2wSF0tC912tAGHTKW4BRue6Aecbj5OC46OhxoIJQViLQNs8gnp6o
         SoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dJ6lR10UqT/svxgk5HLkzmMbK4zBIcx20Yej7ar36t8=;
        b=Gv2JZoFt2RDaH1BANL7zWjZh3ywSCOlx/00Z8gBxhZAGC+E9VjvIxEUyNeR+a4ty+5
         WWtGibCutckS68fePCsIgq1ynQV1oQmG9bzEQKsdmTCK6Kk7gpwym+srNsUcLPCoNE1w
         OZf6sDCLZ8j9G3ov7Iwuyf3en+oolGUtZO/nlaE546ek9IHGrwyasutSCGTS7MUgNhEC
         hblKVJl+2I6KQHRsokEYKP3QT9q/9w5Gd/0wK5RXwp2PpFoFAyfvGC8pCtyFvTFMhSX8
         X39vfZC8lTTS7A1XBFlcB5LemCWcDvuXjFGJGbtVqG2F2gMuAmkCx6jBFXjc6Z78jdN7
         u3HQ==
X-Gm-Message-State: ACgBeo3xjudkqKrEmHeITfadNAmLZl8oxBBFKq4nZbAqaBKH1u8WCtoE
        vXCDOK3LKFNRUyTLxL7kDSozlHBV7y3eagOdOv0=
X-Google-Smtp-Source: AA6agR4V/VrijA2jOsVzxZ7/8/SHHrOYwWX5/nci78brP/zjC9MoIstaGIPRY80wqK73i0+0xJA+/s0BVB0qXfOMxlI=
X-Received: by 2002:a19:6d0d:0:b0:48a:8b3c:e28 with SMTP id
 i13-20020a196d0d000000b0048a8b3c0e28mr4190351lfc.265.1659858716318; Sun, 07
 Aug 2022 00:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220804181800.235368-1-tmaimon77@gmail.com> <10e93907-49ef-a3e6-e0b4-0b3e5f236f44@linaro.org>
In-Reply-To: <10e93907-49ef-a3e6-e0b4-0b3e5f236f44@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 7 Aug 2022 10:51:45 +0300
Message-ID: <CAP6Zq1ju4=PSiCuDaCi2NQTniaXBwmv5Qn6LoLayGmiayDCvYg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>, minyard@acm.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

Hi Krzysztof,

Thanks for your review.

On Fri, 5 Aug 2022 at 09:36, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/08/2022 20:18, Tomer Maimon wrote:
> > Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> > string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
> Your previous commit adding that compatible was simply wrong and not
> matching the driver and it is not the first time. I think all Nuvoton
> patches need much more careful review :(
Will do and sorry about all the mess...
>
> You forgot the fixes tag:
>
> Fixes: 84261749e58a ("dt-bindings: ipmi: Add npcm845 compatible")
Will add the tag next version.
>
>
>
>
> Best regards,
> Krzysztof

Best regards,

Tomer
