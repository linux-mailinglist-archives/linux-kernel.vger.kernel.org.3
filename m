Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1131A57E1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiGVMuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiGVMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:50:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A749EC59;
        Fri, 22 Jul 2022 05:50:41 -0700 (PDT)
Received: from mail-ot1-f54.google.com ([209.85.210.54]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQMmF-1ntCON1MCP-00MHYJ; Fri, 22 Jul 2022 14:50:38 +0200
Received: by mail-ot1-f54.google.com with SMTP id g19-20020a9d1293000000b0061c7bfda5dfso3281281otg.1;
        Fri, 22 Jul 2022 05:50:38 -0700 (PDT)
X-Gm-Message-State: AJIora960o8z6v51O0WitO67/Ju5yQ/M0r8HyGl8EViwcdh5YSmn1KcF
        6Jb8UgKh4d4pzONp7wnrXV7RydBqVedMfOX/8Ik=
X-Google-Smtp-Source: AGRyM1sDu/TpsmUL03yo2zlYiqADzD7kWYXEumM72Hw0lH5LjdoiFgedlCyyF4Wn3/dsln+XanwsGK9LvhTX5PmDwTw=
X-Received: by 2002:a05:6830:61cd:b0:618:d560:b787 with SMTP id
 cc13-20020a05683061cd00b00618d560b787mr184615otb.154.1658494236940; Fri, 22
 Jul 2022 05:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220720190208.11270-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220720190208.11270-1-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jul 2022 14:50:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04pfMoTbWDSdUPYXhXi03i3AjWM1B-8j2Z1OJKRmC14A@mail.gmail.com>
Message-ID: <CAK8P3a04pfMoTbWDSdUPYXhXi03i3AjWM1B-8j2Z1OJKRmC14A@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: update comment after dmabounce removal
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WVpQ7iT7hNCW6OvsQqig5equGMLpq+3Rb9j23SIKG1yoD3fYAA9
 vTW6bkt7s1A0U6HqStjm+OJuPTlf/O47zcIUa2CRfjkdE2ewIW/wW+cETdFlhPBzLGBHBg/
 6aOd7NFm6Zn4vhHFQTC3HyKxRSraEQ5ii1qVUB+oj1AHzzVKlEUDgQFVRYx9ZyUZ3Y/lfOZ
 vW3UnMs8lcABapbLaZShA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G2GDVPGCiPo=:31y4G2SnKTXbubWEvhsDSi
 vZBSCBxXCS2MrHty2S9gdrfFB/hJ0rMOnlkhNoZXLnQhJgqhosvUU1vXwP0nSrnfx3nihbqoD
 6BAwF1T9g8OjSBUw3l7t1dAG20jnpyeQRiR2qmQczCVxHAcnpsvaDs3FTbShhdAMMjz1RlRCh
 F78xlIVmuCRyakdRbJDPqmHcAsTDD8mtTVM7xh1l25ScKVYpTVI1BJPg3HuoFwFz+0ct5z/7v
 R2l8pmGpSmNw0+MMl8OtLixcsyX5EZ4eKW07V5cUPUgwK55Ko0f+oXvZtER5P5gHK/6JUY1dO
 3vno5D0HGgYOQxjbYh/xZNa2OD4vi6fi0sjz2QarNbp8bZUwHTGDKhRqj8Xu8RrtbhwD2hAOQ
 cI9UioelujwDlLeyJFoyGVBOxMib+xvlssp8E3efN3dzQtot3Sj/KfL74a/ML2g8GKbLS5LDJ
 kpRixpF2j0lQQ3DqUPkpsCEY3cJYmAX3rm4n5Ppk8C05rom2sk5NcSi/nufVMMIDABHYIkDB3
 4rVAN/AsQVsqCiwFUaMqIQTlboLKGFQqF7qZX8ll3i4ND8ED52BdcQNRfbncTzPzLbwYAhgFu
 BHQlZLkMFsDNEykYF8Xx9fjGNKeFpuJc+XgMSupVVAayI5p9kWJV0asa5jrzJxFL/Gm/Zknc1
 72VwBJyLB2J2z/hsCg7UZqPNZ52G6SGNTKGOzk6lT1Ir2PkKv2HNINk1Hag9kFDRmeqyABO3I
 1oHuO0zwowYDLJdILU1jOdRzfTZmd1A6ssvTvQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 9:02 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit e3217540c271 ("ARM/dma-mapping: remove dmabounce") removes the
> config DMABOUNCE. A comment to the function __dma_page_cpu_to_dev() refers
> to this removed config DMABOUNCE.
>
> Remove the obsolete explanation, but keep the recommendation not to use
> __dma_page_cpu_to_dev() and use dma_sync_* functions instead.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Thanks!

Acked-by: Arnd Bergmann <arnd@arndb.de>

The e3217540c271 commit is only in Christoph's dma-mapping tree, so this would
ideally get applied on top before the merge window.

        Arnd
