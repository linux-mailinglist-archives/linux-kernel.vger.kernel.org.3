Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541E147D199
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbhLVMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:23:39 -0500
Received: from ixit.cz ([94.230.151.217]:46846 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhLVMXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:23:37 -0500
Received: from [127.0.0.1] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 75D632243C;
        Wed, 22 Dec 2021 13:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640175815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKHE104nrU7+UPiwbD+7cG4P34KlnZN5bC/8w5bsAJs=;
        b=fIWCddE52AW71C8340gbNr+P/QfYOFL3LxN6q1yv2pLq8PCyLFnk0Vt9W+CH0pKSXzMkga
        O03BAaAJzSxFx3DISD0Ay2Gjlj+D6Iw1jOG7jnRqsGo+EDNRsdW2a7of37EITvhYVF06KV
        73RvCI6p6OdA452CXD+QjVeJ8z3SgWM=
Date:   Wed, 22 Dec 2021 12:23:34 +0000
From:   David Heidelberg <david@ixit.cz>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Subject: =?US-ASCII?Q?Re=3A_Question_about_node_naming_in_=5BPATCH_v3?= =?US-ASCII?Q?_13/18=5D_ARM=3A_dts=3A_qcom=3A_sdx55=3A_Add_spmi_node?=
In-Reply-To: <20211222091910.GA5159@thinkpad>
References: <HTKF4R.5S1PY4MCM4QS@ixit.cz> <20211221071219.GD26872@thinkpad> <20211222091910.GA5159@thinkpad>
Message-ID: <8AFA24D7-3378-42B6-87E2-0C4FB2ACDF95@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you=2E

I'll rename the nodes to `spmi@` then and send binding conversion=2E

David


PR is merged now=2E So you can proceed with using "spmi" node name in all =
dts=2E

Thanks,
Mani

> Thanks,
> Mani
>=20
> [1] https://github=2Ecom/devicetree-org/devicetree-specification/pull/50
>=20
> > I'm currently converting binding for
> > Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb and I'm
> > considering adding qcom,spmi into qcom,spmi-pmic-arb or just rename th=
is and
> > arch/arm64/boot/dts/qcom/msm8996=2Edtsi `qcom,spmi@` occurences to `sp=
mi@`=2E
> >=20
> > Ideas, inputs?
> >=20
> > Thank you
> > David
> >=20
> >=20
