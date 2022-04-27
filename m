Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA4511608
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiD0LWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiD0LWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:22:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB32F3AB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651058380; x=1682594380;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=bkeRCcZwT59nqDeoEiIxTZeS9TI5zISxzRCG0NQSDn0=;
  b=LdxIz/jRt1Rh1O5sdAsJZQ/WQo8LY4vKoG3sykL7VGTZ3hz0ouLOy9CC
   CwCc9xilaau4fnHIXzcWMaTnvFhFxmUupQsZ4CKOByTcqzEZpTWdc5yJd
   3BUddqVPZUVZVGPNlROfkxriqXdBZMWRLB9+4MLnlaPsbJtiWllzPrcap
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 04:19:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 04:19:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 04:19:39 -0700
Received: from kvalo10 (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 04:19:36 -0700
From:   Kalle Valo <quic_kvalo@quicinc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
CC:     <kbuild@lists.01.org>, <lkp@intel.com>, <kbuild-all@lists.01.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>
Subject: Re: [ammarfaizi2-block:kvalo/ath/pending 36/40]
 drivers/net/wireless/ath/ath11k/mac.c:8293
 ath11k_mac_op_set_bios_sar_specs() warn: variable dereferenced before
 check 'sar' (see line 8280)
References: <202204182315.h96VPgso-lkp@intel.com>
Date:   Wed, 27 Apr 2022 14:19:34 +0300
In-Reply-To: <202204182315.h96VPgso-lkp@intel.com> (Dan Carpenter's message of
        "Fri, 22 Apr 2022 17:37:33 +0300")
Message-ID: <o5hy1zqhiyh.fsf@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ ath11k list

Dan Carpenter <dan.carpenter@oracle.com> writes:

> tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
> head:   c9a8efc35304a89fc0751649945909caf03eeb29
> commit: 5ad5b356e75f402fec930cf0d77b6c7862850b55 [36/40] ath11k: Add support for SAR
> config: x86_64-randconfig-m001-20220418 (https://download.01.org/0day-ci/archive/20220418/202204182315.h96VPgso-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> New smatch warnings:
> drivers/net/wireless/ath/ath11k/mac.c:8293 ath11k_mac_op_set_bios_sar_specs() warn: variable dereferenced before check 'sar' (see line 8280)
>
> vim +/sar +8293 drivers/net/wireless/ath/ath11k/mac.c
>
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8276  static int ath11k_mac_op_set_bios_sar_specs(struct ieee80211_hw *hw,
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8277  					    const struct cfg80211_sar_specs *sar)
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8278  {
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8279  	struct ath11k *ar = hw->priv;
> 5ad5b356e75f40 Baochen Qiang 2022-04-12 @8280  	const struct cfg80211_sar_sub_specs *sspec = sar->sub_specs;
>                                                                                              ^^^^^^^^^^^^^^
> Dereference
>
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8281  	int ret, index;
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8282  	u8 *sar_tbl;
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8283  	u32 i;
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8284  
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8285  	mutex_lock(&ar->conf_mutex);
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8286  
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8287  	if (!test_bit(WMI_TLV_SERVICE_BIOS_SAR_SUPPORT, ar->ab->wmi_ab.svc_map) ||
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8288  	    !ar->ab->hw_params.bios_sar_capa) {
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8289  		ret = -EOPNOTSUPP;
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8290  		goto exit;
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8291  	}
> 5ad5b356e75f40 Baochen Qiang 2022-04-12  8292  
> 5ad5b356e75f40 Baochen Qiang 2022-04-12 @8293  	if (!sar || sar->type != NL80211_SAR_TYPE_POWER ||
>                                                      ^^^
> Checked too late

Baochen, please submit a fix for this.
