Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C904D7F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiCNKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiCNKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:09:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158071704C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647252519; x=1678788519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BcmmMpXQborg+/AoJTWaQW8xaUtZNy1RLYwKrihUj9c=;
  b=mfAWzQvALyomguhqcOHvRd4g8MO56Wbwo/Zhn2PmgAmv9mIV4uCChdAa
   0GmHF7mdlz91Q4BkHPAjHP/6mh4sp2fKXE7RL0k3U77MxYx/Yzpd+d8td
   /WcnSEN6NgG6zfuGwihxHeG6772kIqolaB7nI7/ndhL+SHM6maADKkXF/
   P4jssiz7M6y2+ydAgerD6AIQLxH2nrFbmq6IqWMjyn3KKkzspfJOFmd2O
   xTWCyQJvMvQZ4ZpXnVGfdB+ErcuendAo+tBpf90PlAKG3mlMmdjEpgK29
   FnLGtWkR1d/emcUi205TH+A5eo+gowA2gKwAqjdYN9Ca0ytAkVX4H9Ka+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="253545699"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="253545699"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="515363760"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 03:08:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nThcy-0009mo-8e; Mon, 14 Mar 2022 10:08:36 +0000
Date:   Mon, 14 Mar 2022 18:08:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcin Szycik <marcin.szycik@linux.intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [ammarfaizi2-block:kvalo/ath/pending 65/109]
 drivers/net/ethernet/intel/ice/ice_switch.c:5568 ice_find_dummy_packet()
 warn: inconsistent indenting
