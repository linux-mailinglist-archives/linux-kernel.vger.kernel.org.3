Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA85A19D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbiHYTwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242842AbiHYTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:51:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC5B249F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:51:52 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4422B3FF30
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661457110;
        bh=Q62BFbHdLMiC8G/bwUd9Yr2gMAz6rRKsbknA9dRkewI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=sD4Zh/EcJE9QaKBLL19xU1hVbqLouE6vSRT4BCfdh8sNCMARGyUo79pF69SWAUUUy
         td/i8PMfHX+mGjT7wamV+rNcZlRgv6UCpkYHbCHAAqKREP/UN7GiwjQHdkCV4PTa8Q
         NUL+tCfAaa/TwZTeoMNuQJn6AF0dwYvT8AHiWDuHPewmsLVWrzwQe0FvFkIMRZQ0Iv
         He44iwDxNu4WRPHKENkUT4iBWxNGZ34ogZ8aNdAB7Hc0HYn7LcviJVjoj+h/DxuEhc
         VTkTGBz9R+sJELUapnWl1yl55VZAM9cYhmx5YI/1edEHrratqSktZ/nw5fQ48yCLNC
         QofgkRUOwxlOQ==
Received: by mail-wm1-f69.google.com with SMTP id j3-20020a05600c1c0300b003a5e72421c2so2889926wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Q62BFbHdLMiC8G/bwUd9Yr2gMAz6rRKsbknA9dRkewI=;
        b=Sc40w1tGo4OXH8pZ/P7Tb9wmkM9RUzFB9J3meCK0ZhqvhTBD8cKVcAmIN1az+h8urn
         4BakncdYOs9xV4sod9JzzEYB6d2xX0PofKCGuoGWW7u3G75dIyGA91isTc/OdP4ya7o1
         YlV2VrbdgW+j40V7JFxu4I4hQxzJb8N8dps3aypnujDpGOL6tBg/jbJjUNZsOLrn5cSB
         TRpH9QtOwt8OZmSSQG5/lrfT7rlB9rCH/WeOBWaaAnmDRDmUepuHl1CWXVOWjRkxuWVM
         kXPcL0d5786QU+sEfCWFh1M7/t1M3AVhiixalmt3pjP50Ygk5WrMGTf9y6X/GhN+p21k
         7Zow==
X-Gm-Message-State: ACgBeo1SgELkgdDkC7mXW5IBNXCGipjXqQ5ehm+g2zIEaWopTu6p0u6a
        nfbEVH7mk4EdbLqrmjcYMwMpLa1Ix9HgcaNGyOqrwt6N+xDAZwo8YKyQKrbn0jI5rt8M4eQV3UM
        CQfqA0sAkGv04KR6FXV01mukotWPP3ivfSrWk2RjZuQ==
X-Received: by 2002:adf:e199:0:b0:225:2f90:9178 with SMTP id az25-20020adfe199000000b002252f909178mr3172735wrb.318.1661457108840;
        Thu, 25 Aug 2022 12:51:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5gPIeNGUoC6hcPYARO1uBIm6Y8DVcE9uV1yA75S5qG3Gwf33wyGXkmtIe0/KVCGk8RLOqckQ==
X-Received: by 2002:adf:e199:0:b0:225:2f90:9178 with SMTP id az25-20020adfe199000000b002252f909178mr3172728wrb.318.1661457108594;
        Thu, 25 Aug 2022 12:51:48 -0700 (PDT)
Received: from [192.168.123.94] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b0022511d35d5bsm130449wrr.12.2022.08.25.12.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 12:51:48 -0700 (PDT)
Message-ID: <18f0c833-94c6-616c-ce21-384492945240@canonical.com>
Date:   Thu, 25 Aug 2022 21:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/2] riscv: dts: microchip: use an mpfs specific l2
 compatible
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Sagar Kadam <sagar.kadam@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <mail@conchuod.ie>
References: <20220825180417.1259360-1-mail@conchuod.ie>
 <20220825180417.1259360-3-mail@conchuod.ie>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220825180417.1259360-3-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/22 20:04, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> PolarFire SoC does not have the same l2 cache controller as the fu540,
> featuring an extra interrupt. Appease the devicetree checker overlords
> by adding a PolarFire SoC specific compatible to fix the below sort of
> warnings:
> 
> mpfs-polarberry.dtb: cache-controller@2010000: interrupts: [[1], [3], [4], [2]] is too long
> 
> Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
> Fixes: 34fc9cc3aebe ("riscv: dts: microchip: correct L2 cache interrupts")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
