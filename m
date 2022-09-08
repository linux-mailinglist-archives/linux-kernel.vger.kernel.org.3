Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139625B153E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiIHHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiIHHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:00:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD5393214
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:00:55 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220908070049epoutp02f2e02433ccfaeac7979dad66c150bd5e~S0H1k1C902447924479epoutp02U
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:00:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220908070049epoutp02f2e02433ccfaeac7979dad66c150bd5e~S0H1k1C902447924479epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662620449;
        bh=6T96RYj6pf3YxtVNFV5qD19gAOJsQuOdZzaaKqHrUGs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=CGyVr6bX8Kdm5PzBZSi6aAqL15HLBgF2Kms9HYnsm9CmTk5WmMoM3yfn/wD4QguDL
         1XQosP9AVD91ydTR6F+A2VFcxmnn6nSupiSkxL+D6Ftx8wxC90eXm4207n0tk3Mi65
         7NeIHY9dA3xjPUlASxj5Y+pSSy0DIDL/o9yKao+s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220908070048epcas5p43268dd50b3dec49ab9c2056db4aff12f~S0H08D1tp0221102211epcas5p4H;
        Thu,  8 Sep 2022 07:00:48 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MNVQ24jcpz4x9Q5; Thu,  8 Sep
        2022 07:00:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.24.54060.A1399136; Thu,  8 Sep 2022 16:00:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220908065342epcas5p1866a46de3dd5672f4d3e934441b1ea5f~S0BoGY9sD2488724887epcas5p1M;
        Thu,  8 Sep 2022 06:53:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220908065342epsmtrp1f1cb601ed65540f44e1a5c0c9c08c6c7~S0BoEBouo3100531005epsmtrp1X;
        Thu,  8 Sep 2022 06:53:42 +0000 (GMT)
X-AuditID: b6c32a4b-be1ff7000000d32c-58-6319931a652d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.50.18644.67199136; Thu,  8 Sep 2022 15:53:42 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220908065339epsmtip29780e0251167befb790cdf459e64a351~S0Bk2tCE12003820038epsmtip2t;
        Thu,  8 Sep 2022 06:53:39 +0000 (GMT)
From:   "Smitha T Murthy" <smitha.t@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, <aakarsh.jain@samsung.com>
In-Reply-To: <7a42d3bc-060d-5a5a-c885-38bdb8465fe2@kernel.org>
Subject: RE: [Patch v2 02/15] dt-bindings: media: s5p-mfc: Add mfcv12
 variant
