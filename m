Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01AC581CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbiG0BPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiG0BPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:15:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF06F28E30
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658884534; x=1690420534;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iEdHwVcvibDT33dBZD6VnWHZTVQ74uuyWgcoCxTOJiM=;
  b=XiTSw+48JgqS24bh8bpBzCP84gnoIBJ1V+rtPBJha8PREWlJOiaapsCj
   2i5kGEl6rjR2cwITHzfoKsPqPdQI40qsyM70JuMVS4Axh5cA/3ji3B50Z
   /dmvn6jekjnVVK+TCQ4JhitMIiuY5Xm6dXMgCjz8oEu0bcHelDhX+CFrx
   iRJOaPFKOa5pXQnbr1NTdsptw0WBrp+NfGsoDH522euaUgKjT30PlSWhS
   YZ5TsLuyH/OWn2vVh7oQ1sGqgiAt1X8lddtUpOtcA5rfrVx9Zc/diGjSA
   cbD5hCvoK+PfVbZ3WuwxDH0X/5U4+4RYo7ossJRvXd9mw/PhjKHSW0H5m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289307543"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="289307543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575754665"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2022 18:15:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGVe8-00088k-1f;
        Wed, 27 Jul 2022 01:15:32 +0000
Date:   Wed, 27 Jul 2022 09:14:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:sound2-2022-07-21-v2 47/47] sound/soc/soc-dapm.c:1560
 dapm_seq_check_event() warn: inconsistent indenting
