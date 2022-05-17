Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E103D52A575
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349429AbiEQO4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiEQO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:56:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27024F3C;
        Tue, 17 May 2022 07:56:41 -0700 (PDT)
Received: from mail-yw1-f170.google.com ([209.85.128.170]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MzQPe-1ndgwC0Ocy-00vRnN; Tue, 17 May 2022 16:56:40 +0200
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2fedd26615cso77498037b3.7;
        Tue, 17 May 2022 07:56:39 -0700 (PDT)
X-Gm-Message-State: AOAM532SeLwfjctoKqmpGfeDF1zEHxm9lGBts33JPuG/U/seg6sQGDHY
        Y153oxZLKtozhOjXYLZhfJz0PJVv00Y14NiWMAE=
X-Google-Smtp-Source: ABdhPJzfQfMq9H+I8M/viBf/bZGDpOu9d60f+7Mz7Q+Kz6SQ6MND8STnx2JgGosiR2GP3lJ5ACWXszxYKv0jdRmGk1s=
X-Received: by 2002:a0d:cd06:0:b0:2f8:f39c:4cfc with SMTP id
 p6-20020a0dcd06000000b002f8f39c4cfcmr26196437ywd.495.1652799398796; Tue, 17
 May 2022 07:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220407204115.34350-1-krzysztof.kozlowski@linaro.org> <YoOZ4TawKslvu01w@xhacker>
In-Reply-To: <YoOZ4TawKslvu01w@xhacker>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 May 2022 15:56:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a34dz7Fkk3jbwNq45BRHMt9tGuO=r5NJDiAuMyX05xW6g@mail.gmail.com>
Message-ID: <CAK8P3a34dz7Fkk3jbwNq45BRHMt9tGuO=r5NJDiAuMyX05xW6g@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: dts: synaptics: remove unused DTSI for AS370
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hmx3t1U0Jy8jKsEIrWSg53d6svImoOqDMm/Y063DOSGTNGV/5RO
 PV4dUNXBTcay3+dLIOmieyAGb0OFDvRXX5Qydr302OBCmG9OvOen5XRnm4//md16AyZ6sJK
 qyukf0xcmj91wSHwDgGaXIC+cK2rPRI9QF6HOmDbxpVtTc96p+UsqWHAsEwXHEhx60koZwi
 BZ/xdjrJCxjZE9WFqqW1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Q2xj5Wdlb0=:fxa9/3eub71EB5gTwlspTN
 t1wR4DhiO2MxcCDf1WAqDwcJCpLHE2510CCLURDpBP/Ex2Beq0RUNDR3IgAC0SbWqzgP/O3Wl
 jK/K+yS1bGn9mZSHbAtJL/JFNBLai5CnQBVgtuaRqL99Zqxs1JavffJn+kK7Lqo+qVpSX+6zq
 ejb7ugPX7OUYbIJo7gOOs/XxQ0Vq+yFoqy5wIDx9XBpSALc8wnrlFl7OvOGm5YUV7ki0cqCq9
 O3CE9Nu4b7fCn0r6oeFvuIVI7/0MqzJXn+2jUE3dBiJacEit5YLQNa4upKjQTe8Y5gj9rFkgx
 j8O1RoBiTGy3eeWGSmCNf7QASy98EwjyGU/eR7/UQM+gYusJfECaGvElVro12oYJz04b+GZqP
 8+Muox+UYk7aFCUId+Klmw1j64fe0DFAGiDijtaKk3rEbKahy0prSe/Xv1NVhXfrqypfXE3TD
 5IW6vZcRqCsOBfKae/tNiJAXiO5Xmys6+0/8KbC5789EdKQe22H6t2rin+OuL17TvM3bmvlv4
 sc9/XgayBtT050U3KwpjDf56oZEmV14a3W8qzBAJKZuWRbZLAUdd5LGA+g6jWprW+O4avF297
 dxTP8dLT/E7qbBGKNHey34r+xUIJdKO32VaGyOFsAvJF3zxHeZajZmmOBULsUFDM8+bXTVUQ6
 VlOTO1a0r1gECCGbnz0m76kXCyxpEDZwfQEQpDMn76lHU7G1eDTldrihhJVDyB2lXxjFK7Hpo
 T9tTyjVmzKIVFmWO1qLDjL+9FseniQOD4HwRjDYeW/PThA2JYyAp356qJIAwnOSjqEknHSz0l
 pHnSeyzy6qpJEmlp3O4/wa4mRNOG1nZhLnCEUDTiAejcBqPEaOTXWBQ5P5xRtSpk/FRoy+o4v
 wf57WYCepNa+6Xu3xdJw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 1:49 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Thu, Apr 07, 2022 at 10:41:15PM +0200, Krzysztof Kozlowski wrote:
> > The as370.dtsi for Synaptics AS370 SoC does not have a user (DTS board
> > file), is uncompilable and untestable.  It was added back in 2018.  No
> > user appeared since that time, so assume it won't be added.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Acked-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Jisheng Zhang <jszhang@kernel.org>
>
> Hi Arnd, Olof,
>
> This is the only one patch of berlin-soc for v5.19, Can you please
> take it?

I had already applied when Krzysztof sent it, but forgot to send
a notification about it.

         Arnd
