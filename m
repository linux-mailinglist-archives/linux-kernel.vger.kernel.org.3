Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC554D1B56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347766AbiCHPJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiCHPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:09:10 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFD22BD5;
        Tue,  8 Mar 2022 07:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646752092; x=1678288092;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=QW0kIvNjJqRyf55LNg2dRlfXAJc8FJm5AfX4mUQJM6U=;
  b=EdYS42WU4Em5+79XNjdN2xfHbG4VQHB4RY+Ql9QVINR/JgasxjFSLn10
   nCXwSVaJjcXcwYMU028u0WwjInrLAsmEpSPF5FpuB+RNUeFfffQr68ZFa
   ER4ABY+Uc0TPcKwC6cnMdrJQ5tVj/RhOskqsbKqc4Grzl2qfGLglXmaQg
   1PCBSgh/slm2KHbrLG3bc2cFlR6GlmkbsNAoDVfry1xZU2sfUejcsNBqG
   Rd1mTJSKQw7CyXgO2OEYPprV3cogzDFIAAVQP15Qt4Mj1dyHrw+7DG2CI
   f1JHPnJ3my4b2488UnV34FHi1s04PiBFOXjpRSyEHIj7aYUWwuoON1Mkd
   A==;
X-IronPort-AV: E=Sophos;i="5.90,165,1643698800"; 
   d="scan'208";a="164943016"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 08:06:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 08:06:38 -0700
Received: from [10.12.73.60] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 08:06:36 -0700
Message-ID: <3826838a-5704-79ea-87dc-f4e61418d9cc@microchip.com>
Date:   Tue, 8 Mar 2022 16:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: at91: clk-master: remove dead code
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220203110202.18329-1-claudiu.beznea@microchip.com>
 <d6a53528-8913-3655-223b-fa5a5ef3ea5c@microchip.com>
