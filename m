Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1331C524E82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354547AbiELNmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354538AbiELNmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:42:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4176A62CD1;
        Thu, 12 May 2022 06:42:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i24so4830356pfa.7;
        Thu, 12 May 2022 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=GgzNh++292NF+E5zmg+4OX55F9De/BlQIpudd+EXtLQ=;
        b=LA63FLxYpym5WboTuUwi/wt+SGKurpEXYZQxiMDo+Xt5K5HxcMaroziFYgsNY4U/D0
         jQcL2M6YnnnpxbMx8WO/l+dZr1XtXZXWlVn/uh428fXkeT5rbnonFqHo8E14tAdUQCsG
         S4W8NZReOH65ZS3DdbfBwBp/s91Ypl8qzOshu5CcbA+6tpQzhSwJbzboU8awwQhvxwgb
         prba+OJY/UDjw4SkwUk7eclm5IT7azw9CMmuZZvVGf9b0WPTP5FXARfsgIf7JDgzJOn7
         lIPjXOuhF8ADfbty0dik/14V86WxCGBL/BSipDt5/OBSqXOfAIprdtTOEQ/LgxHdvchl
         orRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=GgzNh++292NF+E5zmg+4OX55F9De/BlQIpudd+EXtLQ=;
        b=rhUvVR81hmpNdc6UmCck84sIDZZLiq8moZevjrNdD0luwTRpxq3ZU6ls+nm/HnTbAW
         32fyMt+pqmRye3BxMPOh2cfFmwykTi+MeQx5UDis5hdS1nq/XqBiY3JJMPB+HVvKZdqw
         oNO5bOsI/+QzP+pEYmgGzAaOo6k8zGpVHtyd7AsgY92Lp75WB667MEbpuuLhejtvoCWS
         kFOiREwWTUwiO19UP5zGwqD84RngzwDo9pakQvCABe9lgrGRmvdXa3GHotyvI21mUxbV
         1sfnjVAfzlcvyNhb2DZKGugT437o6Et0v6Y3GQXmTomLqwQ2yA78TnS/gS6U/VGjh3/I
         yTpQ==
X-Gm-Message-State: AOAM532N7IwMdRRnxYZuhImr7DWfdmQw2HD761K9KfAW6wI7R1MDvOuj
        8zkwzlLUwAY7c1TUbkFKKRg=
X-Google-Smtp-Source: ABdhPJyhAuXqFsgoeseiRJPc84g3MKIgyF+aoWzOOmIUwQdQ7kGidEG8ONsSZ/Ofybzfz7Fr5YYarA==
X-Received: by 2002:a05:6a00:234b:b0:510:4161:781a with SMTP id j11-20020a056a00234b00b005104161781amr30341812pfj.5.1652362962594;
        Thu, 12 May 2022 06:42:42 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id x40-20020a056a000be800b0051082ab4de0sm3741051pfu.44.2022.05.12.06.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:42:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 19:12:36 +0530
Message-Id: <CJXTS6RN1T67.WNKK2FZKK9UB@skynet-linux>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Loic Poulain" <loic.poulain@linaro.org>
Subject: Re: [PATCH 4/9] dt-bindings: remoteproc: qcom: wcnss: Convert to
 YAML
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
X-Mailer: aerc 0.9.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-5-sireeshkodali1@gmail.com>
 <00234f36-9bae-31d5-5b83-ea238e7e3c11@linaro.org>
 <CJXL0SG2GHN1.1IO2JOR5ARNV8@skynet-linux>
 <a62822a4-a771-dfa9-f46d-586fdccedf66@linaro.org>
 <CJXOGJIR1ONQ.2ZT3JQGVWWHFB@skynet-linux>
 <58a6391b-b930-0095-4f50-618dee4f24e2@linaro.org>
In-Reply-To: <58a6391b-b930-0095-4f50-618dee4f24e2@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 12, 2022 at 4:32 PM IST, Krzysztof Kozlowski wrote:
> On 12/05/2022 11:32, Sireesh Kodali wrote:
> >>>>> +          - enum:
> >>>>> +              - qcom,pronto-v2-pil
> >>>>> +          - enum:
> >>>>> +              - qcom,pronto
> >>>>
> >>>> This does not look correct. The fallback compatible should not chang=
e.
> >>>> What is more, it was not documented in original binding, so this sho=
uld
> >>>> be done in separate patch.
> >>>>
> >>>
> >>> This was not a change to the fallback compatible.=20
> >>
> >> You made it an enum, so you expect it to use different fallback for
> >> different cases.
> >>
> >>> msm8916.dtsi's wcnss
> >>> node has "qcom,pronto" as the compatible string, which is why this wa=
s
> >>> added. It is however not documented in the txt file. Is it sufficient=
 to
> >>> add a note in the commit message, or should it be split into a separa=
te
> >>> commit?
> >>
> >> Please split it, assuming that fallback is correct. Maybe the fallback
> >> is wrong?
> >=20
> > The code doesn't recognize "qcom,pronto", so perhaps the best solution
> > is to just remove that compatible from msm8916.dtsi?
>
> Eh, I don't know. You need to check, maybe also in downstream sources.
>

I just checked, it seems "qcom,pronto" is used by the wcnss driver in
/net. So both "qcom,pronto-v2-pil" and "qcom,pronto" need to be present,
but the latter wasn't documented.

> (...)
>
> >>>>
> >>>>> +
> >>>>> +  iris:
> >>>>
> >>>> Generic node name... what is "iris"?
> >>>>
> >>> Iris is the RF module, I'll make the description better
> >>
> >> RF like wifi? Then the property name should be "wifi".
> >=20
> > RF like wifi and bluetooth. However there are wifi and bt subnodes in
> > the smd-edge subnode. Iris is just the antenna hardware if I understand
> > correctly. Also this is just a documentation of the existing nodes that
> > are present in msm8916.dtsi, but for whatever reason their documentatio=
n
> > was missing in the txt file. Without adding this node in the YAML
> > dtb_check fails.
>
> It seems commit fd52bdae9ab0 ("wcn36xx: Disable 5GHz for wcn3620")
>  added usage of "iris" property but did not document it in the bindings.
>
> You can fix it by documenting (separate patch) existing practice or
> document with changing the node name. I am not sure if it is worth the
> effort, so just new patch please.
>

I'll make a 2 separate patches, documenting the extra "qcom,pronto"
compatible, and the iris subnode.

Thanks,
Sireesh

> Best regards,
> Krzysztof