Date:   Thu, 8 Sep 2022 12:23:37 +0530
Message-ID: <004c01d8c34f$bb730660$32591320$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwYET59QqMDNmfP0SYfUTdtmHMHgLgq2oeAafvi/wBdC0Poaz1+HDA
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xbZRjmnF5OWVI8sOI+cGo9OJUp0HLpPraBUxBPRCbJEli8gF05K4TS
        Nj1FLt4ql6E4N3DgRgeMrAy0KYx1XMpFB6wIwzHCYEU3oBtuQokkSN0ymCO2tCj/nvd9nvfy
        vF8+DsOnGvPnZMjVlEoulhHsLcz2y4EvBvmf8JMIbj14Dt4zVbHg7dp2NtQ9nEOhVWdnwv6L
        bRhsnTjNgI2DvSx4xnyNBTv6ZpnwwryDHauaZsK5M80ItGln2HB0tAWDxt8tLHhnIRmOd1Wz
        4dGWNhZsMk9j8NzkGAobjP+g8Gzb3xgs/tGMwaIjZnQfIA21BoQ0Tdcj5GT9MoPs1E5jpK7H
        hpJG/VdscsrSwyYv1n9OFg+sMsljrXqEXCuowchS8ySbtBufIYfv27FEr3cz96ZT4jRKxafk
        EkVahlwaRcQfSI1JjRAJhEHCSLiL4MvFWVQUEft2YlBchsxxBoL/kViW7UglimmaCIneq1Jk
        qyl+uoJWRxGUMk2mDFcG0+IsOlsuDZZT6t1CgSA0wiH8MDO9t+hbtrLOO9dgWWJokAqvUsST
        A/BwsLzcwi5FtnB88G4EFIwvoq5gGQEny7vdjB0BP9dqWBslo3OdbqILAWVfd2OuYA4BY80W
        zKli48FgwaxjOQke3o4A+9oc20kw8Eom6LP4ObEnHg2sR2+ut92KvwOGLz1mOjETfx6sjdx3
        YA6Hi0eCslsxzjQX9wZXqu4yXW2eBR2L1QzXRnywcq9hvQ0PjwMDk1dYLs02YBswry8H8BlP
        cPNxk9tCLOgx6t3FW8HCYCvmwv7AdvyIG0uB1V6IuLAS1GhaURd+FfROVK/vxsADwfmuEFf6
        aVA53Iy65nqBbx7ddcu5wFS7gQlw9uqQuz0ANxbbWGUIod1kTbvJmnaTBe3/0+oQph7xo5R0
        lpSiI5RhcirnvxeXKLKMyPo32RlvQmZvLwX3IygH6UcAh0HwuL5NQOLDTRPn5VMqRaoqW0bR
        /UiE49zlDH9ficLxz+TqVGF4pCBcJBKFR4aJhMQ2bsXLiMQHl4rVVCZFKSnVRh3K8fTXoL36
        p07UfBb7cS6Z0KLfbuVdz8tLotV0SYxhwqOO4L0REfYnemGwv+9cKW9+pWRqciaId+OAQQ5j
        Lv0Rf3J/4JMB0mWPfA/V4S+2j7fzPWRSv1bNfHVF7ooh/4MFS33OzFuDnauhn7xi03m8dupU
        c6GuLLnb+oRkj/f+hkfHRzlTsTxW8cj3Y2+aUwqmZIJDcZUizQPTLDz0Q0Jj6XdDvqm7I6MK
        3xe93vDLe43Rv5b/ZQlRZfIeJpjic/dc5XtldSSPBCQd27V0+XTfDqnk/PLoePBvnwpDeSDl
        J85hLGUo29d65+CXomg/9kviJHDNdlAXUNJoLdqnyNzxAkPW3Xs9Z5Vg0uli4U6Gihb/C5L8
        ZaOvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZdlhJXrdsomSywbo2KYunO2ayWjyYt43N
        YvGP50wW9xd/ZrE4tHkru8WWK7OZLZYfP8BqMf/IOVaL7QcfsVhsfAGUvTjzLovF8/nrGC1e
        zrrHZnH+/AZ2i02Pr7FaPHwVbnF51xw2i54NW1kt1h65y26x9PpFJotlm/4wWSza+oXdonXv
        EXaLlrYjTA4SHmvmrWH02HF3CaPH9SWfmD12zrrL7rF4z0smj02rOtk87lzbw+axeUm9R+vR
        XywefVtWMXr8a5rL7tF15Dqbx+dNch6nvn5mD+CL4rJJSc3JLEst0rdL4Mo40DKJrWCBYMWa
        ax+YGxin8HUxcnJICJhInH++k62LkYtDSGAHo8SWjqXsEAkJiZW/JzFC2MISK/89B4sLCTxl
        lDh9yRbEZhPQk3h1ZDEriC0isItRYslLc5BBzAIrWSTu3upigZj6mlHi8s1zTCBVnAJ2Evd7
        boF1CAv4Six+swBsKouAisS/s1+BGjg4eAUsJSbcdgYJ8woISpyc+YQFxGYW0JbofdjKCGHL
        S2x/O4cZ4jgFiZ9Pl0Ed4SZx9PpJVogacYmXR4+wT2AUnoVk1Cwko2YhGTULScsCRpZVjJKp
        BcW56bnFhgVGeanlesWJucWleel6yfm5mxjB6URLawfjnlUf9A4xMnEwHmKU4GBWEuEVXSuR
        LMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTqtbNwau+
        GNUZ3XZOuvh4aspXzxvrTnLN6F22d8IzjhNVxw4/kpkXqP7c2qLcjpU3cDmLTrDNibc/1x/X
        8zs2cVfbqqDcdzuZPJ+7L5SZIr6goX+eS0XTtw2yM85snri29kFH/wV7ruBNLMdKDUJrnL3/
        Xt+3Y2Np426nL+WH7oWoOWyJuMR97tfGP2dfnDd7pXVtrcViPo2Vc7KP7r6S6vLmiqOPy99p
        dXeXrbhbZbH2rrTlLrZPVYmXQyzvCd/l6uHetrbYyTBD7HLsti++u7Y1dd93XLJFc9kn5VcT
        +aM4sz6837eo7OX1nY3l5m6FYV5+k+ea3m05ou3yZ1HSlI0bJn5cE5QavurqN0vOT9lKLMUZ
        iYZazEXFiQC1j7ILlgMAAA==
X-CMS-MailID: 20220908065342epcas5p1866a46de3dd5672f4d3e934441b1ea5f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063318epcas5p2a395fc5da7576c3a53b6a55e3cc87911
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063318epcas5p2a395fc5da7576c3a53b6a55e3cc87911@epcas5p2.samsung.com>
        <20220907064715.55778-3-smitha.t@samsung.com>
        <7a42d3bc-060d-5a5a-c885-38bdb8465fe2@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
> Sent: Wednesday, September 7, 2022 4:54 PM
> To: Smitha T Murthy <smitha.t@samsung.com>; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
> benjamin.gaignard@collabora.com; stanimir.varbanov@linaro.org;
> dillon.minfei@gmail.com; david.plowman@raspberrypi.com;
> mark.rutland@arm.com; robh+dt@kernel.org; krzk+dt@kernel.org;
> andi@etezian.org; alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> pankaj.dubey@samsung.com; linux-fsd@tesla.com;
> aakarsh.jain@samsung.com
> Subject: Re: [Patch v2 02/15] dt-bindings: media: s5p-mfc: Add mfcv12
> variant
> 
> On 07/09/2022 08:47, Smitha T Murthy wrote:
> > Adds DT schema for s5p-mfc with a new compatible string for mfcv12
> > variant.
> 
> This msg is over-complicated. Just: "Add Tesla FSD MFC (MFC v12)
> compatible".
> 

I will change it in the next series.

> >
> > Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > index 7cd26d4acbe4..a806489a9edd 100644
> > --- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > @@ -23,6 +23,7 @@ properties:
> >        - samsung,mfc-v8                  # Exynos5800
> >        - samsung,exynos5433-mfc          # Exynos5433
> >        - samsung,mfc-v10                 # Exynos7880
> > +      - samsung,fsd-mfc                 # Tesla FSD
> 
> tesla,fsd-mfc
> 
> (because FSD is attributed everywhere to Tesla)
> 
> Best regards,
> Krzysztof

I will make the change in the next series.

Regards,
Smitha

