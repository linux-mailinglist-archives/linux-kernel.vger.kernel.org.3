Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1B0486E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbiAFX6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:58:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22262 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245708AbiAFX6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641513531; x=1673049531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9xMY2yFLzGFLi8nN0g+LXyKu1GEpgXGH1m9JNKmPhiY=;
  b=XQf9gHm45KsscVO9fke7/AgRpyoZpTXb6v8SFfE8OvsigAxSMXOEVKIv
   Hzg9EOqzYunZWzn7aptmWJDrqntK98hkrA/kZaBG2f5hq35uXsr6B9BHE
   anFpy8KUj7Ilf6E7RwggR6qhVJrEimzvDTiTmBwJlj2toZ5uzfxz0Tw0G
   OCQ38k99nkOjdExgv0JE3ng7YJjSM+JuWr2pblPHaikdkOhYloculnLS1
   pJHzwVcq7JsW4K5UGZ+ke03xDkP1/jIUSG86YhW9z0Dy7YgP6RDiCNcD5
   FBXMC2fAd+Line0YGJTVZ8mLoQ5hCBFqim5SVm/XXnsFcEzj28Ka+KBbt
   A==;
X-IronPort-AV: E=Sophos;i="5.88,268,1635177600"; 
   d="scan'208";a="188847751"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 07:58:51 +0800
IronPort-SDR: cnkNsdZUwijOp2OqVMrjbxKtlDaY7+TYuqEGLnGL69VdxirqDR9UjUW2IqqU+0AMQud00sVtHr
 z9OZoKtlP73J9tUuKWOzAj31noW0CTLCBxTmFyCaOdNVG8TcVkgzeOLhG1BTvAU6QcafGDgtOP
 jDvkgxagYT3gYTdrnA8puZFctY3Nu6e3/y1FSZ6ogXgXBywujEfKl9hbBB+CVn53tfLojsfxRB
 RnFgJE3T4+gogXt1yY5swFLZZ3FZjEKggR4ywdXIXaDBf6H8boevu2lWhqx/BKDbbOWIrwqh0e
 M6Idc0KKvD80/ZVC634S0Er0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:32:40 -0800
IronPort-SDR: myLHss7rUNUm2HTmnKX66xRTA4KEPyfq5NJO9jBKiSCzbHjJylxStKC6jgRFFybr6gCdJOEgrI
 MkI4sKDndWg50CHsAIhNkfZyf5rDQF1xJI9mX577tmFYHmp1zMazPl3sgO0jELbM6a3lFzY1Bd
 3CNta3R47LP9l2MrI5RJ0vRp8SWOTaJs2nNStVh14aM/goEbGawqLN9QYMXvQM18N06/D68oRW
 Gj3XgcvNt5z6xDdcVOclCGexFt51zOGuV3qf6+XqhTi11MxHWnQHBkunHzubGStULI00cWbWcS
 1sk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:58:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVNbv0X3Vz1VSkX
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:58:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641513530; x=1644105531; bh=9xMY2yFLzGFLi8nN0g+LXyKu1GEpgXGH1m9
        JNKmPhiY=; b=XkTfkiFzTrw0IN8SMHxu6Xl1qCRN8FKIoLN/S+SZdcbC4D6KYeI
        sOTgWNRBLQTjibUPsuZ0r2leFYFomhn4DElO2v3g+7mR2VBpxioV9tCW8Zr1WSvt
        h2SOu6ldN0550WgHOQuK+VIZ0zwcHkkHbwckSYmwMOVNUkz1o5Lf6zbxZ9ovy6Vj
        Zo1ANEq2u8ZWWCqmMKUOuE8KvBVSdgMl6ElFe4PV0QztQvTER40tOZrBvrMJ2UlO
        aGkD5VLxGas2ZDd/PMFGyNIIyWuS65oKRIpnL8BomcA49Z6PSPMlowqhgCiz7Wwc
        JF38C0yQAzAJzJ64XQI3RsTsitY3KtniIdQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u-gc2zYgaH6v for <linux-kernel@vger.kernel.org>;
        Thu,  6 Jan 2022 15:58:50 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVNbs55DRz1VSkV;
        Thu,  6 Jan 2022 15:58:49 -0800 (PST)
Message-ID: <92b2ca94-6a72-7ec5-6a0f-d45f776f7a74@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 08:58:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: linux-next: build failure after merge of the libata tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220107010832.42c93c30@canb.auug.org.au>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220107010832.42c93c30@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/06 23:08, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the libata tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/ata/pata_cs5535.c:26:10: fatal error: asm/msr.h: No such file or directory
>    26 | #include <asm/msr.h>
>       |          ^~~~~~~~~~~
> 
> Caused by commit
> 
>   39d0a5fc445a ("ata: pata_cs5535: add compile test support")
> 
> I have reverted that commit for today.
> 

I fixed that yesterday afternoon my time (Japan), so before your morning in the
US (assuming you are based there).

-- 
Damien Le Moal
Western Digital Research
