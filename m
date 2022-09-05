Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444465AD545
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbiIEOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbiIEOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:41:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668DE42AE5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:38:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k18so9410176lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zYdarGuR3Vi4UPBIiISQR9FP8846+ysRJOD4h/7T+v4=;
        b=lhIDTDDbzB02mXV6lHMpUjQwsj+4x2lCMVYvg8N6lxaB4aBvvFY/MwBH0c8rRa7ytT
         LKButDVMjTVuni2hJFRCW4G4Bc+TJrl8Sx9RGN5NpOtDUUnYtMVo9sEfbBkeX1wrZy7v
         vkUFJRwcFy2ClJ2ydcBcJvh4NSTmHYaKajmIE6HeGwgt3eUI5sScIaWbmZNVW7kXNM9q
         fFwaUNQhecXJ+ufEzGcFSO8IUDuyZwJxLx/6HPseYZ/ap8/jiLanU5NkRIQgdVrH+Fbb
         L8FkmnDd+uUxNGzAWmfaRNnZnaGePTPWcTyEtggMHJD+hl1off8X7VSqXRwlzloZXOBX
         2aTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zYdarGuR3Vi4UPBIiISQR9FP8846+ysRJOD4h/7T+v4=;
        b=F2zwYF63VNkSkMDls/+DqaW5zMMvtqCXvNBDXPf8b1Ceo9NOy9Xz7OVGgR/gN8P6t4
         iwBoVPqoWbnlrrI7TW9PLFBjFRmdUM6HBPI8TpjFr6ELoleFHAawZUIdPfQyAXemLR8K
         rd2txWu6t8JO3S70oDGsZShjO/FJUCnFzVYeRYt+izlhQLk0FIuKw0lmE6pVmuetSk+b
         Jow7P+vM5kNfxwPafxVoK29uAMfpBMwqBShhF/790OmbxY/lwE4vGm+RHQp+nsDVm1gh
         m0srnCecDDHusI8gD/XzQv52GpfrZRZIJO7w1ixWM71l2to7+08+APOob82flgqv1YjJ
         LtKQ==
X-Gm-Message-State: ACgBeo087KtYxzxkBx33gg9o3bcdmWWl1GcGdhc7uptxgwO9p293Lp6v
        Y2tURRCFcVfLI1tYYyfdN2y2dOSAiRGREw==
X-Google-Smtp-Source: AA6agR6UICNLfBRPyyhtwC+ItJKmfK8eQbm6NUTy0WoCmuRudCJsM8/NeJT9Eyk5B8ICrbOr3aXgGQ==
X-Received: by 2002:a05:651c:549:b0:268:e0b3:4795 with SMTP id q9-20020a05651c054900b00268e0b34795mr5067940ljp.313.1662388717608;
        Mon, 05 Sep 2022 07:38:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651c10a400b0026872a014b0sm1435564ljn.116.2022.09.05.07.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 07:38:36 -0700 (PDT)
Message-ID: <ff3a2d2a-d0da-260c-2974-b7430dafef68@linaro.org>
Date:   Mon, 5 Sep 2022 16:38:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 1/2] dt-bindings: misc: fastrpc convert bindings to
 yaml
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Rob Herring <robh@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20220905103715.955786-1-abel.vesa@linaro.org>
 <1662381657.354400.1957044.nullmailer@robh.at.kernel.org>
 <YxYH+3hGZ2fyUZpW@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YxYH+3hGZ2fyUZpW@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 16:30, Abel Vesa wrote:
> On 22-09-05 07:40:57, Rob Herring wrote:
>> On Mon, 05 Sep 2022 13:37:14 +0300, Abel Vesa wrote:
>>> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
>>> dt-entries correctly and any future additions can go into yaml format.
>>>
>>> Use compute-cb@ subnodes instead of just cb@.
>>>
>>> Also add qcom,non-secure-domain, qcom,glink-channels and
>>> qcom,smd-channels missing properties to make sure dtbs_check doesn't
>>> fail right off the bat.
>>>
>>> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Co-developed-by: David Heidelberg <david@ixit.cz>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>
>>> Changes since v5:
>>>  * Removed the txt file
>>>
>>>  .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 --------------
>>>  .../bindings/misc/qcom,fastrpc.yaml           | 108 ++++++++++++++++++
>>>  2 files changed, 108 insertions(+), 88 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>>>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dtb: smd-edge: 'qcom,smd-edge' is a required property
>> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dtb: smd-edge: 'oneOf' conditional failed, one must be fixed:
>> 	'mboxes' is a required property
>> 	'qcom,ipc' is a required property
>> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dtb: smd-edge: 'oneOf' conditional failed, one must be fixed:
>> 	'interrupts' is a required property
>> 	'interrupts-extended' is a required property
>> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
> 
> Right.
> 
> So actually, the parent node is glink-edge, not smd-edge.
> 
> And there are some other required properties missing when switching to
> glink-edge.
> 
> Will resend with glink-edge instead and add all the related missing
> properties.

Maybe related to:
https://lore.kernel.org/all/20220901093401.134473-1-krzysztof.kozlowski@linaro.org/
?


Best regards,
Krzysztof
