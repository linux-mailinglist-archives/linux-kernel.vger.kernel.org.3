Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5BE57F0EE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiGWSRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 14:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiGWSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 14:17:53 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811271A83B;
        Sat, 23 Jul 2022 11:17:52 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DB69ACC0D2;
        Sat, 23 Jul 2022 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1658600271; bh=2jhfnHv7ekLvE3WA3KaTePWLN8RBAto8i4LxYZykOPQ=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=sPPqHX+kyx/BmSNvXqKKQyu0luv5o0PP492R+NVHv29q6T53xX6Zb3MRq3iN9FaaE
         FZe+qTvSIPz1D5oRRqOHuRptcjf/FdZbWvuJCVunJoZZSnyBzYeieHGBjSgllXKMDi
         IZ52z+hYZiADEauhFhUQn/2+xb/t3zumMN8L+xlo=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 3/3] ARM: qcom_defconfig: order items with savedefconfig
Date:   Sat, 23 Jul 2022 20:17:50 +0200
Message-ID: <2246145.ElGaqSPkdT@g550jk>
In-Reply-To: <2a865367-47b2-ccde-869e-942252a08c5c@linaro.org>
References: <20220721155356.248319-1-krzysztof.kozlowski@linaro.org> <12020386.O9o76ZdvQC@g550jk> <2a865367-47b2-ccde-869e-942252a08c5c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 23. Juli 2022 19:36:17 CEST Krzysztof Kozlowski wrote:
> On 23/07/2022 11:58, Luca Weiss wrote:
> > See also
> > https://lore.kernel.org/linux-arm-msm/20191104210943.101393-1-luca@z3ntu.x
> > yz/ (never applied for some reason)
> 
> Mentioned patch is incorrect so should not be applied - it removes at
> least TMPFS which is not desired. I did not check other removed symbols.

For this example: TMPFS is still enabled after this, it's selected by other 
options, like DRM or COMMON_CLK.

Imo not doing this just hides the brokeness as options wouldn't get selected 
anyways when you do "make qcom_defconfig". Savedefconfig afterwards just puts 
reality into the defconfig file. And yes, if some option gets lost then some 
dependency for it probably needs to get enabled as well and this should get 
fixed.

Regards
Luca

> 
> 
> Best regards,
> Krzysztof




