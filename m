Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2D55FF49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiF2MMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiF2MMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:12:33 -0400
X-Greylist: delayed 241 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 05:12:32 PDT
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E2B3B3F9;
        Wed, 29 Jun 2022 05:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656504731; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=PGK/k9DeAdxOtwaTL/Ud+3uQ4Q+GGYlfiEYU7tvaIdpH0HgYd18h/U4BPUy2a1X/BTvVX+0Re+6i0KL8M+mptABBTC9TAKqGIEa88fdcxgSVd82I+693RbzLHKmur39aNxfYu5LBNu922V+EkH5cP9FGvnee6CObGNPVMwYPksQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1656504731; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=7Nlg+/A/2lG7nPrwCN9OcJJY+B+CLo/eWqxjs4IwRvk=; 
        b=bLWrd8ZFSymnFvnBMogKwxmaM2t90gywSpTObFBzNgJlHdmUOqSc1srfQkKZA5nEHuHkc/ssjNXcxVuS59QaWr9DXToMvQ565+mPPhApYS1YwHFdAMdpM8ziz9KEY15TrZp6F4FCpK5PQM52jiLYAa+4+Ky18kGSDkOJ2W475no=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656504731;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=7Nlg+/A/2lG7nPrwCN9OcJJY+B+CLo/eWqxjs4IwRvk=;
        b=SO/kyUlNlVYkl9JJB8ag+o5yHnDYD5i65OTv9i3S/z2DTnU5wCe6nAsOrlXV8Mlq
        J2tHohR+IX4gQWKvIgKjPiXUkUDNVTQg6xAuLaW/Z3XZLRQJuhGl7KHVonRv0L5qHPe
        d6L/blNyZCKH+dL14HyDzVRYooB3QlxJugCC4dMU=
Received: from [10.10.10.122] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1656504730341712.7546788738672; Wed, 29 Jun 2022 05:12:10 -0700 (PDT)
Message-ID: <e20a43f7-ed3e-83ef-a863-43cb11535ec2@arinc9.com>
Date:   Wed, 29 Jun 2022 15:12:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] MIPS: dts: align gpio-key node names with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
 <20220624170740.66271-2-krzysztof.kozlowski@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20220624170740.66271-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2022 20:07, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Cheers.
Arınç
