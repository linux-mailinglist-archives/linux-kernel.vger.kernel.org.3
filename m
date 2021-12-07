Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7446C090
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbhLGQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:21:03 -0500
Received: from ixit.cz ([94.230.151.217]:58628 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234804AbhLGQVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:21:02 -0500
Received: from [127.0.0.1] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 22D9A21F5E;
        Tue,  7 Dec 2021 17:17:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1638893849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GovhpTPYK5Ht0VODNqAF4QQig7BvnuyGrtziIctHJUY=;
        b=IWq9cZBv2U+D3hknfdxz5TGB4+SON4bp5ECA52njYU3/rX2LVbzbuRqaKpYaVqDwNnVj+1
        XSGVaQYAdXkzDyRecvUvx9uzHB3iFa00vFga5epWaShNT+dzL5Mh8UQCtJ6t6F7mMQ1/QZ
        drNmePGOXDoT3WAeuIurwRfjRLwMJ/4=
Date:   Tue, 07 Dec 2021 16:17:28 +0000
From:   David Heidelberg <david@ixit.cz>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_dt-bindings=3A_misc=3A_convert_Qu?= =?US-ASCII?Q?alcomm_FastRPC_bindings_to_the_YAML_schema?=
In-Reply-To: <4f631075-85d0-7362-e3d6-b3abaec465e0@linaro.org>
References: <20211206193849.109079-1-david@ixit.cz> <4f631075-85d0-7362-e3d6-b3abaec465e0@linaro.org>
Message-ID: <285F17B6-686B-4DAB-B396-12D1E35F7023@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I see!

Maybe we can do some kind of merge of our almost 99=2E9% same patches or y=
ou want to just nitpick bits from mine?

Also, are you on some Matrix / IRC channel?

Thank you
David


-------- P=C5=AFvodn=C3=AD zpr=C3=A1va --------
Odes=C3=ADlatel: Srinivas Kandagatla <srinivas=2Ekandagatla@linaro=2Eorg>
Odesl=C3=A1no: 7=2E prosince 2021 15:56:33 UTC
Komu: David Heidelberg <david@ixit=2Ecz>, Andy Gross <agross@kernel=2Eorg>=
, Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>, Rob Herring <robh+dt@ke=
rnel=2Eorg>
Kopie: ~okias/devicetree@lists=2Esr=2Eht, linux-arm-msm@vger=2Ekernel=2Eor=
g, devicetree@vger=2Ekernel=2Eorg, linux-kernel@vger=2Ekernel=2Eorg
P=C5=99edm=C4=9Bt: Re: [PATCH] dt-bindings: misc: convert Qualcomm FastRPC=
 bindings to the YAML schema

Hi David,

Thanks for the patch,


On 06/12/2021 19:38, David Heidelberg wrote:
> Switch the DT binding to a YAML schema to enable the DT validation=2E
>=20
> Also:
>   - simplify example
>   - embrace compute-cb@ subnodes instead of just cb@
>=20
> Signed-off-by: David Heidelberg <david@ixit=2Ecz>


There is already a similar patch [1] in the list=2E If you have noticed it=
, Its better to let the author know about your plans so that we do not dupl=
icate the same thing=2E

Your patch seems to have addressed issues with subnode names and example=
=2E

so am okay with this patch=2E

Acked-by: Srinivas Kandagatla <srinivas=2Ekandagatla@linaro=2Eorg>


FastRPC patches normally go via char-misc tree, so if Rob acks can you sen=
d it to Greg as well=2E


--srini


> ---
>   =2E=2E=2E/devicetree/bindings/misc/qcom,fastrpc=2Etxt | 78 -----------=
----
>   =2E=2E=2E/bindings/misc/qcom,fastrpc=2Eyaml           | 94 +++++++++++=
++++++++
>   2 files changed, 94 insertions(+), 78 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc=
=2Etxt
>   create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc=2Etxt b=
/Documentation/devicetree/bindings/misc/qcom,fastrpc=2Etxt
> deleted file mode 100644
> index 2a1827ab50d2=2E=2E000000000000
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc=2Etxt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -Qualcomm Technologies, Inc=2E FastRPC Driver
> -
> -The FastRPC implements an IPC (Inter-Processor Communication)
> -mechanism that allows for clients to transparently make remote method
> -invocations across DSP and APPS boundaries=2E This enables developers
> -to offload tasks to the DSP and free up the application processor for
> -other tasks=2E
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "qcom,fastrpc"
> -
> -- label
> -	Usage: required
> -	Value type: <string>
> -	Definition: should specify the dsp domain name this fastrpc
> -	corresponds to=2E must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
> -
> -- #address-cells
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Must be 1
> -
> -- #size-cells
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Must be 0
> -
> -=3D COMPUTE BANKS
> -Each subnode of the Fastrpc represents compute context banks available
> -on the dsp=2E
> -- All Compute context banks MUST contain the following properties:
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "qcom,fastrpc-compute-cb"
> -
> -- reg
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Context Bank ID=2E
> -
> -- qcom,nsessions:
> -	Usage: Optional
> -	Value type: <u32>
> -	Defination: A value indicating how many sessions can share this
> -		    context bank=2E Defaults to 1 when this property
> -		    is not specified=2E
> -
> -Example:
> -
> -adsp-pil {
> -	compatible =3D "qcom,msm8996-adsp-pil";
> -	=2E=2E=2E
> -	smd-edge {
> -		label =3D "lpass";
> -		fastrpc {
> -			compatible =3D "qcom,fastrpc";
> -			qcom,smd-channels =3D "fastrpcsmd-apps-dsp";
> -			label =3D "adsp";
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -
> -			cb@1 {
> -				compatible =3D "qcom,fastrpc-compute-cb";
> -				reg =3D <1>;
> -			};
> -
> -			cb@2 {
> -				compatible =3D "qcom,fastrpc-compute-cb";
> -				reg =3D <2>;
> -			};
> -			=2E=2E=2E
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc=2Eyaml =
b/Documentation/devicetree/bindings/misc/qcom,fastrpc=2Eyaml
> new file mode 100644
> index 000000000000=2E=2Ef42ab208a7fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc=2Eyaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2=2E0-only OR BSD-2-Clause)
> +%YAML 1=2E2
> +---
> +$id: "http://devicetree=2Eorg/schemas/misc/qcom,fastrpc=2Eyaml#"
> +$schema: "http://devicetree=2Eorg/meta-schemas/core=2Eyaml#"
> +
> +title: Qualcomm FastRPC Driver
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas=2Ekandagatla@linaro=2Eorg>
> +
> +description: |
> +  The FastRPC implements an IPC (Inter-Processor Communication)
> +  mechanism that allows for clients to transparently make remote method
> +  invocations across DSP and APPS boundaries=2E This enables developers
> +  to offload tasks to the DSP and free up the application processor for
> +  other tasks=2E
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,fastrpc
> +
> +  label:
> +    items:
> +      enum:
> +        - adsp
> +        - mdsp
> +        - sdsp
> +        - cdsp
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "(compute-)?cb@[0-9]$":
> +    type: object
> +
> +    description: >
> +      Each subnode of the Fastrpc represents compute context banks avai=
lable on the dsp=2E
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,fastrpc-compute-cb
> +
> +      reg:
> +        maxItems: 1
> +
> +      qcom,nsession:
> +        $ref: /schemas/types=2Eyaml#/definitions/uint32
> +        default: 1
> +        description: >
> +          A value indicating how many sessions can share this context b=
ank=2E
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - label
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    smd-edge {
> +        label =3D "lpass";
> +        fastrpc {
> +            compatible =3D "qcom,fastrpc";
> +            label =3D "adsp";
> +            qcom,smd-channels =3D "fastrpcsmd-apps-dsp";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            compute-cb@1 {
> +                compatible =3D "qcom,fastrpc-compute-cb";
> +                reg =3D <1>;
> +            };
> +
> +            compute-cb@2 {
> +                compatible =3D "qcom,fastrpc-compute-cb";
> +                reg =3D <2>;
> +            };
> +        };
> +    };
>=20
[1] https://patchwork=2Eozlabs=2Eorg/project/devicetree-bindings/patch/202=
11130092846=2E18804-1-srinivas=2Ekandagatla@linaro=2Eorg/
