Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B384FC3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349041AbiDKSGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349037AbiDKSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:06:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828511FCF7;
        Mon, 11 Apr 2022 11:04:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 432CDB80CAF;
        Mon, 11 Apr 2022 18:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F07AC385A3;
        Mon, 11 Apr 2022 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649700261;
        bh=mEtcO+luL+M3MFSDWidwlLniHaY0sogkYUV/bgSCS6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=febxVfGC1uZxrOXZD8gaO6VngV1he/m8F53duvNrhcH9XvdYR1J76jEHeG+zWyNeF
         B3gL49CkYKWcYR+RS+xsBrrkaV5YWRAEp3NSYKw1WWedLc47i4axfb6Ky10awPHFXS
         VCRubFB3mWmkH1vdymqVjI0CB5oQuC6nqqFxMZn8+d2D0z55njQj0mRuND0Qbfd+vW
         yu6VTmDxwKQlhS063xQFWrNkg6zi5Jrh1wNzSGTvlfAkDz/fGQN83OKS0BQlmg6sH7
         Vab5HzjIDDNhr/LIm5B5+1LgI6VQ4tvvuPwISHbmTeJsQ+9NmC5MUljN+7WQxie8xV
         huDLqgMdLHIOw==
Date:   Mon, 11 Apr 2022 23:34:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,qmp: Add SM6350 UFS PHY
 bindings
Message-ID: <YlRtn6RhVQ7+oeep@matsya>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-3-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321133318.99406-3-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-22, 14:33, Luca Weiss wrote:
> Document the compatible string for the UFS PHY found in SM6350.

Applied, thanks
-- 
~Vinod
