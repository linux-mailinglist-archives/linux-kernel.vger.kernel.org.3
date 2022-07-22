Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A681757E3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiGVPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiGVPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:44:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1502735;
        Fri, 22 Jul 2022 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658504695; x=1690040695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qG2pNjvUpLBoBbPnjxVwoN8K5rzv5eBVte0Uf15BYbc=;
  b=VkTHZAO+lOwJuuMyHGkAd3UdWSLuaQu6ewKymYCKDZKuFcv8OCV1Aqab
   KUXzPycXcB+1NYFjTtLuXfsL7ilFxdJst81O17kuyj/JCkQoqdBfoaFXR
   zcllbEh3k8+Td+jPAhnfQfy9vJCO3nP8tl/5vu74+UuOK4R2JcaJ0YF4Q
   kAkqK8HzD10UcRjKSfP08qj3CdRq/23KTaLRARbNLCVsL/1sSMEcc441U
   oPjIPKnvDmsJQ9COG8lgAqu76Nq7uomBUFde0I0jJlb5J4fZ19ON8ZBqL
   7kCDZiSPaNnWTzjKomN0VjEHV/wSigVlJ8i0Eq9yVuOMTbTp0W8unEFmp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="287340974"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="287340974"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 08:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="631602269"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2022 08:44:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEupf-0001Ya-1g;
        Fri, 22 Jul 2022 15:44:51 +0000
