Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C992A50B7E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447723AbiDVNJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiDVNJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:09:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2855022B3E;
        Fri, 22 Apr 2022 06:06:56 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MplsZ-1oG6La1fPJ-00qAUg; Fri, 22 Apr 2022 15:06:55 +0200
Received: by mail-wr1-f41.google.com with SMTP id e2so4712519wrh.7;
        Fri, 22 Apr 2022 06:06:55 -0700 (PDT)
X-Gm-Message-State: AOAM530XfFQvbx2grS7QMjTWC0IZS9o/mZWnPupR+YrJ+cEhxnFF5JZw
        Vptzt2d1qSCJJe52MBR0Oz452vWzV4u/ONGK0DM=
X-Google-Smtp-Source: ABdhPJzr/sEIyUtXuTAvF8Q8/DssMA5FZLT4Nk4euAN9C8OsZ19szl+6WaUMm+cqYUy3lMIOfLqToKLe+raWpc5CMcM=
X-Received: by 2002:a5d:49cb:0:b0:20a:cee3:54fc with SMTP id
 t11-20020a5d49cb000000b0020acee354fcmr122170wrs.12.1650632815075; Fri, 22 Apr
 2022 06:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220421192132.109954-1-nick.hawkins@hpe.com> <20220421192132.109954-11-nick.hawkins@hpe.com>
In-Reply-To: <20220421192132.109954-11-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Apr 2022 15:06:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2axNe=w_5PDdSQ8tDZFand_aEQxdgrNMx0uUKYKVmWtw@mail.gmail.com>
Message-ID: <CAK8P3a2axNe=w_5PDdSQ8tDZFand_aEQxdgrNMx0uUKYKVmWtw@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] arch: arm: boot: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CsANPPSjllyrE9eAZiOWvBmqLhqFtY0s4Ecom+7iR/T+cLTWnCc
 84+ZUpXrOksW4ByviU9Q/l5o4CVZkGzk2019SJZA0Nn8wIohjntjF9jXU/oT9V8uhkwusag
 7RbCBBxKD67Ue/xifCJSDjZMz+YqqClVpnUhidjOlw1tKTVlKjMqHDItwMhmb+Hh1Fze8Py
 E2+fc2WR5waLBwm2n0jZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zURduJZs/yU=:GfyYIYmvY3fIdTM/u/tClE
 N7yBd6UHwgATZDrU9fKBPZW2F2y2pBRvok6dcJwC0+mw0/pRfBHVq/N8yAWysuo0lkex7lBTx
 TnShPCU8YqW/uBBAlclStge/XbJvExnwQlnuhbNb8dRZVTSUaO0HoMsFzUl/mXWPBAXjPm9tT
 kXBbQs9BBWo8qkJdxbKVzxCTncXuPgVxfUOA6ZPWm3AQ7pr0ZWlqnZBVvTYUdLKOxDT7HZXzb
 eL8Yfv0pYNhbvJDfU+Zgsd7erEXPs+2/VUbbp6kLBZuv9Odc6T3vefYJbOfR+FqCmG+7UeJi4
 1tbpw/11Z6SPP3mLDiLfk2yGPByz72AtVr5BNmjvQCGv2wcb1eWFDa8p1b/6S0Lrnwo/tsoij
 u8EhH0y6Uv/NfN9OZ+LwOh+SRL+5WF744Yv7TNiSTPVy9w2wVZKE7l5LXj3w2lKfVYe3RlCea
 w4NB+yQwJ3TBezAVYSvF8nxcAUQSbEXjdusnnjDlNNuu7YdP0F0YcldAdO+XuNvmxvCYigqlN
 2aBM0ei5vKzKJqNlLQdnj+RmGeEZ/B+SBwrSPLJF/Zobq+cnzPq3U+hc2SQ3n6bOYAY1GaM97
 jk77zIvWKNxANQTWS/vqMgbh522HFDvIxrekdeW2Nbk1GXVGxECp+skoSHmDK1+7ZCeqqXrmr
 UIQJSeJqgA9iQ985IOsdlumz3sHfs0E5f8bhRviUCs30dZqR1lD1HFc9CS3f1HdO8+W+CC7O9
 b7feRTcX2XuOx8/1plAn5rsBExWwvJCE5N/lTiLguXEnHuXYsSW9TakXridspQlruqo6XfMs+
 Y1IE4rJryQfs1iyrRHGBLZgYdPfYtI+j8i20taNzgxtR4YEhPY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 9:21 PM <nick.hawkins@hpe.com> wrote:

> +       axi {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               dma-ranges;
> +
> +               ahb@c0000000 {
> +                       compatible = "simple-bus";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0x0 0xc0000000 0x30000000>;

I think you should add a "dma-ranges" property in the ahb node as well,
otherwise this would mean that none of the children are DMA capable,
when at the minimum the USB controllers require DMA.

       Arnd
