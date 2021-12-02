Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11057465D54
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355423AbhLBEYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:24:18 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53179 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355335AbhLBEXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638418832; x=1669954832;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N8aM/Sb3HlK/fVLgx/vco0JFJ9ktzDZRzBTzIyPp2As=;
  b=rZ16zjfrIyt4wcZsCN29RxeCMoqLGtEaAbczGTTDynOUGTrG689pgVd6
   YdKBKx752MxXB70nwSMfi3RCibc8S7XUiaRxW0fq/wRmXUEAB0awLAwgT
   diJizYwawOvmvwlXbpXK1TM8ruNnjc4yzF7W2xx6sVLFIaTjQMqXEsa6C
   kKAaztroV3PNwpWNRTwQgJj7HVZwSV9EK/ChGzctLftipPBp9LeVj8zED
   iufCS4f0CKRFCB1AXImzVpXAn1bSAU2rYsIOLYkONdqRkLDZDiCR3lrDd
   LgNL8dP2fdbn1LEm+bMhQ3I7vXjWbMW9ma/wXA7COP2MXr8MR1waMQJ7v
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="187253084"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 12:19:07 +0800
IronPort-SDR: K3MxIwsOPmv04667JVttc33NmG/C4GtQMkQr8Bn0vAiGhhicjx+2ciSVVovLZi0E/H5kC7FdlW
 f9u8ZSm40bR+kMfmHqseX6pQasC4bpRH/bwGnCt1puAVu2C6saAZslYari7p6mEHjnTdQyZvak
 07wOKi2yrN+fhWJF4+wkKBkjPK7B9rs9jyUFRlG0B1U8bMPhn+/HbxGMHoZpcMlknLURmTrpMU
 skYx2hKSm/GlTV7AFfKX16tajhrAjJBc2zY1R4ulmSI16i/1G4P9tVPQYyXZrNdppfaRdR0+Ll
 1L/GcGkcPDa0h5rlUgnExeXa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 19:53:52 -0800
IronPort-SDR: K16Xg7yDtlEhwoaJhKaRAHHKAz5DDzrbjQSj4wJ+wIB8FZZqYFypAEtxtK+ZSun5ds5DzCoOQG
 FCa5Zd8FwUYLTgSSjDl1KLiyuDtnXEa4ZHUbmwmcyPCkIwlDFolZbKVJfrqu23416spBRALd5c
 uYKdzysgCkf9cNzsd0c5kJ5sr3pmzcrnklWlGR8FXK8Z4Erep56jHwBL6+++FLd305/5VbODwy
 dxtAmf2GX//Gd+wjPO38+SLj3j94bdKoyg26Jm1MD/+Et/N29gbARs2k4aU3yNvvXbEtT0gvPh
 bgo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:19:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4N4r26kHz1RtVp
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 20:19:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638418747; x=1641010748; bh=N8aM/Sb3HlK/fVLgx/vco0JFJ9ktzDZRzBT
        zIyPp2As=; b=O6KyyhgBHKfURETK18F1VWYvQ6LVnU/ltu+7Bthjx5le3b8TC1k
        qKFoPmK1A6VIkBwtavNYABvcAs8lK0m+ozO9aGmf+NaPcvR7IaXSf/NyuG848Q9T
        X5/SJuPDlWodmLbu1FiPUIWNX7QCSAq+eN9D+OeNW5jFfuqIBsJR90aztgSDbLXe
        WPbnPTgZWawknqpa0l2B880y84j6Nx4M1xcMO063Ecw5fki3e47ZCBUvvEYADzrd
        3DwGJXFMLfC7MQ3uk9RBKKaEh5iwHEKswqIhzK165fBg5yWWMtZIKYANmB7DQYVD
        fpdolJdwV2dFb7IdM/ADviMwY9e2mzGYCuQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6LKUXEnD1tq4 for <linux-kernel@vger.kernel.org>;
        Wed,  1 Dec 2021 20:19:07 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4N4q0J71z1RtVl;
        Wed,  1 Dec 2021 20:19:06 -0800 (PST)
Message-ID: <f74c3567-64ff-4bce-89f5-192a1ae9fc45@opensource.wdc.com>
Date:   Thu, 2 Dec 2021 13:19:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] ata: replace snprintf in show functions with sysfs_emit
Content-Language: en-US
To:     davidcomponentone@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <2fbce7707eff3bfebf38138899e900ee8c619931.1638155918.git.yang.guang5@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <2fbce7707eff3bfebf38138899e900ee8c619931.1638155918.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/30 9:04, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
>=20
> coccinelle report=EF=BC=9A
> ./drivers/ata/libata-sata.c:830:8-16:=20
> WARNING: use scnprintf or sprintf
>=20
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>  drivers/ata/libata-sata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 5b78e86e3459..b9c77885b872 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -827,7 +827,7 @@ static ssize_t ata_scsi_lpm_show(struct device *dev=
,
>  	if (ap->target_lpm_policy >=3D ARRAY_SIZE(ata_lpm_policy_names))
>  		return -EINVAL;
> =20
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			ata_lpm_policy_names[ap->target_lpm_policy]);
>  }
>  DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
>=20

Applied to for-5.16-fixes. Thanks !

--=20
Damien Le Moal
Western Digital Research
