Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969F0583AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiG1JJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG1JJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:09:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A24655A6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:09:29 -0700 (PDT)
Received: from mail-ej1-f41.google.com ([209.85.218.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTiHb-1nu9Bi39Yb-00U23g for <linux-kernel@vger.kernel.org>; Thu, 28 Jul
 2022 11:09:27 +0200
Received: by mail-ej1-f41.google.com with SMTP id j22so2095862ejs.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:09:27 -0700 (PDT)
X-Gm-Message-State: AJIora+ZJDj8VeenGOG1tVZMq4bf8ezAQtGhRsHp7Rgi8DInAB1Lw/Dn
        inwBPz90Ksl3p2iw58d1gghOYP6cs6KQFPEQYlk=
X-Google-Smtp-Source: AGRyM1vDhbiuler73u+EjIx5wuxh8QlQQ0Haec12VYGBn4ZX1iE5CsXRYzT6tT02rH/oGeGfxWWYg85bgZqyR1cqrd4=
X-Received: by 2002:a17:906:dc89:b0:72f:1d4f:cea8 with SMTP id
 cs9-20020a170906dc8900b0072f1d4fcea8mr21214622ejc.654.1658999367339; Thu, 28
 Jul 2022 02:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com> <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
 <b39bf8c4-c702-8f49-12aa-d3ac05889b80@huawei.com> <CAK8P3a0w+_MLOjJAKMENe6MYvBcXWXSir47Hz34WbtdEeAmaBw@mail.gmail.com>
 <4d010f40-6c4c-32c7-2772-1bbfa02c03b7@linaro.org>
In-Reply-To: <4d010f40-6c4c-32c7-2772-1bbfa02c03b7@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Jul 2022 11:09:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a38uGGGLA4b2bi=v8cV6-dH5yEcvBYcwr5ChzkwMTX9_Q@mail.gmail.com>
Message-ID: <CAK8P3a38uGGGLA4b2bi=v8cV6-dH5yEcvBYcwr5ChzkwMTX9_Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, John Garry <john.garry@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bA73xE/XE/WMAxOM7287vsXi4ULSEY6mI+8jk0xXPAuALOXaQvU
 cWspFvFcbrr6SVlPRnpxujOUvvZ0/s4QFCtPY7bkQ/lKc5a3LYRBF4fxSsjemSCRdWGtMM7
 sB3PcRs9NUayQQ/E9pBd09wP5Fh8WOBkeGAU+C2HbzEn3L1KkZl/WO/sqaZk5vYTL7YUyNz
 MerAcTZu+RySL9Piahvbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rPy3fbX6cE8=:1cOvK+JtGhLEamnS2DwGCz
 yjyUL3aP7zWUryPsDlBVqXUw6DK8CzNVo5Pu6A5WN+j1z+US+IrkKwciXhD3t3w+VrHygKS0F
 IpzdKwqvYkKriTQTZRF2IY5n9OEXhblKoIjUEbaf4Nyw2TU8p2/nLjhTaIy4ocDjWyBQdYvn2
 gfi0FJ4eRUEtMoNRsb6PO6RdKXFpsQ7Wv8Vk0+bDs3ClymY1q1RlOR74LcHJKuDzTWf/XUYTE
 k45EMV6GLzKbebK2jev9BK1vKjJXYHRO5t7C8FJzNl2ESyoV7D8WRPWJDETgBiZRvkvAyB/6h
 abXAjr9fhSs5AFr52cHAis/Wgo5Irou0PH33dPEJnHFn835+axLoJDqFke/E700vH+4nguNCh
 3DTwpzIr9FEIMX5rRkRUnmosUIdQxwba6YSpMEKzCzLYIfISMiCyDx7yUHA1MednRHIZOBJG6
 zJ3Enqg6EUpmqOu25TnY4G/OoValb3YtWWtIHILEnqwhtfHoLMipgiDE6kH+EKXWDCsZzfY15
 F4EmEw1B9UAjZZMxbUCjgD1qbdPdPEZE7rWKmFpNdeagjbypICAyfEC9h1SjQgvt3Nvfz+Afb
 QAD2yu55vp6UFfWMTkLKBXVJu5D4w6D7h35pGNcf7R6QozF0g5+zoom3LbN5no1TirPxkwv4a
 qXWK6EQLj1anlImhNJDl3/NZuhEvICJz02mpKVNqVmQaPjmn9pSEkKw6AQlZI/2AW1J7BtJ/Z
 nWgDm+/wM5BdMgPsKJA8HhFQXHiHM2pjM2H0tPr5K6iPHk/k5TzclH9bcpvh1RIRC6VnGUMMj
 URRVYwqyqmJEgyp950XSb1kfdqAwv7asuySl2ouI2Hj/ad12DUfNypPa+eF8x+NiEWvWmy+Ob
 s3kp5FD2WlQnPSPEjupg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 10:53 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> On 28/07/2022 09:23, Arnd Bergmann wrote:
> > On Thu, Jul 28, 2022 at 10:06 AM John Garry <john.garry@huawei.com> wrote:
>
> As we are using a common driver for this, we wanted to check if the
> parent was a slimbus or not, to be able to select correct read/write
> interfaces.
>
> rethinking about this approach, It should be doable to also derive this
> information from compatible strings, Soundwire controller versions 1.3.0
> and below are always of type 1 and the newer ones are type 2.
>
> So this could get rid of IS_REACHABLE check along with references to
> slimbus_bus from driver.

Referencing slimbus_bus here is not a problem, just use IS_ENABLED()
and fix the dependency. While at it, please also

> expressing the SlimBus dependency for type 1 should be either captured
> using imply SLIMBUS or depends in Kconfig.

'imply' has no effect on compile testing, it only affects what goes in
the defconfig file, so there has a be a 'depends on'. To allow building both
with and without slimbus, but disallow the configuration with slimbus
as a loadable module and soundwire-qcom as built-in, do it like this:

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 2b7795233282..69e46cce7d8b 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -35,7 +35,7 @@ config SOUNDWIRE_INTEL

 config SOUNDWIRE_QCOM
        tristate "Qualcomm SoundWire Master driver"
-       imply SLIMBUS
+       depends on SLIMBUS || !SLIMBUS
        depends on SND_SOC
        help
          SoundWire Qualcomm Master driver.
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 22b706350ead..f65c7737c2db 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1289,11 +1289,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
        data = of_device_get_match_data(dev);
        ctrl->rows_index = sdw_find_row_index(data->default_rows);
        ctrl->cols_index = sdw_find_col_index(data->default_cols);
-#if IS_REACHABLE(CONFIG_SLIMBUS)
-       if (dev->parent->bus == &slimbus_bus) {
-#else
-       if (false) {
-#endif
+       if (IS_ENABLED(CONFIG_SLIMBUS) && dev->parent->bus == &slimbus_bus) {
                ctrl->reg_read = qcom_swrm_ahb_reg_read;
                ctrl->reg_write = qcom_swrm_ahb_reg_write;
                ctrl->regmap = dev_get_regmap(dev->parent, NULL);
