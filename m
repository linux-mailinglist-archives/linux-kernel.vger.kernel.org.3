Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEDB57B6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiGTNCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiGTNCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:02:00 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555D50739
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:01:58 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id s1so16231991vsr.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AW46xL7r4jS0thdYzx3ynnITVHQeuO0nmP7MJbVua4g=;
        b=UjphxVnACeKxMDkdkSpppTnv3Y5JsowXe3Vk2CQH5ab7IcK0HMW6+PDwch69NTPE90
         SO31hXKWXClODMcnlsODgiAxn5DdX8L/0AIYR+XNYn7iDUx1eG66e0GYeFqV5oYZU9bI
         H+KYBUej4MNPzQC5UzbNbHu3aqqLb0vTDmIL1UaCBxqyXkajWxC06U6hmbZcFnll5wgP
         rQWL2Ih3mDjPeMEidj11cneVolYSWDbVADEnHZlFzxpkgZdJVP/0q2fXOL8THUpxN/Zu
         P8BmNnmWkk8HuXFF9gWVA1hee3jLUNpjQKE8RhOkqMs2yvAWEi6ehxH0B27Jnl7KPNto
         jjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AW46xL7r4jS0thdYzx3ynnITVHQeuO0nmP7MJbVua4g=;
        b=MWG9FgYee4cdSMtLrEsBUxpkpLJbRTelQ3J0FmAkGmz/W7Gk2InOg8Wy0ao3EA17Q8
         qSMZE8DgLzB3Uho/OwbW8eyNbYAIGu0bvVglLoj2L1YXKoKFmiYDjl28B38cR7IvKN3N
         3JwHSxUTnzCgvuC1OK+4kJ+6cWDncwATqYYvSDX5iM8XTi/Yj8FOSm3zCn1uGrQl944v
         qmqDzMkPrs0YOD4lVuQGMU+6mxHfUIDc0bzSMDTYzWPHETR/vOfODmtCY0nQVe/vcjLz
         W2DPT/xgNn356RqHX40d3uR5cWumDkyfj76ctKlckKDl5ljFGTmbiXDPJT6PM2eT6mbk
         OssA==
X-Gm-Message-State: AJIora/ClKVPuoiHFfzm0CSj6t8g42Jc2Vwm0/bchfLzNwAK7x5YrO0g
        cGLAfquSucjrvoV4wEFbOGzLH2GASMxJFJc1X7L+MoE0MCw=
X-Google-Smtp-Source: AGRyM1uMt6EDGuK4a9s9RLh37JSOOK05JUZjiWDWMgJ/zX5bCT7ENqOa88xinWs40uClNk1xzyirSW6dovQho84hDns=
X-Received: by 2002:a05:6102:3d25:b0:357:7f34:2664 with SMTP id
 i37-20020a0561023d2500b003577f342664mr12451410vsv.45.1658322117639; Wed, 20
 Jul 2022 06:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044754.4026295-1-tzungbi@kernel.org> <20220720044754.4026295-2-tzungbi@kernel.org>
