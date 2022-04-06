Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB64F674E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiDFRdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiDFRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:33:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB852AC2;
        Wed,  6 Apr 2022 08:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA4E4B824B4;
        Wed,  6 Apr 2022 15:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BD0C385A1;
        Wed,  6 Apr 2022 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649259527;
        bh=j/cHGt1Adp/5ckJatmOAtFz8YwOh1uG9kyL0/rqOdAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZxMGCv64eYBNc1avTLYsfD8OTSDZAzQlny1jcKpgW7cpaNUn7n2lzRAB8KA+0J+lc
         blAso325sUH2hSDdGMBvrLnlq7sBAn7rt+3e0nMPFHgiaqm3WW7oDk8r6r0EjD/33C
         3zJFZhJkYKMkbll+HRI/2m9zRNN7EtPN7AGtPU93fqfe75x7mw7W9LpfxSs0yNy968
         c3gGMTbxAhAO8iPe+QiMSfuQiT/dcs7TPgHbp29GUwEK7hdb12Zraumk5vV7L3JElu
         /kqCfIhCb3N2mHJnynG8r5EIciy+D8KcqFnwwcCTHtxXDyo3TtxOG/OZ8g9SvONgYu
         KHxSDu2GKbKkg==
Received: by mail-pg1-f172.google.com with SMTP id 32so401846pgl.4;
        Wed, 06 Apr 2022 08:38:47 -0700 (PDT)
X-Gm-Message-State: AOAM5337yWeQjhOnkwDS/9Yjpru+wrCkCn8NxLoNwYn9VxRJskoZjcQu
        SqA58Rt2YUuKdS3yQDGfQFReG/vMCsVLdW/MfLU=
X-Google-Smtp-Source: ABdhPJx6nrBYoOc7Poen+QC3GhpAJV8qLRa+XzbVgFrkIodhg2moVi8VEmGesevH2qrojOojIBiXA0F7l3qLHy9jsCo=
X-Received: by 2002:a05:6a00:1501:b0:4fb:2d19:b6a8 with SMTP id
 q1-20020a056a00150100b004fb2d19b6a8mr9579739pfu.21.1649259526810; Wed, 06 Apr
 2022 08:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220326022728.2969-1-jianjun.wang@mediatek.com> <06c9f2f8236f8dab6b27da9db0332b4ca45a1039.camel@mediatek.com>
In-Reply-To: <06c9f2f8236f8dab6b27da9db0332b4ca45a1039.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 6 Apr 2022 17:38:35 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfWH-XSogkWVy0Q5LcHSk9SXinR7AA_Odo-oTc32y1Ykg@mail.gmail.com>
Message-ID: <CAJKOXPfWH-XSogkWVy0Q5LcHSk9SXinR7AA_Odo-oTc32y1Ykg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] phy: mediatek: Add PCIe PHY driver
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wei-Shun Chang <weishunc@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 at 07:47, Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>
> Hello Maintainers,
>
> Is there anything I can do to get these patches merged?

Patience. :) You posted a patch during the merge window which finished
three days ago, so basically one can assume you ping folks after three
days. Three days is too fast for pinging. :(

Best regards,
Krzysztof
