Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF848A40F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345780AbiAJX6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:58:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56048 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242630AbiAJX6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641859099; x=1673395099;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vjU4XCqmIM5l4vO0SUmreGGleE6WeT5PamKl8gATroY=;
  b=bNgqnExlGwk9YvcOShGSym7vCsPVVsKye6MjcjW47TRhvDKSOtE/9zmn
   0yt49SjZ3Qc12nVscPXIiPxEBz5HZYEk4/44y4KNWMKqysGXsMn12sFP7
   MVdtwX///uC3a4TorUxJqsawP23wHxV67nxDw48OfhTbs55Sn1COzjetn
   JbM6/AoTug0nQuncAP8zZmSftDqDJ+OgcezDvFxZMQYUSt71mgCa9UaGT
   hxsVtnjZZJjEqCQdq4/VEibFqm20iiLohbR3HsDxu5/Nxb/svAe0zv5YL
   E2umeAxA2v1PnU+4Aeb2kDVmCylv7zAdIcEtpUlvSsXyzVZCuNKs1Jje+
   A==;
X-IronPort-AV: E=Sophos;i="5.88,278,1635177600"; 
   d="scan'208";a="294186829"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2022 07:58:18 +0800
IronPort-SDR: JbIvHmVC/do0ygU3Yq8IX8X46ABz2nr/e6vRVTT5Wqxrcyb1RJFv50+bYrwyPTP8okg69u8BmI
 LfR+ONFp4oW5Tx9xnSrdVcY54Kb6T44544M/v6qEwBLfgvCknnVcTllIEOpAazH3l88yn7fjrr
 KEWSIzsa/Zn1EJ4tBiyMipVjN9jUJ0OKtZ5lzxRvKPUK4U5l4TxhQN5Fozoq3leQR+tLYDbcJm
 w4Rj7zwqY4boHX0PenEnqA1iRBqImiZDqjNQz47prM1vGxBqD4FfrzGoHHCsJCNMVYY6MWICKE
 WxIBy8pQ2rDwfGD+R8xcPLnF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 15:32:02 -0800
IronPort-SDR: bqgn9pOLOtMCnXPtaIAthvfI6MILj0bu5dI8PJkfiQTOa/fjwcGq8F661LFSCpyTsdkLVSocY3
 ec7ZAcG6nwYmNC6uDYel5HygDDEgm6Rn9jrhowpYJPve5q5GNO+XhpLxSpKewfHLT8SoUQ9gzF
 EH/6voITHafDWkpJ7sz5gXEfGGWufmuaeBcrGbkFkY08w0YSx7pL/NGaAfkHlf7LN8U80VMrx2
 wzIdGFUVQBHbkMP884Se0hmP3jLCiEkQJ2ek6jOM4qHkkb5vJJI9zczMXVoHZSSn95sXOrT1SR
 Oe4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 15:58:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JXrPQ4jHwz1VSkW
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:58:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641859098; x=1644451099; bh=vjU4XCqmIM5l4vO0SUmreGGleE6WeT5PamK
        l8gATroY=; b=FxhFRZpp7aUNSlOU4neNWZHpWgJWiGnbK1PftJabSDwodDzQQs7
        yrPIJ5pGCa53Sd1ckqeVfRu6uIfFh9h0759qIhOVE8RjOICXlw6QBSob3fbwbFJV
        TnNKTJCRdFLuVDcS8PU1EWZdZNQAfT8vSzGq7eVOwXxrsd+iayP4SpJuSQiuWA6E
        L4kuIMIIi37Hh7NmN2VPGArjaKamMYVh1a1No3tbW2vObCEfe37iqO10vxMShH5x
        5PnnAGpAjbdDFvSLRSOdWsp4lP5BT51bLQj5RG747g5maF0EOnEBCQO5h4Lnyf0k
        Ne10Mv9oNW/YaUnAmwqoYrC+jwb9F/OFQog==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cpgpOMPJ8bFM for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jan 2022 15:58:18 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JXrPN6g3Bz1VSkV;
        Mon, 10 Jan 2022 15:58:16 -0800 (PST)
Message-ID: <4419b25f-dd71-9c14-5de2-4425f9367e29@opensource.wdc.com>
Date:   Tue, 11 Jan 2022 08:58:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5] ata: pata_of_platform: Use platform_get_irq_optional()
 to get the interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105181721.13087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220105181721.13087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 03:17, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
> 
> Note the code does not set the IRQ flags as this is handled automatically
> for DT.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> This patch is part of series [1]. I'll re-visit merging of pata_of_platform
> into pata_platform at later point. As my primary focus is removal of static
> setup of IRQ resource from DT core code.
> 
> [1] https://patchwork.ozlabs.org/project/linux-ide/list/?series=278349
> 
> v4->v5
> * Set end member of IRQ resource
> * Clear irq_res un-conditionally.
> 
> Cheers,
> Prabhakar

Applied to for-5.17. Thanks !


-- 
Damien Le Moal
Western Digital Research
