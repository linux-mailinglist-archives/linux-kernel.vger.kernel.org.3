Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0C5AF12C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiIFQwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiIFQwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429F2F675;
        Tue,  6 Sep 2022 09:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 854C6615C0;
        Tue,  6 Sep 2022 16:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331F6C43470;
        Tue,  6 Sep 2022 16:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662482320;
        bh=Q1/zOZVAd2cRDtKLhEQnFJz318Zh+Fj2+sJC2jnxDxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWBY7jmBcaFjWQ9y8a4aJs3c1i+Z66bN0vLVxWfeSxSQdMvZslMqn238r+/e6mCxa
         lCCxIpVgaizBf+zdUYRott0e+3R/20cJRoa6Jo7uD31At1u1H1P2vX55oU/yAUAt96
         IL3tvohSTfbhta0Rcl7y1UKjlOx2RKPhFbL+qs2Cx6CsC9rfjZjqlms5iMoNl8Evu5
         dufykMhmMublG3qy28PA+wtlpdafk16et+DnmjvAuIbgr3hElQlGtwWe1fxoWeMH4E
         nWMUxnp97Juv3DOOXVz+U3ygoo3Qn9vwboebl/zHYEZtCvm7U2jRVah2YPsDqcz03a
         OEdAFf7iiI6hQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        sheng-liang.pan@quanta.corp-partner.google.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, dianders@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Add a new board device tree named 'evoker' for herobrine variant.
Date:   Tue,  6 Sep 2022 11:38:32 -0500
Message-Id: <166248229986.53237.8738201284800222612.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902080912.118592-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20220902080912.118592-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2022 16:09:09 +0800, Sheng-Liang Pan wrote:
> This patch add the initial dts file for new board 'evoker'.
> 
> Sorry about getting mixed up with version numbers. Here are links to
> previous postings and what I'll assume the version number is:
> 
> v1: https://lore.kernel.org/r/20220830053307.3997495-1-sheng-liang.pan@quanta.corp-partner.google.com/
> v2: https://lore.kernel.org/r/20220901061336.61386-1-sheng-liang.pan@quanta.corp-partner.google.com/
> v3: https://lore.kernel.org/r/20220901091253.93333-1-sheng-liang.pan@quanta.corp-partner.google.com/
> v4: https://lore.kernel.org/r/20220902074240.117075-1-sheng-liang.pan@quanta.corp-partner.google.com/
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: document sc7280 and evoker board
      commit: 8336a4e7611950cbde287a65e91eadcf0803bc1e
[2/2] arm64: dts: qcom: sc7280: Add device tree for herobrine evoker
      commit: 2abf6b6b94290e10974bdd5f42e5ed73975f4452

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
