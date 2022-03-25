Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFC4E7379
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349554AbiCYM35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359616AbiCYM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:28:29 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BC89D4CE;
        Fri, 25 Mar 2022 05:26:06 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id m84so4140726vke.1;
        Fri, 25 Mar 2022 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OW2X/n8+/Y9eRUhdPagVsT3XevbzyJFnqyDFs/6ofLE=;
        b=JGVs4nxG87jz1HYwKu/7SuWEduyJ1NrXlEKNDfTjjm9xd/tri5exYN7InR3+xSyCg9
         Axi8yCHsAoBGxGldoJaU9GiL2BoNxkkmgp96Nl4Ubqff1WKj+nlE4kHbJl0EYIcmp3BQ
         DPeWRI/i+4wd54SThX6ZomTkEwNHx56/eVOcBZ4cGLJP05uVqKCO19iZDhvo3QoNdLQ0
         bNPtndNYqKBa6/2uZ5U+vNTx06BYgqJ5u6Z1YvBHKRdJAR2ihyTDMP+Yx4L1mfrMUm9Y
         QpN7uQSq5jKsgwFBw4n9eF2QDwY88pzTn0+c6KxsyIXt0z5vzpYQua9v6elHK1AiM2Hb
         c7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OW2X/n8+/Y9eRUhdPagVsT3XevbzyJFnqyDFs/6ofLE=;
        b=h6Ay8fE1XREGl4eSBJDSOyvCs4EMTJ92P5YKDKw7O7FckAfOQfReObDjzvBnrmsLQA
         szhO7czRrIoBEib9tb+ZHkLlh4Jl5jOJHzhxU2HvfMxc8n3hV75CQbh1wuFUuCrwuNXI
         TAp2onJqPScoBM8uul12u/fyAGQy39TNS96BDzIgGV8WTdVy9X1WWSUQAiRN2vdct8t5
         8SKAj2J5RJF+KhV4P5Y1jtTd3J8gc/MSwNIMMdxxFFmdtYXGjU+zNNwTV3WMKdII1CZa
         brdPPU6XMZVq35KJ7usZXivjgLehiGokHSrus8zGxfXjIh9jp/H1EHPIsTbE8AGNl2U/
         QyJQ==
X-Gm-Message-State: AOAM531XZWAcjERUs8r6p1xRrb62IlCFIHHQOnRi+Dp4JLA1Scx7I9+z
        7brc6vxmpDYq0UfuTyAfMKQGAEx/I788e6aAoIr7qzK+3tw=
X-Google-Smtp-Source: ABdhPJzGtQRmOanbE2F813vo1nLbz8KXAs2WCBYRxBOxe6/nfHGjk6QQFqSOGbQwkE5+AsgjCYPnkOxeyZrl/HgETao=
X-Received: by 2002:a05:6122:50f:b0:337:aa83:8887 with SMTP id
 x15-20020a056122050f00b00337aa838887mr4913403vko.10.1648211165942; Fri, 25
 Mar 2022 05:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220324124402.3631379-1-daniel@0x0f.com> <20220324124402.3631379-5-daniel@0x0f.com>
In-Reply-To: <20220324124402.3631379-5-daniel@0x0f.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Fri, 25 Mar 2022 13:25:54 +0100
Message-ID: <CABgxDoK=5k94JJr1kry5xxS8NS5cyoBPS8PfMrjR8_h_LTjdBQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: mstar: Add second UART to base dtsi.
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        andriy.shevchenko@linux.intel.com,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


Le jeu. 24 mars 2022 =C3=A0 13:44, Daniel Palmer <daniel@0x0f.com> a =C3=A9=
crit :
>
> Add the second UART to the base dtsi.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

More context in the long message would help, imho.
Otherwise:
Reviewed-by: Romain Perier <romain.perier@gmail.com>
