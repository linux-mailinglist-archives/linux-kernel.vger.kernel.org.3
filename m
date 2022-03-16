Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D704DAEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348274AbiCPLjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiCPLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:39:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CC246179
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647430705; x=1678966705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CA7ohyySipfkOmxuHDSFEb5ZzJ4yO/s6nSLzC1xdF0A=;
  b=LwXLasTybGsEQuj4G2P0S6HDlINjtYSg3F5egYPanJfNB4ErafV2QnME
   NDiAudPc+/eFjYmW/yY97iO+ND1VEbgiIUYQ0IzIfA0Zd3PkLn8GKgP9f
   v/uM36xrhsB7uNLt80juWQp1FVkOln6kYGI2bNBNpHqDBZKxg5HOjNR20
   d1hTUqx3Tlp+mXqXA2MieJ+i3bIefk2Fm+Z5GpSZ1YY0E1siEn9B9s3ss
   5S22qc+OdLXdkMP+9eGvATQInZ4KavRu6wjczfNl/XkIulqQNSehRqytQ
   oFcivm6HaD52Z8quSfvee09u+fmz6QkTw4UDaP98gBz607cAeig391xjN
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="194417921"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 19:38:23 +0800
IronPort-SDR: akjR/Ao+gDp5mrgRPekj5UTULhLCc9SWR85nGEcPW/lZtIs5JxJgsbNpYDfmoULucN0ubw530I
 Qjf9JYDAdr4b9qNSNNUAbqPXpWYf6YG5iG0Vj1fdFNgY72iP+VaWOJp4QNgap+bUQOQIRYy2PT
 La8yfmh3RHqEEvhW5sAtLALPBxOx+vYNQoGwbaUM+grmJlSd89XmTcSfeG7OFH2seBkbYhuOdd
 +66MqmlnAF8DiGWsODn0gFE2ERrG884RC6viMRG7cwRfG6T53SYgqL06WKLN5XaHe3wEp0majI
 pMswgXyyCe95hohFQOwCZP0a
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:09:30 -0700
IronPort-SDR: +FDwBTTamdWSEUTYltsCbtowpUzWOkAVw+xDeWskzEWUfYdSYQ8W/+4YPlawfF66Tb3Ilq5y2x
 7YWMviVfX2bdP+W9tUKA1N55PEs+C3cIDRPMCsRdjjHLa+vsoXCjtM2LtCpDeqI+5XfsjaccU1
 bHV2AuJdPry7G6szZeT+/Z2Wqlk8WvPD3oQjZKVCg2djox8ZgtnW5rlkT4Cwqj+769bO1rPZYq
 +jeNG0YiWmViZqar3F+kpQe/3xS3zRPct4zuMXu41p7PnEdWu8XpVgl3cprAwBVRCzZvzF3Gs7
 vRo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:38:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJSvg3Xcbz1Rwrw
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:38:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647430702; x=1650022703; bh=CA7ohyySipfkOmxuHDSFEb5ZzJ4yO/s6nSL
        zC1xdF0A=; b=qTUcGQpmuiedPgvfI2epiNTd4Vxd8yFRi0U/caaeTz+sc3CulvZ
        vY7MZJIkeu4A8zd2P9eys+5PZ9B1pyoLep6CGZTEkUSwc0+voujqiFmnVN5lkmrz
        zBk3hk/1RIJKfcpxUimlJax3vmBEiOUoqxwCxNbEgtsobBLQgp237WWutb+0lnfu
        bR1knAHJwhEGLIYFDEW/a9XVtgdMgYYak4i/EtiWX80DWtx4K6Uc7g1XoUKxrfV+
        vwq16noUTf1ZUuKE3lnaYhSzTIhgtB9GEHyxph9WqsU1JAAN0oSEJk7l29Kybj2E
        8JKy8MAkhZAZ2MLKNJFsFLEaUT2Qp0X9xdg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IsIl4wcQ7Pbm for <linux-kernel@vger.kernel.org>;
        Wed, 16 Mar 2022 04:38:22 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJSvc3tj9z1Rvlx;
        Wed, 16 Mar 2022 04:38:20 -0700 (PDT)
Message-ID: <9768fa36-27ed-834f-0462-3b79fd8b3478@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 20:38:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] scsi: core: Fix sbitmap depth in
 scsi_realloc_sdev_budget_map()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        bvanassche@acm.org, martin.wilck@suse.com, ming.lei@redhat.com,
        hch@lst.de, hare@suse.de
References: <1647423870-143867-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1647423870-143867-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 18:44, John Garry wrote:
> In commit edb854a3680b ("scsi: core: Reallocate device's budget map on
> queue depth change"), the sbitmap for the device budget map may be
> reallocated after the slave device depth is configured.
> 
> When the sbitmap is reallocated we use the result from
> scsi_device_max_queue_depth() for the sbitmap size, but don't resize to
> match the actual device queue depth.
> 
> Fix by resizing the sbitmap after reallocating the budget sbitmap. We do
> this instead of init'ing the sbitmap to the device queue depth as the user
> may want to change the queue depth later via sysfs or other.
> 
> Fixes: edb854a3680b ("scsi: core: Reallocate device's budget map on queue depth change")
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
> Changes since v1 (apart from sending as a separate patch):
> - Add fixes and RB tag (thanks)
> - mention in commit message why we don't init sbitmap at queue depth
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index f4e6c68ac99e..2ef78083f1ef 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -223,6 +223,8 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
>  	int ret;
>  	struct sbitmap sb_backup;
>  
> +	depth = min_t(unsigned int, depth, scsi_device_max_queue_depth(sdev));
> +
>  	/*
>  	 * realloc if new shift is calculated, which is caused by setting
>  	 * up one new default queue depth after calling ->slave_configure
> @@ -245,6 +247,9 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
>  				scsi_device_max_queue_depth(sdev),
>  				new_shift, GFP_KERNEL,
>  				sdev->request_queue->node, false, true);
> +	if (!ret)
> +		sbitmap_resize(&sdev->budget_map, depth);
> +
>  	if (need_free) {
>  		if (ret)
>  			sdev->budget_map = sb_backup;

Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
