Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A770A4981E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiAXOSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:18:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231918AbiAXOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:18:04 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OEHnCh029695;
        Mon, 24 Jan 2022 14:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Et8yW9+F6AaKtARe4eqmqYMpsRnk2elsWakDt31EXUU=;
 b=mLRlvzsDp0T8kr9EwsEq2Zbu1gbS/P8TdfXhzZ+4AV0n1oyZ9ZcdOuQz9ZKL75I2YP36
 Nd5LxqM5cRNDbF6PSCOBV6hY9HAKJt6AMGrC5IJWYGnubRF8Zg3T3l0YuRKSsuruGBY0
 O6D/Vitv/PcXiLKblVAH3+wXtJrmY3MDDL18bsq1PJIYkZ2rYdwtZP7NIJ3z5tSy5ale
 lVYe3UvpIm0D+CEeDW3KYHivoRihtUtbyxZBMBxco028jvzUioyeinSWRTEXY8SzfA+R
 INoMTkeK3pV05HugRYb+6Ji2fUtazBcI+tKuMoHtY9SjNLIhS/Z5mNGfcMI6NlXfEIfC FA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dswqxr0x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 14:17:57 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20OEDPq9021439;
        Mon, 24 Jan 2022 14:17:55 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3dr9j9xdgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 14:17:55 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20OEHs5222020370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 14:17:54 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4480928072;
        Mon, 24 Jan 2022 14:17:54 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 309AF2806A;
        Mon, 24 Jan 2022 14:17:53 +0000 (GMT)
Received: from [9.163.14.245] (unknown [9.163.14.245])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jan 2022 14:17:52 +0000 (GMT)
Message-ID: <44deb918-2527-7fcd-29de-f09534b0837b@linux.ibm.com>
Date:   Mon, 24 Jan 2022 08:17:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/2] fsi: sbefifo: Use specified value of start of
 response timeout
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220121053816.82253-1-joel@jms.id.au>
 <20220121053816.82253-2-joel@jms.id.au>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220121053816.82253-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6wXcJlmuqa451MELYp93D8eNXCzJbOmZ
X-Proofpoint-ORIG-GUID: 6wXcJlmuqa451MELYp93D8eNXCzJbOmZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_07,2022-01-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/20/22 23:38, Joel Stanley wrote:
> From: Amitay Isaacs <amitay@ozlabs.org>
>
> For some of the chip-ops where sbe needs to collect trace information,
> sbe can take a long time (>30s) to respond.  Currently these chip-ops
> will timeout as the start of response timeout defaults to 10s.
>
> Instead of default value, use specified value.  The require timeout
> value will be set using ioctl.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   drivers/fsi/fsi-sbefifo.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 52328adef643..1e9b326e8f67 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -125,6 +125,7 @@ struct sbefifo {
>   	bool			dead;
>   	bool			async_ffdc;
>   	bool			timed_out;
> +	u32			timeout_start_rsp_ms;
>   };
>   
>   struct sbefifo_user {
> @@ -549,7 +550,7 @@ static int sbefifo_read_response(struct sbefifo *sbefifo, struct iov_iter *respo
>   
>   	dev_vdbg(dev, "reading response, buflen = %zd\n", iov_iter_count(response));
>   
> -	timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_START_RSP);
> +	timeout = msecs_to_jiffies(sbefifo->timeout_start_rsp_ms);
>   	for (;;) {
>   		/* Grab FIFO status (this will handle parity errors) */
>   		rc = sbefifo_wait(sbefifo, false, &status, timeout);
> @@ -972,6 +973,7 @@ static int sbefifo_probe(struct device *dev)
>   	sbefifo->fsi_dev = fsi_dev;
>   	dev_set_drvdata(dev, sbefifo);
>   	mutex_init(&sbefifo->lock);
> +	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
>   
>   	/*
>   	 * Try cleaning up the FIFO. If this fails, we still register the
