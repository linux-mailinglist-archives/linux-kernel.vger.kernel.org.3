Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEBB5AF130
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiIFQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiIFQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:52:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D7D642FA;
        Tue,  6 Sep 2022 09:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53C6FB8190D;
        Tue,  6 Sep 2022 16:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36166C433C1;
        Tue,  6 Sep 2022 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662482318;
        bh=vCUupEuPLJIk7VOj19Rq2xEmHT3/AGgrx6iNgp6XLz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZybeMdfZDvVM4bXmt05uBI6BrDk0pcYDsTeb/qANtUFFJCvl+FeROEFKRhDt1dDm
         Xnm47a3tfv6DtO03n9fQo/kmU70Cm/Q0zhnPheKy6wZt/0senukTmPsmfGdqIUgLRM
         3FDPForSomLh5wPFs2l6mG1EPZo8nj7j+wxjJmydvWSeVF7y0I+J1JE9PRLce/BkVa
         QMZFIfXTtTGBk+evBaIwQyZqvbiaismPleeRWQ5DsNzK1Cc9kyPp6GWJBhv62xyGS6
         iTtYN80CCDMj/bmRQZf+Hcjjqoe7ybHqY37Z/expVlFmbkKa9d3nXOqnOmEF30m4Ve
         pX7MYbrEdp3Cg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca.weiss@fairphone.com, linux-arm-msm@vger.kernel.org
Cc:     lee@kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        sboyd@kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] mfd: qcom-spmi-pmic: Add pm7250b compatible
Date:   Tue,  6 Sep 2022 11:38:30 -0500
Message-Id: <166248229989.53237.11442388040940709437.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902111055.106814-1-luca.weiss@fairphone.com>
References: <20220902111055.106814-1-luca.weiss@fairphone.com>
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

On Fri, 2 Sep 2022 13:10:53 +0200, Luca Weiss wrote:
> Document the compatible for pm7250b that is used with e.g. sm6350.
> 
> Also while we're at it, sort the compatibles alphabetically.
> 
> 

Applied, thanks!

[2/3] arm64: dts: qcom: Add pm7250b PMIC
      commit: 11975b9b813576686653cf76e768d08484a2ddba
[3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Add pm7250b PMIC
      commit: 80f63766e52d040726ff38b46e5f569a9fecaf5f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
