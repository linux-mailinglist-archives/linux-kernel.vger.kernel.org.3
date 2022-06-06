Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34AB53E961
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiFFKKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiFFKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:08:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E587210
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:07:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v19so18083391edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uwcCEtSswrsSeV8Oe+2oTvOp0hok5ZHYDzpgWGeOlQ=;
        b=DE69h8+Q3aglb3detW4jawOS1bRNj33jBRCuZvuuZpeknccYBlvm4xRpPjZqCT6xlC
         9tO5iUZhxoO2ZJv9IkPSVwStFjoyrmQ12dGIfOazv5x4tkDRdqtx3Odupd6yfsdLYL02
         9ZsU3L6IE2/ZPEDo9d54IFGjZLrLbHosPGwF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uwcCEtSswrsSeV8Oe+2oTvOp0hok5ZHYDzpgWGeOlQ=;
        b=aB+5skh0IUhIbSQIqzdGAHlUHYpQlKU6KmYjq20jbxbSYrBO2KpMVQBqjT3osUUFW3
         qy0DgbtPxXpVYM5eTaAHSTh79Q6cod5owkplsiyxxrOT53O9nnbSdjAeq8QqLPK8h3pc
         V3WM32T4AyJcvmFgzmHOUcyB1rpnxDywEjv/Xx/agPPFZRxjs52JTYP/OIPeHopJ6oWi
         wL8edwKrp23ryfoLSTcaer4hHSmxJQ7xqkyN+RXuUZj0mg5QOvfWRlhIh8a/gpYeDfOq
         7F4V/LZoCxDjokui0+zhrygNq4Q2KahgSMTYsqunoWLI30ewp3+7VaW8n0gM58j2z/dz
         p/Dw==
X-Gm-Message-State: AOAM5334QPM3Wdl54w6NYhXAIZnKjOEg0zSGrEIuj/bu6vhZgYSEHNIP
        kuC1AKAmHlz0ASQ9oa+4T+kNIhrdP0C6zhbTL4o/GA==
X-Google-Smtp-Source: ABdhPJw0GXg99MvbQTKVkrNI4lLKZkQooYMuZvDOZ1tfUMZGtWWH5ppQgsFJTyLOn9eTLW43RxaLMTqeNMsUuS8GDAY=
X-Received: by 2002:aa7:c84d:0:b0:431:4226:70c9 with SMTP id
 g13-20020aa7c84d000000b00431422670c9mr9032595edt.51.1654510043095; Mon, 06
 Jun 2022 03:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220527110036.8810-1-johnson.wang@mediatek.com>
In-Reply-To: <20220527110036.8810-1-johnson.wang@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 6 Jun 2022 18:07:12 +0800
Message-ID: <CAGXv+5FZ9DthNaZCgaO6ygO4cUD91Bw1uVYJq98SHUcoAmPoPQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Introduce MediaTek CCI devfreq driver
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com
Cc:     krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com,
        khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 7:01 PM Johnson Wang <johnson.wang@mediatek.com> wrote:
>
> The Cache Coherent Interconnect (CCI) is the management of cache
> coherency by hardware. CCI DEVFREQ is DVFS driver for power saving by
> scaling clock frequency and supply voltage of CCI. CCI uses the same
> input clock source and power rail as LITTLE CPUs on Mediatek SoCs.
>
> This series depends on:
> Chanwoo's repo: kernel/git/chanwoo/linux.git
> branch: devfreq-testing
> [1]: PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
> [2]: PM / devfreq: Add cpu based scaling support to passive governor
> [3]: PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
> [4]: PM / devfreq: passive: Update frequency when start governor
>
> Changes in v6:
> - Remove unnecessary "goto" statement.
>
> Changes in v5:
> - Modify some binding description.
> - Remove pre_voltage member.
> - Not to enable/disable intermediate clock.
> - Not to "put" resources that using devm_ variants.
>
> Resend v4:
> - CC interconnect maintainer.
> - Change sign-off sequence in commit message.
>
> Changes in v4:
> - Add a maintainer in the binding document.
> - Modify clock description.
> - Add binding document into MAINTAINERS.
> - Replace format specifier %d with %ld.
>
> Changes in v3:
> - Move binding document to 'interconnect' and rename it.
> - Add COMPILE_TEST dependence symbol.
> - Remove need_voltage_tracking variable.
> - Move mtk_ccifreq_voltage_tracking() code into mtk_ccifreq_set_voltage().
> - Add an interation limit in the while() loop.
> - Replace 'cci_dev' with 'dev'
> - Replace old_* with pre_*
> - Remove of_match_ptr()
> - Use module_platform_driver()
>
> Changes in v2:
> - Take MT8183 as example in binding document.
> - Use dev_err() instead of pr_err().
> - Use 'goto' statement to handle error case.
> - Clean up driver code.
>
> Johnson Wang (2):
>   dt-bindings: interconnect: Add MediaTek CCI dt-bindings
>   PM / devfreq: mediatek: Introduce MediaTek CCI devfreq driver

FTR,

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
