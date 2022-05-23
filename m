Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5544531B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiEWTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiEWTwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:52:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E2860052
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:52:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so237896pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vJ/7h+gtdAcH6lg5046ozHJXlKfDaJ+7rqIOW4j5rFs=;
        b=lTQCZCv5SjCSpZkO1elU8OQ5aWFQCrQkHtVcF9TDFzMsnqBFg7KzqJyiNaKPcKbRJj
         i90imZ0Whn93Tu8MftddRbbWIGE4Z51y2k7ektQtHftyO4NCDzN8TCKYp6v4huEfqPiP
         9EULlaFtpqTC5St9isyzpphnuuSOM7iPCBf+hZQdU/kF892Rd5g3H41PsxboienPw/+L
         eQH9HkzV9iG5aCuHhZYSTJreYTOaKCjlfaxF3j2t6Pi5o2S41dP4XVx8pIyTds/M1Hzn
         Sth5UH14P0IyZENuN5FAyQcocPp/wYtTbxP4sf5o+PgAQBR3okXLoeYO/K8CMJlOpwKV
         ONDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vJ/7h+gtdAcH6lg5046ozHJXlKfDaJ+7rqIOW4j5rFs=;
        b=axcR6C+MmuiWDvA+8c5L9FNLUMZzg4XfwbjglpuYBeveTFl9j3w84UlZAA8u3xWfD8
         K9udnwoeD8ylaXtRWVoESaJiRJBpMyDCEPpGv0/Xlnqg+ksw/z0qf22KyHvmBUXrMYHk
         fE/Wk46uJzrZZOlYJMK25I+GPnMdAKksyGocA/ZXUSYgsj39T1yr3Xq8T4XJxiIsL3Wj
         5NZJeP52U9QA6s0HNu7Di4j8Glo/gsISBxW1lGLCmpNHBi4VrZWLmc3S8ws42fdoSjpg
         dNoPdgw2++jP01uLkP6kqqJXPKNp/tSNACFJ5pHCbfu/2bAvMhcBJDMvwSnqnchD3b2R
         7KhQ==
X-Gm-Message-State: AOAM530q8700wmKlLtR6Ns/uzlJmTZb0oAo2pe+V4fYf+dQtWrNF27uk
        eestkJp3WSZEJvo30VbpZsHW0A==
X-Google-Smtp-Source: ABdhPJze5JLlUhh4DOxqmNYacegzQnT4dWAyORP1w+YfXIZRr1SHeDENWbQ94DWlMydgQBSrwKF7xw==
X-Received: by 2002:a17:903:25c5:b0:162:e9f:4e6d with SMTP id jc5-20020a17090325c500b001620e9f4e6dmr11457165plb.60.1653335556517;
        Mon, 23 May 2022 12:52:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i12-20020a65484c000000b003fa5855ad66sm2314836pgs.64.2022.05.23.12.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:52:35 -0700 (PDT)
Date:   Mon, 23 May 2022 12:52:35 -0700 (PDT)
X-Google-Original-Date: Mon, 23 May 2022 12:52:31 PDT (-0700)
Subject:     Re: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock drivers
In-Reply-To: <875112a6-7328-a40d-bc78-bff4e7d14aa0@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Daire.McNamara@microchip.com, Lewis.Hanly@microchip.com,
        Cyril.Jean@microchip.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor.Dooley@microchip.com, Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-9bccd0ce-6754-49d4-bf6d-5a83b2226b5d@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 04:42:53 PDT (-0700), Conor.Dooley@microchip.com wrote:
> On 05/05/2022 11:55, Conor Dooley wrote:
>> Hardware random, PCI and clock drivers for the PolarFire SoC have been
>> upstreamed but are not covered by the MAINTAINERS entry, so add them.
>> Daire is the author of the clock & PCI drivers, so add him as a
>> maintainer in place of Lewis.
>> 
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey Palmer,
> I know youre busy etc but just a reminder :)

Sorry, I didn't realize this was aimed at the RISC-V tree.  I'm fine 
taking it, but it seems like these should have gone in along with the 
drivers.

Arnd: maybe this is really an SOC tree sort of thing?  No big deal 
either way on my end, just let me know.

> Thanks,
> Conor.
> 
>> ---
>>   MAINTAINERS | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fd768d43e048..d7602658b0a5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16939,12 +16939,15 @@ N:	riscv
>>   K:	riscv
>>   
>>   RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
>> -M:	Lewis Hanly <lewis.hanly@microchip.com>
>>   M:	Conor Dooley <conor.dooley@microchip.com>
>> +M:	Daire McNamara <daire.mcnamara@microchip.com>
>>   L:	linux-riscv@lists.infradead.org
>>   S:	Supported
>>   F:	arch/riscv/boot/dts/microchip/
>> +F:	drivers/char/hw_random/mpfs-rng.c
>> +F:	drivers/clk/microchip/clk-mpfs.c
>>   F:	drivers/mailbox/mailbox-mpfs.c
>> +F:	drivers/pci/controller/pcie-microchip-host.c
>>   F:	drivers/soc/microchip/
>>   F:	include/soc/microchip/mpfs.h
>>   
> 
