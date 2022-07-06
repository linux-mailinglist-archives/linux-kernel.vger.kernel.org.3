Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6A5690E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiGFRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiGFRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:42:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD2EB87C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657129338; x=1688665338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=id27GaKfdc/LaUJ5IInwpXGIPa9O9rQUx2Zc+9nNpks=;
  b=FFJM402O6I0a+vc12A03/rAJYzdKkrRYMD/F8e3qIJdFZi2tNRemA97O
   tTGIQ1Iicpot+mBwXuIiVr/EUe6ip9k4cU5YU6CXNhHYItBMls9qWw/kf
   O94lZCSQdpm0kDWIW2KOWd2TQ/9bN+mAgfH0mfLe3yZJxwT2YjeGpPcmP
   Dck4mGHSsm+xAvveXdenKDIsB1xT0QwbT6niXmw7jGDp08aKPwk9uNKLX
   FHtrxXtHrddV5e+dndD6vHZX/FRFf36mknPwIi37sLCwbMv3Pk/LBqz7N
   sAMRUtwUFofRMFMWEq1g4Nz46BEkSqnRVdafYkdJljSDe+PWujprxRmJw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="282575720"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="282575720"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="568167863"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 10:42:16 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o992V-000KrH-Lb;
        Wed, 06 Jul 2022 17:42:15 +0000
Date:   Thu, 7 Jul 2022 01:41:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:xdp_hints 27/52] net/bpf/core.c:801:37: sparse: sparse:
 incorrect type in argument 2 (different base types)
Message-ID: <202207070123.NXIiCz5W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux xdp_hints
head:   e9f4215398901c2e3f477da53abc668ce7b7e320
commit: 7f869a161c7f4f95855a6bbcb1f5ea86cd926e50 [27/52] net, xdp: add &sk_buff <-> &xdp_meta_generic converters
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220707/202207070123.NXIiCz5W-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/alobakin/linux/commit/7f869a161c7f4f95855a6bbcb1f5ea86cd926e50
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin xdp_hints
        git checkout 7f869a161c7f4f95855a6bbcb1f5ea86cd926e50
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/bpf/core.c:801:37: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __wsum const [usertype] csum @@
   net/bpf/core.c:801:37: sparse:     expected unsigned int [usertype] val
   net/bpf/core.c:801:37: sparse:     got restricted __wsum const [usertype] csum
>> net/bpf/core.c:844:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/bpf/core.c:844:19: sparse:     expected restricted __wsum [usertype] csum
   net/bpf/core.c:844:19: sparse:     got unsigned int

vim +801 net/bpf/core.c

   781	
   782	/**
   783	 * ___xdp_build_meta_generic_from_skb - fill a generic metadata from an skb
   784	 * @rx_md: a pointer to the XDP generic metadata to be filled
   785	 * @skb: a pointer to the skb to take the info from
   786	 *
   787	 * Fills a given generic metadata struct with the info set previously in
   788	 * an skb. @md can point to anywhere and the function doesn't use the
   789	 * skb_metadata_{end,len}().
   790	 */
   791	void ___xdp_build_meta_generic_from_skb(struct xdp_meta_generic_rx *rx_md,
   792						const struct sk_buff *skb)
   793	{
   794		struct xdp_meta_generic *md = to_gen_md(rx_md);
   795		ktime_t ts;
   796	
   797		xdp_meta_init(rx_md, xdp_meta_generic_id);
   798	
   799		xdp_meta_rx_csum_level_set(md, skb->csum_level);
   800		xdp_meta_rx_csum_status_set(md, skb->ip_summed);
 > 801		xdp_meta_rx_csum_set(md, skb->csum);
   802	
   803		xdp_meta_rx_hash_set(md, skb_get_hash_raw(skb));
   804		xdp_meta_rx_hash_type_set(md, xdp_meta_rx_hash_type_from_skb(skb));
   805	
   806		if (likely(skb_rx_queue_recorded(skb))) {
   807			xdp_meta_rx_qid_present_set(md, 1);
   808			xdp_meta_rx_qid_set(md, skb_get_rx_queue(skb));
   809		}
   810	
   811		if (skb_vlan_tag_present(skb)) {
   812			xdp_meta_rx_vlan_type_set(md, xdp_meta_rx_vlan_from_prot(skb));
   813			xdp_meta_rx_vid_set(md, skb_vlan_tag_get(skb));
   814		}
   815	
   816		ts = skb_hwtstamps(skb)->hwtstamp;
   817		if (ts) {
   818			xdp_meta_rx_tstamp_present_set(md, 1);
   819			xdp_meta_rx_tstamp_set(md, ktime_to_ns(ts));
   820		}
   821	}
   822	EXPORT_SYMBOL_GPL(___xdp_build_meta_generic_from_skb);
   823	
   824	/**
   825	 * ___xdp_populate_skb_meta_generic - fill the skb fields from a generic meta
   826	 * @skb: a pointer to the skb to be filled
   827	 * @rx_md: a pointer to the generic metadata to take the values from
   828	 *
   829	 * Populates the &sk_buff fields from a given XDP generic metadata. A meta
   830	 * can be from anywhere, the function doesn't use skb_metadata_{end,len}().
   831	 * Checks whether the metadata is generic-compatible before accessing other
   832	 * fields.
   833	 */
   834	void ___xdp_populate_skb_meta_generic(struct sk_buff *skb,
   835					      const struct xdp_meta_generic_rx *rx_md)
   836	{
   837		const struct xdp_meta_generic *md = to_gen_md(rx_md);
   838	
   839		if (unlikely(!xdp_meta_has_generic(md + 1)))
   840			return;
   841	
   842		skb->csum_level = xdp_meta_rx_csum_level_get(md);
   843		skb->ip_summed = xdp_meta_rx_csum_status_get(md);
 > 844		skb->csum = xdp_meta_rx_csum_get(md);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