In-Reply-To: <20220720044754.4026295-2-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 20 Jul 2022 06:01:46 -0700
Message-ID: <CABXOdTf-9WWc30WC6r7YjTnp7SGS-skJLTgLUaaqHVcCnx=fYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: merge Kunit utils and test cases
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 9:48 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Merge CROS_KUNIT and CROS_EC_PROTO_KUNIT_TEST so that when they're built
> as modules cros_kunit_util doesn't need to export the symbols.
>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/Kconfig           | 10 ++--------
>  drivers/platform/chrome/Makefile          |  5 +++--
>  drivers/platform/chrome/cros_kunit_util.c | 14 --------------
>  3 files changed, 5 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index cae859f0bc06..c45fb376d653 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -269,17 +269,11 @@ source "drivers/platform/chrome/wilco_ec/Kconfig"
>
>  # Kunit test cases
>  config CROS_KUNIT
> -       tristate
> -       help
> -         ChromeOS Kunit.
> -
> -config CROS_EC_PROTO_KUNIT_TEST
> -       tristate "Kunit tests for ChromeOS EC protocol" if !KUNIT_ALL_TESTS
> +       tristate "Kunit tests for ChromeOS" if !KUNIT_ALL_TESTS
>         depends on KUNIT && CROS_EC
>         default KUNIT_ALL_TESTS
>         select CROS_EC_PROTO
> -       select CROS_KUNIT
>         help
> -         Kunit tests for the ChromeOS Embedded Controller protocol.
> +         ChromeOS Kunit tests.
>
>  endif # CHROMEOS_PLATFORMS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index a06bc56d12a8..f7e74a845afc 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -32,5 +32,6 @@ obj-$(CONFIG_CROS_USBPD_NOTIFY)               += cros_usbpd_notify.o
>  obj-$(CONFIG_WILCO_EC)                 += wilco_ec/
>
>  # Kunit test cases
> -obj-$(CONFIG_CROS_KUNIT)               += cros_kunit_util.o
> -obj-$(CONFIG_CROS_EC_PROTO_KUNIT_TEST) += cros_ec_proto_test.o
> +obj-$(CONFIG_CROS_KUNIT)               += cros_kunit.o
> +cros_kunit-objs                                := cros_kunit_util.o
> +cros_kunit-objs                                += cros_ec_proto_test.o
> diff --git a/drivers/platform/chrome/cros_kunit_util.c b/drivers/platform/chrome/cros_kunit_util.c
> index d37c334b416d..090927d43035 100644
> --- a/drivers/platform/chrome/cros_kunit_util.c
> +++ b/drivers/platform/chrome/cros_kunit_util.c
> @@ -14,11 +14,8 @@
>  #include "cros_kunit_util.h"
>
>  int cros_kunit_ec_xfer_mock_default_ret;
> -EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);
>  int cros_kunit_ec_cmd_xfer_mock_called;
> -EXPORT_SYMBOL_GPL(cros_kunit_ec_cmd_xfer_mock_called);
>  int cros_kunit_ec_pkt_xfer_mock_called;
> -EXPORT_SYMBOL_GPL(cros_kunit_ec_pkt_xfer_mock_called);
>
>  static struct list_head cros_kunit_ec_xfer_mock_in;
>  static struct list_head cros_kunit_ec_xfer_mock_out;
> @@ -48,27 +45,23 @@ int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_comman
>
>         return mock->ret;
>  }
> -EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock);
>
>  int cros_kunit_ec_cmd_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
>  {
>         ++cros_kunit_ec_cmd_xfer_mock_called;
>         return cros_kunit_ec_xfer_mock(ec_dev, msg);
>  }
> -EXPORT_SYMBOL_GPL(cros_kunit_ec_cmd_xfer_mock);
>
>  int cros_kunit_ec_pkt_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
>  {
>         ++cros_kunit_ec_pkt_xfer_mock_called;
>         return cros_kunit_ec_xfer_mock(ec_dev, msg);
>  }
> -EXPORT_SYMBOL_GPL(cros_kunit_ec_pkt_xfer_mock);
>
>  struct ec_xfer_mock *cros_kunit_ec_xfer_mock_add(struct kunit *test, size_t size)
>  {
>         return cros_kunit_ec_xfer_mock_addx(test, size, EC_RES_SUCCESS, size);
>  }
> -EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_add);
>
>  struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
>                                                   int ret, int result, size_t size)
> @@ -91,7 +84,6 @@ struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
>
>         return mock;
>  }
> -EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_addx);
>
>  struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void)
>  {
> @@ -103,14 +95,10 @@ struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void)
>
>         return mock;
>  }
> -EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_next);
>
>  int cros_kunit_readmem_mock_offset;
> -EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_offset);
>  u8 *cros_kunit_readmem_mock_data;
> -EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_data);
>  int cros_kunit_readmem_mock_ret;
> -EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_ret);
>
>  int cros_kunit_readmem_mock(struct cros_ec_device *ec_dev, unsigned int offset,
>                             unsigned int bytes, void *dest)
> @@ -121,7 +109,6 @@ int cros_kunit_readmem_mock(struct cros_ec_device *ec_dev, unsigned int offset,
>
>         return cros_kunit_readmem_mock_ret;
>  }
> -EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock);
>
>  void cros_kunit_mock_reset(void)
>  {
> @@ -135,6 +122,5 @@ void cros_kunit_mock_reset(void)
>         cros_kunit_readmem_mock_data = NULL;
>         cros_kunit_readmem_mock_ret = 0;
>  }
> -EXPORT_SYMBOL_GPL(cros_kunit_mock_reset);
>
>  MODULE_LICENSE("GPL");
> --
> 2.37.0.170.g444d1eabd0-goog
>
