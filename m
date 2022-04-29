Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0A514E42
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiD2OyG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Apr 2022 10:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377999AbiD2Oxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:53:52 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6241911A39;
        Fri, 29 Apr 2022 07:50:25 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2ea3.dip0.t-ipconnect.de [91.61.46.163])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3B3CCCED21;
        Fri, 29 Apr 2022 16:50:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v1 1/3] dt-bindings: net: bluetooth: Add wlan-gpio entry
 for wcn6750
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1651228073-1999-2-git-send-email-quic_bgodavar@quicinc.com>
Date:   Fri, 29 Apr 2022 16:50:23 +0200
Cc:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_saluvala@quicinc.com, quic_rjliao@quicinc.com,
        mcchou@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DDBF36DE-18F1-40ED-90B8-CE2E31841D4A@holtmann.org>
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
 <1651228073-1999-2-git-send-email-quic_bgodavar@quicinc.com>
To:     Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> This patch adds a wlan-gpio entry and its reference usage for
> BT SoC wcn6750.
> 
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> ---
> Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
> index f93c6e7..624f957 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
> @@ -24,6 +24,10 @@ properties:
>       - qcom,qca6390-bt
>       - qcom,wcn6750-bt
> 
> +  wlan-gpios:
> +    maxItems: 1
> +    description: gpio specifier used to wlan chip
> +
>   enable-gpios:
>     maxItems: 1
>     description: gpio specifier used to enable chip
> @@ -123,6 +127,7 @@ allOf:
>               - qcom,wcn6750-bt
>     then:
>       required:
> +        - wlan-gpios

why is this in the Bluetooth section? Why should Bluetooth care about any WiFi GPIO?

Regards

Marcel

