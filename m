Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC169562B38
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiGAGIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiGAGI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:08:29 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27F612ACF;
        Thu, 30 Jun 2022 23:08:26 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4LZ4WS4bkVz9sSW;
        Fri,  1 Jul 2022 08:08:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1656655700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApVaQ0+81CkJu3JOr6ozmZ5VOG1Au9PWb++lawJbq8c=;
        b=AkuP/0hAHrQ+30wDcGwGcc7q+zkgNsp7snOmpWfaVuTRYZU0cRCZdWL9TR2VaUZ0AiY2Ln
        ksbikUObPuU/HLJ7CnNyDWFeCasPcn5SY5MaAovjwkR92QonydDXf15HEigCEAuJJ/ras2
        grxouwE4AVOr8RBhCtuiu2MYiCPDex5JVFQpFnhprTdXPEhVl8TCm3oap5oz55JzPFNe3J
        EAbZZ0YPnm1IYXsLraVf9h8AfkSkvmzMCRhFTlW+QfH3FU17oEVjTwk1MkGalx0xeIWlCO
        VPNeq44Ow2Q6pII8ih/UwzrzFfYtqnW174iE5JeZXrpOJv8eDRVBQQLgjxIv9w==
Message-ID: <8c771e3a76ba1c41bbd955aeabe06a5f70abcece.camel@dylanvanassche.be>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: Add a few LPG LEDs
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Jul 2022 08:08:18 +0200
In-Reply-To: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
References: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4LZ4WS4bkVz9sSW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-04 at 19:27 -0700, Bjorn Andersson wrote:
> Now that the LPG binding is accepted, sprinkle some lpg definitions
> in various
> PMIC files and define the LPG attached LEDs for RB3 and db820c.
>=20
> Bjorn Andersson (4):
> =C2=A0 arm64: dts: qcom: Add LPG to pm8916, pm8994, pmi8994 and pmi8998
> =C2=A0 arm64: dts: qcom: sdm845: Enable user LEDs on DB845c
> =C2=A0 arm64: dts: qcom: pmi8994: Define MPP block
> =C2=A0 arm64: dts: qcom: db820c: Add user LEDs
>=20
> =C2=A0arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 56
> +++++++++++++++++++++
> =C2=A0arch/arm64/boot/dts/qcom/pm8916.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 8 +++
> =C2=A0arch/arm64/boot/dts/qcom/pm8994.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 10 ++++
> =C2=A0arch/arm64/boot/dts/qcom/pmi8994.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 20 ++++++++
> =C2=A0arch/arm64/boot/dts/qcom/pmi8998.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 11 +++-
> =C2=A0arch/arm64/boot/dts/qcom/sdm845-db845c.dts=C2=A0 | 31 ++++++++++++
> =C2=A06 files changed, 135 insertions(+), 1 deletion(-)
>=20

Changes look good to me, I applied similar changes here:
https://patchwork.kernel.org/project/linux-arm-msm/patch/20220512054439.139=
71-1-me@dylanvanassche.be/

Reviewed-by: Dylan Van Assche <me@dylanvanassche.be>

Thanks!
Dylan
