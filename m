Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8134487110
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbiAGDKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiAGDKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:10:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40156C061245;
        Thu,  6 Jan 2022 19:10:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so10640757pjd.1;
        Thu, 06 Jan 2022 19:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iY5YKhrWGtv3PVz3CqUsOeJdo+Ll0jlGjU2SO1zZ0rI=;
        b=E4EctSnN4YWAnFKv4W6RlD4QPT3glQAvsVC/85AwANR2GYi0HPGSVPMESdAGOJUmmW
         SYgWw/2y0ioZ+tNexZt4OBzhRYoA4sC6cOXsOq3DpMI2ZDx9mUFZBB5N7dZJ+w9N6Pn3
         aI8/fA/d6n2xMJbit6agt78xV/nPvkcjphu6zWC77/JDsYg0PwUHQfXMC/GqGQvOUMmW
         sNu1zXpZ+/2PyWue82jj9uIO081QiNah6bsEgIXcqQFPv51M8/WecMJofvcCI+jCciGH
         x+bPNn+ZAhJvD9HT1kmq1JWw4akFWgRhpbyIHfGisnXlTEtNi2bp64OPw2R5Grr584pW
         X9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iY5YKhrWGtv3PVz3CqUsOeJdo+Ll0jlGjU2SO1zZ0rI=;
        b=FsuncJF9oemHE35HZhf9oWAFOshQ+8UxxNW5N4XBOa2WYgnZQ/CZZn2nqwMPap2LxC
         4GRTQfpmtbSTlZ72IBhRNTiTKOFC3AMjNgWf3Wj7Z3yJdLmpGBeCB2IRzWJ7TyzteJr2
         kWvntZ6m7Qh/cmxAeO8ePZDJU2HLakYT0zSl0HrU/S/W6axwqCqBqT/yUWYLG2/LLCqS
         39/cC4PSQJOLOaSD1opKCfL1eGdloZW/M4H+3PhkwtZ0d44Fm9Wv8dbTLcGFvm/1ixn6
         nRfOoE9do+gYPmcZbTisa7z2LJW7ge4Al53g4/dz6kUD2OFcWPxubEgbxQLRB3uRzqtJ
         au9g==
X-Gm-Message-State: AOAM5308pNl3CFQueXECtL+MiFCgij5e+w65HKRGEM25euOnJT5vqw8H
        nXr2KIcw5lx9WKquMc6mSToALTJWs2U=
X-Google-Smtp-Source: ABdhPJznvRNqeW9KiMIacBGgZ9YsfjM57PB6eYRoAbWn1w65ZaA+55945j1Lf4/n/Rbym4fqyGGDBA==
X-Received: by 2002:a17:90b:4ad2:: with SMTP id mh18mr13513571pjb.197.1641525014620;
        Thu, 06 Jan 2022 19:10:14 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id np1sm7563632pjb.42.2022.01.06.19.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 19:10:14 -0800 (PST)
Message-ID: <703aeebe-3413-0e5e-80ca-4c0bcd36e3f5@gmail.com>
Date:   Thu, 6 Jan 2022 19:10:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 2/9] mtd: rawnand: brcmnand: Allow SoC to provide I/O
 operations
Content-Language: en-US
To:     linux-mtd@lists.infradead.org
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
 <20220107001328.2233896-3-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220107001328.2233896-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/2022 4:13 PM, Florian Fainelli wrote:
> Allow a brcmnand_soc instance to provide a custom set of I/O operations
> which we will require when using this driver on a BCMA bus which is not
> directly memory mapped I/O. Update the nand_{read,write}_reg accordingly
> to use the SoC operations if provided.
> 
> To minimize the penalty on other SoCs which do support standard MMIO
> accesses, we use a static key which is disabled by default and gets
> enabled if a soc implementation does provide I/O operations.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

[snip]

>   	init_completion(&ctrl->done);
>   	init_completion(&ctrl->dma_done);
>   	init_completion(&ctrl->edu_done);
> @@ -3145,6 +3169,8 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
>   		/* Enable interrupt */
>   		ctrl->soc->ctlrdy_ack(ctrl->soc);
>   		ctrl->soc->ctlrdy_set_enabled(ctrl->soc, true);
> +		if (brcmnand_soc_has_ops(soc))
> +			static_branch_enable(&brcmnand_soc_has_ops_key);

This hunk got mistakenly added with a rebase, I will wait for additional 
comments before spinning a new version.
-- 
Florian
