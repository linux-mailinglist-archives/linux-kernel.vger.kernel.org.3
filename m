Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB248DDD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiAMSpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:45:44 -0500
Received: from m-r2.th.seeweb.it ([5.144.164.171]:39293 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiAMSpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:45:44 -0500
Received: from [192.168.1.101] (83.6.165.232.neoplus.adsl.tpnet.pl [83.6.165.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A613C3F398;
        Thu, 13 Jan 2022 19:45:41 +0100 (CET)
Message-ID: <796a60da-2fe5-1712-ed78-d5bb8050779c@somainline.org>
Date:   Thu, 13 Jan 2022 19:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
Content-Language: en-US
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2022 19:44, Konrad Dybcio wrote:
> While I have absolutely 0 idea why and how, running clear_bam_transaction
> when READID is issued makes the DMA totally clog up and refuse to function
> at all on mdm9607. In fact, it is so bad that all the data gets garbled
> and after a short while in the nand probe flow, the CPU decides that
> sepuku is the only option.
> 
> Removing _READID from the if condition makes it work like a charm, I can
> read data and mount partitions without a problem.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> This is totally just an observation which took me an inhumane amount of
> debug prints to find.. perhaps there's a better reason behind this, but
> I can't seem to find any answers.. Therefore, this is a BIG RFC!
> 
Somehow I didn't put RFC in the title though, sorry!

Konrad
