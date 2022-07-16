Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16357713D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiGPTpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiGPTpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 15:45:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90A1C101
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658000736; x=1689536736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GDtmLPfu8wmTpZX/OOli0d7UCNSqrSBsJMk4LYDiDh8=;
  b=F8eQV/vaXqG9xqtOUNgDYQDbtWGbnbeMto+QC4ZQah2noNQE9vDMYKA1
   fQ0WdOBT+Kt1Oe2t2M2dx4t6LGsPMa9fH2pFHsGpHGuaew3ueZomf+yIV
   zLCbILUFndQDAxwgj+WX6sYuwhyO1FuJ4nuxLgUD3+EO9womeBMRoNan7
   w7kD+IwF4CqPpPJsdXpe4FmBeBLAW5YFUWfZILa2XLIg0fgtlmgiWLItb
   Bp/hY/Cq7/s5F/04RvM3BpO9F6qKY3fy+u8u1tqeCzXL51VoEjyEiuLGN
   x+zdsdk/lh8ZQjh0Na6Oz/sxJMkmhd5sluTguyYYICbxlglCb1RJMYTFj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="349965472"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="349965472"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 12:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="624247442"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2022 12:45:34 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCnjJ-00023K-Kk;
        Sat, 16 Jul 2022 19:45:33 +0000
Date:   Sun, 17 Jul 2022 03:44:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 17/18]
 drivers/hid/dockchannel-hid/dockchannel-hid.c:261:22: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202207170336.N81Uiegb-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   2902ed1bd2d6ac439a835c53841122c7f3455a6c
