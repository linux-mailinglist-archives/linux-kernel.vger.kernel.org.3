Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400CE4D79ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 05:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiCNEiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 00:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiCNEiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 00:38:07 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.50.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4316B6592
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 21:36:58 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id BB60B19E0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 23:36:57 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id TcS1nx5WIdx86TcS1nvtfB; Sun, 13 Mar 2022 23:36:57 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TPMJ1EhsFnNaIQ2r4ew3lUN+ygZdnSd9hmHS3o56OHo=; b=r/H41ZX15ieWhGnDNOloEgnOv5
        CRQpcovtgeun9GkyVBYU/12GwMCTjSbyC99rFwU4HTV/+QJcZoIvo75GcyUHZ43gYLOQfVrf9PuIi
        OyxRhcfaJRJNnnt8UjG9InJFGHANH2dgvWAprJDiw3tYTgl+Qji0ohMKwx2z8XHSFj4tMJiyC1Qev
        o69URwaUIsA7P8RUVVxQmvN/Kmuayd8bsLmalPJY6+35Uli9q+msHOtvOUpgClTsDbgLRsv7aeX7z
        FpkW0SQMJ2gNH7tKtqhuhIlZ28vLka64fjCV96pafmb+eZ8ymCQelfnU4xXktoTzML1gVGd0d06Rn
        h8vSMOvg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54246)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nTcS1-001k4n-59; Mon, 14 Mar 2022 04:36:57 +0000
Message-ID: <fa8b2d9f-e5c9-73f4-3916-84e370748687@roeck-us.net>
Date:   Sun, 13 Mar 2022 21:36:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] hwmon: (pmbus/ibm-cffps) Add clear_faults debugfs
 entry
Content-Language: en-US
To:     Brandon Wyman <bjwyman@gmail.com>, Joel Stanley <joel@jms.id.au>,
        openbmc@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220311181014.3448936-1-bjwyman@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220311181014.3448936-1-bjwyman@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nTcS1-001k4n-59
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54246
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 10:10, Brandon Wyman wrote:
> Add a clear_faults write-only debugfs entry for the ibm-cffps device
> driver.
> 
> Certain IBM power supplies require clearing some latched faults in order
> to indicate that the fault has indeed been observed/noticed.
> 

That is insufficient, sorry. Please provide the affected power supplies as
well as the affected faults, and confirm that the problem still exists
in v5.17-rc6 or later kernels - or, more specifically, in any kernel which
includes commit 35f165f08950 ("hwmon: (pmbus) Clear pmbus fault/warning
bits after read").

Thanks,
Guenter

> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
> ---
> V1 -> V2: Explain why this change is needed
> 
>   drivers/hwmon/pmbus/ibm-cffps.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index e3294a1a54bb..3f02dde02a4b 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -67,6 +67,7 @@ enum {
>   	CFFPS_DEBUGFS_CCIN,
>   	CFFPS_DEBUGFS_FW,
>   	CFFPS_DEBUGFS_ON_OFF_CONFIG,
> +	CFFPS_DEBUGFS_CLEAR_FAULTS,
>   	CFFPS_DEBUGFS_NUM_ENTRIES
>   };
>   
> @@ -274,6 +275,13 @@ static ssize_t ibm_cffps_debugfs_write(struct file *file,
>   		if (rc)
>   			return rc;
>   
> +		rc = 1;
> +		break;
> +	case CFFPS_DEBUGFS_CLEAR_FAULTS:
> +		rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
> +		if (rc < 0)
> +			return rc;
> +
>   		rc = 1;
>   		break;
>   	default:
> @@ -607,6 +615,9 @@ static int ibm_cffps_probe(struct i2c_client *client)
>   	debugfs_create_file("on_off_config", 0644, ibm_cffps_dir,
>   			    &psu->debugfs_entries[CFFPS_DEBUGFS_ON_OFF_CONFIG],
>   			    &ibm_cffps_fops);
> +	debugfs_create_file("clear_faults", 0200, ibm_cffps_dir,
> +			    &psu->debugfs_entries[CFFPS_DEBUGFS_CLEAR_FAULTS],
> +			    &ibm_cffps_fops);
>   
>   	return 0;
>   }

