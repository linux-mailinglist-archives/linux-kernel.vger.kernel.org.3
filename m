Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0554054C7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347567AbiFOLyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348157AbiFOLyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:54:06 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88164226
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655294046; x=1686830046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=80Rp0zRg6bQP1I0DMDJ0rUfrw5zWcwXRBqMQRPk4k64=;
  b=Edw9J0aRondOQi28vMXMC0LEt+dQMjP9UJdKV7PFFd1Gtiv4hFm1yQv3
   BgVl1St4Dc3/ib9ouqDPnljgEOpbA44pX2vVOU9MRVzIBl/cdiZEXjHjk
   HePmNH8VKQtJjUdt5xnWi4lH1qlN0xV0iYYEXl8ci2z6pxAxrJocmmcyy
   ruXv6JbkChnQswPg/Jzwy7Dn4JIMyhsNny98Rxn9RElVjNj4AatjW2M9C
   l2SQPFmPqEBZpL6aKLGJPwsdvgyuy0GdUov9RrBHwUDQ59YpinV8kQc/b
   PDZ7eszCsf8DtxEewfrpqFSXxMXjBOOFlf42AKYpR1qLwY7kwtCQ9WXov
   w==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="203985813"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 19:54:04 +0800
IronPort-SDR: EibKC1SpqjvzTxN1AODsueuZHGI2hAKZcDWEq3URc+uz8+Lzs74D1NAf7PpVFuLWJuAWWwptcT
 snXMX2ailfqc82+md00l1FuZRyAnWtwgc2OXftj8NBqFr5vyllvSIK7yLayAqaEYDRLR7/G2co
 ILntOBoZ5N3o3x4LeXhTbyCKwkeqWCkt33g+CFLisfVW8oPQzXPrRWQHOo79dHToaf+lxc8nRO
 orMT8LyoHiun1UHsPiCT5BEyiCG19yFLDGqTEIGX85l45xX5kZd9MeZNuIdn66yaj5dhBmsV9h
 bi4oOOayKj2YMBIwn1aIOa+M
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:16:54 -0700
IronPort-SDR: Jm1wZQyMisEkBiSelUacdx83uKyBU+omv6hMcSQGKLM6RXeLLoqAanka+PzfYEF1oEjXZ8sPsd
 LjYrOj76IU8RG7vjky4tNNY6Ubjs4cnZ4zGrcP0nPjqzLLJhJhANwHi7pkzdD4poH2OAwfkt21
 iT2yxZzBR/eNK//MfWoodFSb7ngDWezLVk3pUFRXEjvfv9eR6ng2pbbcsYwjD0GiHJzMYL5xxs
 cXhVCES8v/f+Iyyb2fFufpkBc57PAM00sM5It+6ezM3UZFMwgKgC/0DNrtP7qVccnXgeG/n29w
 M3o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:54:03 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNNxk575vz1SVpC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:54:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655294041; x=1657886042; bh=80Rp0zRg6bQP1I0DMDJ0rUfrw5zWcwXRBqM
        QRPk4k64=; b=oRC+W6gVdo0i6iv8oDtPTvW66O4PvnMzjzNAeHtj9DV+xtMFNoO
        vHU/zlPNO5e9MVo3nxodUtKSsjxQrFlLw4eYnsoNrEJLrQmRN0ZS6+uGj2rPGOyL
        hHhfknJsZ4PikEmI8829Ximb9pWPUXUEwCr8VtC4OPwbwdxwdVIVtjbmdxwdZavS
        eZmCHAuWD5VJr+GCTOgJXFgd3mBmIU37vlgCbuCG6/rfE8w0mWIvPpj3DnkcP6/d
        2aCfwPBnPwK5b07kvsPT/G5xfoXDGtEDICLCwfmr2pWIoycruimfd1gTf3r8s0KO
        GQpzoCSzZyF8xxeJym+xp39/nTJGnAizNQQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mnuo7zeaHywA for <linux-kernel@vger.kernel.org>;
        Wed, 15 Jun 2022 04:54:01 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNNxf0Tpcz1Rvlc;
        Wed, 15 Jun 2022 04:53:57 -0700 (PDT)
Message-ID: <064551fa-4575-87cb-d9da-90a34309f634@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 20:53:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 10/13] dm-table: use bdev_is_zone_start helper in
 device_area_is_invalid()
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498@eucas1p2.samsung.com>
 <20220615101920.329421-11-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615101920.329421-11-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 19:19, Pankaj Raghav wrote:
> Use bdev_is_zone_start() helper that uses generic calculation to check
> for zone alignment instead of using po2 based alignment check.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/md/dm-table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index bd539afbf..b553cdb6d 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -251,7 +251,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> -		if (start & (zone_sectors - 1)) {
> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), start)) {

This is wrong. And you are changing this to the correct test in the next
patch.

>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)start,
> @@ -268,7 +268,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  		 * devices do not end up with a smaller zone in the middle of
>  		 * the sector range.
>  		 */
> -		if (len & (zone_sectors - 1)) {
> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), len)) {
>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)len,


-- 
Damien Le Moal
Western Digital Research
