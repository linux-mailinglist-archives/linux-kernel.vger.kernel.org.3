Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6546451AEF8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377977AbiEDU1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377994AbiEDU04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:26:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9314F45D;
        Wed,  4 May 2022 13:23:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n10so5029073ejk.5;
        Wed, 04 May 2022 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:references:from
         :in-reply-to:content-transfer-encoding;
        bh=9J1muNG7xxQsE+IQE8kK9Xe8x16+0OIP6QRk6sSLBHA=;
        b=HEK2utQXKHjtqLbqX/vqazx+hdZwt+Mg2EADF9WqJbFE5pMaDWvvu2FF2xc+26Q687
         ecMTl3kbnmdnSaNDtLpoo66vFp/eZlI2Z2WmQK30epJ8vLQGiexgkNtz7KKiG9Lz0PYx
         KU0ZGHdSruT4oWtDPR8ByQeAhB8aKdEcAKCYTusdSGiZ0Y6gNEEe5ml+Jrn/66bLpr7h
         TAs9lprs6QHYk1Sg32LzjBeUJ0mUPVWTTrJArdq5ynzMim4OcXiTMLXrRMvF60znfTqt
         RZ9HNUibOoW453GAI24+8tVkt15XJQ6U89hfMLqj/Gy6DtyAIWNU8+EB/Gjh1b74RM4G
         d8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:references:from:in-reply-to:content-transfer-encoding;
        bh=9J1muNG7xxQsE+IQE8kK9Xe8x16+0OIP6QRk6sSLBHA=;
        b=PEwzVtMRhWYUClmaUFYeZ3orwosbRWi4VV3fRB0kd0/nJgV3vXA0WWmtjGDunsdrXW
         Fq8YjYD5hVWiSQ8bka360+QsAc9b4RgtrYB2xnn+DWHCEApHX43KVDV1+BF+ECt5k/Ze
         TO/2RkEUv6eZUXn2BkdCXYEk0lvUAHX2prCW4i4B3+vECn+qOU12a9SZELu5pOB2sxQh
         lLLqS6iLeGMFtqa38UT3dkHSnifIY2CrnTBJ+7tnNvs2r1EwFT+0DZYX0QevML9pfaBI
         o+VXl14h/OgXDH9DUTaZ2ebS5bFfrazl5uFU4/1q09rCHQc3SgPOshbOGl7ziEBAOuL7
         bY8g==
X-Gm-Message-State: AOAM530KvAKypSe5z2O9vCu96JoraJS3p3o4r28ulOwL7dkNhFdXGLLF
        ievlETXu4VRmXqOSCu9R9twMzPAzTpM=
X-Google-Smtp-Source: ABdhPJwRIRMKn8SmQQLwOuNdIe7xBc/BywkOBRX4mCM0mgbE0qRs0UsZGf3yaw4d4xA3xKs282RfJg==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr19550187ejc.243.1651695797311;
        Wed, 04 May 2022 13:23:17 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id bo9-20020a0564020b2900b0042617ba63a5sm9559652edb.47.2022.05.04.13.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 13:23:16 -0700 (PDT)
Message-ID: <f511426e-47cd-7139-baab-ff31c9be2ba3@gmail.com>
Date:   Wed, 4 May 2022 22:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [RESEND PATCH v3 0/2] Add nvmem support for dynamic partitions
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429124825.21477-1-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220429124825.21477-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.2022 14:48, Ansuel Smith wrote:
> This very small series comes to fix the very annyoing problem of
> partitions declared by parser at runtime NOT supporting nvmem cells
> definition.
> 
> The current implementation is very generic. The idea is to provide an of
> node if defined for everyone and not strictly limit this to nvmem stuff.
> But still the actual change is done only for nvmem-cells mtd. (just to
> make sure) This can totally change by removing the compatible check.
> 
> The idea here is that a user can still use these dynamic parsers
> instead of declaring a fixed-partition and also declare how nvmem-cells
> are defined for the partition.
> This live with the assumption that dynamic partition have always the
> same name and they are known. (this is the case for smem-part partition
> that would require a bootloader reflash to change and for parsers like
> cmdlinepart where the name is always the same.)
> With this assumption, it's easy to fix this problem. Just introduce a
> new partition node that will declare just these special partition.
> Mtdcore then will check if these special declaration are present and
> connect the dynamic partition with the OF node present in the dts. Nvmem
> will automagically fin the OF node and cells will be works based on the
> data provided by the parser.
> 
> The initial idea was to create a special nvmem driver with a special
> compatible where a user would declare the mtd partition name and this
> driver would search it and register the nvmem cells but that became
> difficult really fast, mtd notifier system is problematic for this kind
> of stuff. So here is the better implementation. A variant of this is
> already tested on openwrt where we have devices that use cmdlinepart.
> (that current variant have defined in the dts the exact copy of
> cmdlinepart in the fixed-partition scheme and we patched the cmdlinepart
> parser to scan this fixed-partition node (that is ignored as cmdlinepart
> have priority) and connect the dynamic partition with the dts node)
> 
> I provided an example of this in the documentation commit.
> In short it's needed to add to the partitions where the compatible parser
> is declared, a partition with just the label declared (instead of the reg).
> Then declare some nvmem-cells and it will all work at runtime.
> Mtdcore will check if a node with the same label is present and assign an
> OF node to the MTD.
> 
> I currently tested this on my device that have smem-part and the
> gmac driver use nvmem to get the mac-address. This works correctly and
> the same address is provided.

Thanks a lot for working on this.

Another case (that I need this work for) is cmdline parser. Some
partitions passed by U-Boot may require extra handling and that needs to
be described in DT.
