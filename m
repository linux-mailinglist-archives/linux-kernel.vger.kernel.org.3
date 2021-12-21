Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3547B91C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 05:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhLUDzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:55:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:25217 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhLUDzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640058945; x=1671594945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yzyhjsXsaa9gQGzdHlahSjk3Vc1nxAg/JDoznyM/pj0=;
  b=IqOIFZgzXIL/7mSjo2W6cCYbrNfVTM5Q6sdXE6ldTzIaXvRsowYNVlzq
   9iIMBwENJ61JiSHbXo2RRBEo/r/IEejzGkG3aRaQ78N3/xtt9AkL3EZK9
   IvzkzWB4tmNdoOwYxoLFZh74glp2FGLH1bPRbKlCqK/ls8FxW0YX9Kyfz
   nWRXDjQYKInPvFI4T1IKDhupp3KrXIzymGzEaLdxRxeEq57FAoYlm4MSP
   kAJx66SXeiDHI0V+EwJb1kEUna/JhbnAuVw7IYziMarw0CgQSr0fSQJAM
   m6aU+EOzG2zPexjiMOLtM+CthGr3csLaihq6VjJe0yvEB0K/DzUB1urbf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240127300"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="240127300"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 19:55:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="467634239"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2021 19:55:43 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzWFa-0008eV-WC; Tue, 21 Dec 2021 03:55:42 +0000
Date:   Tue, 21 Dec 2021 11:54:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Ye <yekai13@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: drivers/crypto/hisilicon/qm.c:4135:8: warning: %x in format string
 (no. 2) requires 'unsigned int *' but the argument type is 'signed int *'.
 [invalidScanfArgType_int]
Message-ID: <202112211125.pOtaOLOt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   86085fe79e3c1a66e32f2acae0ae64f4cceb8d28
commit: 3bbf0783636be8fd672907df25904288f14566f2 crypto: hisilicon/qm - supports to inquiry each function's QoS
date:   6 months ago
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
   drivers/crypto/hisilicon/qm.c:4077:8: warning: %ld in format string (no. 1) requires 'long *' but the argument type is 'unsigned long *'. [invalidScanfArgType_int]
    ret = sscanf(buf, "%ld", val);
          ^
>> drivers/crypto/hisilicon/qm.c:4135:8: warning: %x in format string (no. 2) requires 'unsigned int *' but the argument type is 'signed int *'. [invalidScanfArgType_int]
    ret = sscanf(tbuf_bdf, "%d:%x:%d.%d", &tmp1, &bus, &device, &function);
          ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   drivers/crypto/hisilicon/qm.c:4077:8: warning: %ld in format string (no. 1) requires 'long *' but the argument type is 'unsigned long *'. [invalidScanfArgType_int]
    ret = sscanf(buf, "%ld", val);
          ^
>> drivers/crypto/hisilicon/qm.c:4135:8: warning: %x in format string (no. 2) requires 'unsigned int *' but the argument type is 'signed int *'. [invalidScanfArgType_int]
    ret = sscanf(tbuf_bdf, "%d:%x:%d.%d", &tmp1, &bus, &device, &function);
          ^
>> drivers/crypto/hisilicon/qm.c:4122:8: warning: sscanf() without field width limits can crash with huge input data. [invalidscanf]
    ret = sscanf(tbuf, "%s %s", tbuf_bdf, val_buf);
          ^
>> drivers/crypto/hisilicon/qm.c:4031:9: warning: Uninitialized variable: ret [uninitvar]
    return ret;
           ^

vim +4135 drivers/crypto/hisilicon/qm.c