Message-ID: <202203141819.R8xopRXM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
head:   451837c0788abda8deb4df8850b510f414b7fc33
commit: 9a225f81f540f65225e4b820e303d40d9e747e78 [65/109] ice: Support GTP-U and GTP-C offload in switchdev
config: riscv-randconfig-m031-20220313 (https://download.01.org/0day-ci/archive/20220314/202203141819.R8xopRXM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/net/ethernet/intel/ice/ice_switch.c:5568 ice_find_dummy_packet() warn: inconsistent indenting

vim +5568 drivers/net/ethernet/intel/ice/ice_switch.c

  5496	
  5497	/**
  5498	 * ice_find_dummy_packet - find dummy packet
  5499	 *
  5500	 * @lkups: lookup elements or match criteria for the advanced recipe, one
  5501	 *	   structure per protocol header
  5502	 * @lkups_cnt: number of protocols
  5503	 * @tun_type: tunnel type
  5504	 * @pkt: dummy packet to fill according to filter match criteria
  5505	 * @pkt_len: packet length of dummy packet
  5506	 * @offsets: pointer to receive the pointer to the offsets for the packet
  5507	 */
  5508	static void
  5509	ice_find_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
  5510			      enum ice_sw_tunnel_type tun_type,
  5511			      const u8 **pkt, u16 *pkt_len,
  5512			      const struct ice_dummy_pkt_offsets **offsets)
  5513	{
  5514		bool inner_tcp = false, inner_udp = false, outer_ipv6 = false;
  5515		bool vlan = false, inner_ipv6 = false, gtp_no_pay = false;
  5516		u16 i;
  5517	
  5518		for (i = 0; i < lkups_cnt; i++) {
  5519			if (lkups[i].type == ICE_UDP_ILOS)
  5520				inner_udp = true;
  5521			else if (lkups[i].type == ICE_TCP_IL)
  5522				inner_tcp = true;
  5523			else if (lkups[i].type == ICE_IPV6_OFOS)
  5524				outer_ipv6 = true;
  5525			else if (lkups[i].type == ICE_VLAN_OFOS)
  5526				vlan = true;
  5527			else if (lkups[i].type == ICE_ETYPE_OL &&
  5528				 lkups[i].h_u.ethertype.ethtype_id ==
  5529					cpu_to_be16(ICE_IPV6_ETHER_ID) &&
  5530				 lkups[i].m_u.ethertype.ethtype_id ==
  5531					cpu_to_be16(0xFFFF))
  5532				outer_ipv6 = true;
  5533			else if (lkups[i].type == ICE_ETYPE_IL &&
  5534				 lkups[i].h_u.ethertype.ethtype_id ==
  5535					cpu_to_be16(ICE_IPV6_ETHER_ID) &&
  5536				 lkups[i].m_u.ethertype.ethtype_id ==
  5537					cpu_to_be16(0xFFFF))
  5538				inner_ipv6 = true;
  5539			else if (lkups[i].type == ICE_IPV6_IL)
  5540				inner_ipv6 = true;
  5541			else if (lkups[i].type == ICE_GTP_NO_PAY)
  5542				gtp_no_pay = true;
  5543		}
  5544	
  5545		if (tun_type == ICE_SW_TUN_GTPU) {
  5546			if (outer_ipv6) {
  5547				if (gtp_no_pay) {
  5548					*pkt = dummy_ipv6_gtp_packet;
  5549					*pkt_len = sizeof(dummy_ipv6_gtp_packet);
  5550					*offsets = dummy_ipv6_gtp_no_pay_packet_offsets;
  5551				} else if (inner_ipv6) {
  5552					if (inner_udp) {
  5553						*pkt = dummy_ipv6_gtpu_ipv6_udp_packet;
  5554						*pkt_len = sizeof(dummy_ipv6_gtpu_ipv6_udp_packet);
  5555						*offsets = dummy_ipv6_gtpu_ipv6_udp_packet_offsets;
  5556					} else {
  5557						*pkt = dummy_ipv6_gtpu_ipv6_tcp_packet;
  5558						*pkt_len = sizeof(dummy_ipv6_gtpu_ipv6_tcp_packet);
  5559						*offsets = dummy_ipv6_gtpu_ipv6_tcp_packet_offsets;
  5560					}
  5561				} else {
  5562					if (inner_udp) {
  5563						*pkt = dummy_ipv6_gtpu_ipv4_udp_packet;
  5564						*pkt_len = sizeof(dummy_ipv6_gtpu_ipv4_udp_packet);
  5565						*offsets = dummy_ipv6_gtpu_ipv4_udp_packet_offsets;
  5566					} else {
  5567						*pkt = dummy_ipv6_gtpu_ipv4_tcp_packet;
> 5568					*pkt_len = sizeof(dummy_ipv6_gtpu_ipv4_tcp_packet);
  5569						*offsets = dummy_ipv6_gtpu_ipv4_tcp_packet_offsets;
  5570					}
  5571				}
  5572			} else {
  5573				if (gtp_no_pay) {
  5574					*pkt = dummy_ipv4_gtpu_ipv4_packet;
  5575					*pkt_len = sizeof(dummy_ipv4_gtpu_ipv4_packet);
  5576					*offsets = dummy_ipv4_gtp_no_pay_packet_offsets;
  5577				} else if (inner_ipv6) {
  5578					if (inner_udp) {
  5579						*pkt = dummy_ipv4_gtpu_ipv6_udp_packet;
  5580						*pkt_len = sizeof(dummy_ipv4_gtpu_ipv6_udp_packet);
  5581						*offsets = dummy_ipv4_gtpu_ipv6_udp_packet_offsets;
  5582					} else {
  5583						*pkt = dummy_ipv4_gtpu_ipv6_tcp_packet;
  5584						*pkt_len = sizeof(dummy_ipv4_gtpu_ipv6_tcp_packet);
  5585						*offsets = dummy_ipv4_gtpu_ipv6_tcp_packet_offsets;
  5586					}
  5587				} else {
  5588					if (inner_udp) {
  5589						*pkt = dummy_ipv4_gtpu_ipv4_udp_packet;
  5590						*pkt_len = sizeof(dummy_ipv4_gtpu_ipv4_udp_packet);
  5591						*offsets = dummy_ipv4_gtpu_ipv4_udp_packet_offsets;
  5592					} else {
  5593						*pkt = dummy_ipv4_gtpu_ipv4_tcp_packet;
  5594						*pkt_len = sizeof(dummy_ipv4_gtpu_ipv4_tcp_packet);
  5595						*offsets = dummy_ipv4_gtpu_ipv4_tcp_packet_offsets;
  5596					}
  5597				}
  5598			}
  5599			return;
  5600		}
  5601	
  5602		if (tun_type == ICE_SW_TUN_GTPC) {
  5603			if (outer_ipv6) {
  5604				*pkt = dummy_ipv6_gtp_packet;
  5605				*pkt_len = sizeof(dummy_ipv6_gtp_packet);
  5606				*offsets = dummy_ipv6_gtp_no_pay_packet_offsets;
  5607			} else {
  5608				*pkt = dummy_ipv4_gtpu_ipv4_packet;
  5609				*pkt_len = sizeof(dummy_ipv4_gtpu_ipv4_packet);
  5610				*offsets = dummy_ipv4_gtp_no_pay_packet_offsets;
  5611			}
  5612			return;
  5613		}
  5614	
  5615		if (tun_type == ICE_SW_TUN_NVGRE) {
  5616			if (inner_tcp && inner_ipv6) {
  5617				*pkt = dummy_gre_ipv6_tcp_packet;
  5618				*pkt_len = sizeof(dummy_gre_ipv6_tcp_packet);
  5619				*offsets = dummy_gre_ipv6_tcp_packet_offsets;
  5620				return;
  5621			}
  5622			if (inner_tcp) {
  5623				*pkt = dummy_gre_tcp_packet;
  5624				*pkt_len = sizeof(dummy_gre_tcp_packet);
  5625				*offsets = dummy_gre_tcp_packet_offsets;
  5626				return;
  5627			}
  5628			if (inner_ipv6) {
  5629				*pkt = dummy_gre_ipv6_udp_packet;
  5630				*pkt_len = sizeof(dummy_gre_ipv6_udp_packet);
  5631				*offsets = dummy_gre_ipv6_udp_packet_offsets;
  5632				return;
  5633			}
  5634			*pkt = dummy_gre_udp_packet;
  5635			*pkt_len = sizeof(dummy_gre_udp_packet);
  5636			*offsets = dummy_gre_udp_packet_offsets;
  5637			return;
  5638		}
  5639	
  5640		if (tun_type == ICE_SW_TUN_VXLAN ||
  5641		    tun_type == ICE_SW_TUN_GENEVE) {
  5642			if (inner_tcp && inner_ipv6) {
  5643				*pkt = dummy_udp_tun_ipv6_tcp_packet;
  5644				*pkt_len = sizeof(dummy_udp_tun_ipv6_tcp_packet);
  5645				*offsets = dummy_udp_tun_ipv6_tcp_packet_offsets;
  5646				return;
  5647			}
  5648			if (inner_tcp) {
  5649				*pkt = dummy_udp_tun_tcp_packet;
  5650				*pkt_len = sizeof(dummy_udp_tun_tcp_packet);
  5651				*offsets = dummy_udp_tun_tcp_packet_offsets;
  5652				return;
  5653			}
  5654			if (inner_ipv6) {
  5655				*pkt = dummy_udp_tun_ipv6_udp_packet;
  5656				*pkt_len = sizeof(dummy_udp_tun_ipv6_udp_packet);
  5657				*offsets = dummy_udp_tun_ipv6_udp_packet_offsets;
  5658				return;
  5659			}
  5660			*pkt = dummy_udp_tun_udp_packet;
  5661			*pkt_len = sizeof(dummy_udp_tun_udp_packet);
  5662			*offsets = dummy_udp_tun_udp_packet_offsets;
  5663			return;
  5664		}
  5665	
  5666		if (inner_udp && !outer_ipv6) {
  5667			if (vlan) {
  5668				*pkt = dummy_vlan_udp_packet;
  5669				*pkt_len = sizeof(dummy_vlan_udp_packet);
  5670				*offsets = dummy_vlan_udp_packet_offsets;
  5671				return;
  5672			}
  5673			*pkt = dummy_udp_packet;
  5674			*pkt_len = sizeof(dummy_udp_packet);
  5675			*offsets = dummy_udp_packet_offsets;
  5676			return;
  5677		} else if (inner_udp && outer_ipv6) {
  5678			if (vlan) {
  5679				*pkt = dummy_vlan_udp_ipv6_packet;
  5680				*pkt_len = sizeof(dummy_vlan_udp_ipv6_packet);
  5681				*offsets = dummy_vlan_udp_ipv6_packet_offsets;
  5682				return;
  5683			}
  5684			*pkt = dummy_udp_ipv6_packet;
  5685			*pkt_len = sizeof(dummy_udp_ipv6_packet);
  5686			*offsets = dummy_udp_ipv6_packet_offsets;
  5687			return;
  5688		} else if ((inner_tcp && outer_ipv6) || outer_ipv6) {
  5689			if (vlan) {
  5690				*pkt = dummy_vlan_tcp_ipv6_packet;
  5691				*pkt_len = sizeof(dummy_vlan_tcp_ipv6_packet);
  5692				*offsets = dummy_vlan_tcp_ipv6_packet_offsets;
  5693				return;
  5694			}
  5695			*pkt = dummy_tcp_ipv6_packet;
  5696			*pkt_len = sizeof(dummy_tcp_ipv6_packet);
  5697			*offsets = dummy_tcp_ipv6_packet_offsets;
  5698			return;
  5699		}
  5700	
  5701		if (vlan) {
  5702			*pkt = dummy_vlan_tcp_packet;
  5703			*pkt_len = sizeof(dummy_vlan_tcp_packet);
  5704			*offsets = dummy_vlan_tcp_packet_offsets;
  5705		} else {
  5706			*pkt = dummy_tcp_packet;
  5707			*pkt_len = sizeof(dummy_tcp_packet);
  5708			*offsets = dummy_tcp_packet_offsets;
  5709		}
  5710	}
  5711	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