commit: e24c3dd5875015f606e146e07ede25ae4d866fcc [17/18] hid: Add Apple DockChannel HID transport driver
config: arm64-randconfig-s042-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170336.N81Uiegb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/e24c3dd5875015f606e146e07ede25ae4d866fcc
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout e24c3dd5875015f606e146e07ede25ae4d866fcc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ drivers/hid/dockchannel-hid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:261:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] length @@     got unsigned long @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:261:22: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:261:22: sparse:     got unsigned long
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:265:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] length @@     got unsigned long [usertype] size @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:265:22: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:265:22: sparse:     got unsigned long [usertype] size
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:408:16: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:408:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:409:20: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:409:54: sparse: sparse: restricted __le32 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:410:37: sparse: sparse: cast from restricted __le32
   drivers/hid/dockchannel-hid/dockchannel-hid.c:410:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:411:20: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:411:41: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:418:65: sparse: sparse: restricted __le32 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:419:35: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] len @@     got restricted __le32 [usertype] data_length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:419:35: sparse:     expected unsigned long [usertype] len
   drivers/hid/dockchannel-hid/dockchannel-hid.c:419:35: sparse:     got restricted __le32 [usertype] data_length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:426:28: sparse: sparse: restricted __le32 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:429:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long [usertype] @@     got restricted __le32 [usertype] data_length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:429:15: sparse:     expected unsigned long [usertype]
   drivers/hid/dockchannel-hid/dockchannel-hid.c:429:15: sparse:     got restricted __le32 [usertype] data_length
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:601:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] vendor_id @@     got int @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:601:52: sparse:     expected restricted __le16 [usertype] vendor_id
   drivers/hid/dockchannel-hid/dockchannel-hid.c:601:52: sparse:     got int
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:628:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] vendor @@     got restricted __le16 [usertype] vendor_id @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:628:21: sparse:     expected unsigned int [usertype] vendor
   drivers/hid/dockchannel-hid/dockchannel-hid.c:628:21: sparse:     got restricted __le16 [usertype] vendor_id
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:629:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] product @@     got restricted __le16 [usertype] product_id @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:629:22: sparse:     expected unsigned int [usertype] product
   drivers/hid/dockchannel-hid/dockchannel-hid.c:629:22: sparse:     got restricted __le16 [usertype] product_id
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:630:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] version @@     got restricted __le16 [usertype] version_number @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:630:22: sparse:     expected unsigned int [usertype] version
   drivers/hid/dockchannel-hid/dockchannel-hid.c:630:22: sparse:     got restricted __le16 [usertype] version_number
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:713:24: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:717:65: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] desc_len @@     got restricted __le16 [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:717:65: sparse:     expected unsigned long [usertype] desc_len
   drivers/hid/dockchannel-hid/dockchannel-hid.c:717:65: sparse:     got restricted __le16 [usertype] length
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:725:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int id @@     got restricted __le16 [usertype] id @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:725:54: sparse:     expected int id
   drivers/hid/dockchannel-hid/dockchannel-hid.c:725:54: sparse:     got restricted __le16 [usertype] id
   drivers/hid/dockchannel-hid/dockchannel-hid.c:715:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:715:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:733:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:734:30: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:781:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] retcode @@     got unsigned int [assigned] [usertype] retcode @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:781:22: sparse:     expected restricted __le32 [usertype] retcode
   drivers/hid/dockchannel-hid/dockchannel-hid.c:781:22: sparse:     got unsigned int [assigned] [usertype] retcode
   drivers/hid/dockchannel-hid/dockchannel-hid.c:829:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:829:53: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:830:17: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:838:64: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] length @@     got restricted __le16 [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:838:64: sparse:     expected unsigned long [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:838:64: sparse:     got restricted __le16 [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:840:71: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] length @@     got restricted __le16 [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:840:71: sparse:     expected unsigned long [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:840:71: sparse:     got restricted __le16 [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:855:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:855:47: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:856:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:867:17: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:883:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:883:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:883:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:883:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:883:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:883:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:885:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long [usertype] resp_size @@     got restricted __le16 [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:885:26: sparse:     expected unsigned long [usertype] resp_size
   drivers/hid/dockchannel-hid/dockchannel-hid.c:885:26: sparse:     got restricted __le16 [usertype] length
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:887:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] retcode @@     got restricted __le32 [usertype] retcode @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:887:24: sparse:     expected unsigned int [usertype] retcode
   drivers/hid/dockchannel-hid/dockchannel-hid.c:887:24: sparse:     got restricted __le32 [usertype] retcode
   drivers/hid/dockchannel-hid/dockchannel-hid.c:909:60: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:909:80: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:915:55: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:955:43: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:961:9: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] @@     got restricted __le16 [addressable] [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:961:9: sparse:     expected unsigned long [usertype]
   drivers/hid/dockchannel-hid/dockchannel-hid.c:961:9: sparse:     got restricted __le16 [addressable] [usertype] length

vim +261 drivers/hid/dockchannel-hid/dockchannel-hid.c

   246	
   247	static int dchid_send(struct dchid_iface *iface, u32 flags, void *msg, size_t size)
   248	{
   249		u32 checksum = 0xffffffff;
   250		size_t wsize = round_down(size, 4);
   251		size_t tsize = size - wsize;
   252		int ret;
   253		struct {
   254			struct dchid_hdr hdr;
   255			struct dchid_subhdr sub;
   256		} __packed h;
   257	
   258		memset(&h, 0, sizeof(h));
   259		h.hdr.hdr_len = sizeof(h.hdr);
   260		h.hdr.channel = DCHID_CHANNEL_CMD;
 > 261		h.hdr.length = round_up(size, 4) + sizeof(h.sub);
   262		h.hdr.seq = iface->tx_seq;
   263		h.hdr.iface = iface->index;
   264		h.sub.flags = flags;
 > 265		h.sub.length = size;
   266	
   267		ret = dockchannel_send(iface->dchid->dc, &h, sizeof(h));
   268		if (ret < 0)
   269			return ret;
   270		checksum -= dchid_checksum(&h, sizeof(h));
   271	
   272		ret = dockchannel_send(iface->dchid->dc, msg, wsize);
   273		if (ret < 0)
   274			return ret;
   275		checksum -= dchid_checksum(msg, wsize);
   276	
   277		if (tsize) {
   278			u8 tail[4] = {0, 0, 0, 0};
   279	
   280			memcpy(tail, msg + wsize, tsize);
   281			ret = dockchannel_send(iface->dchid->dc, tail, sizeof(tail));
   282			if (ret < 0)
   283				return ret;
   284			checksum -= dchid_checksum(tail, sizeof(tail));
   285		}
   286	
   287		ret = dockchannel_send(iface->dchid->dc, &checksum, sizeof(checksum));
   288		if (ret < 0)
   289			return ret;
   290	
   291		return 0;
   292	}
   293	
   294	static int dchid_cmd(struct dchid_iface *iface, u32 type, u32 req,
   295			     void *data, size_t size, void *resp_buf, size_t resp_size)
   296	{
   297		int ret;
   298		int report_id = *(u8*)data;
   299	
   300		mutex_lock(&iface->out_mutex);
   301	
   302		WARN_ON(iface->out_report != -1);
   303		iface->out_report = report_id;
   304		iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
   305		iface->resp_buf = resp_buf;
   306		iface->resp_size = resp_size;
   307		reinit_completion(&iface->out_complete);
   308	
   309		ret = dchid_send(iface, iface->out_flags, data, size);
   310		if (ret < 0)
   311			goto done;
   312	
   313		if (!wait_for_completion_timeout(&iface->out_complete, msecs_to_jiffies(1000))) {
   314			dev_err(iface->dchid->dev, "output report 0x%x to iface  %d (%s) timed out\n",
   315				report_id, iface->index, iface->name);
   316			ret = -ETIMEDOUT;
   317			goto done;
   318		}
   319	
   320		ret = iface->resp_size;
   321		if (iface->retcode) {
   322			dev_err(iface->dchid->dev,
   323				"output report 0x%x to iface %d (%s) failed with err 0x%x\n",
   324				report_id, iface->index, iface->name, iface->retcode);
   325			ret = -EIO;
   326		}
   327	
   328	done:
   329		iface->tx_seq++;
   330		iface->out_report = -1;
   331		iface->out_flags = 0;
   332		iface->resp_buf = NULL;
   333		iface->resp_size = 0;
   334		mutex_unlock(&iface->out_mutex);
   335		return ret;
   336	}
   337	
   338	static int dchid_comm_cmd(struct dockchannel_hid *dchid, void *cmd, size_t size)
   339	{
   340		return dchid_cmd(dchid->comm, GROUP_CMD, REQ_SET_REPORT, cmd, size, NULL, 0);
   341	}
   342	
   343	static int dchid_enable_interface(struct dchid_iface *iface)
   344	{
   345		u8 msg[] = { CMD_ENABLE_INTERFACE, iface->index };
   346	
   347		return dchid_comm_cmd(iface->dchid, msg, sizeof(msg));
   348	}
   349	
   350	static int dchid_reset_interface(struct dchid_iface *iface, int state)
   351	{
   352		u8 msg[] = { CMD_RESET_INTERFACE, 1, iface->index, state };
   353	
   354		return dchid_comm_cmd(iface->dchid, msg, sizeof(msg));
   355	}
   356	
   357	static int dchid_send_firmware(struct dchid_iface *iface, void *firmware, size_t size)
   358	{
   359		struct {
   360			u8 cmd;
   361			u8 unk1;
   362			u8 unk2;
   363			u8 iface;
   364			u64 addr;
   365			u32 size;
   366		} __packed msg = {
   367			.cmd = CMD_SEND_FIRMWARE,
   368			.unk1 = 2,
   369			.unk2 = 0,
   370			.iface = iface->index,
   371			.size = size,
   372		};
   373		dma_addr_t addr;
   374		void *buf = dmam_alloc_coherent(iface->dchid->dev, size, &addr, GFP_KERNEL);
   375	
   376		if (IS_ERR_OR_NULL(buf))
   377			return buf ? PTR_ERR(buf) : -ENOMEM;
   378	
   379		msg.addr = addr;
   380		memcpy(buf, firmware, size);
   381		wmb();
   382	
   383		return dchid_comm_cmd(iface->dchid, &msg, sizeof(msg));
   384	}
   385	
   386	static int dchid_get_firmware(struct dchid_iface *iface, void **firmware, size_t *size)
   387	{
   388		int ret;
   389		const char *fw_name;
   390		const struct firmware *fw;
   391		struct fw_header *hdr;
   392		u8 *fw_data;
   393	
   394		ret = of_property_read_string(iface->of_node, "firmware-name", &fw_name);
   395		if (ret) {
   396			/* Firmware is only for some devices */
   397			*firmware = NULL;
   398			*size = 0;
   399			return 0;
   400		}
   401	
   402		ret = request_firmware(&fw, fw_name, iface->dchid->dev);
   403		if (ret)
   404			return ret;
   405	
   406		hdr = (struct fw_header *)fw->data;
   407	
 > 408		if (hdr->magic != FW_MAGIC || hdr->version != FW_VER ||
   409			hdr->hdr_length < sizeof(*hdr) || hdr->hdr_length > fw->size ||
 > 410			(hdr->hdr_length + (size_t)hdr->data_length) > fw->size ||
   411			hdr->iface_offset >= hdr->data_length) {
   412			dev_warn(iface->dchid->dev, "%s: invalid firmware header\n",
   413				 fw_name);
   414			ret = -EINVAL;
   415			goto done;
   416		}
   417	
   418		fw_data = devm_kmemdup(iface->dchid->dev, fw->data + hdr->hdr_length,
 > 419				       hdr->data_length, GFP_KERNEL);
   420		if (!fw_data) {
   421			ret = -ENOMEM;
   422			goto done;
   423		}
   424	
   425		if (hdr->iface_offset)
   426			fw_data[hdr->iface_offset] = iface->index;
   427	
   428		*firmware = fw_data;
 > 429		*size = hdr->data_length;
   430	
   431	done:
   432		release_firmware(fw);
   433		return ret;
   434	}
   435	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
