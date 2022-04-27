Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F27F5113C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359560AbiD0IwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbiD0IwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4FC18C2AB;
        Wed, 27 Apr 2022 01:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CE6561C4F;
        Wed, 27 Apr 2022 08:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DAFC385A7;
        Wed, 27 Apr 2022 08:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651049339;
        bh=4/pwffnz1gA5fVolKqCSmvQ8ffQV331yFy9eoDnVIZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1K9IFXCK9nUsObNGX2mup9YAMQfQFdd+Sb+5rIG0KSkFGemd3+e/8SdzUxPnWaqJ
         mcmV1n+xBZi72irt9nTcqAcuhoOPStkkGzFofdhldw0PsO8tZHycG6vQGknXCHImYH
         O5VZ94V4FnqjgpH6abhrSK3kF8P0nvPZ5G4JJQRxs9fsKj6aYyyVyxQG6MEbKz5LVe
         gIMt6O5N0nut335n8VQQuHPohtPGB8FMw0nVc74A7/8OCkKbZFW7IMpj9zFv5ADgLc
         e+apFV3aZh5fuq+ZHVasRdMoT6twHbCDuheb4u/bONNfwSQbBTQBdtRmlU2DnnLCCT
         zeFU9TwlBONQg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1njdM4-0004wv-I0; Wed, 27 Apr 2022 10:49:01 +0200
Date:   Wed, 27 Apr 2022 10:49:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] soc: qcom: rpmhpd: Add sc8280xp and sa8540p
Message-ID: <YmkDfI8HPNhDxpEv@hovoldconsulting.com>
References: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:35:05PM -0700, Bjorn Andersson wrote:
> Add compatibles and power-domain definitions for the sc8280xp and sa8540p
> platforms.
> 
> Bjorn Andersson (3):
>   dt-bindings: power: rpmpd: Add sc8280xp RPMh power-domains
>   soc: qcom: rpmhpd: Don't warn about sparse rpmhpd arrays
>   soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains

Looks good. For the series:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
