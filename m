Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A604BEAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiBUShf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:37:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiBUSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:36:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D4ECDF;
        Mon, 21 Feb 2022 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645468555; x=1677004555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yluBqLZc4oyMvozL6AwPEvECwa2vXXK+JWSRPFjqZYA=;
  b=f+rlIrZtwk6hBz9qoSJUQvYoCtrZBuwZxU+ECx7/8Yo0le5k7ZetLSHU
   6+kLfCAa+vK91jLGF+IxFo2HdtaYMsEfc2spUt69ymTikfAbVLkKMj8xQ
   VdoV4NaqbKwa3ZdyjP/z2jm1geOZY//uwMC4dq5+b9ieiFj1FhuF4Lhz2
   1JEtjsPUA/SJoDQzqokRe5FEU4T0pv2k5V8dhjjzIIJRSLXtJNzPKj+9n
   dKczGGBCBPsVS7dOxpsizdTAIw6y9UVBbfBApYioOh63PYARvZS+6T6kp
   Al+dGyV/oCq4qGywxxPGlxHQqm3NB3CGA/6faD8mSzllSiB3gx+3CXmnC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="249134658"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="249134658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 10:35:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="490518889"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2022 10:35:37 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMDX6-0001su-Ik; Mon, 21 Feb 2022 18:35:36 +0000
