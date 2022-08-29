Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B175A582E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiH2XsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH2XrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:47:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F02A6C2C;
        Mon, 29 Aug 2022 16:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FC73B815D7;
        Mon, 29 Aug 2022 23:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A13C43470;
        Mon, 29 Aug 2022 23:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816802;
        bh=cAtzJP6mULfhyj1besIKDW4KYCtsZya/XltnSxtzGuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlKGjkIMWdl7jh8Q0MSEGJXl+r8rZraBALZ+tc+Tmbx6zs8MJdYiW6q3FrEy6+t4x
         xyP+8xbTi3s0Ozw1o8juoiXeCVD/5Oeo2/c2sUIjrf6hmvi08sB3hfKTe0dBJjUWbF
         V/c3EsBMO/IXVbclurgypSFwR5GpleVvC1iR+v6VxNf3lydOlZiwXAcVPLoRqx+L4T
         QNOJ1uCl8E7joiW41QFKkPQStCBg/uo1nbh8cyJ3DNiCeqPjHV1XSlFQsuXZeeBYcB
         F/WsrDbTKpX8XPameC13kOPhqHn+LjDfVvbsFtBI7h6AXvIxH/10mydjCcPA9lult3
         c+QUeCMUsRlrA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, luca.weiss@fairphone.com
Cc:     robh+dt@kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 5/5] arm64: dts: qcom: sm6350: Add interconnect support
Date:   Mon, 29 Aug 2022 18:46:04 -0500
Message-Id: <166181675952.322065.6438908661865226238.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220525144404.200390-6-luca.weiss@fairphone.com>
References: <20220525144404.200390-1-luca.weiss@fairphone.com> <20220525144404.200390-6-luca.weiss@fairphone.com>
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

On Wed, 25 May 2022 16:44:01 +0200, Luca Weiss wrote:
> Add all the different NoC providers that are found in SM6350 and
> populate different nodes that use the interconnect properties.
> 
> 

Applied, thanks!

[5/5] arm64: dts: qcom: sm6350: Add interconnect support
      commit: 38c5c4fe17014130dee4f85e663c5d919655801e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
