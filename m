Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509224828A0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 23:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiAAWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 17:01:51 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:39904 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiAAWBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 17:01:50 -0500
Received: by mail-ua1-f42.google.com with SMTP id j11so15019311uaq.6;
        Sat, 01 Jan 2022 14:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=EIYlX0fg89iThHN0zMuGWjZdyWg72w1vf2v0+D7SNtI=;
        b=hrOsgbOYGBqErc1KQWtNwwl5z4eJTcbsp4pzs/N9OrkJ3jHn5LHhj5l6bRjwhxlNBa
         Kh1q8mRFsOuCoJpKKn14Av2Piju4og2yzR2qY+fLjo0BiGrMDc0EXWUfBmemy1rIn/LP
         yI93Rj4cL3ySqjc/DK1rbTuvWqnVEfa19m0QNMjcV5tnftwL/yl3YC1rTrx25WaPsLtR
         jvA6DLab610B5JMAuknBSoR1BoSyoBAHWKpqNL8hs3yIF2dvD1q/7vP1N4ky9kWzP27j
         3QotvZk68eggtMfpA7kJ+b+FcbIkKG9gZgXfpiqksNO46F/oQBlm1DBBTo0gHQPHkHYj
         03Pg==
X-Gm-Message-State: AOAM53358rVQ0qWjkq8zzXEJU0cmzGdMW8TPiySLJ0zE2FjcLfyuouFC
        okNPdH6ggXksOOwig234QEJsIKlxCwj1
X-Google-Smtp-Source: ABdhPJz2XEbM/n1d4hzrwv5hiRpcGtsXAB6QuViudqMOLi02VAkPU3bX7OP/UX05O/2eLvlC42/doQ==
X-Received: by 2002:ab0:6956:: with SMTP id c22mr5104855uas.51.1641074509649;
        Sat, 01 Jan 2022 14:01:49 -0800 (PST)
Received: from robh.at.kernel.org ([209.91.235.3])
        by smtp.gmail.com with ESMTPSA id i62sm6165690vke.33.2022.01.01.14.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 14:01:48 -0800 (PST)
Received: (nullmailer pid 839548 invoked by uid 1000);
        Sat, 01 Jan 2022 22:01:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rajeev Nandan <quic_rajeevny@quicinc.com>
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        quic_mkrishn@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_kalyant@quicinc.com, freedreno@lists.freedesktop.org,
        robdclark@gmail.com, daniel@ffwll.ch, swboyd@chromium.org,
        airlied@linux.ie, sean@poorly.run, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_abhinavk@quicinc.com,
        dri-devel@lists.freedesktop.org, jonathan@marek.ca
In-Reply-To: <1640856276-14697-2-git-send-email-quic_rajeevny@quicinc.com>
References: <1640856276-14697-1-git-send-email-quic_rajeevny@quicinc.com> <1640856276-14697-2-git-send-email-quic_rajeevny@quicinc.com>
Subject: Re: [v1 1/2] dt-bindings: msm/dsi: Add 10nm dsi phy tuning properties
Date:   Sat, 01 Jan 2022 18:01:44 -0400
Message-Id: <1641074504.063577.839547.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 14:54:35 +0530, Rajeev Nandan wrote:
> Add 10nm dsi phy tuning properties for phy drive strength and
> phy drive level adjustemnt.
> 
> Signed-off-by: Rajeev Nandan <quic_rajeevny@quicinc.com>
> ---
>  .../devicetree/bindings/display/msm/dsi-phy-10nm.yaml | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:phy-drive-strength-cfg:type: 'array' is not one of ['boolean', 'object']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: properties:phy-drive-level-cfg:type: 'array' is not one of ['boolean', 'object']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml: ignoring, error in schema: properties: phy-drive-strength-cfg: type
Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.example.dt.yaml:0:0: /example-0/dsi-phy@ae94400: failed to match any schema with compatible: ['qcom,dsi-phy-10nm']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1574124

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

