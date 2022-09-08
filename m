Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64FD5B1A14
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIHKgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C5799B7D;
        Thu,  8 Sep 2022 03:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AACEF61C50;
        Thu,  8 Sep 2022 10:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A8FC433D6;
        Thu,  8 Sep 2022 10:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662633374;
        bh=DcnqZRnwLXuCJ325syeXI+k0aeFY+oaFwD/58GLiR+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GD7d0+xBkLfoSXdhm5qwtn56WCIC+BZZvw66xPZLmLzrzJdaS624JndynNyyxyou7
         jCImtE0r+d1zHATxQlI1/PLHH98LRWpn77FXG/JaigZ/cyE6/SX1hWXkuk0Dul4q7n
         YdxHnsO5kOOsLUBAcvXBN/oS3nbOfj7TyrlKCcwvFbH/Zkoxqe4DyFVOQjkvIY0DfY
         HyE7kCCkPcy/TqE/A/ynp+Y9kaDdKNbM1pDg/6ZKJBvF9Go0Kl3GT3lsznE887NiGb
         VC8lNUTKCvXqCPFqNJ6oD96ByvlbAfgwh0eXfbCauL1Xka4odD7d6T6NemtzFjMym2
         y0cOSnTBDjUJQ==
Date:   Thu, 8 Sep 2022 11:36:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: qcom-spmi-pmic: Add pm7250b compatible
Message-ID: <YxnFl8qZ2sj/n7sq@google.com>
References: <20220902111055.106814-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902111055.106814-1-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Sep 2022, Luca Weiss wrote:

> Document the compatible for pm7250b that is used with e.g. sm6350.
> 
> Also while we're at it, sort the compatibles alphabetically.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
