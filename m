Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5550C1D3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiDVV4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiDVVz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:55:56 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91DF2A3D4E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:26 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e5c42b6e31so9779966fac.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=8fNT3B9xShMp8YjDhB8mNsFwDWX1HRS1Y91CrVG13FY=;
        b=A1Yt+jpSTR8vU8ep0aUKLOsD88y/Ntg+K6gPVRkqcFHGbnr5asBMqtQ3LP4oMIyBl8
         OjQ3WRB2aedSWEX4Gm/d6wCfkUbgPOoLUdsvi2FKp6SR4f5XV7SFuppJnMiTxYXImXGu
         u3G6TJ2AP6MnAJClkh4o5q0x5y4yqP4L+41Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=8fNT3B9xShMp8YjDhB8mNsFwDWX1HRS1Y91CrVG13FY=;
        b=PrSebyU7EamZoVgFSOO1EHLbUgvOdWUnatNTAi5c5C7QuQu+Sw55gJFmRkVAPG4HQK
         f1WzqQ5JGAzSZ9Qia6uh9GZiZe+csYDd0Z3zSpHcEHYDjKeK0YM/wosLV4/MM+24DipX
         DB7Y5ikL5+k3Hgj394PX+nnKbdH1p8dDfOF2FKN9e4J4p4r1R7+Ka1hHETKbgpqRv5ZO
         d5y0cLsQ3nSNGw/gVlGoH/KeZKd+tszrOpIrr8cJnEnKvYl0fAtF0HrnpoMO4nQIB12V
         iOMn7hUMcBCsQAAenh8r9QeraniFszd2D/FuP1LMFLWIS9Gm6P7PaNXiVciSbCA8WotJ
         HcQA==
X-Gm-Message-State: AOAM530jk9L/7iJ0xhkQC1KASOhx27nIaRKiDqzvdTD6ImEWzOVqHUQT
        F50UwlnIZnNocKo8ocPLt25BCKe2G22Gx73KZRDxzg==
X-Google-Smtp-Source: ABdhPJzqMbbeseVcLoVmKetnixFamZypwpLkOXrtgjUg5Boaskdudv5pEv5IHeI79MhQOMHrOAB0NVnPKI+8x5c4v7A=
X-Received: by 2002:a05:6870:15ca:b0:e9:551:6d1c with SMTP id
 k10-20020a05687015ca00b000e905516d1cmr1468427oad.193.1650659676785; Fri, 22
 Apr 2022 13:34:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Apr 2022 13:34:36 -0700
MIME-Version: 1.0
In-Reply-To: <e54804ee-15f8-36a1-bbc5-9a218a4aec56@kernel.org>
References: <20220412220033.1273607-1-swboyd@chromium.org> <20220415005828.1980055-1-swboyd@chromium.org>
 <Yl92UkRwlQsd71mr@ripper> <e54804ee-15f8-36a1-bbc5-9a218a4aec56@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 22 Apr 2022 13:34:36 -0700
Message-ID: <CAE-0n50OvNmcX9fir8+zgaz9sE+sksNzTjN3vWgzT3A7ay6s+A@mail.gmail.com>
Subject: Re: [PATCH 3/2] arm64: dts: qcom: sc7180: Remove ipa interconnect node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Georgi Djakov (2022-04-22 00:01:24)
> On 20.04.22 5:56, Bjorn Andersson wrote:
> > On Thu 14 Apr 17:58 PDT 2022, Stephen Boyd wrote:
> >
> >> This device node is unused now that we've removed the driver that
> >> consumed it in the kernel. Drop the unused node to save some space.
> >>
> >
> > I'm expecting that merging patch 3 and 4 will work, but cause sync_state
> > to not happen until the driver changes are merged.
> >
> > Can you confirm my expectation? And perhaps confirm that it's fine for
> > Georgi to pick the driver changes independently of the dts changes...

It should be OK to pick the driver changes independently of the dts.
They fix a boot up issue.

>
> I have picked the driver changes, as the boot failure definitely needs to
> be addressed. The sync-state might not happen until we have the DT changes
> merged, as the framework is matching the count of probed drivers with the
> count of providers in DT.

Indeed. The DT change is required to actually have sync-state happen
when the driver changes are merged. Without the DT change I'm not able
to enter suspend. I didn't notice this earlier, ugh.

This means that the DTS change needs to be backported to fix suspend,
because otherwise the _other_ interconnects that aren't IPA keep the
initial sync-state request forever, waiting for the IPA provider in DT
to be probed by a driver that doesn't exist. One solution is to have the
DT change, which makes the probed driver and provider counts match.

Maybe a better solution is to ignore these compatibles in the provider
count? That way we aren't required to backport a DTS change and
everything is still contained to driver code.

----8<----
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 80ed03f4dfd0..bfa6788afca1 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1087,9 +1087,15 @@ static int of_count_icc_providers(struct device_node *np)
 {
 	struct device_node *child;
 	int count = 0;
+	const struct of_device_id ignore_list[] = {
+		{ .compatible = "qcom,sc7180-ipa-virt", },
+		{ .compatible = "qcom,sdx55-ipa-virt", },
+		{}
+	};

 	for_each_available_child_of_node(np, child) {
-		if (of_property_read_bool(child, "#interconnect-cells"))
+		if (of_property_read_bool(child, "#interconnect-cells") &&
+		    likely(!of_match_node(ignore_list, child)))
 			count++;
 		count += of_count_icc_providers(child);
 	}
