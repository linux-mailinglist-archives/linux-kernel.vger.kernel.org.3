Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34594F7E23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbiDGLkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiDGLk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B36D5F8E7;
        Thu,  7 Apr 2022 04:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF7061E11;
        Thu,  7 Apr 2022 11:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D5DC385A0;
        Thu,  7 Apr 2022 11:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649331509;
        bh=TG0yL4INQRkSWREccn9ae6NDvDoCcJKDi8COYvkgGgs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SfmDwz9CXnvV6mzu9+3DgBV3o1t++mInJYjqeuJHR3/Umq6H1EoMXZ+FNSmPsF9/O
         mQyOlBoV3xMDMnDjEQU/hV0Bv+1VzYKxXgTOEmWlQEz4ZBhD5kKv8hB09FyntYt9Gd
         ifxHmsDKvK3OYyfLlak9t7NcEOcZr24W/M9cT9giJj+S97IaHCnWAQbF8aGuGWCIlu
         ry7NTvnvfnUMFs4WYK2ijfiJyxWIrZyXb6PO/4zBkYKQVrA3pfALJyzsbbC5rLcZiT
         zBWRsp1iFME84R5kXgMW3IOQ3G6q9aZxQ/MU4sxTNDR8n9Ih/TDOFbEseGwKB28/SY
         n2LOxe/zNPKMw==
Message-ID: <78ddc1a6-4597-46b7-76f0-32087ed62546@kernel.org>
Date:   Thu, 7 Apr 2022 13:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: qcom: Add sc7180-gelarshie
Content-Language: en-US
To:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220406094156.3191-1-chenxiangrui@huaqin.corp-partner.google.com>
 <Yk21MbGKVi8d9cAy@google.com>
 <CA+Bnokw-8023cvifSZtT8WR4TvUi8K3512TmEoXhKezMjbQNUQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CA+Bnokw-8023cvifSZtT8WR4TvUi8K3512TmEoXhKezMjbQNUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 10:15, Mars Chen wrote:
> Hi Matthias,
> I had removed camera related files on upstream device trees.
> 
> Hi Krzysztof,
> The v2 patch just addressed the v1 patch comment and I had sent the v2
> patch. 
> 

Hi,

I do not see it being addressed at all. :(

Best regards,
Krzysztof
