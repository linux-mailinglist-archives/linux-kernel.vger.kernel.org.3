Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4901538B01
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbiEaFv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiEaFvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:51:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A5B79811
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653976260; x=1685512260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OFIVowWUEY+CrEN/cZWThoG6hVBDy8CRwBivpdiwjE4=;
  b=LP0chj+NGC5sLKzpWmYWXtzh0eQA2xw2R3yKzx552qEsrKqIDVuMbKjE
   ZK3Y5tLHuWT47P7Mw/0zTTkjKq0q2VJoHfoghHEEj4HsFQvJcdC+QCuPb
   uz3ldZC1nDWPfjoZdb2WDSa3ic4m+7V5Qw67Zv/enECnH4QuDCpD8A8Rs
   2tTEtCFWPAd/AfijOZMYFhuEv1JrE34i6gmfL89gqkWV30yXT8Ub0usbr
   7717OxGHVzz/kcbOdIT+RAPCXuFLqZqEl6x1C7yfs4AQYYNaufORMkJOK
   xilKBe6ZmtUjlxgsO+og7N5MpdWoSkoFZjtJv4J6unW0sOvX1/bBoA1iO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="273954954"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="273954954"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 22:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="706423631"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2022 22:50:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvumP-0002Nu-AA;
        Tue, 31 May 2022 05:50:57 +0000
Date:   Tue, 31 May 2022 13:50:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [hare-scsi-devel:auth.v13 7/9]
 drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse: sparse: invalid
 assignment: |=
