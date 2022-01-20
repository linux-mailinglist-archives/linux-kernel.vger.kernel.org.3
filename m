Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73D549474B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiATG1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiATG1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:27:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D7FC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 22:27:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n10so8512306edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 22:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFmjgHfLJUWnV7Qn5kkhmeJMJ9N6Wi1gBrX6Yzqq6s4=;
        b=NOhBd8DBEsPtzKkaMHiWGBI06alNXGRbtaYcVQ/XYpsd4bPZz6sQCpaK8eJFbkugbV
         7duaOl/w2PKuya5QjCcARZTGYBVFgx+EBml4cMSpzimuFjzfBazElT9NvMuHMiP+ITXt
         GY/YYzsNRbSQqb3H/dxkbOlCSsVvavwNjT4N4zVpNWYepKSXwDA4KM1jPvDdgbvCPC0Y
         qqsO/ppjxvTTBKCH3oiNifA2Vl+l0b5VtENIs220rSob3/+4jRJGk+vB6fCNoBTccswk
         w10/3zgOjFINr3jPFEb84RVRyNBC7CsE3UtkUIYWpEmBtG2LhndriimTDViMgZyiNwb4
         l6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFmjgHfLJUWnV7Qn5kkhmeJMJ9N6Wi1gBrX6Yzqq6s4=;
        b=B6lVxBcmA9vcqML1Afdyrv77SHaNhG9v5Z/1gtgiuf5SfzP6p4+odQwnLCm4BgTrLP
         3Wf9QvRJHIySvcepp0BBHl3W11MvhRLp01f+2+g6dF/jt2s4X5ivEWJ8pYCZ2rWFrJD1
         LNk+ykfoeV8pXN9hN+U0bCI6F/Q4YARMmIJXNtO4WXzS4Ix1NAUfIQ35CkADBwitlRpq
         FeddkvLMsOONQifr66sH8COWqsSnwEfUXmq8WdhvtdVtPFOQ22tNw/URqIfiTYMviwQX
         5cc8o4Y975cbJWPDZlr+wIg6Y7JQUZe2cUZVCIVsSPONjKL0izg7GNoeI9Eju0AqjLiX
         S8hA==
X-Gm-Message-State: AOAM530koavb4Z5ORsQl/8XobF+k0EHbuVYdEGmOt0hdZsZfYla++J3n
        tkKbRvHbzNaBix2tnwrIl/NEpAr3kKpcd1fVtAMQrA==
X-Google-Smtp-Source: ABdhPJx2uxNAqDbQ38pk3vSVFQaZXnp2TzhRt62urgSck+VK2Foh8PrLAFAG8qfcXOo8lcSa8sKH6ks8HkniLgRmad0=
X-Received: by 2002:a05:6402:1e91:: with SMTP id f17mr32501596edf.229.1642660021400;
 Wed, 19 Jan 2022 22:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20220120052303.2098394-1-sboyd@kernel.org>
