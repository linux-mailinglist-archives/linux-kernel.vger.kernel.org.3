Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2851E4B1294
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbiBJQVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:21:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiBJQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:21:05 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:21:05 -0800 (PST)
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MS3zP-1nl5hE3SGp-00TXbr for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022
 17:21:03 +0100
Received: by mail-wm1-f45.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso1111295wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:21:03 -0800 (PST)
X-Gm-Message-State: AOAM530eHuBi/2UnuaZofXosOgY/croxe3Bqdm6quxsRM6Wsja3s3uPG
        5XTCwFEFG09mFFgBY/dP08JTBmAS4QT9gMLVCtM=
X-Google-Smtp-Source: ABdhPJxEt42iOSrAM6C3TvkblI3b5gQmXnnRKKOtEBtFl2RyO5MYFlbo5PnAEnruW7eQTVPA+SeI0QUJdaKY2LsCsdY=
X-Received: by 2002:a05:600c:1f0b:: with SMTP id bd11mr2796188wmb.82.1644510063280;
 Thu, 10 Feb 2022 08:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20220209163242.430265-1-michael@walle.cc>
In-Reply-To: <20220209163242.430265-1-michael@walle.cc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 17:20:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0cBdT0EjStDhB5jSPWm=FiPVj8_5X6rVnBfXOcznTy6g@mail.gmail.com>
Message-ID: <CAK8P3a0cBdT0EjStDhB5jSPWm=FiPVj8_5X6rVnBfXOcznTy6g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] soc: fsl: guts: cleanups and serial_number support
To:     Michael Walle <michael@walle.cc>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WHj5oaTRZYHSkNli9IcEqspxMVOanKqshGxvtcOA2tehxwogl/1
 xTtnqpL1McELerOGOaBpVItu7QNXHXP0hQ4HqzUcAqKEsL12Qt2tG5NXLqA9i2sjjLraCAj
 jpI+whuu/87WvpeetUOzYLxMgjPKS/z81ARZbxC7t2dUMcwOKFdLaMrKmCt/xtru/TE0AWT
 o0jkm+PBkd+8dzhElIKKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GeHd+OAoNPg=:Y7BgX5BIPgszT0O4BxZW7J
 WaaFg03KOchGu73tJVqpCMjndPFmr/7oMG9c0pM/9tLcxqL4bfT6hg88+zije3jeSCRsQHid6
 TQ2blzfgVe5+u0qN8xpzHUvhQ2QHp5/AG/pw7iyp7HPdzpYLLzXRkj5Iah3By1hgwlKgzpQ5x
 7/4aRq+XMM5fh9vN3LNqsw3TBRyOGA1o3YM71Au/uQvmV7G7TSiWdNJtYcipspFHsAFqVan2U
 6Vla6fj6UAue+9riHNlf/iDNY/BS92awiHlXbFdTxiULoJ9rDgMyvISJdVwCxQSoZKej/hxts
 NidOpVLETufpcwbh7w1E6XPRYd6HAb4Gvr0ggnYcWy72cVxrd9kOFnMnNP35XHjqo3Aq5WXR9
 mZLST7iJghJGI5bZZU/WS4eu04UmA2dsqinpDTzqmM3ihDnvn1olaWwszcEdki5tchasqvs9/
 avk6MFAgexGImMYBVuDl5XJT/6bCfxzwkpSZDLkMxoIV3GwKRuXNll/9CRrIKjfhTNspX7Wx7
 ud6XRgvlRDCyOfLsVEJLjfYsD6WQTpZ6HjgET7dBqmOmeU4duT2ngthrbLrWrsCpq55DozLx7
 o3hFmjGuxrHzILCk+qWdEoTIV7sHfSyIDJbB8ddxG/bqgnUvVo6mFFZ2eJ4H022vMFNpVV/MB
 kIPWLmZaBsOaDDIaYTbZMir/EFcrhRuIqJYn9D1uNKDF1B1Tef0RmdXyeGQZAFYTo3ek=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 5:32 PM Michael Walle <michael@walle.cc> wrote:
>
> This series converts the guts driver from a platform driver to just an
> core_initcall. The driver itself cannot (or rather should never) be
> unloaded because others depends on detecting the current SoC revision
> to apply chip errata. Other SoC drivers do it the same way. Overall I
> got rid of all the global static variables.
>
> The last patch finally adds unique id support to the guts driver. But
> because the binding [1] for the security fuse processor is still pending,
> it is marked as RFC.
>
> [1] https://lore.kernel.org/linux-devicetree/20220127163728.3650648-2-michael@walle.cc/
>
> changes since v1:
>  - call kfree() in error case, thanks Dan
>  - add missing of_node_put(np), thanks Dan

Looks all good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
