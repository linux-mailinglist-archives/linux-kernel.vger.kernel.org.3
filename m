Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4573A461401
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbhK2LpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:45:20 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:6190 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242121AbhK2LnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638186001; x=1669722001;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iOMJ4dvNQK4Me/uwxnZ2mPnknSGekZgo0zSNRQ430XE=;
  b=p8OKJ/5WpgSIOC7ucRHKPi2GuxHJWb50AmziEtPDJ+QqikCZs4jkKVCZ
   AkDMaLcbQvFks0HJJO/DobL69sCMEM8pvW3CDQ88vVU850UXIAFk9gya7
   9BQVbUStHblL0NV8QMapEWmmHTe1+wv1DIx9fi/2023DvXbsN/s72emlT
   Sxk9mR0H5OY0QBEKWeCUcnm56RWuLYyP7Sur/hiZOH6+BLslpkzqMulGZ
   zpZH0hKdxX9/IKWSISYAev4VSr4gwGk3XRB8MneScuJW+QUKQI/vPs6Hi
   o3AFdVrUCD9aCd1sdho3Xe3PC+pxUtO7faxPTquwb0kgQolj916m8CaQr
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; 
   d="scan'208";a="185939069"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 19:38:53 +0800
IronPort-SDR: oF6mgyngffUfARwM4j4wqihhMLhL3IZqKIViM/edeHiRIiqzfBfv8gc3RwHql2gTI3q7DK+F/6
 tCbhp0BeTHyojH6OTJt9VtMQ1pBJFZvdRYPzYkpD+wv74OugXe7Fz6A2JYGiV2JwtlVco6wWeB
 p2UDcyBjthH+KiAj64yF/z8pVHeVPyN2PaiQpVUGDxuGsBo165ZeLNxlETFqfT2nIEJAIN72kp
 vZGG8RaOr2DxI72Smv2I0JXXKC/ey/7ywA/iTtYYn4ZoaChtKhhX4Qu7/fpaFybxKhEX4H4/Wm
 8oKYB4lf9uJJu6fiTx+BrRgs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:13:39 -0800
IronPort-SDR: 4L/hEJqyoHQgP3qUj3xYe6Z4OospeSimSOEk0b8KudgRLnC0VON0+ex6s5oFiWOwlROpJL92O4
 DTPnvRddEIhVnQSm9bhZz0ZsJW5th3w4i4sH6rwuoGhu+4oijKMDtXnBDckHO/KFQz0kXi9yfX
 O2+BoTjm9Il08eoqxFbmTTuVbElwGPfzwzPVoz7kcFLGLDpBQpeQIXpErlMjtLjKaMziYJglG+
 qE2PFx3djVpxymbDBaIh5JsJPtsBAiBN7/IpJCm5w2khj2R/OuU2VjPFSr0IAwfysPq7Jm/4hT
 XaQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:38:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2jzd0QrQz1RtVm
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 03:38:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638185932; x=1640777933; bh=iOMJ4dvNQK4Me/uwxnZ2mPnknSGekZgo0zS
        NRQ430XE=; b=eXllMQj7+o7eiG2MFQWT9vq2TFiKCGeBy1QqiSSSP4oyZf/jwaf
        gDoA60oDGPQkIzTBWh0X3N3s6wp6w9N0Mc1zAHZcligxgNue/oBatvErSy02riMo
        yJzzE3liwC6I7Ekx7bM6Cp+vOObZBlfxkpWOYmhPZfVNivM1Bouzu0Y3/GkvbJnC
        RNtobIlQ7HTwxQWbX8t48Y+mIGXKzc/9dO9mQ3VOER5DV33jrn7MRIOpk1r8WKP9
        BsGpj721NlwSKF+iOJwHkbBMg9lOlmxKcqsN8X8fjpMnlc+7UnX72hYXGzGU+mQK
        pnZIkYJogkjZx74qLJhT9fFXJPeV9rHu8XA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T0s1W9KL-We7 for <linux-kernel@vger.kernel.org>;
        Mon, 29 Nov 2021 03:38:52 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2jzb3ndhz1RtVl;
        Mon, 29 Nov 2021 03:38:51 -0800 (PST)
Message-ID: <32ed5d27-e0ea-5926-c7ed-766936024991@opensource.wdc.com>
Date:   Mon, 29 Nov 2021 20:38:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH -next V5 0/2] fix two bugs when trying rmmod sata_fsl
Content-Language: en-US
To:     Baokun Li <libaokun1@huawei.com>, axboe@kernel.dk, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, yebin10@huawei.com, yukuai3@huawei.com
References: <20211126020307.2168767-1-libaokun1@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211126020307.2168767-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/26 11:03, Baokun Li wrote:
> V1->V2:
> 	Fixed the check on the return value of platform_get_irq().
> 	And propagate errors up to sata_fsl_probe()'s callers.
> V2->V3:
> 	Add fixed and CC stable and modified the patch description.
> V3->V4:
> 	Use a single structure.
> V4->V5:
> 	Delete duplicate dev_err() message.
> 
> Baokun Li (2):
>   sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
>   sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl
> 
>  drivers/ata/sata_fsl.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 

Applied to for-5.16-fixes. Thanks.


-- 
Damien Le Moal
Western Digital Research
