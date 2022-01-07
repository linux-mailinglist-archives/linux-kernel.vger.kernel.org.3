Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5CA48732A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 07:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiAGGlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 01:41:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56465 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiAGGlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 01:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641537684; x=1673073684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iwQYZhPpwMpxea++iPye//jg3r0vrEscM38jEzj1QnI=;
  b=CUAJNmJ6xsvWXME16lRLB79Sl3S0m0v4rJo0xsdr/bZeiWekK2BzG6ps
   sntriqmUZtr/+YJRXoj4MgAptGluoRSZwdxsTOF+kbM8PXIQuXoNsx/dR
   ALxwD0yeSKeOlHJ20EHkW31YNHEml0NAYmM341SFjjab6zbeAppASkNRL
   PfQvsWjpGzlOaVXja9lnd9ZMpz3J9PCOA4YvCNBcBUuu+6DjtU3Sb6XkE
   y0p8cfTIy/1hcDd3ygTmTnBiqTMdT+EyDuXCpitr3acyrzq9E89UGl2va
   dax7cpB5w1+qzajJiRu624oGO884tnLyXfX+ElbAgTItkO+Jj3xGyQrv5
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,268,1635177600"; 
   d="scan'208";a="194707179"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 14:41:22 +0800
IronPort-SDR: nTonICdq2F4NrecZzkC7ARB7Y3b7L68609c8i5SPOKf5eE+gj0d+uFfaqWsXoPykZUaclu2aos
 pkxPa2+wkHZDa8dlTnjLC8trvEW4zYX7gFPy3A4NA7uuGlk9VZYOQUxWYubFHtTruymirynu/h
 bMJpX9dml48oKEWrhH7LNLYzx4lM/cvS6rqsPfOugcyEap6nmmtXeonJ0JQE5Vyf/FXei1qApd
 PtQN1ScZ+qsISI6y5cw3d9+cEyyYPwkJ3U+F2U+3hbgTfmCTlALft7mL8eL32olyI54qjcDvLv
 ctQ5Lkd5czSY754JAWHkteAB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 22:15:12 -0800
IronPort-SDR: ZXyZSZF9ZMUpdltvnWMiK04zYkoGVKsKKHWd3AaPWH1UMHGfJuPTxOFcdNAwUzc++HYYyTFGCc
 CqZQcC5NSobOQSXnyzhK52u2mOaM36LXhcj+Af0RuMExGHhvCL5sdofQbw4FD7jw08utQvQe0W
 aohBSlppX5FFCZJOqF8ysdIIkVIl6bqIrLi1hPHOFj7Jg7kp+OUggY19T88KI5zCSJWNCoh3fj
 IoxvFj3i8Ow4m+kp3sEWcWzvv9buDxtHqOOpyemO6SB+fT2gha9UkckjLXPV13+JTdyjXA0OW4
 J40=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 22:41:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVYXL2QJTz1VSkY
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 22:41:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641537681; x=1644129682; bh=iwQYZhPpwMpxea++iPye//jg3r0vrEscM38
        jEzj1QnI=; b=FXUQSxx/q2w+qVeECbYZ+2vlBPqSBl2kERh4AzX+/o/B2BSFcOI
        MF9Vwl5c7wBxUXEZMps+cVBND5LdbGxAXwzkFB/scMZBYjEAeSMjiGvKHx7fTvNs
        RpT2K8bqVL9aQS898USNKwHKBl7SnhOXG/utbJLhLNgyOGZRGS3Viy+13wprSxbf
        iELxm6n55wqW5sn2kaT1ZLM2B7TJ2C3bK+GY5NVGZ0bYYV/GK9mnmcQJfBp5+FIk
        7265RomK7Ynqrs1Qnahvd2fV2tO2eYHC5rPom1PEEUfHI+K6/nu5GYAGAfnvaMOF
        yZlVWq9D7a96025Cl75fRPaZQRGU+Yvg0SA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y0A5RQPY7yRs for <linux-kernel@vger.kernel.org>;
        Thu,  6 Jan 2022 22:41:21 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVYXK27NRz1VSkV;
        Thu,  6 Jan 2022 22:41:21 -0800 (PST)
Message-ID: <bcd92fb0-8b2a-99b8-e2d3-80882b904d2a@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 15:41:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107062814.3611747-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220107062814.3611747-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/07 15:28, Jiasheng Jiang wrote:
> On Fri, Jan 07, 2022 at 01:30:35PM +0800, Damien Le Moal wrote:
>> There is no such file... What kernel is this patch against ?
> 
> Thanks, this patch is based on linux-stable-5.13.9.
> And I just notice that in Jun 16 2021, this file was removed.
> Anyway, this patch can be applied to the previous version, which still
> has the `drivers/ide/ide_platform.c`.

Kernel 5.13 is EOL. No new patches are applied to this kernel. If you need this
fixed, then please check the latest kernel first and mark the patch for
backporting (fixes + cc: stable tags) to the latest stable (5.15) and LTS
kernels (5.15, 5.10 etc).


> 
> Sincerely thanks,
> Jiang
> 


-- 
Damien Le Moal
Western Digital Research
