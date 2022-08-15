Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BEE593C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbiHOTke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245740AbiHOThs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:37:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D731368;
        Mon, 15 Aug 2022 11:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 955BB61124;
        Mon, 15 Aug 2022 18:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9B2C433D6;
        Mon, 15 Aug 2022 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660589184;
        bh=xd05IOvXbZkYJrbK//9m4SCmIjrh7J1pnQoHMdMOv2E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oqY3F37rs1pwHEALe6zFf8ndvDZABmILsEEYN2S5kzrM06BlrHZBoDErpJdKg52cr
         OtyJ8kKFRxoI2wk8XAY0Mq215EX0PjwE8A0dNsOoBhuowEHhfjvmJyGB2fMOEKCP+a
         hx3yaAl9peS/f9SJF3QOcmYl1ROjwSQ/EyXRbckwPQU8uvq2G13qKvgfrlbRdNlPVU
         TI+pEeJ3aLieY7o5gXG66CRwqV9jYISDZC1vKS6qhRnfLLKMFyEXmACUCgoemTu6Bc
         pWl85vTuSeQ1RXE7iYNh2GpoIXccvymhqle/4G3OcQTErqHzU9PFpS0tuu+UBvgu1V
         Puz20GODxIGrQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220811042855.3867774-2-bjorn.andersson@linaro.org>
References: <20220811042855.3867774-1-bjorn.andersson@linaro.org> <20220811042855.3867774-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GPU binding
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Mon, 15 Aug 2022 11:46:22 -0700
User-Agent: alot/0.10
Message-Id: <20220815184623.EC9B2C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-08-10 21:28:54)
> Add compatible for the Qualcomm SC8280XP GPU.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
