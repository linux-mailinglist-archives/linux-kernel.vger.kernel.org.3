Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A15572F66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiGMHm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiGMHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:42:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A0AE477A;
        Wed, 13 Jul 2022 00:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0EF24CE1DFF;
        Wed, 13 Jul 2022 07:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07023C34114;
        Wed, 13 Jul 2022 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657698140;
        bh=mHJcwUWhMboDxIfJdmt9WJ6y+0j5+D86+p+eDlzLAzY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GN09hmSRP/B7nNVf0Mq8WBcOW2iy/ywNO4lGPBWDa68dFXLauSqn0skWjsDZNhJ9Z
         LEt+LDWNkqcD2sd4M4T2qygvXGl+wnXfWiuSNeLpsPPOqQhyXQZRE1Wr+K0ayZU2mY
         o96svKncLM5hoY7AR0VBgTW8mJQDH3o3JkOrCqtwuRjtbYBFaOyAM6hfplG/OdRDVL
         4mh1r9xgQoFg2bc0HjHnL5ibYrmjXCY7kHvSsAZRXELHMN/Alh+mat9t1wMGnoex9z
         JOhYWjWyGy3EjyOxfBiNSBbuViapOuYhn041DpYlWoYuhGzAPmKlfi5I/1WP8cSh0V
         9cyu+ySS3tKqw==
Message-ID: <3190164d-dcdb-6dd8-37c8-e1bb1128ef56@kernel.org>
Date:   Wed, 13 Jul 2022 09:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] Add Samsung system manager and secure service
Content-Language: en-US
To:     dj76.yang@samsung.com,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
References: <CGME20220713045143epcms1p5483300a3cf9ed97308a1bcfe5b889a02@epcms1p5>
 <20220713045143epcms1p5483300a3cf9ed97308a1bcfe5b889a02@epcms1p5>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220713045143epcms1p5483300a3cf9ed97308a1bcfe5b889a02@epcms1p5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 06:51, Dongjin Yang wrote:
> Add Samsung System manager driver and Secure Service code.
> Samsung System manager is for SoCs produced by Samsung Foundry
> to provide system read/write request by System Manager API.
> Samsung Secure service is for SoCs produced by Samsung Foundry
> to provide secure monitor service using Trusted Foundations.
> 

1. You need to provide users of these drivers. For the
syscon-regmap-export driver (better name than manager which does not
manager anything), having a user would answer the question why such
weird driver is needed. Since there is no user and driver's behavior
breaks design choices, it has to be NAKed.

2. Thread your submissions properly. Git send email does it
automatically for you. You can use other tools, but then be sure your
patches are properly threaded. This patchset was not which makes review
more difficult than it should.

Best regards,
Krzysztof