Organization: microchip
In-Reply-To: <d6a53528-8913-3655-223b-fa5a5ef3ea5c@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2022 at 12:15, Nicolas Ferre wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 03/02/2022 at 12:02, Claudiu Beznea wrote:
>> Commit facb87ad7560 ("clk: at91: sama7g5: remove prescaler part of master
>> clock") removed the master clock's prescaler from clock tree of SAMA7G5
>> as it has been discovered that there is a hardware bug when trying to
>> change it at run-time (bug is described in description of
>> commit facb87ad7560 ("clk: at91: sama7g5: remove prescaler part of master
>> clock")). This was previously changed at CPUFreq driver request. Thus, with
>> commit facb87ad7560 ("clk: at91: sama7g5: remove prescaler part of master
>> clock") there is no need of code that handles run-time changes of master
>> clock's prescaler, thus remove this code.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> It looks good to me:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Now queued in clk-at91, ready for a PR to Stephen for 5.18.

Best regards,
   Nicolas

>> ---
>>    drivers/clk/at91/at91rm9200.c  |   3 +-
>>    drivers/clk/at91/at91sam9260.c |   3 +-
>>    drivers/clk/at91/at91sam9g45.c |   3 +-
>>    drivers/clk/at91/at91sam9n12.c |   3 +-
>>    drivers/clk/at91/at91sam9rl.c  |   3 +-
>>    drivers/clk/at91/at91sam9x5.c  |   3 +-
>>    drivers/clk/at91/clk-master.c  | 117 ++-------------------------------
>>    drivers/clk/at91/dt-compat.c   |   3 +-
>>    drivers/clk/at91/pmc.h         |   2 +-
>>    drivers/clk/at91/sam9x60.c     |   3 +-
>>    drivers/clk/at91/sama5d2.c     |   3 +-
>>    drivers/clk/at91/sama5d3.c     |   3 +-
>>    drivers/clk/at91/sama5d4.c     |   3 +-
>>    13 files changed, 18 insertions(+), 134 deletions(-)
>>
>> diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
>> index fff4fdda974f..b174f727a8ef 100644
>> --- a/drivers/clk/at91/at91rm9200.c
>> +++ b/drivers/clk/at91/at91rm9200.c
>> @@ -143,8 +143,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>>                                           parent_names,
>>                                           &at91rm9200_master_layout,
>>                                           &rm9200_mck_characteristics,
>> -                                        &rm9200_mck_lock, CLK_SET_RATE_GATE,
>> -                                        INT_MIN);
>> +                                        &rm9200_mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
>> diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
>> index 79802f864ee5..11550e50cd9f 100644
>> --- a/drivers/clk/at91/at91sam9260.c
>> +++ b/drivers/clk/at91/at91sam9260.c
>> @@ -419,8 +419,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>>                                           parent_names,
>>                                           &at91rm9200_master_layout,
>>                                           data->mck_characteristics,
>> -                                        &at91sam9260_mck_lock,
>> -                                        CLK_SET_RATE_GATE, INT_MIN);
>> +                                        &at91sam9260_mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
>> diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
>> index 7ed984f8058c..8c9344451f46 100644
>> --- a/drivers/clk/at91/at91sam9g45.c
>> +++ b/drivers/clk/at91/at91sam9g45.c
>> @@ -154,8 +154,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>>                                           parent_names,
>>                                           &at91rm9200_master_layout,
>>                                           &mck_characteristics,
>> -                                        &at91sam9g45_mck_lock,
>> -                                        CLK_SET_RATE_GATE, INT_MIN);
>> +                                        &at91sam9g45_mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
>> diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
>> index 63cc58944b00..0bb19400d199 100644
>> --- a/drivers/clk/at91/at91sam9n12.c
>> +++ b/drivers/clk/at91/at91sam9n12.c
>> @@ -181,8 +181,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>>                                           parent_names,
>>                                           &at91sam9x5_master_layout,
>>                                           &mck_characteristics,
>> -                                        &at91sam9n12_mck_lock,
>> -                                        CLK_SET_RATE_GATE, INT_MIN);
>> +                                        &at91sam9n12_mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
>> diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
>> index 4d4faf6c61d8..b992137bab02 100644
>> --- a/drivers/clk/at91/at91sam9rl.c
>> +++ b/drivers/clk/at91/at91sam9rl.c
>> @@ -123,8 +123,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
>>                                           parent_names,
>>                                           &at91rm9200_master_layout,
>>                                           &sam9rl_mck_characteristics,
>> -                                        &sam9rl_mck_lock, CLK_SET_RATE_GATE,
>> -                                        INT_MIN);
>> +                                        &sam9rl_mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
>> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
>> index bd8007b4f3e0..3857db2e144b 100644
>> --- a/drivers/clk/at91/at91sam9x5.c
>> +++ b/drivers/clk/at91/at91sam9x5.c
>> @@ -201,8 +201,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>>        hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
>>                                           parent_names,
>>                                           &at91sam9x5_master_layout,
>> -                                        &mck_characteristics, &mck_lock,
>> -                                        CLK_SET_RATE_GATE, INT_MIN);
>> +                                        &mck_characteristics, &mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
>> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
>> index b2d0a7f4f7f9..164e2959c7cf 100644
>> --- a/drivers/clk/at91/clk-master.c
>> +++ b/drivers/clk/at91/clk-master.c
>> @@ -374,85 +374,6 @@ static void clk_sama7g5_master_best_diff(struct clk_rate_request *req,
>>        }
>>    }
>>
>> -static int clk_master_pres_determine_rate(struct clk_hw *hw,
>> -                                       struct clk_rate_request *req)
>> -{
>> -     struct clk_master *master = to_clk_master(hw);
>> -     struct clk_rate_request req_parent = *req;
>> -     const struct clk_master_characteristics *characteristics =
>> -                                                     master->characteristics;
>> -     struct clk_hw *parent;
>> -     long best_rate = LONG_MIN, best_diff = LONG_MIN;
>> -     u32 pres;
>> -     int i;
>> -
>> -     if (master->chg_pid < 0)
>> -             return -EOPNOTSUPP;
>> -
>> -     parent = clk_hw_get_parent_by_index(hw, master->chg_pid);
>> -     if (!parent)
>> -             return -EOPNOTSUPP;
>> -
>> -     for (i = 0; i <= MASTER_PRES_MAX; i++) {
>> -             if (characteristics->have_div3_pres && i == MASTER_PRES_MAX)
>> -                     pres = 3;
>> -             else
>> -                     pres = 1 << i;
>> -
>> -             req_parent.rate = req->rate * pres;
>> -             if (__clk_determine_rate(parent, &req_parent))
>> -                     continue;
>> -
>> -             clk_sama7g5_master_best_diff(req, parent, req_parent.rate,
>> -                                          &best_diff, &best_rate, pres);
>> -             if (!best_diff)
>> -                     break;
>> -     }
>> -
>> -     return 0;
>> -}
>> -
>> -static int clk_master_pres_set_rate(struct clk_hw *hw, unsigned long rate,
>> -                                 unsigned long parent_rate)
>> -{
>> -     struct clk_master *master = to_clk_master(hw);
>> -     unsigned long flags;
>> -     unsigned int pres, mckr, tmp;
>> -     int ret;
>> -
>> -     pres = DIV_ROUND_CLOSEST(parent_rate, rate);
>> -     if (pres > MASTER_PRES_MAX)
>> -             return -EINVAL;
>> -
>> -     else if (pres == 3)
>> -             pres = MASTER_PRES_MAX;
>> -     else if (pres)
>> -             pres = ffs(pres) - 1;
>> -
>> -     spin_lock_irqsave(master->lock, flags);
>> -     ret = regmap_read(master->regmap, master->layout->offset, &mckr);
>> -     if (ret)
>> -             goto unlock;
>> -
>> -     mckr &= master->layout->mask;
>> -     tmp = (mckr >> master->layout->pres_shift) & MASTER_PRES_MASK;
>> -     if (pres == tmp)
>> -             goto unlock;
>> -
>> -     mckr &= ~(MASTER_PRES_MASK << master->layout->pres_shift);
>> -     mckr |= (pres << master->layout->pres_shift);
>> -     ret = regmap_write(master->regmap, master->layout->offset, mckr);
>> -     if (ret)
>> -             goto unlock;
>> -
>> -     while (!clk_master_ready(master))
>> -             cpu_relax();
>> -unlock:
>> -     spin_unlock_irqrestore(master->lock, flags);
>> -
>> -     return ret;
>> -}
>> -
>>    static unsigned long clk_master_pres_recalc_rate(struct clk_hw *hw,
>>                                                 unsigned long parent_rate)
>>    {
>> @@ -539,13 +460,6 @@ static void clk_master_pres_restore_context(struct clk_hw *hw)
>>                pr_warn("MCKR PRES was not configured properly by firmware!\n");
>>    }
>>
>> -static void clk_master_pres_restore_context_chg(struct clk_hw *hw)
>> -{
>> -     struct clk_master *master = to_clk_master(hw);
>> -
>> -     clk_master_pres_set_rate(hw, master->pms.rate, master->pms.parent_rate);
>> -}
>> -
>>    static const struct clk_ops master_pres_ops = {
>>        .prepare = clk_master_prepare,
>>        .is_prepared = clk_master_is_prepared,
>> @@ -555,25 +469,13 @@ static const struct clk_ops master_pres_ops = {
>>        .restore_context = clk_master_pres_restore_context,
>>    };
>>
>> -static const struct clk_ops master_pres_ops_chg = {
>> -     .prepare = clk_master_prepare,
>> -     .is_prepared = clk_master_is_prepared,
>> -     .determine_rate = clk_master_pres_determine_rate,
>> -     .recalc_rate = clk_master_pres_recalc_rate,
>> -     .get_parent = clk_master_pres_get_parent,
>> -     .set_rate = clk_master_pres_set_rate,
>> -     .save_context = clk_master_pres_save_context,
>> -     .restore_context = clk_master_pres_restore_context_chg,
>> -};
>> -
>>    static struct clk_hw * __init
>>    at91_clk_register_master_internal(struct regmap *regmap,
>>                const char *name, int num_parents,
>>                const char **parent_names,
>>                const struct clk_master_layout *layout,
>>                const struct clk_master_characteristics *characteristics,
>> -             const struct clk_ops *ops, spinlock_t *lock, u32 flags,
>> -             int chg_pid)
>> +             const struct clk_ops *ops, spinlock_t *lock, u32 flags)
>>    {
>>        struct clk_master *master;
>>        struct clk_init_data init;
>> @@ -599,7 +501,6 @@ at91_clk_register_master_internal(struct regmap *regmap,
>>        master->layout = layout;
>>        master->characteristics = characteristics;
>>        master->regmap = regmap;
>> -     master->chg_pid = chg_pid;
>>        master->lock = lock;
>>
>>        if (ops == &master_div_ops_chg) {
>> @@ -628,19 +529,13 @@ at91_clk_register_master_pres(struct regmap *regmap,
>>                const char **parent_names,
>>                const struct clk_master_layout *layout,
>>                const struct clk_master_characteristics *characteristics,
>> -             spinlock_t *lock, u32 flags, int chg_pid)
>> +             spinlock_t *lock)
>>    {
>> -     const struct clk_ops *ops;
>> -
>> -     if (flags & CLK_SET_RATE_GATE)
>> -             ops = &master_pres_ops;
>> -     else
>> -             ops = &master_pres_ops_chg;
>> -
>>        return at91_clk_register_master_internal(regmap, name, num_parents,
>>                                                 parent_names, layout,
>> -                                              characteristics, ops,
>> -                                              lock, flags, chg_pid);
>> +                                              characteristics,
>> +                                              &master_pres_ops,
>> +                                              lock, CLK_SET_RATE_GATE);
>>    }
>>
>>    struct clk_hw * __init
>> @@ -661,7 +556,7 @@ at91_clk_register_master_div(struct regmap *regmap,
>>        hw = at91_clk_register_master_internal(regmap, name, 1,
>>                                               &parent_name, layout,
>>                                               characteristics, ops,
>> -                                            lock, flags, -EINVAL);
>> +                                            lock, flags);
>>
>>        if (!IS_ERR(hw) && safe_div) {
>>                master_div = to_clk_master(hw);
>> diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
>> index ca2dbb65b9df..8ca8bcacf66d 100644
>> --- a/drivers/clk/at91/dt-compat.c
>> +++ b/drivers/clk/at91/dt-compat.c
>> @@ -392,8 +392,7 @@ of_at91_clk_master_setup(struct device_node *np,
>>
>>        hw = at91_clk_register_master_pres(regmap, "masterck_pres", num_parents,
>>                                           parent_names, layout,
>> -                                        characteristics, &mck_lock,
>> -                                        CLK_SET_RATE_GATE, INT_MIN);
>> +                                        characteristics, &mck_lock);
>>        if (IS_ERR(hw))
>>                goto out_free_characteristics;
>>
>> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
>> index 3a1bf6194c28..efe4975bddc3 100644
>> --- a/drivers/clk/at91/pmc.h
>> +++ b/drivers/clk/at91/pmc.h
>> @@ -175,7 +175,7 @@ at91_clk_register_master_pres(struct regmap *regmap, const char *name,
>>                              int num_parents, const char **parent_names,
>>                              const struct clk_master_layout *layout,
>>                              const struct clk_master_characteristics *characteristics,
>> -                           spinlock_t *lock, u32 flags, int chg_pid);
>> +                           spinlock_t *lock);
>>
>>    struct clk_hw * __init
>>    at91_clk_register_master_div(struct regmap *regmap, const char *name,
>> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
>> index 5c264185f261..9ea4ce501bad 100644
>> --- a/drivers/clk/at91/sam9x60.c
>> +++ b/drivers/clk/at91/sam9x60.c
>> @@ -271,8 +271,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>>        parent_names[2] = "pllack_divck";
>>        hw = at91_clk_register_master_pres(regmap, "masterck_pres", 3,
>>                                           parent_names, &sam9x60_master_layout,
>> -                                        &mck_characteristics, &mck_lock,
>> -                                        CLK_SET_RATE_GATE, INT_MIN);
>> +                                        &mck_characteristics, &mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
>> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
>> index f479e39e3bb2..cfd0f5e23b99 100644
>> --- a/drivers/clk/at91/sama5d2.c
>> +++ b/drivers/clk/at91/sama5d2.c
>> @@ -242,8 +242,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>>        hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
>>                                           parent_names,
>>                                           &at91sam9x5_master_layout,
>> -                                        &mck_characteristics, &mck_lock,
>> -                                        CLK_SET_RATE_GATE, INT_MIN);
>> +                                        &mck_characteristics, &mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
>> diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
>> index 339d0f382ff0..7e93c6edf305 100644
>> --- a/drivers/clk/at91/sama5d3.c
>> +++ b/drivers/clk/at91/sama5d3.c
>> @@ -175,8 +175,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>>        hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
>>                                           parent_names,
>>                                           &at91sam9x5_master_layout,
>> -                                        &mck_characteristics, &mck_lock,
>> -                                        CLK_SET_RATE_GATE, INT_MIN);
>> +                                        &mck_characteristics, &mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
>> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
>> index 4af75b1e39e9..1a14a9bce308 100644
>> --- a/drivers/clk/at91/sama5d4.c
>> +++ b/drivers/clk/at91/sama5d4.c
>> @@ -190,8 +190,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>>        hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
>>                                           parent_names,
>>                                           &at91sam9x5_master_layout,
>> -                                        &mck_characteristics, &mck_lock,
>> -                                        CLK_SET_RATE_GATE, INT_MIN);
>> +                                        &mck_characteristics, &mck_lock);
>>        if (IS_ERR(hw))
>>                goto err_free;
>>
> 
> 
> --
> Nicolas Ferre
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Nicolas Ferre
