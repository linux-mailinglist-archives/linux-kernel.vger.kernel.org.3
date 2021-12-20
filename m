Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2230C47B459
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhLTU12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:27:28 -0500
Received: from ixit.cz ([94.230.151.217]:44040 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhLTU10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:27:26 -0500
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id ABC1824CCF;
        Mon, 20 Dec 2021 21:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640032044; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=ORC/JrBSePSE25uEIZUJV7aCzD+oFqZmh5cxvl76U5A=;
        b=nunPWPnPnvmycJrvEebRbbSuImtpTURN50NkxB/xrDzSZ/OQq7g1aFS3XnWPfq9WjiXBWl
        648R9cHVTxGUEkzJG399uEuyI6fCgBEc8Xmdl9cJM0huzbhJWZdLFEnHSPs0YnREmpVORd
        HLwWoDcty/oSd6Q9GEJRw4FRTpQCZlc=
Date:   Mon, 20 Dec 2021 21:27:17 +0100
From:   David Heidelberg <david@ixit.cz>
Reply-To: 20210106125322.61840-14-manivannan.sadhasivam@linaro.org
Subject: Question about node naming in [PATCH v3 13/18] ARM: dts: qcom: sdx55:
 Add spmi node
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Message-Id: <HTKF4R.5S1PY4MCM4QS@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Manivannan,

I'd like to ask, if you had any particular reason to name node 
`qcom,spmi@` instead of basic `spmi@`.

I'm currently converting binding for 
Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb and I'm 
considering adding qcom,spmi into qcom,spmi-pmic-arb or just rename 
this and arch/arm64/boot/dts/qcom/msm8996.dtsi `qcom,spmi@` occurences 
to `spmi@`.

Ideas, inputs?

Thank you
David


