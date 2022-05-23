Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94208530B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiEWILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiEWILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:11:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF2BF6F;
        Mon, 23 May 2022 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653293481; x=1684829481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=22iblQjLmvajfejVT7Ta1hWWhwDRz6x7UvvPJFylOWw=;
  b=HvqywCByYlsr1lsn6o34/ERkHmr/4JhhXL/HIVyiGtzDXHsJJRJr26aT
   bryCH0J1k8SVKfjuOQHFFx1FVMB//nbjRuxUPesSRpFZfNVzElv14CkmP
   J3ZktHYY2sIDS+7PFCbhEMHPRRv4b9LDg8VeYawuSvaXFCP/Iza9+h8Cv
   yNCKV/9Jkac9Yv/KPUWo0z7jFD7vkm26S86Hz0E9w+JbUcOFw7EOS43U2
   +hQSR2Ut/4QPcW6IGDthb8fLuGv0SVK9/dlVfGeWklHI1+4sPVnhMzFxx
   JKe9Bzsft5nxXB0Perq3hlO3w+guf0zRW4le2odzu5I6IBvGmFQ2sqrvg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="272851202"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="272851202"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:15:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="600488729"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:15:22 -0700
Message-ID: <210f8557-7735-a83f-7ebb-e8e8dc612b02@intel.com>
Date:   Mon, 23 May 2022 10:15:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH V6 3/5] mmc: debugfs: Add debug fs entry for mmc driver
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        shawn.lin@rock-chips.com, yoshihiro.shimoda.uh@renesas.com,
        digetx@gmail.com, quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1652857340-6040-4-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1652857340-6040-4-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/22 10:02, Shaik Sajida Bhanu wrote:
> Add debug fs entry to query eMMC and SD card errors statistics
> 
> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/debugfs.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 3fdbc80..6aa5a60 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -223,6 +223,59 @@ static int mmc_clock_opt_set(void *data, u64 val)
>  DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>  	"%llu\n");
>  
> +static int mmc_err_stats_show(struct seq_file *file, void *data)
> +{
> +	struct mmc_host *host = (struct mmc_host *)file->private;
> +	const char *desc[MMC_ERR_MAX] = {
> +		[MMC_ERR_CMD_TIMEOUT] = "Command Timeout Occurred",
> +		[MMC_ERR_CMD_CRC] = "Command CRC Errors Occurred",
> +		[MMC_ERR_DAT_TIMEOUT] = "Data Timeout Occurred",
> +		[MMC_ERR_DAT_CRC] = "Data CRC Errors Occurred",
> +		[MMC_ERR_AUTO_CMD] = "Auto-Cmd Error Occurred",
> +		[MMC_ERR_ADMA] = "ADMA Error Occurred",
> +		[MMC_ERR_TUNING] = "Tuning Error Occurred",
> +		[MMC_ERR_CMDQ_RED] = "CMDQ RED Errors",
> +		[MMC_ERR_CMDQ_GCE] = "CMDQ GCE Errors",
> +		[MMC_ERR_CMDQ_ICCE] = "CMDQ ICCE Errors",
> +		[MMC_ERR_REQ_TIMEOUT] = "Request Timedout",
> +		[MMC_ERR_CMDQ_REQ_TIMEOUT] = "CMDQ Request Timedout",
> +		[MMC_ERR_ICE_CFG] = "ICE Config Errors",
> +		[MMC_ERR_CTRL_TIMEOUT] = "Controller Timedout errors",
> +		[MMC_ERR_UNEXPECTED_IRQ] = "Unexpected IRQ errors",
> +	};
> +	int i;
> +
> +	for (i = 0; i < MMC_ERR_MAX; i++) {
> +		if (desc[i])
> +			seq_printf(file, "# %s:\t %d\n",
> +					desc[i], host->err_stats[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mmc_err_stats_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, mmc_err_stats_show, inode->i_private);
> +}
> +
> +static ssize_t mmc_err_stats_write(struct file *filp, const char __user *ubuf,
> +				   size_t cnt, loff_t *ppos)
> +{
> +	struct mmc_host *host = filp->f_mapping->host->i_private;
> +
> +	pr_debug("%s: Resetting MMC error statistics\n", __func__);
> +	memset(host->err_stats, 0, sizeof(host->err_stats));
> +
> +	return cnt;
> +}
> +
> +static const struct file_operations mmc_err_stats_fops = {
> +	.open	= mmc_err_stats_open,
> +	.read	= seq_read,
> +	.write	= mmc_err_stats_write,
> +};
> +
>  void mmc_add_host_debugfs(struct mmc_host *host)
>  {
>  	struct dentry *root;
> @@ -236,6 +289,9 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>  	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>  				   &mmc_clock_fops);
>  
> +	debugfs_create_file("err_stats", 0600, root, host,
> +			    &mmc_err_stats_fops);
> +
>  #ifdef CONFIG_FAIL_MMC_REQUEST
>  	if (fail_request)
>  		setup_fault_attr(&fail_default_attr, fail_request);