Date:   Fri, 22 Jul 2022 23:44:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] remoteproc: Add AVM WASP driver
Message-ID: <202207222313.GAofKYST-lkp@intel.com>
References: <20220721193455.2717-4-kestrelseventyfour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721193455.2717-4-kestrelseventyfour@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on robh/for-next linus/master v5.19-rc7 next-20220721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Kestrel/Add-support-for-WASP-SoC-on-AVM-router-boards/20220722-033724
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220722/202207222313.GAofKYST-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 72686d68c137551cce816416190a18d45b4d4e2a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b737a00511b74767e3eb13b2ddfba8e6dfe8e5c2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Kestrel/Add-support-for-WASP-SoC-on-AVM-router-boards/20220722-033724
        git checkout b737a00511b74767e3eb13b2ddfba8e6dfe8e5c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/avm_wasp.c:582:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!avmwasp->linux_blob) {
               ^~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/avm_wasp.c:776:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/remoteproc/avm_wasp.c:582:2: note: remove the 'if' if its condition is always false
           if (!avmwasp->linux_blob) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/avm_wasp.c:566:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +582 drivers/remoteproc/avm_wasp.c

   545	
   546	/**
   547	 * avm_wasp_load_initramfs_image() - load initramfs image to WASP
   548	 * @avmwasp: pointer to drivers private avm_wasp_rproc structure
   549	 *
   550	 * Uses the lan port specified from DT to load the initramfs to
   551	 * WASP after the network boot firmware was successfully started.
   552	 * Communication is done by using raw sockets.
   553	 * There are several commands and status values which are checked.
   554	 * First a discovery packet is received and then each data packet
   555	 * is acknowledged by the WASP network boot firmware.
   556	 * First packet needs to prepend the load address and last packet
   557	 * needs to append the execution address.
   558	 *
   559	 * Return: 0 on Success, -EFAULT if errors with the WASP send protocol
   560	 * have occurred, -EAGAIN if the wasp network interface is down or the
   561	 * error returned from the failed operating system function or service
   562	 */
   563	static int avm_wasp_load_initramfs_image(struct avm_wasp_rproc *avmwasp)
   564	{
   565		bool done = false;
   566		int ret;
   567		u32 num_chunks, chunk_counter;
   568		short interface_flags;
   569		const u8 *firmware, *firmware_end;
   570		struct device *dev = &avmwasp->pdev->dev;
   571		struct kvec socket_kvec;
   572		struct msghdr socket_msghdr;
   573		struct net_device *send_netdev;
   574		struct sockaddr send_sock_addr;
   575		struct sockaddr_ll send_socket_address;
   576		struct socket *wasp_socket;
   577		struct wasp_packet *packet = (struct wasp_packet *)
   578				(avmwasp->buffer);
   579		struct __kernel_old_timeval timeout;
   580		time64_t start_time, current_time;
   581	
 > 582		if (!avmwasp->linux_blob) {
   583			dev_err(dev, "error accessing initramfs image\n");
   584			goto err;
   585		}
   586	
   587		firmware = avmwasp->linux_blob->data;
   588		firmware_end = firmware + avmwasp->linux_blob->size;
   589	
   590		ret = sock_create_kern(&init_net, PF_PACKET, SOCK_RAW,
   591				       htons(ETH_TYPE_ATH_ECPS_FRAME),
   592				       &wasp_socket);
   593		if (ret < 0) {
   594			dev_err(dev, "error opening recv socket: %d\n", ret);
   595			goto err;
   596		}
   597	
   598		timeout.tv_sec = 10;
   599		timeout.tv_usec = 0;
   600		ret = sock_setsockopt(wasp_socket, SOL_SOCKET, SO_RCVTIMEO_OLD,
   601				      KERNEL_SOCKPTR(&timeout), sizeof(timeout));
   602		if (ret < 0) {
   603			dev_err(dev, "error SO_RCVTIMEO recv socket: %d\n", ret);
   604			goto err_socket;
   605		}
   606	
   607		ret = sock_setsockopt(wasp_socket, SOL_SOCKET, SO_SNDTIMEO_OLD,
   608				      KERNEL_SOCKPTR(&timeout), sizeof(timeout));
   609		if (ret < 0) {
   610			dev_err(dev, "error SO_SNDTIMEO send socket: %d\n", ret);
   611			goto err_socket;
   612		}
   613	
   614		rcu_read_lock();
   615		send_netdev = dev_get_by_name_rcu(sock_net(wasp_socket->sk),
   616						  avmwasp->loader_port);
   617		if (send_netdev)
   618			interface_flags = (short)dev_get_flags(send_netdev);
   619		rcu_read_unlock();
   620	
   621		if (IS_ERR_OR_NULL(send_netdev)) {
   622			dev_err(dev, "error accessing net device\n");
   623			ret = -ENODEV;
   624			goto err_socket;
   625		}
   626	
   627		if (!(interface_flags & IFF_UP && interface_flags & IFF_RUNNING)) {
   628			dev_err(dev, "error wasp interface %s is down\n",
   629				avmwasp->loader_port);
   630			ret = -EAGAIN;
   631			goto err_socket;
   632		}
   633	
   634		avmwasp->ifindex = send_netdev->ifindex;
   635		ret = dev_get_mac_address(&send_sock_addr, &init_net,
   636					  avmwasp->loader_port);
   637		if (ret < 0) {
   638			dev_err(dev, "error getting mac address: %d\n", ret);
   639			goto err_socket;
   640		}
   641	
   642		send_socket_address.sll_halen = ETH_ALEN;
   643		send_socket_address.sll_ifindex = avmwasp->ifindex;
   644		memset(&socket_msghdr, 0, sizeof(socket_msghdr));
   645		socket_msghdr.msg_name = (struct sockaddr *)&send_socket_address;
   646		socket_msghdr.msg_namelen = sizeof(struct sockaddr_ll);
   647	
   648		start_time = ktime_get_seconds();
   649	
   650		while (!done) {
   651			current_time = ktime_get_seconds();
   652			if ((current_time - start_time) > ETH_SEND_LOOP_TIMEOUT_SECS) {
   653				dev_err(dev,
   654					"waiting for packet from WASP timed out\n");
   655				ret = -ETIMEDOUT;
   656				goto err_socket;
   657			}
   658	
   659			socket_kvec.iov_base = avmwasp->buffer;
   660			socket_kvec.iov_len = ETH_BUF_SIZE;
   661			ret = kernel_recvmsg(wasp_socket,
   662					     &socket_msghdr, &socket_kvec, 1,
   663					     ETH_BUF_SIZE, 0);
   664	
   665			if (ret < 0) {
   666				dev_err(dev,
   667					"error receiving any packet or timeout: %d\n",
   668					ret);
   669				goto err_socket;
   670			}
   671	
   672			if (ret < (sizeof(struct ethhdr) + sizeof(packet->hdr))) {
   673				dev_err(dev,
   674					"packet too small, discard and continue\n");
   675				continue;
   676			}
   677	
   678			if (packet->eh.h_proto != ETH_TYPE_ATH_ECPS_FRAME)
   679				continue;
   680	
   681			memcpy(wasp_mac, packet->eh.h_source, sizeof(wasp_mac));
   682	
   683			if (packet->hdr.packet_start == ETH_WASP_PACKET_ID) {
   684				switch (packet->hdr.response) {
   685				case RESP_DISCOVER:
   686					chunk_counter = 1;
   687					num_chunks = DIV_ROUND_UP(avmwasp->linux_blob->size,
   688								  ETH_DATA_SIZE);
   689					fallthrough;
   690				case RESP_OK:
   691					memcpy(packet->eh.h_dest, wasp_mac, sizeof(packet->eh.h_dest));
   692					packet->eh.h_proto = ETH_TYPE_ATH_ECPS_FRAME;
   693					memcpy(packet->eh.h_source, send_sock_addr.sa_data,
   694					       sizeof(packet->eh.h_source));
   695	
   696					if (firmware < firmware_end) {
   697						size_t bytestosend, send_len;
   698						u32 data_offset = 0;
   699	
   700						if (chunk_counter == 1) {
   701							memcpy(packet->payload,
   702							       &m_load_addr,
   703							       sizeof(m_load_addr));
   704							data_offset = sizeof(m_load_addr);
   705						}
   706	
   707						if ((firmware_end - firmware) >=
   708						     ETH_DATA_SIZE)
   709							bytestosend = ETH_DATA_SIZE;
   710						else
   711							bytestosend = firmware_end -
   712										firmware;
   713						memcpy(&packet->payload[data_offset],
   714						       firmware, bytestosend);
   715						firmware = firmware + ETH_DATA_SIZE;
   716	
   717						packet->hdr.packet_start =
   718								ETH_WASP_PACKET_ID;
   719						if (chunk_counter == num_chunks) {
   720							packet->hdr.response =
   721								CMD_START_FIRMWARE;
   722							memcpy(&packet->payload
   723							       [data_offset + bytestosend],
   724							       &m_load_addr,
   725							       sizeof(m_load_addr));
   726							bytestosend += sizeof(m_load_addr);
   727						} else {
   728							packet->hdr.command =
   729								CMD_FIRMWARE_DATA;
   730						}
   731						packet->hdr.counter =
   732								(chunk_counter - 1) * 4;
   733	
   734						send_len = sizeof(struct ethhdr)
   735							+ sizeof(packet->hdr) + bytestosend +
   736							data_offset;
   737	
   738						socket_kvec.iov_len = send_len;
   739						socket_kvec.iov_base = avmwasp->buffer;
   740	
   741						ret = kernel_sendmsg(wasp_socket,
   742								     &socket_msghdr,
   743								     &socket_kvec,
   744								     1, send_len);
   745						if (ret < 0) {
   746							dev_err(dev,
   747								"error sending to WASP %d\n",
   748								ret);
   749							goto err_socket;
   750						}
   751	
   752						chunk_counter++;
   753					}
   754					break;
   755				case RESP_ERROR:
   756					dev_err(dev,
   757						"received an WASP error packet\n");
   758					ret = -EFAULT;
   759					goto err_socket;
   760				case RESP_STARTING:
   761					done = true;
   762					ret = 0;
   763					continue;
   764					break;
   765				default:
   766					dev_err(dev, "unknown packet, continue\n");
   767					continue;
   768					break;
   769				}
   770			}
   771		}
   772	
   773	err_socket:
   774		wasp_socket->ops->release(wasp_socket);
   775	err:
   776		return ret;
   777	}
   778	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
