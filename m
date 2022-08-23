Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23959CF24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiHWDHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbiHWDGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:06:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53015C9FC
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:04:27 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so9006820otr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc;
        bh=9USu+PAmtohDCmKb1hTyNHROeZPmDrw/Mk40q4+1Ohw=;
        b=aJ9tzk4WXMM0uYiOf6l3xVnjlPJrlXlQhgH0ESoAMmE5JkCZQcTmnf/EK1tcqwyHqr
         DnZXvElRFKUYzNE3RoixpEhu7kcfRBoNJ96TArhjKX3g8wpoIqV4C8g6qGITSiCr6Pwh
         aGc2bFnU+fibB6WUCRa9k8/SKXaiO+TBwe+PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9USu+PAmtohDCmKb1hTyNHROeZPmDrw/Mk40q4+1Ohw=;
        b=J3Ij8cATgFEPTOHeQ7BvocQJqIrrm5UiAnAsuY/Q3j+mBIJ4TUHdRExit9UPcq5nZ2
         /b5c2SI378McMzvyB/Qk9Mctm/QkS0b6y84bjbnbiZYwhDEDwWMCTs2MlTQZ0hYI98dP
         4kKGl8DSpvP6mNRQ+d51KtmLVcQIiuwS10i4Xv+b1CoVOy+AKDqiRoKf7GHg0ukrsXMB
         oeappbdZvG3+HWvAGhNzIviMLP0Wrl3DqI4+tuyCLZ/4VfJvtHS4gCvn0yaydzWJokGr
         6FcuMmhlBsvDhfDzNbYOpF2aMBoJTyG9C0xVU0b4ApK9r0iNDIi68X0Eo6BfFDmOMftN
         +9ug==
X-Gm-Message-State: ACgBeo2uVoLlGoCBvEUHcJfEBit0NRM/6w3mjyaiR+mPuWVaVtyvcCn3
        PKyiFGH60X2evVA/ER3BcmxY/fY1g8AQEhBHzGRKSQ==
X-Google-Smtp-Source: AA6agR53rAN/wQpJ8uvZH4Xbd8+6gQhksCRGCRSUJ9blp3iRiG7EfMcTZ1cB6tggc5cNejuQsyh5pUXufNrHvLmWmnI=
X-Received: by 2002:a9d:738c:0:b0:638:9962:8cb6 with SMTP id
 j12-20020a9d738c000000b0063899628cb6mr8588543otk.73.1661223866572; Mon, 22
 Aug 2022 20:04:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Aug 2022 22:04:26 -0500
MIME-Version: 1.0
In-Reply-To: <1661156523-22611-2-git-send-email-quic_srivasam@quicinc.com>
References: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com> <1661156523-22611-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 22 Aug 2022 22:04:26 -0500
Message-ID: <CAE-0n51Fk=32qzy=ZT7hgxFhSz8G_9UHohP+R16jzLVJum5_Rw@mail.gmail.com>
Subject: Re: [RESEND v5 1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP support
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-08-22 01:21:57)
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> new file mode 100644
> index 0000000..cf895fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> @@ -0,0 +1,196 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-adsp-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SC7280 ADSP Peripheral Image Loader
> +
[...]
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
> +    #include <dt-bindings/clock/qcom,lpass-sc7280.h>
> +    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> +    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    remoteproc@3000000 {
> +        compatible = "qcom,sc7280-adsp-pil";
> +        reg = <0x03000000 0x5000>,
> +              <0x355B000 0x10>;

Lowercase hex please. Also, please pad it out to match the first reg
property.

> +
> +        interrupts-extended = <&pdc 162 IRQ_TYPE_EDGE_RISING>,