Message-ID: <202207270955.hN8qEXNi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound2-2022-07-21-v2
head:   9a531dde39dc408ec83ad303735743e9401be154
commit: 9a531dde39dc408ec83ad303735743e9401be154 [47/47] hoge
config: openrisc-randconfig-m041-20220721 (https://download.01.org/0day-ci/archive/20220727/202207270955.hN8qEXNi-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
sound/soc/soc-dapm.c:1560 dapm_seq_check_event() warn: inconsistent indenting
sound/soc/soc-dapm.c:1588 dapm_seq_run_coalesced() warn: inconsistent indenting
sound/soc/soc-dapm.c:1651 dapm_seq_run() warn: inconsistent indenting
sound/soc/soc-dapm.c:1958 dapm_power_widgets() warn: inconsistent indenting
sound/soc/soc-dapm.c:2627 snd_soc_dapm_sync_unlocked() warn: inconsistent indenting
sound/soc/soc-dapm.c:3285 snd_soc_dapm_new_widgets() warn: inconsistent indenting
sound/soc/soc-dapm.c:3828 snd_soc_dai_link_event_pre_pmu() warn: inconsistent indenting
sound/soc/soc-dapm.c:3926 snd_soc_dai_link_event() warn: inconsistent indenting
sound/soc/soc-dapm.c:4461 soc_dapm_stream_event() warn: inconsistent indenting

vim +1560 sound/soc/soc-dapm.c

  1523	
  1524	static void dapm_seq_check_event(struct snd_soc_card *card,
  1525					 struct snd_soc_dapm_widget *w, int event)
  1526	{
  1527		const char *ev_name;
  1528		int power;
  1529	
  1530		switch (event) {
  1531		case SND_SOC_DAPM_PRE_PMU:
  1532			ev_name = "PRE_PMU";
  1533			power = 1;
  1534			break;
  1535		case SND_SOC_DAPM_POST_PMU:
  1536			ev_name = "POST_PMU";
  1537			power = 1;
  1538			break;
  1539		case SND_SOC_DAPM_PRE_PMD:
  1540			ev_name = "PRE_PMD";
  1541			power = 0;
  1542			break;
  1543		case SND_SOC_DAPM_POST_PMD:
  1544			ev_name = "POST_PMD";
  1545			power = 0;
  1546			break;
  1547		case SND_SOC_DAPM_WILL_PMU:
  1548			ev_name = "WILL_PMU";
  1549			power = 1;
  1550			break;
  1551		case SND_SOC_DAPM_WILL_PMD:
  1552			ev_name = "WILL_PMD";
  1553			power = 0;
  1554			break;
  1555		default:
  1556			WARN(1, "Unknown event %d\n", event);
  1557			return;
  1558		}
  1559	
> 1560	printk("-- %s : %s\n", __func__, ev_name);
  1561		if (w->new_power != power)
  1562			return;
  1563	
  1564		if (w->event && (w->event_flags & event)) {
  1565			int ret;
  1566	
  1567			pop_dbg(w->dapm->dev, card->pop_time, "pop test : %s %s\n",
  1568				w->name, ev_name);
  1569			soc_dapm_async_complete(w->dapm);
  1570			trace_snd_soc_dapm_widget_event_start(w, event);
  1571			ret = w->event(w, NULL, event);
  1572			trace_snd_soc_dapm_widget_event_done(w, event);
  1573			if (ret < 0)
  1574				dev_err(w->dapm->dev, "ASoC: %s: %s event failed: %d\n",
  1575				       ev_name, w->name, ret);
  1576		}
  1577	}
  1578	
  1579	/* Apply the coalesced changes from a DAPM sequence */
  1580	static void dapm_seq_run_coalesced(struct snd_soc_card *card,
  1581					   struct list_head *pending)
  1582	{
  1583		struct snd_soc_dapm_context *dapm;
  1584		struct snd_soc_dapm_widget *w;
  1585		int reg;
  1586		unsigned int value = 0;
  1587		unsigned int mask = 0;
> 1588	printk("-- %s : %d\n", __func__, __LINE__);
  1589	
  1590		w = list_first_entry(pending, struct snd_soc_dapm_widget, power_list);
  1591		reg = w->reg;
  1592		dapm = w->dapm;
  1593	
  1594		list_for_each_entry(w, pending, power_list) {
  1595			WARN_ON(reg != w->reg || dapm != w->dapm);
  1596			w->power = w->new_power;
  1597	
  1598			mask |= w->mask << w->shift;
  1599			if (w->power)
  1600				value |= w->on_val << w->shift;
  1601			else
  1602				value |= w->off_val << w->shift;
  1603	
  1604			pop_dbg(dapm->dev, card->pop_time,
  1605				"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
  1606				w->name, reg, value, mask);
  1607	
  1608			/* Check for events */
  1609			dapm_seq_check_event(card, w, SND_SOC_DAPM_PRE_PMU);
  1610			dapm_seq_check_event(card, w, SND_SOC_DAPM_PRE_PMD);
  1611		}
  1612	
  1613		if (reg >= 0) {
  1614			/* Any widget will do, they should all be updating the
  1615			 * same register.
  1616			 */
  1617	
  1618			pop_dbg(dapm->dev, card->pop_time,
  1619				"pop test : Applying 0x%x/0x%x to %x in %dms\n",
  1620				value, mask, reg, card->pop_time);
  1621			pop_wait(card->pop_time);
  1622			soc_dapm_update_bits(dapm, reg, mask, value);
  1623		}
  1624	
  1625		list_for_each_entry(w, pending, power_list) {
  1626			dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMU);
  1627			dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMD);
  1628		}
  1629	}
  1630	
  1631	/* Apply a DAPM power sequence.
  1632	 *
  1633	 * We walk over a pre-sorted list of widgets to apply power to.  In
  1634	 * order to minimise the number of writes to the device required
  1635	 * multiple widgets will be updated in a single write where possible.
  1636	 * Currently anything that requires more than a single write is not
  1637	 * handled.
  1638	 */
  1639	static void dapm_seq_run(struct snd_soc_card *card,
  1640		struct list_head *list, int event, bool power_up)
  1641	{
  1642		struct snd_soc_dapm_widget *w, *n;
  1643		struct snd_soc_dapm_context *d;
  1644		LIST_HEAD(pending);
  1645		int cur_sort = -1;
  1646		int cur_subseq = -1;
  1647		int cur_reg = SND_SOC_NOPM;
  1648		struct snd_soc_dapm_context *cur_dapm = NULL;
  1649		int i;
  1650		int *sort;
> 1651	printk("-- %s : %d\n", __func__, __LINE__);
  1652		if (power_up)
  1653			sort = dapm_up_seq;
  1654		else
  1655			sort = dapm_down_seq;
  1656	
  1657		list_for_each_entry_safe(w, n, list, power_list) {
  1658			int ret = 0;
  1659	
  1660			/* Do we need to apply any queued changes? */
  1661			if (sort[w->id] != cur_sort || w->reg != cur_reg ||
  1662			    w->dapm != cur_dapm || w->subseq != cur_subseq) {
  1663				if (!list_empty(&pending))
  1664					dapm_seq_run_coalesced(card, &pending);
  1665	
  1666				if (cur_dapm && cur_dapm->component) {
  1667					for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
  1668						if (sort[i] == cur_sort)
  1669							snd_soc_component_seq_notifier(
  1670								cur_dapm->component,
  1671								i, cur_subseq);
  1672				}
  1673	
  1674				if (cur_dapm && w->dapm != cur_dapm)
  1675					soc_dapm_async_complete(cur_dapm);
  1676	
  1677				INIT_LIST_HEAD(&pending);
  1678				cur_sort = -1;
  1679				cur_subseq = INT_MIN;
  1680				cur_reg = SND_SOC_NOPM;
  1681				cur_dapm = NULL;
  1682			}
  1683	
  1684			switch (w->id) {
  1685			case snd_soc_dapm_pre:
  1686				if (!w->event)
  1687					continue;
  1688	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
