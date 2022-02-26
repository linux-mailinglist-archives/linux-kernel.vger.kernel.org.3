Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D134C57C9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 20:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiBZTOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 14:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiBZTOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:14:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BC450066
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645902849; x=1677438849;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kIJBp/nzhxZ2xXsHsaI1ovOue0plIU8nsuK+IkB7K8U=;
  b=c0bG1Qt7hlUO3izIuYIMPgwRjSTyc2upcdNMod9tY0+gEh6Y6H2DDpUj
   hqh6GzVv6XcycaeLBVj4io7Ll9nHUzPmZz3+MkxviMdIhWH4PNcRUDW1s
   r35S36oItk0IGXElC/Z1JZapQTPBZ3riSU8zZzLnm9Lq4zpKpVvVQSJvz
   Dxl5FdjJj8U/U6mBm1NUlfd/LhJ5XHt3zSJ7+2Y8lhU862HtfaAiDDWmS
   Z2nh39TfPzoYAtCwxCmJ95r2FFVqSw5d8aTO3ZpXmN5wKrEdak8tInYxb
   V5VyWqUHP0Wk5DhqG3prPzdHVMfRe6D1UPDiRAPuLm/lM4E695Yd1ocE/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="251510588"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="251510588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 11:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="549700616"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Feb 2022 11:14:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO2W6-0005rw-1A; Sat, 26 Feb 2022 19:14:06 +0000
Date:   Sun, 27 Feb 2022 03:13:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 149/159]
 drivers/nvme/host/tcp.c:1299:35: warning: format specifies type 'unsigned
 long' but the argument has type 'size_t' (aka 'unsigned int')
Message-ID: <202202262102.YfMrKOTP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   21b520ae0b338bd30496feb1ca90a2820dab7a65
commit: 96e2b9364c5e070dab1a5d438376a406ab66690d [149/159] nvme-tcp: cmsg for tls recvmsg()
config: hexagon-randconfig-r023-20220226 (https://download.01.org/0day-ci/archive/20220226/202202262102.YfMrKOTP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=96e2b9364c5e070dab1a5d438376a406ab66690d
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 96e2b9364c5e070dab1a5d438376a406ab66690d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/tcp.c:1299:35: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                    nvme_tcp_queue_id(queue), ret, iov.iov_len);
                                                   ^~~~~~~~~~~
   include/linux/printk.h:574:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   drivers/nvme/host/tcp.c:1328:35: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                    nvme_tcp_queue_id(queue), ret, iov.iov_len);
                                                   ^~~~~~~~~~~
   include/linux/printk.h:574:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   2 warnings generated.


