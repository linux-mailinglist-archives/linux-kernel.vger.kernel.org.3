Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE375AD624
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbiIEPTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbiIEPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:18:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AFF2496A;
        Mon,  5 Sep 2022 08:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7C3DB811E0;
        Mon,  5 Sep 2022 15:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD902C433C1;
        Mon,  5 Sep 2022 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662391115;
        bh=OYPiTnXo7bb7hJwVSPWes/+Nq+zYOTrTHyss+h6VYo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDxfRg7k2JMjGFkMn8+/LTZSQNlWWnzMBv8TiM+aZG8WfpCklOb/zYAqZM4XE+fpY
         rs2rNTcqypi/Ymx66IECFIq8P0LnEAeumaycw1PLF94hacP8yD68/JeeoptW5Lx5Vl
         57nufRRk4GhwDzlKg7oQMkrAgFpjFa1ZtYo0fvLh0XnVE5uTfTSh5+kjy7DoDp/wOY
         xqntjmtzikCy2OmKXCYmmlAohAO13PluvsZ8YxrWTYJey/1rAIgZG58iRjY3eGIGLB
         1Fwo6+Ls6SieLxlyJ4ygC8DlLJX7pxvZm78wBH1qEClQCJdIiEF/JnguTag1WzkZLm
         04sga6uQd9+uA==
Date:   Mon, 5 Sep 2022 16:18:12 +0100
From:   Lee Jones <lee@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, jic23@kernel.org,
        lars@metafoo.de, deller@gmx.de, broonie@kernel.org,
        mazziesaccount@gmail.com, andriy.shevchenko@linux.intel.com,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, szunichen@gmail.com,
        andy.shevchenko@gmail.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 04/10] dt-bindings: backlight: Add MediaTek MT6370
 backlight
Message-ID: <YxYSDSlnOELL2mPF@google.com>
References: <20220830034042.9354-2-peterwu.pub@gmail.com>
 <20220830034042.9354-5-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830034042.9354-5-peterwu.pub@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022, ChiaEn Wu wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add MT6370 backlight binding documentation.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>  .../leds/backlight/mediatek,mt6370-backlight.yaml  | 121 +++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
