Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD0485130
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiAEKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:34:34 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:14621 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230353AbiAEKed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:34:33 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTQpK0l7Sz1VSkb
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:34:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641378872; x=1643970873; bh=JZC4MUm/DP7FUwD82iZHpaKpnoe4eAqjaHZ
        TgJ6MJYc=; b=oCWGdeWecbfoKk+TNjKZCQbGJaI5+LEJE+hY53kzXNIP/lOvpYn
        sF+a46ykVqepyKOdJPrLTYDIxBmCXnSD0L1AfCs+8/cnLQuTQ82amRpY7djBHfvX
        GFh3W73A3Btgf/HSp5F3XpDytwRMlToF1D/EpzM1pZP/50QQFVqJjzB3FPMuQDzw
        zkmexcZFtKU99jsEKfnjhrhQEEijbHfLW4u+Hje9gctxczSRidrwWqUJ8fhczaJE
        L6BythS2feTAzDKjLC+iNCBwWBgvhH0hsyAiDYm5/tfQlC9SJxEHTLaLlUONsjJC
        neyt6Hbu5lyWC1lhSYI1LJatYb7AlO6F5jQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vo5h26MwPD58 for <linux-kernel@vger.kernel.org>;
        Wed,  5 Jan 2022 02:34:32 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTQpJ0pKHz1VSkV;
        Wed,  5 Jan 2022 02:34:31 -0800 (PST)
Message-ID: <c3b0e649-54b0-bc8d-f744-d411c06cba0f@opensource.wdc.com>
Date:   Wed, 5 Jan 2022 19:34:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: linux-next: Signed-off-by missing for commits in the libata tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220105205702.557f492a@canb.auug.org.au>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220105205702.557f492a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 18:57, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   b3a1ea642b5f ("ata: sata_dwc_460ex: drop DEBUG_NCQ")
>   8fb32f1d555c ("ata: libata: tracepoints for bus-master DMA")
> 
> are missing a Signed-off-by from their committers.
> 

My bad. Sorry about that.
Fixed now.

-- 
Damien Le Moal
Western Digital Research