Message-ID: <202205311329.qL8gyR6R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth.v13
head:   a444c5289874c2a619b92858d240a7cf40c9874b
commit: 6752fbe0803cafd906b16e8c6ea667b5e5a60053 [7/9] nvmet: Implement basic In-Band Authentication
config: arm-randconfig-s032-20220531 (https://download.01.org/0day-ci/archive/20220531/202205311329.qL8gyR6R-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=6752fbe0803cafd906b16e8c6ea667b5e5a60053
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth.v13
        git checkout 6752fbe0803cafd906b16e8c6ea667b5e5a60053
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse: sparse: invalid assignment: |=
>> drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse:    left side has type restricted __le32
>> drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse:    right side has type int
>> drivers/nvme/target/fabrics-cmd-auth.c:92:22: sparse: sparse: cast to restricted __le32
>> drivers/nvme/target/fabrics-cmd-auth.c:92:22: sparse: sparse: cast from restricted __le16

vim +20 drivers/nvme/target/fabrics-cmd-auth.c

    14	
    15	void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
    16	{
    17		/* Initialize in-band authentication */
    18		req->sq->authenticated = false;
    19		req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
  > 20		req->cqe->result.u32 |= 0x2 << 16;
    21	}
    22	
    23	static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
    24	{
    25		struct nvmet_ctrl *ctrl = req->sq->ctrl;
    26		struct nvmf_auth_dhchap_negotiate_data *data = d;
    27		int i, hash_id = 0, fallback_hash_id = 0, dhgid;
    28	
    29		pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d halen %d dhlen %d\n",
    30			 __func__, ctrl->cntlid, req->sq->qid,
    31			 data->sc_c, data->napd, data->auth_protocol[0].dhchap.authid,
    32			 data->auth_protocol[0].dhchap.halen,
    33			 data->auth_protocol[0].dhchap.dhlen);
    34		req->sq->dhchap_tid = le16_to_cpu(data->t_id);
    35		if (data->sc_c)
    36			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
    37	
    38		if (data->napd != 1)
    39			return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
    40	
    41		if (data->auth_protocol[0].dhchap.authid !=
    42		    NVME_AUTH_DHCHAP_AUTH_ID)
    43			return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
    44	
    45		for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
    46			u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
    47	
    48			if (!fallback_hash_id &&
    49			    nvme_auth_hmac_name(host_hmac_id))
    50				fallback_hash_id = host_hmac_id;
    51			if (ctrl->shash_id != host_hmac_id)
    52				continue;
    53			hash_id = ctrl->shash_id;
    54			break;
    55		}
    56		if (hash_id == 0) {
    57			if (fallback_hash_id == 0) {
    58				pr_debug("%s: ctrl %d qid %d: no usable hash found\n",
    59					 __func__, ctrl->cntlid, req->sq->qid);
    60				return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
    61			}
    62			pr_debug("%s: ctrl %d qid %d: no usable hash found, falling back to %s\n",
    63				 __func__, ctrl->cntlid, req->sq->qid,
    64				 nvme_auth_hmac_name(fallback_hash_id));
    65			ctrl->shash_id = fallback_hash_id;
    66		}
    67	
    68		dhgid = -1;
    69		for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
    70			int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
    71	
    72			if (tmp_dhgid == NVME_AUTH_DHGROUP_NULL) {
    73				dhgid = tmp_dhgid;
    74				break;
    75			}
    76		}
    77		if (dhgid < 0) {
    78			pr_debug("%s: ctrl %d qid %d: no usable DH group found\n",
    79					 __func__, ctrl->cntlid, req->sq->qid);
    80			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
    81		}
    82		pr_debug("%s: ctrl %d qid %d: selected DH group %s (%d)\n",
    83			 __func__, ctrl->cntlid, req->sq->qid,
    84			 nvme_auth_dhgroup_name(dhgid), dhgid);
    85		return 0;
    86	}
    87	
    88	static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
    89	{
    90		struct nvmet_ctrl *ctrl = req->sq->ctrl;
    91		struct nvmf_auth_dhchap_reply_data *data = d;
  > 92		u32 dhvlen = le32_to_cpu(data->dhvlen);
    93		u8 *response;
    94	
    95		pr_debug("%s: ctrl %d qid %d: data hl %d cvalid %d dhvlen %u\n",
    96			 __func__, ctrl->cntlid, req->sq->qid,
    97			 data->hl, data->cvalid, dhvlen);
    98	
    99		if (dhvlen) {
   100			return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
   101		}
   102	
   103		response = kmalloc(data->hl, GFP_KERNEL);
   104		if (!response)
   105			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
   106	
   107		if (!ctrl->host_key) {
   108			pr_warn("ctrl %d qid %d no host key\n",
   109				ctrl->cntlid, req->sq->qid);
   110			kfree(response);
   111			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
   112		}
   113		if (nvmet_auth_host_hash(req, response, data->hl) < 0) {
   114			pr_debug("ctrl %d qid %d host hash failed\n",
   115				 ctrl->cntlid, req->sq->qid);
   116			kfree(response);
   117			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
   118		}
   119	
   120		if (memcmp(data->rval, response, data->hl)) {
   121			pr_info("ctrl %d qid %d host response mismatch\n",
   122				ctrl->cntlid, req->sq->qid);
   123			kfree(response);
   124			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
   125		}
   126		kfree(response);
   127		pr_debug("%s: ctrl %d qid %d host authenticated\n",
   128			 __func__, ctrl->cntlid, req->sq->qid);
   129		if (data->cvalid) {
   130			req->sq->dhchap_c2 = kmalloc(data->hl, GFP_KERNEL);
   131			if (!req->sq->dhchap_c2)
   132				return NVME_AUTH_DHCHAP_FAILURE_FAILED;
   133			memcpy(req->sq->dhchap_c2, data->rval + data->hl, data->hl);
   134	
   135			pr_debug("%s: ctrl %d qid %d challenge %*ph\n",
   136				 __func__, ctrl->cntlid, req->sq->qid, data->hl,
   137				 req->sq->dhchap_c2);
   138			req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
   139		} else
   140			req->sq->dhchap_c2 = NULL;
   141	
   142		return 0;
   143	}
   144	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