3bbf0783636be8 Kai Ye 2021-06-11  4002  
3bbf0783636be8 Kai Ye 2021-06-11  4003  static int qm_vf_read_qos(struct hisi_qm *qm)
3bbf0783636be8 Kai Ye 2021-06-11  4004  {
3bbf0783636be8 Kai Ye 2021-06-11  4005  	int cnt = 0;
3bbf0783636be8 Kai Ye 2021-06-11  4006  	int ret;
3bbf0783636be8 Kai Ye 2021-06-11  4007  
3bbf0783636be8 Kai Ye 2021-06-11  4008  	/* reset mailbox qos val */
3bbf0783636be8 Kai Ye 2021-06-11  4009  	qm->mb_qos = 0;
3bbf0783636be8 Kai Ye 2021-06-11  4010  
3bbf0783636be8 Kai Ye 2021-06-11  4011  	/* vf ping pf to get function qos */
3bbf0783636be8 Kai Ye 2021-06-11  4012  	if (qm->ops->ping_pf) {
3bbf0783636be8 Kai Ye 2021-06-11  4013  		ret = qm->ops->ping_pf(qm, QM_VF_GET_QOS);
3bbf0783636be8 Kai Ye 2021-06-11  4014  		if (ret) {
3bbf0783636be8 Kai Ye 2021-06-11  4015  			pci_err(qm->pdev, "failed to send cmd to PF to get qos!\n");
3bbf0783636be8 Kai Ye 2021-06-11  4016  			return ret;
3bbf0783636be8 Kai Ye 2021-06-11  4017  		}
3bbf0783636be8 Kai Ye 2021-06-11  4018  	}
3bbf0783636be8 Kai Ye 2021-06-11  4019  
3bbf0783636be8 Kai Ye 2021-06-11  4020  	while (true) {
3bbf0783636be8 Kai Ye 2021-06-11  4021  		msleep(QM_WAIT_DST_ACK);
3bbf0783636be8 Kai Ye 2021-06-11  4022  		if (qm->mb_qos)
3bbf0783636be8 Kai Ye 2021-06-11  4023  			break;
3bbf0783636be8 Kai Ye 2021-06-11  4024  
3bbf0783636be8 Kai Ye 2021-06-11  4025  		if (++cnt > QM_MAX_VF_WAIT_COUNT) {
3bbf0783636be8 Kai Ye 2021-06-11  4026  			pci_err(qm->pdev, "PF ping VF timeout!\n");
3bbf0783636be8 Kai Ye 2021-06-11  4027  			return  -ETIMEDOUT;
3bbf0783636be8 Kai Ye 2021-06-11  4028  		}
3bbf0783636be8 Kai Ye 2021-06-11  4029  	}
3bbf0783636be8 Kai Ye 2021-06-11  4030  
3bbf0783636be8 Kai Ye 2021-06-11 @4031  	return ret;
3bbf0783636be8 Kai Ye 2021-06-11  4032  }
3bbf0783636be8 Kai Ye 2021-06-11  4033  
3bbf0783636be8 Kai Ye 2021-06-11  4034  static ssize_t qm_algqos_read(struct file *filp, char __user *buf,
3bbf0783636be8 Kai Ye 2021-06-11  4035  			       size_t count, loff_t *pos)
3bbf0783636be8 Kai Ye 2021-06-11  4036  {
3bbf0783636be8 Kai Ye 2021-06-11  4037  	struct hisi_qm *qm = filp->private_data;
3bbf0783636be8 Kai Ye 2021-06-11  4038  	char tbuf[QM_DBG_READ_LEN];
3bbf0783636be8 Kai Ye 2021-06-11  4039  	u32 qos_val, ir;
3bbf0783636be8 Kai Ye 2021-06-11  4040  	int ret;
3bbf0783636be8 Kai Ye 2021-06-11  4041  
3bbf0783636be8 Kai Ye 2021-06-11  4042  	/* Mailbox and reset cannot be operated at the same time */
3bbf0783636be8 Kai Ye 2021-06-11  4043  	if (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
3bbf0783636be8 Kai Ye 2021-06-11  4044  		pci_err(qm->pdev, "dev resetting, read alg qos failed!\n");
3bbf0783636be8 Kai Ye 2021-06-11  4045  		return  -EAGAIN;
3bbf0783636be8 Kai Ye 2021-06-11  4046  	}
3bbf0783636be8 Kai Ye 2021-06-11  4047  
3bbf0783636be8 Kai Ye 2021-06-11  4048  	if (qm->fun_type == QM_HW_PF) {
3bbf0783636be8 Kai Ye 2021-06-11  4049  		ir = qm_get_shaper_vft_qos(qm, 0);
3bbf0783636be8 Kai Ye 2021-06-11  4050  	} else {
3bbf0783636be8 Kai Ye 2021-06-11  4051  		ret = qm_vf_read_qos(qm);
3bbf0783636be8 Kai Ye 2021-06-11  4052  		if (ret)
3bbf0783636be8 Kai Ye 2021-06-11  4053  			goto err_get_status;
3bbf0783636be8 Kai Ye 2021-06-11  4054  		ir = qm->mb_qos;
3bbf0783636be8 Kai Ye 2021-06-11  4055  	}
3bbf0783636be8 Kai Ye 2021-06-11  4056  
3bbf0783636be8 Kai Ye 2021-06-11  4057  	qos_val = ir / QM_QOS_RATE;
3bbf0783636be8 Kai Ye 2021-06-11  4058  	ret = scnprintf(tbuf, QM_DBG_READ_LEN, "%u\n", qos_val);
3bbf0783636be8 Kai Ye 2021-06-11  4059  
3bbf0783636be8 Kai Ye 2021-06-11  4060  	ret =  simple_read_from_buffer(buf, count, pos, tbuf, ret);
3bbf0783636be8 Kai Ye 2021-06-11  4061  
3bbf0783636be8 Kai Ye 2021-06-11  4062  err_get_status:
3bbf0783636be8 Kai Ye 2021-06-11  4063  	clear_bit(QM_RESETTING, &qm->misc_ctl);
3bbf0783636be8 Kai Ye 2021-06-11  4064  	return ret;
3bbf0783636be8 Kai Ye 2021-06-11  4065  }
3bbf0783636be8 Kai Ye 2021-06-11  4066  
72b010dc33b959 Kai Ye 2021-06-11  4067  static ssize_t qm_qos_value_init(const char *buf, unsigned long *val)
72b010dc33b959 Kai Ye 2021-06-11  4068  {
72b010dc33b959 Kai Ye 2021-06-11  4069  	int buflen = strlen(buf);
72b010dc33b959 Kai Ye 2021-06-11  4070  	int ret, i;
72b010dc33b959 Kai Ye 2021-06-11  4071  
72b010dc33b959 Kai Ye 2021-06-11  4072  	for (i = 0; i < buflen; i++) {
72b010dc33b959 Kai Ye 2021-06-11  4073  		if (!isdigit(buf[i]))
72b010dc33b959 Kai Ye 2021-06-11  4074  			return -EINVAL;
72b010dc33b959 Kai Ye 2021-06-11  4075  	}
72b010dc33b959 Kai Ye 2021-06-11  4076  
72b010dc33b959 Kai Ye 2021-06-11  4077  	ret = sscanf(buf, "%ld", val);
72b010dc33b959 Kai Ye 2021-06-11  4078  	if (ret != QM_QOS_VAL_NUM)
72b010dc33b959 Kai Ye 2021-06-11  4079  		return -EINVAL;
72b010dc33b959 Kai Ye 2021-06-11  4080  
72b010dc33b959 Kai Ye 2021-06-11  4081  	return 0;
72b010dc33b959 Kai Ye 2021-06-11  4082  }
72b010dc33b959 Kai Ye 2021-06-11  4083  
72b010dc33b959 Kai Ye 2021-06-11  4084  static ssize_t qm_algqos_write(struct file *filp, const char __user *buf,
72b010dc33b959 Kai Ye 2021-06-11  4085  			       size_t count, loff_t *pos)
72b010dc33b959 Kai Ye 2021-06-11  4086  {
72b010dc33b959 Kai Ye 2021-06-11  4087  	struct hisi_qm *qm = filp->private_data;
72b010dc33b959 Kai Ye 2021-06-11  4088  	char tbuf[QM_DBG_READ_LEN];
72b010dc33b959 Kai Ye 2021-06-11  4089  	int tmp1, bus, device, function;
72b010dc33b959 Kai Ye 2021-06-11  4090  	char tbuf_bdf[QM_DBG_READ_LEN] = {0};
72b010dc33b959 Kai Ye 2021-06-11  4091  	char val_buf[QM_QOS_VAL_MAX_LEN] = {0};
72b010dc33b959 Kai Ye 2021-06-11  4092  	unsigned int fun_index;
72b010dc33b959 Kai Ye 2021-06-11  4093  	unsigned long val = 0;
72b010dc33b959 Kai Ye 2021-06-11  4094  	int len, ret;
72b010dc33b959 Kai Ye 2021-06-11  4095  
72b010dc33b959 Kai Ye 2021-06-11  4096  	if (qm->fun_type == QM_HW_VF)
72b010dc33b959 Kai Ye 2021-06-11  4097  		return -EINVAL;
72b010dc33b959 Kai Ye 2021-06-11  4098  
72b010dc33b959 Kai Ye 2021-06-11  4099  	/* Mailbox and reset cannot be operated at the same time */
72b010dc33b959 Kai Ye 2021-06-11  4100  	if (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
72b010dc33b959 Kai Ye 2021-06-11  4101  		pci_err(qm->pdev, "dev resetting, write alg qos failed!\n");
72b010dc33b959 Kai Ye 2021-06-11  4102  		return -EAGAIN;
72b010dc33b959 Kai Ye 2021-06-11  4103  	}
72b010dc33b959 Kai Ye 2021-06-11  4104  
72b010dc33b959 Kai Ye 2021-06-11  4105  	if (*pos != 0) {
72b010dc33b959 Kai Ye 2021-06-11  4106  		ret = 0;
72b010dc33b959 Kai Ye 2021-06-11  4107  		goto err_get_status;
72b010dc33b959 Kai Ye 2021-06-11  4108  	}
72b010dc33b959 Kai Ye 2021-06-11  4109  
72b010dc33b959 Kai Ye 2021-06-11  4110  	if (count >= QM_DBG_READ_LEN) {
72b010dc33b959 Kai Ye 2021-06-11  4111  		ret = -ENOSPC;
72b010dc33b959 Kai Ye 2021-06-11  4112  		goto err_get_status;
72b010dc33b959 Kai Ye 2021-06-11  4113  	}
72b010dc33b959 Kai Ye 2021-06-11  4114  
72b010dc33b959 Kai Ye 2021-06-11  4115  	len = simple_write_to_buffer(tbuf, QM_DBG_READ_LEN - 1, pos, buf, count);
72b010dc33b959 Kai Ye 2021-06-11  4116  	if (len < 0) {
72b010dc33b959 Kai Ye 2021-06-11  4117  		ret = len;
72b010dc33b959 Kai Ye 2021-06-11  4118  		goto err_get_status;
72b010dc33b959 Kai Ye 2021-06-11  4119  	}
72b010dc33b959 Kai Ye 2021-06-11  4120  
72b010dc33b959 Kai Ye 2021-06-11  4121  	tbuf[len] = '\0';
72b010dc33b959 Kai Ye 2021-06-11 @4122  	ret = sscanf(tbuf, "%s %s", tbuf_bdf, val_buf);
72b010dc33b959 Kai Ye 2021-06-11  4123  	if (ret != QM_QOS_PARAM_NUM) {
72b010dc33b959 Kai Ye 2021-06-11  4124  		ret = -EINVAL;
72b010dc33b959 Kai Ye 2021-06-11  4125  		goto err_get_status;
72b010dc33b959 Kai Ye 2021-06-11  4126  	}
72b010dc33b959 Kai Ye 2021-06-11  4127  
72b010dc33b959 Kai Ye 2021-06-11  4128  	ret = qm_qos_value_init(val_buf, &val);
72b010dc33b959 Kai Ye 2021-06-11  4129  	if (val == 0 || val > QM_QOS_MAX_VAL || ret) {
72b010dc33b959 Kai Ye 2021-06-11  4130  		pci_err(qm->pdev, "input qos value is error, please set 1~1000!\n");
72b010dc33b959 Kai Ye 2021-06-11  4131  		ret = -EINVAL;
72b010dc33b959 Kai Ye 2021-06-11  4132  		goto err_get_status;
72b010dc33b959 Kai Ye 2021-06-11  4133  	}
72b010dc33b959 Kai Ye 2021-06-11  4134  
72b010dc33b959 Kai Ye 2021-06-11 @4135  	ret = sscanf(tbuf_bdf, "%d:%x:%d.%d", &tmp1, &bus, &device, &function);
72b010dc33b959 Kai Ye 2021-06-11  4136  	if (ret != QM_QOS_BDF_PARAM_NUM) {
72b010dc33b959 Kai Ye 2021-06-11  4137  		pci_err(qm->pdev, "input pci bdf value is error!\n");
72b010dc33b959 Kai Ye 2021-06-11  4138  		ret = -EINVAL;
72b010dc33b959 Kai Ye 2021-06-11  4139  		goto err_get_status;
72b010dc33b959 Kai Ye 2021-06-11  4140  	}
72b010dc33b959 Kai Ye 2021-06-11  4141  
72b010dc33b959 Kai Ye 2021-06-11  4142  	fun_index = device * 8 + function;
72b010dc33b959 Kai Ye 2021-06-11  4143  
72b010dc33b959 Kai Ye 2021-06-11  4144  	ret = qm_func_shaper_enable(qm, fun_index, val);
72b010dc33b959 Kai Ye 2021-06-11  4145  	if (ret) {
72b010dc33b959 Kai Ye 2021-06-11  4146  		pci_err(qm->pdev, "failed to enable function shaper!\n");
72b010dc33b959 Kai Ye 2021-06-11  4147  		ret = -EINVAL;
72b010dc33b959 Kai Ye 2021-06-11  4148  		goto err_get_status;
72b010dc33b959 Kai Ye 2021-06-11  4149  	}
72b010dc33b959 Kai Ye 2021-06-11  4150  
72b010dc33b959 Kai Ye 2021-06-11  4151  	ret =  count;
72b010dc33b959 Kai Ye 2021-06-11  4152  
72b010dc33b959 Kai Ye 2021-06-11  4153  err_get_status:
72b010dc33b959 Kai Ye 2021-06-11  4154  	clear_bit(QM_RESETTING, &qm->misc_ctl);
72b010dc33b959 Kai Ye 2021-06-11  4155  	return ret;
72b010dc33b959 Kai Ye 2021-06-11  4156  }
72b010dc33b959 Kai Ye 2021-06-11  4157  

:::::: The code at line 4135 was first introduced by commit
:::::: 72b010dc33b9598883bc84d40b0a9d07c16f5e39 crypto: hisilicon/qm - supports writing QoS int the host

:::::: TO: Kai Ye <yekai13@huawei.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
