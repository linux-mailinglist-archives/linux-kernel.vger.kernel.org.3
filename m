Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB4571480
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiGLI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiGLI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:28:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F4D974B4;
        Tue, 12 Jul 2022 01:28:05 -0700 (PDT)
Received: from mail-yw1-f170.google.com ([209.85.128.170]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEFnP-1oIZmQ3fEr-00AE1Q; Tue, 12 Jul 2022 10:28:04 +0200
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31d85f82f0bso37513587b3.7;
        Tue, 12 Jul 2022 01:28:03 -0700 (PDT)
X-Gm-Message-State: AJIora9eodH2nmyg+yyjo3Z+gkYDPi4P3wVkR3YF+A68HYlLIUmA0zCq
        jC3id/5XNgGFI7Tn7JFC41FkyFV209Dmiw1F3cs=
X-Google-Smtp-Source: AGRyM1u9HrvdVLUYfcTjxl6JYK42QXCE/vx+bUc1E+DlIYc4j8YKWLUVVYfD/FHC1DMwxhEvHUxz2HArNEw2IL5mAk0=
X-Received: by 2002:a81:d93:0:b0:31c:d32d:4d76 with SMTP id
 141-20020a810d93000000b0031cd32d4d76mr25884738ywn.135.1657614482595; Tue, 12
 Jul 2022 01:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220704025632.235968-1-renzhijie2@huawei.com>
In-Reply-To: <20220704025632.235968-1-renzhijie2@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Jul 2022 10:27:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07jGCuAVQAZgpENRP_xFLiogU9W1Uze+n21h7TdOZhog@mail.gmail.com>
Message-ID: <CAK8P3a07jGCuAVQAZgpENRP_xFLiogU9W1Uze+n21h7TdOZhog@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     stanley.chu@mediatek.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QdMVMsi+6aHmn8J8UEPhX4t+Uv/ZKhDQIrzYhy9SLwFVH7u6RXI
 lBZY9oBpwN6WznVGfIM5S+V3jXTGYE5YDq/mHG92u0zkoZo7RIINkRLmntZx2ksjIqxpCsH
 NkOf1B9+dhOFzCqaOCotC0GFsIoBHlIpZdCuiMzoL805o71BLpPUhBA5CgPBpz3PlsLnDAW
 wBlKc6Dwwz4OdTRpeSe2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2RFsKK1FhIg=:EnSRMEo+1oOOgalCgJFfAy
 RKxRpWDqwP9PtHNZLjIFEUrXYLxlztensnEY8i+/NF3wohXijARCQr1yDP6TM+t8VGIIicvo7
 qlAFGc1eBm+m48Y1J8/Y+2puCEJJDpLypIwBjOENm2zVZsmY7WKqIxbc3azXwL/OslfFdhwya
 08UUwakZvPysBUZBxCrUMQJcCIqYI7vuLIxYwU5+xQJQoAoFS8Qf1fuPfWQ86mt821snaDd+t
 OMw9O4yX7CCHBQp3zkI/AiYGsw5ZuizVVaE50FIEe9MXVMneIv7hb9ZqAqS3hAijecDItHxro
 aWRlJqHKj0Y/kQcXCRzlUM9qs5f7gEUNVEp4n1BNHuVKJJROArjWNFoAA4ZyoXk+9AbFCodHF
 wi2KRzOf2zdISHTAfHAFVa0odTeiLr7n6ax0PsSJA1kPfMSWKW4vL9pEUljL9HAuvHwDFCOZa
 a60ihbBvoSzKge5z4pXQX7oSPOqhYt+LeSh7lg2EAFxrDWxqN+hNfgIBvN3CqFdIgS+5IQPwB
 aBJdsmY1L8gRPOEvlCNfOYRNwKGJOBR7KvlHm03TZTSv4ATJkeaibGJ9r5/iiYX1MURIVB+Jx
 JShSqymQvd+V7Ld7GNh8dRbTtsy8AgV5UjicgmxvN2lgt7qHFQr1hHtQaKh9363oo2laPN2yZ
 XQje3/Vey/4uRPgbqcjTpg8KVcAdyTSSoNDEqGPVA1m3IWQ8mjgNS1T+2pr8+fakjhidSs254
 OPnZ802WXcvafSkKb0DY/+u2wl8nGPNlBFfWAUcwKlDnmWspwuSwHsIdECOGdN50kxwM1KvMP
 xIKPUMbQ6PqTlOQbv5bz6/LIUHJOn4W9H1bqjoJHc3BZq8ofwlqFXLu9t2zRm01z3F5BAKcy4
 //h14B5wc7W2dy7SHQ3g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 4:56 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
> diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
> index c958279bdd8f..e006c2528a3a 100644
> --- a/drivers/ufs/host/ufs-mediatek.c
> +++ b/drivers/ufs/host/ufs-mediatek.c
> @@ -1427,6 +1427,7 @@ static int ufs_mtk_system_resume(struct device *dev)
>  }
>  #endif
>
> +#ifdef CONFIG_PM
>  static int ufs_mtk_runtime_suspend(struct device *dev)
>  {
>         struct ufs_hba *hba = dev_get_drvdata(dev);
> @@ -1449,6 +1450,7 @@ static int ufs_mtk_runtime_resume(struct device *dev)
>
>         return ufshcd_runtime_resume(dev);
>  }
> +#endif
>
>  static const struct dev_pm_ops ufs_mtk_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(ufs_mtk_system_suspend,

This change works, but it's not great. It's better to change the
SET_SYSTEM_SLEEP_PM_OPS() to the new SYSTEM_SLEEP_PM_OPS()
that works without the #ifdef.

         Arnd
