Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E057583E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiG1MDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiG1MD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:03:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B599D69F38
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:03:24 -0700 (PDT)
Received: from mail-ej1-f45.google.com ([209.85.218.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N33ZD-1nL2lr44jN-013O7J for <linux-kernel@vger.kernel.org>; Thu, 28 Jul
 2022 14:03:23 +0200
Received: by mail-ej1-f45.google.com with SMTP id z23so2764534eju.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:03:22 -0700 (PDT)
X-Gm-Message-State: AJIora8J+pdb9SgWvbAlwlJLv7bfeoJtSQk95HwSR40ZLbdxH3yOnZrF
        LUIkbeeN7Q5NES+79rhrmpR79XsXUMn5X+9MBTA=
X-Google-Smtp-Source: AGRyM1vbcZtXff9wdVPPzf+JJ956N9jBi6RVLMTg4p5oOr7chFDjRAgayypXIkN9s9OCY7Rbo+VZ/Wqd9spSTPDDM/I=
X-Received: by 2002:a17:907:d0f:b0:72e:db1f:9b91 with SMTP id
 gn15-20020a1709070d0f00b0072edb1f9b91mr21266735ejc.470.1659009802540; Thu, 28
 Jul 2022 05:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com> <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
 <b39bf8c4-c702-8f49-12aa-d3ac05889b80@huawei.com> <CAK8P3a0w+_MLOjJAKMENe6MYvBcXWXSir47Hz34WbtdEeAmaBw@mail.gmail.com>
 <4d010f40-6c4c-32c7-2772-1bbfa02c03b7@linaro.org> <CAK8P3a38uGGGLA4b2bi=v8cV6-dH5yEcvBYcwr5ChzkwMTX9_Q@mail.gmail.com>
 <966a62da-52b6-1789-13d6-5fe06b62c7fe@marek.ca>
In-Reply-To: <966a62da-52b6-1789-13d6-5fe06b62c7fe@marek.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Jul 2022 14:03:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2HGYJZvcXM+9fROys5A6c40zFWD2qATT4xssSJf6hRfQ@mail.gmail.com>
Message-ID: <CAK8P3a2HGYJZvcXM+9fROys5A6c40zFWD2qATT4xssSJf6hRfQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xVJOdBOsIQjuFIi3cL17M0Cl/DpUHhg5lxdtZ8F0Tq2wbkSDYZg
 EwlpUXB3OkCZPbviUz0kKAr8fXZdM/fU9DLyoufpshmj/UykoipDpPKWv2dTDXgCdRVl2Ea
 6k81F4WUPKm9t4Q6nmCxzf+CasqEg6X+H51leVnxE1MyJMWtfgElQZFC5ctTZmiFXlVbHm+
 rlFIp+5hKdfP2yaEOFnFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mzPKANfprsg=:DNJlnpS/IZdYPb27FeAC+s
 6+CF8Ppc6Ye1hInlkg39qAcQ+YKu0EaBikfV270R/+w4i29ptbI1gvGfv5UigpClPwxW7wjGx
 4sr1PtEdazq+9RjkZwfrHrePYexJIhEI5p2rR3JMcFCaOq5L0KcVffe2inx5SLUgaRoxpIMLU
 roZFpZ3Cor3iud2jQOvbWmxv+LiOSfwEWFNDT1eg/s3DLMtNbavmg1d8vdTyUZuG8WX+8AcQB
 bFrBL6dEfHsPae2YUNydsfjVn2tLAKGPQkZVr8IV73MBTONigKyYwM7Ka7XhfrF4VAC3251k/
 eqFSSJew6IiDg8oavtkSEi+lazwItoJdrzAhwhbHPEKWnDDB/Khx2uwt/leQVsK3jJlzk6Wfx
 JWKW1U0YbjMQX31MFbEsliF2FlM76uMwmVjtDLUssxgijdIObHBvJwUwBRb1LguWkpoBsGL/D
 JQJW4Vde5ol0ZdUZo7oF37U8qGSCa9muqf5BQIV6KqHoRUBRbL19bCqJgywGbOBsBt/UBdfFI
 EZR5uKF6n8GaVdtEXpp5WhquIYkwB2w0LlYXJHkkPr/j3a392zRjgDzz1f5xiS/TUHmunM7cb
 OV6MDZ43banzYulpTRlfjoeunDwfk6BxRgr6JjAzMKZUIBdOXN2VaLT9olL9S3YMmc4ggweoB
 OK0mRHUQIFXIPNuKO8AjTODU6yU9yCPNmGrFZGAs7ulEgtvgx7lpE19XX/ee/KBvRXIhKZg9d
 uAKTVYGbOgXUYdw9Bf7vKu/9Ss8mHRkTLS10AaFhKxHoYAtBpCJl3BMH+MZbKRJGDn+wFHvDe
 ZZjZhgFMnz9SGUZKMLXFVKCyalmUDbL9Fnp2/XadIW3dhflajEsW2Euqqcd+xbabBpgoLgWG+
 HVrql/XD53rJxfKiguRg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 1:57 PM Jonathan Marek <jonathan@marek.ca> wrote:
> On 7/28/22 5:09 AM, Arnd Bergmann wrote:
> > diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> > index 22b706350ead..f65c7737c2db 100644
> > --- a/drivers/soundwire/qcom.c
> > +++ b/drivers/soundwire/qcom.c
> > @@ -1289,11 +1289,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
> >          data = of_device_get_match_data(dev);
> >          ctrl->rows_index = sdw_find_row_index(data->default_rows);
> >          ctrl->cols_index = sdw_find_col_index(data->default_cols);
> > -#if IS_REACHABLE(CONFIG_SLIMBUS)
> > -       if (dev->parent->bus == &slimbus_bus) {
> > -#else
> > -       if (false) {
> > -#endif
> > +       if (IS_ENABLED(CONFIG_SLIMBUS) && dev->parent->bus == &slimbus_bus) {
> >                  ctrl->reg_read = qcom_swrm_ahb_reg_read;
> >                  ctrl->reg_write = qcom_swrm_ahb_reg_write;
> >                  ctrl->regmap = dev_get_regmap(dev->parent, NULL);
> >
>
> This relies on the compiler optimizing out the reference to slimbus_bus,
> which doesn't exist in the CONFIG_SLIMBUS=n case (not tested, but I
> think this means an O0 build will fail?).

That is correct: We rely on this everywhere in the kernel, which is why
it is impossible to build kernels with -O0.

       Arnd
