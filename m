Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D733532265
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiEXFTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiEXFTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:19:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15CE7938B;
        Mon, 23 May 2022 22:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653369584; x=1684905584;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y70m4zoFMo/2xMKYhPGTkP2g/JnmhAQgI6QzWYKSkZE=;
  b=GE4u9oMXWLxUFAshU6Vx5HQY1Yf7oJrLjdY3NKC5CIBUX4joWTxJ+oxV
   fMTVjbf3OqYU/8gPxdm4HLtB9OVTDST94ZLrn21OFjut/BiTAfPDm3yc4
   pV6/pCm1AS88owEMw4P3ExzrlEjVs5Plk2+seh8h2eLRVvQT1rFjXSC/8
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 May 2022 22:19:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 22:19:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 22:19:43 -0700
Received: from [10.216.49.5] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 22:19:36 -0700
Message-ID: <c0217be0-2c69-8dcb-45c4-a8bd47063da0@quicinc.com>
Date:   Tue, 24 May 2022 10:49:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V6 4/5] mmc: debugfs: Add debug fs error state entry for
 mmc driver
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <wsa+renesas@sang-engineering.com>, <shawn.lin@rock-chips.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <digetx@gmail.com>,
        <quic_asutoshd@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sartgarg@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sayalil@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1652857340-6040-5-git-send-email-quic_c_sbhanu@quicinc.com>
 <79590e32-5505-7a0c-81b4-0efd5c8f156f@intel.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <79590e32-5505-7a0c-81b4-0efd5c8f156f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Thanks for the review.

Please find the inline comments.

Thanks,

Sajida

On 5/23/2022 12:45 PM, Adrian Hunter wrote:
> On 18/05/22 10:02, Shaik Sajida Bhanu wrote:
>> Add debug fs entry error state to query eMMC and SD card errors statistics.
>> If any errors occurred in eMMC and SD card driver level then
>> err_state value will be set to 1.
>>
>> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
>> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Could use debugfs_create_file_unsafe() (see below)
>
> Otherwise:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Sure Thank you
>
>> ---
>>   drivers/mmc/core/debugfs.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index 6aa5a60..3c7908d 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -223,6 +223,27 @@ static int mmc_clock_opt_set(void *data, u64 val)
>>   DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>>   	"%llu\n");
>>   
>> +static int mmc_err_state_get(void *data, u64 *val)
>> +{
>> +	struct mmc_host *host = data;
>> +	int i;
>> +
>> +	if (!host)
>> +		return -EINVAL;
>> +
>> +	*val = 0;
>> +	for (i = 0; i < MMC_ERR_MAX; i++) {
>> +		if (host->err_stats[i]) {
>> +			*val = 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +DEFINE_DEBUGFS_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
>> +
>>   static int mmc_err_stats_show(struct seq_file *file, void *data)
>>   {
>>   	struct mmc_host *host = (struct mmc_host *)file->private;
>> @@ -289,6 +310,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>>   	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>>   				   &mmc_clock_fops);
>>   
>> +	debugfs_create_file("err_state", 0600, root, host,
>> +			    &mmc_err_state);
> This could use debugfs_create_file_unsafe()
Sure
>
>>   	debugfs_create_file("err_stats", 0600, root, host,
>>   			    &mmc_err_stats_fops);
>>   