In-Reply-To: <20220120052303.2098394-1-sboyd@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 19 Jan 2022 22:26:50 -0800
Message-ID: <CAGS_qxoMRsvx8HDex9Aq9KUALAQrdNe3VVYikyzT59TEYfbLdg@mail.gmail.com>
Subject: Re: [PATCH v2] clk: gate: Add some kunit test suites
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 19, 2022 at 9:23 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Test various parts of the clk gate implementation with the kunit testing
> framework.
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Cc: <kunit-dev@googlegroups.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>
> Changes from v1 (https://lore.kernel.org/r/20220115080657.2780989-1-sboyd@kernel.org):
>  * Changed file name to semi-match convention
>  * Changed Kconfig symbol name to match convention
>  * Changed kzalloc to test managed allocation
>  * Inlined check for ret where possible
>
>  drivers/clk/.kunitconfig    |   3 +
>  drivers/clk/Kconfig         |   8 +
>  drivers/clk/Makefile        |   1 +
>  drivers/clk/clk-gate_test.c | 469 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 481 insertions(+)
>  create mode 100644 drivers/clk/.kunitconfig
>  create mode 100644 drivers/clk/clk-gate_test.c
>
> diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
> new file mode 100644
> index 000000000000..3754fdb9485a
> --- /dev/null
> +++ b/drivers/clk/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=y
> +CONFIG_COMMON_CLK=y
> +CONFIG_CLK_GATE_KUNIT_TEST=y
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c5b3dc97396a..947cd0b12dbd 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -421,4 +421,12 @@ source "drivers/clk/x86/Kconfig"
>  source "drivers/clk/xilinx/Kconfig"
>  source "drivers/clk/zynqmp/Kconfig"
>
> +# Kunit test cases
> +config CLK_GATE_KUNIT_TEST
> +       tristate "Basic gate type Kunit test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Kunit test for the basic clk gate type.
> +
>  endif
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e42312121e51..52faef37bc9b 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_COMMON_CLK)        += clk-divider.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-factor.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-fixed-rate.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-gate.o
> +obj-$(CONFIG_CLK_GATE_KUNIT_TEST) += clk-gate_test.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-multiplier.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-mux.o
>  obj-$(CONFIG_COMMON_CLK)       += clk-composite.o
> diff --git a/drivers/clk/clk-gate_test.c b/drivers/clk/clk-gate_test.c
> new file mode 100644
> index 000000000000..2448ff0d1d68
> --- /dev/null
> +++ b/drivers/clk/clk-gate_test.c
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kunit test for clk gate basic type
> + */
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include <kunit/test.h>
> +
> +static void clk_gate_register_test_dev(struct kunit *test)
> +{
> +       struct clk_hw *ret;
> +       struct platform_device *pdev;
> +
> +       pdev = platform_device_register_simple("test_gate_device", -1, NULL, 0);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       ret = clk_hw_register_gate(&pdev->dev, "test_gate", NULL, 0, NULL,
> +                                  0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> +       KUNIT_EXPECT_STREQ(test, "test_gate", clk_hw_get_name(ret));
> +       KUNIT_EXPECT_EQ(test, 0UL, clk_hw_get_flags(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       platform_device_put(pdev);
> +}
> +
> +static void clk_gate_register_test_parent_names(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *ret;
> +
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           1000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       ret = clk_hw_register_gate(NULL, "test_gate", "test_parent", 0, NULL,
> +                                  0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> +       KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       clk_hw_unregister_fixed_rate(parent);
> +}
> +
> +static void clk_gate_register_test_parent_data(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *ret;
> +       struct clk_parent_data pdata = { };
> +
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           1000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +       pdata.hw = parent;
> +
> +       ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
> +                                              NULL, 0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> +       KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       clk_hw_unregister_fixed_rate(parent);
> +}
> +
> +static void clk_gate_register_test_parent_data_legacy(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *ret;
> +       struct clk_parent_data pdata = { };
> +
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           1000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +       pdata.name = "test_parent";
> +
> +       ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
> +                                              NULL, 0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> +       KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       clk_hw_unregister_fixed_rate(parent);
> +}
> +
> +static void clk_gate_register_test_parent_hw(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *ret;
> +
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           1000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       ret = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0, NULL,
> +                                            0, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> +       KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> +
> +       clk_hw_unregister_gate(ret);
> +       clk_hw_unregister_fixed_rate(parent);
> +}
> +
> +static void clk_gate_register_test_hiword_invalid(struct kunit *test)
> +{
> +       struct clk_hw *ret;
> +
> +       ret = clk_hw_register_gate(NULL, "test_gate", NULL, 0, NULL,
> +                                  20, CLK_GATE_HIWORD_MASK, NULL);
> +
> +       KUNIT_EXPECT_TRUE(test, IS_ERR(ret));
> +}
> +
> +static struct kunit_case clk_gate_register_test_cases[] = {
> +       KUNIT_CASE(clk_gate_register_test_dev),
> +       KUNIT_CASE(clk_gate_register_test_parent_names),
> +       KUNIT_CASE(clk_gate_register_test_parent_data),
> +       KUNIT_CASE(clk_gate_register_test_parent_data_legacy),
> +       KUNIT_CASE(clk_gate_register_test_parent_hw),
> +       KUNIT_CASE(clk_gate_register_test_hiword_invalid),
> +       {}
> +};
> +
> +static struct kunit_suite clk_gate_register_test_suite = {
> +       .name = "clk-gate-register-test",
> +       .test_cases = clk_gate_register_test_cases,
> +};
> +
> +struct clk_gate_test_context {
> +       void __iomem *fake_mem;
> +       struct clk_hw *hw;
> +       struct clk_hw *parent;
> +       u32 fake_reg; /* Keep at end, KASAN can detect out of bounds */
> +};
> +
> +static struct clk_gate_test_context *clk_gate_test_alloc_ctx(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx;
> +
> +       test->priv = ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +       ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
> +
> +       return ctx;
> +}
> +
> +static void clk_gate_test_parent_rate(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       unsigned long prate = clk_hw_get_rate(parent);
> +       unsigned long rate = clk_hw_get_rate(hw);
> +
> +       KUNIT_EXPECT_EQ(test, prate, rate);
> +}
> +
> +static void clk_gate_test_enable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       u32 enable_val = BIT(5);
> +
> +       KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
> +
> +       KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static void clk_gate_test_disable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       u32 enable_val = BIT(5);
> +       u32 disable_val = 0;
> +
> +       KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
> +       KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> +
> +       clk_disable_unprepare(clk);
> +       KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static struct kunit_case clk_gate_test_cases[] = {
> +       KUNIT_CASE(clk_gate_test_parent_rate),
> +       KUNIT_CASE(clk_gate_test_enable),
> +       KUNIT_CASE(clk_gate_test_disable),
> +       {}
> +};
> +
> +static int clk_gate_test_init(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           2000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
> +                                           ctx->fake_mem, 5, 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +
> +       ctx->hw = hw;
> +       ctx->parent = parent;
> +
> +       return 0;
> +}
> +
> +static void clk_gate_test_exit(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +
> +       clk_hw_unregister_gate(ctx->hw);
> +       clk_hw_unregister_fixed_rate(ctx->parent);
> +       kfree(ctx);

I think we forgot to drop some kfree's now that we're using
test->priv = ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);

This will result in duplicate kfree's.

Running with KASAN surfaces this, e.g
$ git rebase torvalds/master  # or really, I just want bf4eebf8cfa2r
$ run_kunit --kunitconfig=drivers/clk --kconfig_add=CONFIG_KASAN=y
--arch=x86_64 --build_dir=kunit_x86/
...
BUG: KASAN: double-free or invalid-free in kunit_remove_resource+0xb3/0xe0
...
Freed by task 36:
 kasan_save_stack+0x1e/0x50
 kasan_set_track+0x20/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0xfb/0x130
 kfree+0x80/0x1e0
 clk_gate_test_is_disabled_inverted+0x18d/0x1e0  <----- leftover kfree()
 kunit_try_run_case+0x88/0xc0
 kunit_generic_run_threadfn_adapter+0x24/0x40
 kthread+0x1fe/0x230
 ret_from_fork+0x22/0x30
...

I generally find this little recipe very useful, so here's some
explanations in case they're useful:
1. I'm using the bash function from
https://www.kernel.org/doc/html/latest/dev-tools/kunit/running_tips.html#running-from-any-directory
2. --kconfig_add is a new feature in torvalds/master for 5.17
3. KASAN doesn't work on UML right now, hence --arch=x86_64
4. I also like to use a different --build_dir for x86 builds so I
minimize rebuilding when I switch between UML and x86

> +}
> +
> +static struct kunit_suite clk_gate_test_suite = {
> +       .name = "clk-gate-test",
> +       .init = clk_gate_test_init,
> +       .exit = clk_gate_test_exit,
> +       .test_cases = clk_gate_test_cases,
> +};
> +
> +static void clk_gate_test_invert_enable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       u32 enable_val = 0;
> +
> +       KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
> +
> +       KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static void clk_gate_test_invert_disable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       u32 enable_val = 0;
> +       u32 disable_val = BIT(15);
> +
> +       KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
> +       KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> +
> +       clk_disable_unprepare(clk);
> +       KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static struct kunit_case clk_gate_test_invert_cases[] = {
> +       KUNIT_CASE(clk_gate_test_invert_enable),
> +       KUNIT_CASE(clk_gate_test_invert_disable),
> +       {}
> +};
> +
> +static int clk_gate_test_invert_init(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           2000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       ctx->fake_reg = BIT(15); /* Default to off */
> +       hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
> +                                           ctx->fake_mem, 15,
> +                                           CLK_GATE_SET_TO_DISABLE, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +
> +       ctx->hw = hw;
> +       ctx->parent = parent;
> +
> +       return 0;
> +}
> +
> +static struct kunit_suite clk_gate_test_invert_suite = {
> +       .name = "clk-gate-invert-test",
> +       .init = clk_gate_test_invert_init,
> +       .exit = clk_gate_test_exit,
> +       .test_cases = clk_gate_test_invert_cases,
> +};
> +
> +static void clk_gate_test_hiword_enable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       u32 enable_val = BIT(9) | BIT(9 + 16);
> +
> +       KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
> +
> +       KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static void clk_gate_test_hiword_disable(struct kunit *test)
> +{
> +       struct clk_gate_test_context *ctx = test->priv;
> +       struct clk_hw *parent = ctx->parent;
> +       struct clk_hw *hw = ctx->hw;
> +       struct clk *clk = hw->clk;
> +       u32 enable_val = BIT(9) | BIT(9 + 16);
> +       u32 disable_val = BIT(9 + 16);
> +
> +       KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
> +       KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> +
> +       clk_disable_unprepare(clk);
> +       KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> +       KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> +}
> +
> +static struct kunit_case clk_gate_test_hiword_cases[] = {
> +       KUNIT_CASE(clk_gate_test_hiword_enable),
> +       KUNIT_CASE(clk_gate_test_hiword_disable),
> +       {}
> +};
> +
> +static int clk_gate_test_hiword_init(struct kunit *test)
> +{
> +       struct clk_hw *parent;
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
> +                                           2000000);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +       hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
> +                                           ctx->fake_mem, 9,
> +                                           CLK_GATE_HIWORD_MASK, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +
> +       ctx->hw = hw;
> +       ctx->parent = parent;
> +
> +       return 0;
> +}
> +
> +static struct kunit_suite clk_gate_test_hiword_suite = {
> +       .name = "clk-gate-hiword-test",
> +       .init = clk_gate_test_hiword_init,
> +       .exit = clk_gate_test_exit,
> +       .test_cases = clk_gate_test_hiword_cases,
> +};
> +
> +static void clk_gate_test_is_enabled(struct kunit *test)
> +{
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       ctx->fake_reg = BIT(7);
> +       hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
> +                                 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +       KUNIT_ASSERT_TRUE(test, clk_hw_is_enabled(hw));
> +
> +       clk_hw_unregister_gate(hw);
> +       kfree(ctx);

ditto


> +}
> +
> +static void clk_gate_test_is_disabled(struct kunit *test)
> +{
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       ctx->fake_reg = BIT(4);
> +       hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
> +                                 0, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +       KUNIT_ASSERT_FALSE(test, clk_hw_is_enabled(hw));
> +
> +       clk_hw_unregister_gate(hw);
> +       kfree(ctx);
> +}
> +
> +static void clk_gate_test_is_enabled_inverted(struct kunit *test)
> +{
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       ctx->fake_reg = BIT(31);
> +       hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 2,
> +                                 CLK_GATE_SET_TO_DISABLE, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +       KUNIT_ASSERT_TRUE(test, clk_hw_is_enabled(hw));
> +
> +       clk_hw_unregister_gate(hw);
> +       kfree(ctx);

ditto

> +}
> +
> +static void clk_gate_test_is_disabled_inverted(struct kunit *test)
> +{
> +       struct clk_hw *hw;
> +       struct clk_gate_test_context *ctx;
> +
> +       ctx = clk_gate_test_alloc_ctx(test);
> +       ctx->fake_reg = BIT(29);
> +       hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 29,
> +                                 CLK_GATE_SET_TO_DISABLE, NULL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +       KUNIT_ASSERT_FALSE(test, clk_hw_is_enabled(hw));
> +
> +       clk_hw_unregister_gate(hw);
> +       kfree(ctx);

ditto

> +}
> +
> +static struct kunit_case clk_gate_test_enabled_cases[] = {
> +       KUNIT_CASE(clk_gate_test_is_enabled),
> +       KUNIT_CASE(clk_gate_test_is_disabled),
> +       KUNIT_CASE(clk_gate_test_is_enabled_inverted),
> +       KUNIT_CASE(clk_gate_test_is_disabled_inverted),
> +       {}
> +};
> +
> +static struct kunit_suite clk_gate_test_enabled_suite = {
> +       .name = "clk-gate-is_enabled-test",
> +       .test_cases = clk_gate_test_enabled_cases,
> +};
> +
> +kunit_test_suites(
> +       &clk_gate_register_test_suite,
> +       &clk_gate_test_suite,
> +       &clk_gate_test_invert_suite,
> +       &clk_gate_test_hiword_suite,
> +       &clk_gate_test_enabled_suite
> +);
> +MODULE_LICENSE("GPL v2");
>
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>
