Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0585120BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiD0P5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiD0P5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:57:40 -0400
X-Greylist: delayed 152 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 08:54:16 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E51268F9D;
        Wed, 27 Apr 2022 08:54:16 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mqrjz-1oENqG0iKf-00mrwW; Wed, 27 Apr 2022 17:54:13 +0200
Received: by mail-yb1-f178.google.com with SMTP id i38so4119931ybj.13;
        Wed, 27 Apr 2022 08:54:12 -0700 (PDT)
X-Gm-Message-State: AOAM5335823T6pjdSAsQAfjCB1La+EVJEs666fSiPlkX8XgBmnOIN5N3
        DGBXwMiHHFrPEjkebILmSADWIWvOlDqBLv8o8K8=
X-Google-Smtp-Source: ABdhPJxHemNwK0DAy5FuErl9xC8yLLyxMtfbA2y/7QlMY3Z3+7pVeZiYe0pvKik1aCqyajVLtuwn0BCFg68MYiLj78c=
X-Received: by 2002:a25:75c5:0:b0:648:dccd:e1c with SMTP id
 q188-20020a2575c5000000b00648dccd0e1cmr2434334ybc.452.1651074851892; Wed, 27
 Apr 2022 08:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1644824638.git.quic_saipraka@quicinc.com> <8e1fe065405c2d9d1e28e3f84880d156c2e887a4.1644824638.git.quic_saipraka@quicinc.com>
In-Reply-To: <8e1fe065405c2d9d1e28e3f84880d156c2e887a4.1644824638.git.quic_saipraka@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 17:53:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1mQr5mRQhviymJLdvibUYPyk94MrRmhj4e74+d5_485Q@mail.gmail.com>
Message-ID: <CAK8P3a1mQr5mRQhviymJLdvibUYPyk94MrRmhj4e74+d5_485Q@mail.gmail.com>
Subject: Re: [PATCHv10 2/6] coresight: etm4x: Use asm-generic IO memory barriers
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        quic_psodagud@quicinc.com, gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HzsXgr21LZih4Qg1akjM6j3OWlwK78UWe7tclJwsbp78YXHKteF
 NCO2XA4DeDOP6TgX+0f2/0kgIy52bicYervXFo/Dsi65efFiQJDGrHnTsdvoDSAzj+IBC7o
 tI+iZVTkUzRAsX16vHT6H9paBkExYggU9XvXU0Vyz7TgxYpr0bI/pqprH6rDKh1zsLkTzAp
 H05NSYyVGC18rO/icFXvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8W5PFcq20lQ=:aydZdMlFmwdFaTxD++rczK
 6w8sIdB8+egqwwLx/wGRnQyk0Q303IKvAyQ6XCx1onOgSpq2xKsfTHvNS06v1ap1LJvd3HpVC
 78mLdOkSTfvDIhQc9RNhhbYHSkUxG7FfNwlDOj1y8vIzCkvZdgNgEsXLiBOXjxR8NvfWW3v6M
 GjYDbY6x7nWuAhi92jsgPGSi+DFi6jMKo7u7Hfn4+2NX0sqUhWNefjcjUQz8jg25tYwLAafO6
 y80DCvdLPeyX2ALGf7FqMh1B3/I2iL95pmwpt4CluxUS3eF7l4ZAN1MdXFPc/plnGXWe6TtT7
 xVJzZW0kdlcGCziSOfy9qCJasAFflAHCuD9hc6dX0jr3pg2ZMY1QgIT4a1mW5JBBzPzKP/fMV
 MONkerpIcdGn4fOsBpCf9mJOqgurFH+wHKkhYpHFSYyC0A25IyBgN5GBr3MqFewo9NDuIA60D
 jHypzASfFG1EDwOVIXK7eP1XV0HkxOcYD5/YLoJAu65VVGxooYVqDviJhKgNhgyq66POBSxNT
 ssrODvixvqSaU6Wjx3gS5t1IvJU57XBPwGNY0XWEziW5TOKKsjNQHGeV0vqlY6LhHv+l6XZKu
 +qL7YpKe/EEBGkhWGmv2b57PTxOiGzd7GBhWIJbwZnK9BTJN2z8SQ0eZ5VJDys7NeW5TxJiSA
 mUNCVH4d8ojfBuuxO4SmJnwfb7m3b9f9tzG4uDSyMFYf08/AAvm7Q9ZVXfIB47oc0WwI0GnA9
 gp70yrWiK5lH0Mo3dSXPz/C8Qt63LyrP6CIm06CWyVd2SoFBSGdzUOoaPvEha3yW9icC9/T53
 5iVIeGQ4K2pbMiuEQZ+LzIZwIt2FeBGEbwCzSqNoVnRQ/S+KFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 7:07 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
>
> Per discussion in [1], it was decided to move to using architecture
> independent/asm-generic IO memory barriers to have just one set of
> them and deprecate use of arm64 specific IO memory barriers in driver
> code. So replace current usage of __io_rmb()/__iowmb() in drivers to
> __io_ar()/__io_bw().
>
> [1] https://lore.kernel.org/lkml/CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com/
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: coresight@lists.linaro.org
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
