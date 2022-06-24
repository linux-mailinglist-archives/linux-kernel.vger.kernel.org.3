Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FED555A1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiFXTat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:30:45 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAFA51319;
        Fri, 24 Jun 2022 12:30:44 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 56E4BE0004;
        Fri, 24 Jun 2022 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656099041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKFQojvU/Z4xJXXg9m8WeraQpHiDGSwFdVIDjpYzlrc=;
        b=ilHnaDOy/xGvBXeawsdx83QWHi87hzMkk/ldH6oGbb1G6qMetU+xhquoD8ARuso0McG85K
        vqttFHHUWT9KGzdKCvHCjho/uHEqIk7rdK4RYaesERV07h4093L/Z+2uZR4POp35kt25Zr
        BBi8+Fa8sA3TNZ/kLWGoYnZHW/d1uR0aJKu2376HwNZVPAJIJevGWIfjdv5G31jqOT664G
        rpxfK5KYmSp9HzfjTtjTd3YX+Av1aPr3bC0RiIvrmMlNEjrWPg6mAxKXmaJF/FxmrEx6gy
        KoqTb/Ss4A1YkO59RkUFZtpp/uh5w+gth9M+3CYY9T2Rj/V5s26wxOfYbc9r8A==
Date:   Fri, 24 Jun 2022 21:30:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     robh+dt@kernel.org, agross@kernel.org, a.zummo@towertech.it,
        krzysztof.kozlowski+dt@linaro.org, bjorn.andersson@linaro.org,
        quic_c_skakit@quicinc.com
Cc:     quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/2] Update the binding documents with latest mail ID
Message-ID: <165609897247.33320.6918087685461996896.b4-ty@bootlin.com>
References: <1655874639-11273-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655874639-11273-1-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 10:40:37 +0530, Satya Priya wrote:
> Satya Priya (2):
>   dt-bindings: mfd: qcom-pm8xxx: Update the maintainers section
>   dt-bindings: rtc: qcom-pm8xxx-rtc: Update the maintainers section
> 
> Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml     | 2 +-
>  Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Applied, thanks!

[2/2] dt-bindings: rtc: qcom-pm8xxx-rtc: Update the maintainers section
      commit: fa1f8e6ac455b20955f107023916eef946674cb8

Best regards,
-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
