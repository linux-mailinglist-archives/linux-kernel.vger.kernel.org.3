Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02B453B491
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiFBHsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiFBHs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:48:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C051E4B73
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:48:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x5so103431edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C12bw2A3CHzAUpNuzzn6m1oe/ljWC5uGF40ieL0miec=;
        b=c23FZNn3/bgRdRrIZiM+hV6SnxMmFq/Y9AfC9nSlI/d2+4TUVKcysKJsv5steIko2k
         IvH/PdjZXkV6xXTBidJTiTq8gzV+g2OKMM9zOEImD037x3t4Ey/nfLtJj9laCudpiuT4
         U62u8mJAVH18ZoErYArpi0gj2XvBwoJy2l7nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C12bw2A3CHzAUpNuzzn6m1oe/ljWC5uGF40ieL0miec=;
        b=di3vlseIauWcDtfTWTY9K/4UQPZsL9SkwfkhZH6NhKbCRfIYRGL4cSMvpbqMjCUAcb
         987qmt86wLncGMCCDEnNtVvC/tpqDkhaWBNQ7+p5/MmuVVrebIAhgCobXVcRHZCLumhx
         TsRL/Sr+pUs6Dcw02z1DaW357BFd0lTAwuS8Sv47c71KuhkEYgCaRVknd4V+CPq+D2aS
         HOqtejjpjVgJQFAgKmtv6yKpQH2WIpuPUozVUyZY0TN5B8v2REFeuuJ1K5qR/a0fyUpx
         DIwIQ0KTjZ98eOkH/sQqdqplWoAyD9t1h1l3h/39OpmGYLUQJ+Elz88rbCrpdFVJgSxc
         QETw==
X-Gm-Message-State: AOAM531LYTmUOsR+4qmgR0Hv0I2UJxmOcJ4I6cVqMzYaITqVzT4b02N5
        2YUY4JemolgEV5xNjGzpo+Vv5oKSXkUDP1C1eSp26A==
X-Google-Smtp-Source: ABdhPJxqp0Nxz6J6DoU+O15+uzvAOSxUtw8bcGb5LDcaau3YVt8AzcCopzleJr/PEA6I1rhTJZSaltGdDwWHodAISPk=
X-Received: by 2002:a05:6402:350a:b0:42d:d605:36eb with SMTP id
 b10-20020a056402350a00b0042dd60536ebmr3809144edd.99.1654156103448; Thu, 02
 Jun 2022 00:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
In-Reply-To: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 2 Jun 2022 15:48:12 +0800
Message-ID: <CAGXv+5E9s3c0j501fHZxhwsHSeK0vG+GEqLMhtZMvtvC=+etjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Support MediaTek devapc for MT8186
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        runyang.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 7:55 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> This series is for supporting devapc implementation in MT8186.
>
> V2:
> - Add a patch to separate register offsets from mtk_devapc_data.
>
> V1:
> - Add dt-binding and add devapc data for MT8186.
>
> Rex-BC Chen (3):
>   dt-bindings: soc: mediatek: devapc: Add bindings for MT8186
>   soc: mediatek: devapc: Separate register offsets from mtk_devapc_data
>   soc: mediatek: devapc: Add support for MT8186

Applied this on next-20220602 (with a few fixes for other section mismatch
errors), booted and got:

[    1.948483] mtk-devapc 10207000.devapc: Read Violation
[    1.948488] mtk-devapc 10207000.devapc: Bus ID:0x100, Dom ID:0x0,
Vio Addr:0x13000000
[    1.948520] mtk-devapc 10207000.devapc: Read Violation
[    1.948523] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
Vio Addr:0x140001a0
[    1.948537] mtk-devapc 10207000.devapc: Read Violation
[    1.948540] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
Vio Addr:0x140001a0
[    1.948555] mtk-devapc 10207000.devapc: Read Violation
[    1.948558] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
Vio Addr:0x14000100
[    1.948573] mtk-devapc 10207000.devapc: Read Violation
[    1.948576] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
Vio Addr:0x14000100
[    1.948590] mtk-devapc 10207000.devapc: Read Violation
[    1.948593] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
Vio Addr:0x14000100
[    1.948607] mtk-devapc 10207000.devapc: Read Violation
[    1.948610] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
Vio Addr:0x14000100
[    1.948624] mtk-devapc 10207000.devapc: Read Violation
[    1.948627] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
Vio Addr:0x14000100

during the boot process. So I think this works well. Manually reading a
known secure address also triggers it:

root@hayato:~# busybox devmem 0x1000e000
0x00000000
[  135.069121] mtk-devapc 10207000.devapc: Read Violation
[  135.069132] mtk-devapc 10207000.devapc: Bus ID:0x482, Dom ID:0x0,
Vio Addr:0x1000e000

So,

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

BTW, looks like MT8186 support in mainline is shaping up real good.
SCP firmware is still missing, so video codec stuff won't work.
