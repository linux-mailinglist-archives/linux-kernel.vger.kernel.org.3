Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53295A56CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiH2WIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiH2WIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BBFA3467;
        Mon, 29 Aug 2022 15:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1973612C3;
        Mon, 29 Aug 2022 22:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4487FC433D6;
        Mon, 29 Aug 2022 22:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661810916;
        bh=NOPnv2uylXkzFypcLInNFweNcD2q+mcMBqoW/Qpoum8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JQT1oJadlGpcMEFflQ8ORMEEBKM28xQ5txr7kDRSf2CyIhx/xk2aOnZyYZmIH910n
         GH56nitn5eHpUVJ0YeGFwz3GiijNr9VdSSFbmvnlt9GlAYj7DAaAhD9uBA6Bl8shV2
         U9BoQub/46JRHs3iXucBTymPnkHqOBBhPss583cteDRZ/MuI2+UxfEZMD6G86xpw/Z
         CObtR8FBJu8xhp5SWtThKp+JCs37MWcBzkHtq7yvc1N/q+//imvGbXOmZlzoLGxlQR
         tJOwyWj8IKs9ZnyoQsZMX9wGXa5rI9h6ldEKfgvu3uNTIgUmGtx83fIqBKbdbV+Rvr
         O67mLOe5xId7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220828065123.39734-1-krzysztof.kozlowski@linaro.org>
References: <20220828065123.39734-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: add missing compatibles
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Aug 2022 15:08:34 -0700
User-Agent: alot/0.10
Message-Id: <20220829220836.4487FC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-08-27 23:51:23)
> Conversion from TXT to DT schema lost several compatibles.
>=20
> Fixes: 3f5117be9584 ("dt-bindings: mfd: convert to yaml Qualcomm SPMI PMI=
C")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Unless you want me to pick it up?
