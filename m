Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137DA461400
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbhK2LpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:45:02 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62162 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhK2LnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638185985; x=1669721985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UrCJHp+LEhvdydvmtakJJZJ0GM7ARkL5TKhWqxVUYqo=;
  b=cApzqJ7IG4LlPTTSO0MZcwFWjbZQHOjqf5RyjqGUazwCG9/ywrsJRhQl
   Q901Dw+Y5c/vDm0Mk818Ijg1j2j2VRUYz+vf0YdiQLrwIzwCEqXr42PSk
   vBQnteoJkg/XZa+4Lmn+5rLvYU1ibMsLGv1G/lkYmPHYlq7cGsb59hVHq
   mnBPu2MDBTSRjl3lQNoxa3FKrUKxcuWpluJ4yS7RzEg0NLtTAqs6VglqT
   XCpurrEZIoslzQ+GY9qWvtA5Q9tt82B1vAPc8ac5yOTUxAii70HleJq5k
   EQoO4IEDjPqujlSodcxN7zKXdYQrb70YxKO1A6Irae803239tPcaANHLn
   w==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; 
   d="scan'208";a="187958564"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 19:38:33 +0800
IronPort-SDR: yFa93Z4E+U8w8e1vdF607oPTwK5c6LFWC8thReqQTMeqVSWp6BFakkVhZkroSSPMDLe6aWaSIJ
 7KSAEJEbgAgf7uItM9j4/e5K2RA2/RAbwjADtmgRBaYy95rR93oqJPY58mVqRL7RBRCJkEcQut
 o1I3mSFiMmWdPNuhyVdg8icmGky553Gy3goCTAsRDyBLwitnbLKdkyvE7Q0lOJvprKzMBalztc
 Yj3LYt7pahj4zr3FSVJuzTBA40lHmzVTNeSgBCkziAdlrmvZXdyKQ7IbAMoIUf1L60bveJNMnj
 c24Yl3AQiZMBgIAatdBh3lsi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:13:20 -0800
IronPort-SDR: 1VBAk0aAjXWR0/mZGaGF0+8zgLX/hosyAVc2fHorNg6BZRkrZa69Y3Magbl789L5opX/6ECAmn
 dfvcJRXQElMSwTeExavxeZM6xOtTT613AuKriEhlEaa6M+RzV0rUoTHkNDMAD6wv5OSADYflUS
 PeAlpU4V8vfH3iIzx5h9eQjoXNn8vBF+s5YcfHWG8pHjJOPEw72WKuVzFlUOqPMm20t4JKsrRU
 Qwd+Cem4zeCDn3Aci9vifvBueO+zS15Ea8NUXsXWrUrnT3jicBqBbWY56VgbeKk7P1GXjmbvzd
 oZk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:38:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2jzF2SMQz1RtVp
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 03:38:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638185912; x=1640777913; bh=UrCJHp+LEhvdydvmtakJJZJ0GM7ARkL5TKh
        WqxVUYqo=; b=KwTIanqv6eWjvdpk1apEJlKuA/D0/ycTFy2CqDoY15v2ilAVkcU
        Ir0hVNO0AaOr0vbEfrSI9KosDYhMg0s9espOlq/poL6P91J6ZewbAz9A+fLtgqdR
        mBCqkPrXoUNfXk7JcteaqPm/qI1gBWBpQmmmDduaLTUpRKY8bzB23PU8NhoRfqYf
        fqB5pEtKzteZZxaso+3g50jRaqd7uEWCvTeRtxPF8eMrfPwu3IjUd/yQfLgfSQje
        yDEzOGvmSn4w+bDgxGLNzl74vC7phO/4EFXJTHnIlgAZ6gNHhXCqKkahJSdnC1vk
        oMZh3uEfBxRg+2AzCHGFsl/m9TweV5c5/pQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UAyYlcjFtkx2 for <linux-kernel@vger.kernel.org>;
        Mon, 29 Nov 2021 03:38:32 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2jzD0Q9hz1RtVl;
        Mon, 29 Nov 2021 03:38:31 -0800 (PST)
Message-ID: <6cbcabe8-029b-9c3d-a503-afe4293f9dbc@opensource.wdc.com>
Date:   Mon, 29 Nov 2021 20:38:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2] pata_falcon: Avoid type warnings from sparse
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8f6a78cf7b60160ef3d22445ee1b8f2c0678f74b.1637879659.git.fthain@linux-m68k.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <8f6a78cf7b60160ef3d22445ee1b8f2c0678f74b.1637879659.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/26 7:34, Finn Thain wrote:
> The zero day bot reported some sparse complaints in pata_falcon.c. E.g.
> 
> drivers/ata/pata_falcon.c:58:41: warning: cast removes address space '__iomem' of expression
> drivers/ata/pata_falcon.c:58:41: warning: incorrect type in argument 1 (different address spaces)
> drivers/ata/pata_falcon.c:58:41:    expected unsigned short volatile [noderef] [usertype] __iomem *port
> drivers/ata/pata_falcon.c:58:41:    got unsigned short [usertype] *
> 
> The same thing shows up in 8 places, all told. Avoid this by removing
> unnecessary type casts.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Applied to for-5.16-fixes. Thanks.


-- 
Damien Le Moal
Western Digital Research
