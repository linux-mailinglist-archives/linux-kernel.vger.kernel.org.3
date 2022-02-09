Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA674AE865
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346773AbiBIEIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbiBIDVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:21:35 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2795C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644376894; x=1675912894;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bG51Nl2Ql0sNOokMZGbhgn1+otGBW36quGu5gynwTYs=;
  b=pJ/AVO/jZ37DxoL3gu+katg9SRYl4oOfnnt1fcZUj94eqi5FrfxHj8CD
   Y4CRwnYdDM0HqdF3e82EXAA1lHcCtNDpVcpAn66S81QdQlbXfUFzdR/oT
   wGnx1qUDMfcM5X7RhrjG2O3EBDTjmJm/6gYmyNnVIGqcEyHp8b3sKXj0C
   iY/lcUr840O1T1wZYG2E1ewzQdhTdY9kSSZ57y4JWNcok5BmuEapqosIs
   x6X0B5lltBpNzFAbQRSAY5qqI3aunFptbrJb5uoc0xSsjNGV14me9yYz7
   ntOMmhSvZVXhK9Kz2RD5cOokAeUr98uKg3Apa9amyb7ZKGn+2O/NyYKmH
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,354,1635177600"; 
   d="scan'208";a="191410509"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 11:16:32 +0800
IronPort-SDR: 0NBaSTkFiR128NFAM9Qr9udOCjHmnlxfqd8m0bOnDarQpry0bcGR3jWENdNDlj+pZHchYzxNLT
 qcCTKz8+MRGiv9sybNWL5qDCF7UeK9VSKaoIZg6uPYLRGjzYV73HbIJ8LalE6qvJ8Xw3lIqmId
 U7vyw4hU/6WtP4t/aGwYGM03o/3aL4khpZnUilRypFq1M1VMv6fcipwteCVmCy/k5jJfi19729
 Jrxxa03u9PLSrjSkfZCp4hKxj9pvnEpNnqHT9R2NDXLOcrwj/phh8xCZDiyg7/yj8bAkKsVgjJ
 TddBbsoxvwQwM/PGIMEDJiaG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:49:31 -0800
IronPort-SDR: PIe0AhBgnhKf3PvlLXRN/UDPqy1V1qkLAtNGaLWrGtcriMX0+yYK0tQ6UKWwDxmpzuiKZZLtqJ
 vo2VPUpv0c5aTr36Aj5ynVJziJPHeIF0Y3e2UBXfOF1Se0JAmQWRI1IdfNyU7eCH2uT32THXpG
 BS5A8mImR0bo8X74roiFC29cRi3bsaB6grSlgar0LGZxyc0ETXGTv6q5WuqNIuT+p1aJb3nnVn
 XO12TSqAc+LQ3Ee+cPrJNo/fDcbn9MFLIZY+cr1TxYsipuUo9QmU8nCGOdFmKXOzt62AAZMbjc
 jcg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 19:16:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtlQl5zsLz1SVp3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:16:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644376591; x=1646968592; bh=bG51Nl2Ql0sNOokMZGbhgn1+otGBW36quGu
        5gynwTYs=; b=m3VC1PkiFVw9+a+cl8Pi88PT/aN/rN+M5jTPRrlPzqSu/NYiSoi
        x1u6Bf8v0MhjmzI75pNzZo0PehdxR06PfiUJmcYap7M0pXDYkUFXqVeHW02xo03p
        47z4nQUO1/qkpwnK6iFRpk8D4ueFt3MF3tdqPfw5rx4JCefQp22/Ru3kiLmPfqGe
        jMMo1e+bS5FeQNxvHyjRJY5FaD3djeM7+n6eCUwMTY7dxTim/0di7QKkYGZX/eBc
        0kHO0XFTj6elfZMls6Er8bDNyXTHs7+U8G7kdc7A2O3ArkMRTaHn+e/k9qT4fGYk
        HHcbW21/0zuEwzg6jjm7JWo1kNrHCQIPZWQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B0xoiKnsJ3pG for <linux-kernel@vger.kernel.org>;
        Tue,  8 Feb 2022 19:16:31 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtlQj448cz1Rwrw;
        Tue,  8 Feb 2022 19:16:29 -0800 (PST)
Message-ID: <0093948e-a408-61dd-3b51-524b6d112e35@opensource.wdc.com>
Date:   Wed, 9 Feb 2022 12:16:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] scsi: csiostor: replace snprintf with sysfs_emit
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, davidcomponentone@gmail.com,
        jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, bvanassche@acm.org,
        yang.guang5@zte.com.cn, jiapeng.chong@linux.alibaba.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <d711ec5a5f416204079155666d2de49d43070897.1644287527.git.yang.guang5@zte.com.cn>
 <148a5448-71f1-4f39-834b-eb9283de0bfb@opensource.wdc.com>
 <f4b63b5a4177e38dd80f102f87bbec3ea77d9fe8.camel@perches.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f4b63b5a4177e38dd80f102f87bbec3ea77d9fe8.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/09 12:12, Joe Perches wrote:
> On Wed, 2022-02-09 at 11:36 +0900, Damien Le Moal wrote:
>> On 2/9/22 09:40, davidcomponentone@gmail.com wrote:
>>> From: Yang Guang <yang.guang5@zte.com.cn>
>>>
>>> coccinelle report:
>>> ./drivers/scsi/csiostor/csio_scsi.c:1433:8-16:
>>> WARNING: use scnprintf or sprintf
>>> ./drivers/scsi/csiostor/csio_scsi.c:1369:9-17:
>>> WARNING: use scnprintf or sprintf
>>> ./drivers/scsi/csiostor/csio_scsi.c:1479:8-16:
>>> WARNING: use scnprintf or sprintf
>>>
>>> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> []
>>> diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
> []
>>> @@ -1366,9 +1366,9 @@ csio_show_hw_state(struct device *dev,
>>>  	struct csio_hw *hw = csio_lnode_to_hw(ln);
>>>  
>>>  	if (csio_is_hw_ready(hw))
>>> -		return snprintf(buf, PAGE_SIZE, "ready\n");
>>> +		return sysfs_emit(buf, "ready\n");
>>>  	else
>>> -		return snprintf(buf, PAGE_SIZE, "not ready\n");
>>> +		return sysfs_emit(buf, "not ready\n");
>>
>> While at it, you could remove the useless "else" above.
> 
> Or not.  It's fine as is.  It's just a style preference.

It is. I dislike the useless line of code in this case :)

> 
> Another style option would be to use a ?: like any of
> 
> 	return sysfs_emit(buf, "%sready\n", csio_is_hw_ready(hw) ? "" : "not ");
> or
> 	return sysfs_emit(buf, "%s\n", csio_is_hw_ready(hw) ? "ready" : "not ready");
> or
> 	return sysfs_emit(buf, csio_is_hw_ready(hw) ? "ready\n" : "not ready\n");

That is nice and can make that
	
	return sysfs_emit(buf, "%sready\n", csio_is_hw_ready(hw) ? "" : "not ");

too :)

-- 
Damien Le Moal
Western Digital Research
