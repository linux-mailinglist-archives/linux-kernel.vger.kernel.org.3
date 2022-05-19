Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62A852C864
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiESAJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiESAJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:09:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947C149DAB;
        Wed, 18 May 2022 17:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2079B61795;
        Thu, 19 May 2022 00:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60622C385A9;
        Thu, 19 May 2022 00:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652918966;
        bh=VHN4Xys86O3wVft4a4gvIAece6uh7eNQPyResqeGr7g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Czrj3X+e3/Ull3Z0Pm/FAlOS8gRRLWJz6D6xc/8FsKxfuen5bh6zT3ExRCgd0adiq
         O6ncDTZtZqk2r7Cv7AicotVFv0ZJNVxaVSMylVECkv0YCTpP50Wf1rBzIScSgcoCFC
         GyKHB3DIrBhb678UFCAlaQxyVkYgMsotL0ANg7rTHQ0Zj/6R1dtPj1xJnLgwoOu9dQ
         65d+Ti4WHJ+biO0A4RA6FKUXSkIQ5vGuGBbwlAonEFnXBp+O/NfAE/HqerUNWTkD4O
         t9TBqbq0jGZ/dWUegMKtVURaATLzyCc+1SKT2M2T27dXp5hUlvO11hxcG/K/74+2dC
         CU/vBT9b4qWHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220501103520.111561-5-krzysztof.kozlowski@linaro.org>
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org> <20220501103520.111561-5-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 5/8] rpmsg: qcom: glink: remove unused name
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Date:   Wed, 18 May 2022 17:09:24 -0700
User-Agent: alot/0.10
Message-Id: <20220519000926.60622C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-05-01 03:35:17)
> The qcom_glink.name is read from DTS but never used further, never
> referenced, so drop it.  This also fixes kerneldoc warning:
>=20
>   drivers/rpmsg/qcom_glink_native.c:125:
>     warning: Function parameter or member 'name' not described in 'qcom_g=
link'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