vim +1299 drivers/nvme/host/tcp.c

  1255	
  1256	static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
  1257	{
  1258		struct nvme_tcp_icreq_pdu *icreq;
  1259		struct nvme_tcp_icresp_pdu *icresp;
  1260		struct msghdr msg = {};
  1261		char cbuf[CMSG_SPACE(sizeof(char))];
  1262		struct cmsghdr *cmsg;
  1263		unsigned char ctype;
  1264		struct kvec iov;
  1265		bool ctrl_hdgst, ctrl_ddgst;
  1266		int ret;
  1267	
  1268		icreq = kzalloc(sizeof(*icreq), GFP_KERNEL);
  1269		if (!icreq)
  1270			return -ENOMEM;
  1271	
  1272		icresp = kzalloc(sizeof(*icresp), GFP_KERNEL);
  1273		if (!icresp) {
  1274			ret = -ENOMEM;
  1275			goto free_icreq;
  1276		}
  1277	
  1278		icreq->hdr.type = nvme_tcp_icreq;
  1279		icreq->hdr.hlen = sizeof(*icreq);
  1280		icreq->hdr.pdo = 0;
  1281		icreq->hdr.plen = cpu_to_le32(icreq->hdr.hlen);
  1282		icreq->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
  1283		icreq->maxr2t = 0; /* single inflight r2t supported */
  1284		icreq->hpda = 0; /* no alignment constraint */
  1285		if (queue->hdr_digest)
  1286			icreq->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
  1287		if (queue->data_digest)
  1288			icreq->digest |= NVME_TCP_DATA_DIGEST_ENABLE;
  1289	
  1290		iov.iov_base = icreq;
  1291		iov.iov_len = sizeof(*icreq);
  1292		ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
  1293		if (ret < 0) {
  1294			pr_err("queue %d: failed to send icresp, error %d\n",
  1295			       nvme_tcp_queue_id(queue), ret);
  1296			goto free_icresp;
  1297		}
  1298		pr_debug("queue %d: sent %d/%lu icreq bytes\n",
> 1299			 nvme_tcp_queue_id(queue), ret, iov.iov_len);
  1300		memset(&msg, 0, sizeof(msg));
  1301		msg.msg_control = cbuf;
  1302		msg.msg_controllen = sizeof(cbuf);
  1303		msg.msg_flags = MSG_WAITALL;
  1304		iov.iov_base = icresp;
  1305		iov.iov_len = sizeof(*icresp);
  1306		ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
  1307				iov.iov_len, msg.msg_flags);
  1308		cmsg = CMSG_FIRSTHDR(&msg);
  1309		if (cmsg) {
  1310			pr_debug("queue %d: received cmsg level %d\n",
  1311				 nvme_tcp_queue_id(queue), cmsg->cmsg_level);
  1312			if (cmsg->cmsg_level == SOL_TLS) {
  1313				pr_debug("queue %d: received tls cmsg %d\n",
  1314					 nvme_tcp_queue_id(queue), cmsg->cmsg_type);
  1315				if (cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
  1316					ctype = *((unsigned char *)CMSG_DATA(cmsg));
  1317					if (ctype != 100)
  1318						ret = -ENOTCONN;
  1319				}
  1320			}
  1321		}
  1322		if (ret < 0) {
  1323			pr_err("queue %d: failed to receive icresp, error %d\n",
  1324			       nvme_tcp_queue_id(queue), ret);
  1325			goto free_icresp;
  1326		}
  1327		pr_debug("queue %d: received %d/%lu icresp bytes\n",
  1328			 nvme_tcp_queue_id(queue), ret, iov.iov_len);
  1329		ret = -EINVAL;
  1330		if (icresp->hdr.type != nvme_tcp_icresp) {
  1331			pr_err("queue %d: bad type returned %d\n",
  1332				nvme_tcp_queue_id(queue), icresp->hdr.type);
  1333			print_hex_dump(KERN_ERR, "icresp: ", 0,
  1334				       8, 1, icresp, iov.iov_len, true);
  1335			goto free_icresp;
  1336		}
  1337	
  1338		if (le32_to_cpu(icresp->hdr.plen) != sizeof(*icresp)) {
  1339			pr_err("queue %d: bad pdu length returned %d\n",
  1340				nvme_tcp_queue_id(queue), icresp->hdr.plen);
  1341			goto free_icresp;
  1342		}
  1343	
  1344		if (icresp->pfv != NVME_TCP_PFV_1_0) {
  1345			pr_err("queue %d: bad pfv returned %d\n",
  1346				nvme_tcp_queue_id(queue), icresp->pfv);
  1347			goto free_icresp;
  1348		}
  1349	
  1350		ctrl_ddgst = !!(icresp->digest & NVME_TCP_DATA_DIGEST_ENABLE);
  1351		if ((queue->data_digest && !ctrl_ddgst) ||
  1352		    (!queue->data_digest && ctrl_ddgst)) {
  1353			pr_err("queue %d: data digest mismatch host: %s ctrl: %s\n",
  1354				nvme_tcp_queue_id(queue),
  1355				queue->data_digest ? "enabled" : "disabled",
  1356				ctrl_ddgst ? "enabled" : "disabled");
  1357			goto free_icresp;
  1358		}
  1359	
  1360		ctrl_hdgst = !!(icresp->digest & NVME_TCP_HDR_DIGEST_ENABLE);
  1361		if ((queue->hdr_digest && !ctrl_hdgst) ||
  1362		    (!queue->hdr_digest && ctrl_hdgst)) {
  1363			pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
  1364				nvme_tcp_queue_id(queue),
  1365				queue->hdr_digest ? "enabled" : "disabled",
  1366				ctrl_hdgst ? "enabled" : "disabled");
  1367			goto free_icresp;
  1368		}
  1369	
  1370		if (icresp->cpda != 0) {
  1371			pr_err("queue %d: unsupported cpda returned %d\n",
  1372				nvme_tcp_queue_id(queue), icresp->cpda);
  1373			goto free_icresp;
  1374		}
  1375	
  1376		ret = 0;
  1377	free_icresp:
  1378		kfree(icresp);
  1379	free_icreq:
  1380		kfree(icreq);
  1381		return ret;
  1382	}
  1383	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
