Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223AD5A9BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiIAPaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbiIAPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:30:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56752A3;
        Thu,  1 Sep 2022 08:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3C40B827F0;
        Thu,  1 Sep 2022 15:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127C8C433D7;
        Thu,  1 Sep 2022 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662046181;
        bh=d5ZaiJJZmZijzR8TBsyEbX8fYa3CVJ1eKnFJnVSpO6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Od20IUqztwDI02Q+39X4ol8oIB8R1bbqyYf+XcA34qxCu3+eas1X9AAl50I3CFUyT
         mNTlUZ98p9Sod8HpZgBwJyNk4L3rLh2kPfY/260RCL9JbnMPvXbzIq/ZTDyRieFSGp
         lOuSR81oIuRSHHkHMjMD8dLMeJAThPD2HbhlzZ7gLbHjHfimdogB1a04RxcL2Tvk2H
         Ry97Io8o+1JHZny/YvDAvvo2m01szH6tbVlNSrO5gT0Am/juLUsEwoVSt7sGpQBG1E
         pYnEb+vVQDRBbwbbMLwTH+MC0wTh1bkygajmsDYDpG5SYtjJX0k60l3KDhC4Pz+LGC
         akk1wYOep3G8w==
Date:   Thu, 1 Sep 2022 20:59:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Luca Weiss <luca@z3ntu.xyz>, Maxime Ripard <maxime@cerno.tech>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] dt-bindings: arm: cpus: Add kryo240 compatible
Message-ID: <YxDP4Q7ExOjzNSqS@matsya>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-12-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901072414.1923075-12-iskren.chernev@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-09-22, 10:24, Iskren Chernev wrote:
> Kryo240 is found in SM4250, the slower sibling of the SM6115.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