Date:   Tue, 22 Feb 2022 02:34:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] remoteproc: Add AVM WASP driver
Message-ID: <202202220201.CqRPstWg-lkp@intel.com>
References: <20220221135424.GA7385@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221135424.GA7385@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on robh/for-next v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daniel-Kestrel/Add-support-for-WASP-SoC-on-AVM-router-boards/20220221-215619
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202220201.CqRPstWg-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/76e19a3c7ae383687205d7be3ac6224253d97704
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daniel-Kestrel/Add-support-for-WASP-SoC-on-AVM-router-boards/20220221-215619
        git checkout 76e19a3c7ae383687205d7be3ac6224253d97704
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/remoteproc/avm_wasp.c:150:5: warning: no previous prototype for 'avm_wasp_netboot_mdio_read' [-Wmissing-prototypes]
     150 | int avm_wasp_netboot_mdio_read(struct avm_wasp_rproc *avmwasp,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/avm_wasp.c:176:6: warning: no previous prototype for 'avm_wasp_netboot_mdio_write' [-Wmissing-prototypes]
     176 | void avm_wasp_netboot_mdio_write(struct avm_wasp_rproc *avmwasp,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/avm_wasp.c:197:6: warning: no previous prototype for 'avm_wasp_netboot_mdio_write_u32_split' [-Wmissing-prototypes]
     197 | void avm_wasp_netboot_mdio_write_u32_split(struct avm_wasp_rproc *avmwasp,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/avm_wasp.c:380:5: warning: no previous prototype for 'avm_wasp_netboot_load_firmware' [-Wmissing-prototypes]
     380 | int avm_wasp_netboot_load_firmware(struct avm_wasp_rproc *avmwasp)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/avm_wasp.c:569:5: warning: no previous prototype for 'avm_wasp_load_initramfs_image' [-Wmissing-prototypes]
     569 | int avm_wasp_load_initramfs_image(struct avm_wasp_rproc *avmwasp)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/of_device.h:5,
                    from drivers/remoteproc/avm_wasp.c:14:
   drivers/remoteproc/avm_wasp.c: In function 'avm_wasp_load_initramfs_image':
>> drivers/remoteproc/avm_wasp.c:724:33: warning: format '%d' expects argument of type 'int', but argument 3 has type 'ssize_t' {aka 'long int'} [-Wformat=]
     724 |                                 "Error receiving any packet or timeout: %d\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/remoteproc/avm_wasp.c:723:25: note: in expansion of macro 'dev_err'
     723 |                         dev_err(&avmwasp->pdev->dev,
         |                         ^~~~~~~
   drivers/remoteproc/avm_wasp.c:724:74: note: format string is defined here
     724 |                                 "Error receiving any packet or timeout: %d\n",
         |                                                                         ~^
         |                                                                          |
         |                                                                          int
         |                                                                         %ld
   drivers/remoteproc/avm_wasp.c: In function 'avm_wasp_rproc_boot_addr':
>> drivers/remoteproc/avm_wasp.c:969:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     969 |         return (u64)((u32)fw->data);
         |                      ^


vim +724 drivers/remoteproc/avm_wasp.c

   549	
   550	/**
   551	 * avm_wasp_load_initramfs_image() - load initramfs image to WASP
   552	 * @avmwasp: pointer to drivers private avm_wasp_rproc structure
   553	 *
   554	 * Uses the lan port specified from DT to load the initramfs to
   555	 * WASP after the network boot firmware was successfully started.
   556	 * Communication is done by using raw sockets.
   557	 * The port of the lantiq gswip device will be started if not
   558	 * already up and running.
   559	 * There are several commands and status values which are checked.
   560	 * First a discovery packet is received and then each data packet
   561	 * is acknowledged by the WASP network boot firmware.
   562	 * First packet needs to prepend the load address and last packet
   563	 * needs to append the execution address.
   564	 *
   565	 * Return: 0 on Success, -14 if errors with the WASP send protocol
   566	 * have occurred or the error returned from the failed operating
   567	 * system function or service
   568	 */
   569	int avm_wasp_load_initramfs_image(struct avm_wasp_rproc *avmwasp)
   570	{
   571		int done = 0;
   572		int reuse = 1;
   573		int num_chunks = 0;
   574		int chunk_counter = 1;
   575		int ret, packet_counter, data_offset;
   576		int send_len = 0;
   577		short interface_flags;
   578		ssize_t numbytes;
   579		ssize_t read;
   580		const u8 *firmware;
   581		const u8 *firmware_end;
   582		struct wasp_packet *packet = (struct wasp_packet *)
   583				(avmwasp->recvbuf + sizeof(struct ethhdr));
   584		struct ethhdr *recv_eh = (struct ethhdr *)avmwasp->recvbuf;
   585		struct msghdr recv_socket_hdr;
   586		struct kvec recv_vec;
   587		struct ethhdr *send_eh = (struct ethhdr *)avmwasp->sendbuf;
   588		struct sockaddr_ll send_socket_address;
   589		struct msghdr send_socket_hdr;
   590		struct kvec send_vec;
   591		struct net_device *send_netdev;
   592		struct sockaddr send_sock_addr;
   593		struct timeval {
   594			__kernel_old_time_t	tv_sec;
   595			__kernel_suseconds_t	tv_usec;
   596		} timeout;
   597		time64_t start_time, current_time;
   598	
   599		if (!avmwasp->linux_blob) {
   600			dev_err(&avmwasp->pdev->dev,
   601				"Error accessing initramfs image");
   602			goto err;
   603		}
   604	
   605		ret = sock_create_kern(&init_net, PF_PACKET, SOCK_RAW,
   606				       htons(ETHER_TYPE_ATH_ECPS_FRAME),
   607				       &avmwasp->recv_socket);
   608		if (ret < 0) {
   609			dev_err(&avmwasp->pdev->dev,
   610				"Error opening recv socket: %d", ret);
   611			goto err;
   612		}
   613	
   614		ret = sock_setsockopt(avmwasp->recv_socket, SOL_SOCKET, SO_REUSEADDR,
   615				      KERNEL_SOCKPTR(&reuse), sizeof(reuse));
   616		if (ret < 0) {
   617			dev_err(&avmwasp->pdev->dev,
   618				"Error SO_REUSEADDR recv socket: %d", ret);
   619			goto err_recv;
   620		}
   621	
   622		ret = sock_setsockopt(avmwasp->recv_socket, SOL_SOCKET,
   623				      SO_BINDTODEVICE,
   624				      KERNEL_SOCKPTR(avmwasp->loader_port),
   625				      IFNAMSIZ - 1);
   626		if (ret < 0) {
   627			dev_err(&avmwasp->pdev->dev,
   628				"Error SO_BINDTODEVICE recv socket: %d", ret);
   629			goto err_recv;
   630		}
   631	
   632		timeout.tv_sec = 10;
   633		timeout.tv_usec = 0;
   634		ret = sock_setsockopt(avmwasp->recv_socket, SOL_SOCKET,
   635				      SO_RCVTIMEO_OLD,
   636				KERNEL_SOCKPTR(&timeout), sizeof(timeout));
   637		if (ret < 0) {
   638			dev_err(&avmwasp->pdev->dev,
   639				"Error SO_RCVTIMEO recv socket: %d", ret);
   640			goto err_recv;
   641		}
   642	
   643		ret = sock_create_kern(&init_net, AF_PACKET, SOCK_RAW, IPPROTO_RAW,
   644				       &avmwasp->send_socket);
   645		if (ret < 0) {
   646			dev_err(&avmwasp->pdev->dev,
   647				"Error opening send socket: %d", ret);
   648			goto err_recv;
   649		}
   650	
   651		timeout.tv_sec = 10;
   652		timeout.tv_usec = 0;
   653		ret = sock_setsockopt(avmwasp->send_socket, SOL_SOCKET,
   654				      SO_SNDTIMEO_OLD,
   655				KERNEL_SOCKPTR(&timeout), sizeof(timeout));
   656		if (ret < 0) {
   657			dev_err(&avmwasp->pdev->dev,
   658				"Error SO_SNDTIMEO send socket: %d", ret);
   659			goto err_send;
   660		}
   661	
   662		rcu_read_lock();
   663		send_netdev = dev_get_by_name_rcu(sock_net(avmwasp->send_socket->sk),
   664						  avmwasp->loader_port);
   665		if (send_netdev)
   666			interface_flags = (short)dev_get_flags(send_netdev);
   667		rcu_read_unlock();
   668	
   669		if (IS_ERR_OR_NULL(send_netdev)) {
   670			dev_err(&avmwasp->pdev->dev, "Error accessing net device.\n");
   671			ret = -ENODEV;
   672			goto err_send;
   673		}
   674	
   675		interface_flags |= IFF_PROMISC | IFF_UP | IFF_RUNNING;
   676		rtnl_lock();
   677		ret = dev_change_flags(send_netdev, interface_flags, NULL);
   678		rtnl_unlock();
   679	
   680		if (ret) {
   681			dev_err(&avmwasp->pdev->dev,
   682				"Error changing interface flags: %d\n", ret);
   683			goto err_send;
   684		}
   685	
   686		avmwasp->ifindex = send_netdev->ifindex;
   687		ret = dev_get_mac_address(&send_sock_addr,
   688					  sock_net(avmwasp->send_socket->sk),
   689				avmwasp->loader_port);
   690		if (ret < 0) {
   691			dev_err(&avmwasp->pdev->dev,
   692				"Error getting mac address: %d\n", ret);
   693			goto err_send;
   694		}
   695	
   696		memset(avmwasp->sendbuf, 0, BUF_SIZE);
   697	
   698		memcpy(send_eh->h_dest, wasp_mac, sizeof(send_eh->h_dest));
   699		send_eh->h_proto = ETHER_TYPE_ATH_ECPS_FRAME;
   700		memcpy(send_eh->h_source, send_sock_addr.sa_data,
   701		       sizeof(send_eh->h_source));
   702	
   703		start_time = ktime_get_seconds();
   704	
   705		while (!done) {
   706			current_time = ktime_get_seconds();
   707			if ((current_time - start_time) > SEND_LOOP_TIMEOUT_SECONDS) {
   708				dev_err(&avmwasp->pdev->dev,
   709					"Waiting for packet from WASP timed out.\n");
   710				ret = -EFAULT;
   711				goto err_send;
   712			}
   713	
   714			memset(&recv_vec, 0, sizeof(recv_vec));
   715			memset(&recv_socket_hdr, 0, sizeof(recv_socket_hdr));
   716			recv_vec.iov_base = avmwasp->recvbuf;
   717			recv_vec.iov_len = BUF_SIZE;
   718			numbytes = kernel_recvmsg(avmwasp->recv_socket,
   719						  &recv_socket_hdr, &recv_vec, 1,
   720						  BUF_SIZE, 0);
   721	
   722			if (numbytes < 0) {
   723				dev_err(&avmwasp->pdev->dev,
 > 724					"Error receiving any packet or timeout: %d\n",
   725					numbytes);
   726				ret = -EFAULT;
   727				goto err_send;
   728			}
   729	
   730			if (numbytes < (sizeof(struct ethhdr) + WASP_HEADER_LEN)) {
   731				dev_err(&avmwasp->pdev->dev,
   732					"Packet too small, discard and continue.\n");
   733				continue;
   734			}
   735	
   736			if (recv_eh->h_proto != ETHER_TYPE_ATH_ECPS_FRAME)
   737				continue;
   738	
   739			memcpy(wasp_mac, recv_eh->h_source, sizeof(wasp_mac));
   740			memset(&avmwasp->s_packet, 0, sizeof(avmwasp->s_packet));
   741	
   742			if (packet->packet_start == PACKET_START) {
   743				switch (packet->response) {
   744				case RESP_DISCOVER:
   745					packet_counter = 0;
   746					firmware = avmwasp->linux_blob->data;
   747					firmware_end = firmware
   748							+ avmwasp->linux_blob->size;
   749	
   750					chunk_counter = 1;
   751					num_chunks =
   752						avmwasp->linux_blob->size / CHUNK_SIZE;
   753					if (avmwasp->linux_blob->size % CHUNK_SIZE != 0)
   754						num_chunks++;
   755				break;
   756				case RESP_OK:
   757					/* got reply send next packet */
   758				break;
   759				case RESP_ERROR:
   760					dev_err(&avmwasp->pdev->dev,
   761						"Received an WASP error packet!\n");
   762					ret = -EFAULT;
   763					goto err_send;
   764				break;
   765				case RESP_STARTING:
   766					done = 1;
   767					ret = 0;
   768					continue;
   769				break;
   770				default:
   771					dev_err(&avmwasp->pdev->dev,
   772						"Unknown packet! Continue.\n");
   773					continue;
   774				break;
   775				}
   776	
   777				if (packet_counter == 0) {
   778					memcpy(avmwasp->s_packet.payload, &m_load_addr,
   779					       sizeof(m_load_addr));
   780					data_offset = sizeof(m_load_addr);
   781				} else {
   782					data_offset = 0;
   783				}
   784	
   785				if (firmware < firmware_end) {
   786					if ((firmware_end - firmware) >= CHUNK_SIZE)
   787						read = CHUNK_SIZE;
   788					else
   789						read = firmware_end - firmware;
   790					memcpy(&avmwasp->s_packet.payload[data_offset],
   791					       firmware, read);
   792					firmware = firmware + CHUNK_SIZE;
   793	
   794					avmwasp->s_packet.packet_start = PACKET_START;
   795					if (chunk_counter == num_chunks) {
   796						avmwasp->s_packet.response =
   797								CMD_START_FIRMWARE;
   798						memcpy(&avmwasp->s_packet.payload
   799						       [data_offset + read],
   800						       &m_load_addr, sizeof(m_load_addr));
   801						data_offset += sizeof(m_load_addr);
   802					} else {
   803						avmwasp->s_packet.command =
   804								CMD_FIRMWARE_DATA;
   805					}
   806					avmwasp->s_packet.counter = packet_counter;
   807	
   808					memcpy(avmwasp->sendbuf + sizeof(struct ethhdr),
   809					       avmwasp->s_packet.data,
   810					       WASP_HEADER_LEN + read + data_offset);
   811					send_len = sizeof(struct ethhdr)
   812						+ WASP_HEADER_LEN + read + data_offset;
   813					send_socket_address.sll_halen = ETH_ALEN;
   814					send_socket_address.sll_ifindex =
   815								avmwasp->ifindex;
   816	
   817					memset(&send_vec, 0, sizeof(send_vec));
   818					send_vec.iov_len = send_len;
   819					send_vec.iov_base = avmwasp->sendbuf;
   820	
   821					memset(&send_socket_hdr, 0,
   822					       sizeof(send_socket_hdr));
   823					send_socket_hdr.msg_name = (struct sockaddr *)
   824								&send_socket_address;
   825					send_socket_hdr.msg_namelen =
   826						sizeof(struct sockaddr_ll);
   827	
   828					ret = kernel_sendmsg(avmwasp->send_socket,
   829							     &send_socket_hdr,
   830							     &send_vec,
   831							     1, send_len);
   832					if (ret < 0) {
   833						dev_err(&avmwasp->pdev->dev,
   834							"Error sending to WASP %d\n",
   835							ret);
   836						goto err_send;
   837					}
   838	
   839					packet_counter += COUNTER_INCR;
   840					chunk_counter++;
   841				}
   842			}
   843		}
   844	
   845	err_send:
   846		avmwasp->send_socket->ops->release(avmwasp->send_socket);
   847	err_recv:
   848		avmwasp->recv_socket->ops->release(avmwasp->recv_socket);
   849	err:
   850		return ret;
   851	}
   852	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
