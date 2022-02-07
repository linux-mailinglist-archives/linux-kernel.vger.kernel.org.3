Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF44AB44E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350476AbiBGFwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351504AbiBGEUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:20:25 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5C9C043180
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 20:20:24 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220207041432epoutp01f2c18cdf52918eaa4460907073fca182~RZc2W7oY31555715557epoutp01q
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:14:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220207041432epoutp01f2c18cdf52918eaa4460907073fca182~RZc2W7oY31555715557epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644207272;
        bh=cKaqzGvLSjPPcG0AVyfE83/T8ju4iTLggAP2I/DvWPE=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=FH2+becMDm0utT58mASXIAA73gfRHaT1/MktAMLGhHPJE8rGrfRurHaNOFOYbfDB2
         709baAm8+aPWMGbmlTsWWzumRuBMsan6zqZIcflpFc4jWqQ0LagzY5KFWOT53TYx9O
         3p0zIjRNRl3eCwVhOfwBqbl7xaWi0C0MYLt0X8tA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220207041431epcas5p46a035c15d73ee7e6fee3c1bcbc5c409b~RZc1tLNxG2343723437epcas5p4f;
        Mon,  7 Feb 2022 04:14:31 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JsXpZ6HVTz4x9Px; Mon,  7 Feb
        2022 04:14:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.63.46822.B0C90026; Mon,  7 Feb 2022 13:11:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220207041428epcas5p3661db168eb3582e93ac58a424cca0b42~RZcyvlVB00817508175epcas5p3J;
        Mon,  7 Feb 2022 04:14:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220207041428epsmtrp2e6d09c0a84351cd9972d2e39f085a32c~RZcyus8600784907849epsmtrp2h;
        Mon,  7 Feb 2022 04:14:28 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-8e-62009c0bb86d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.4B.08738.4AC90026; Mon,  7 Feb 2022 13:14:28 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220207041426epsmtip290c052ba0e0e5ea81b1e9ec8edbc0d9d~RZcw6ya7E0134401344epsmtip2F;
        Mon,  7 Feb 2022 04:14:26 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Lukasz Luba'" <lukasz.luba@arm.com>,
        "'Dmitry Osipenko'" <digetx@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20220206135807.211767-6-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v3 5/8] dt-bindings: memory: lpddr3: deprecate
 manufacturer ID
Date:   Mon, 7 Feb 2022 09:44:25 +0530
Message-ID: <0a7101d81bd9$33088840$991998c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGyHe1yAVlgrWkusZTYpz8Cv3vw/AK18OIBAhf1WX6srQSowA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmli73HIYkg5d/VSzmHznHarH642NG
        i41vfzBZbHp8jdXi8q45bBafe48wWsw4v4/JYmFTC7tF694j7A6cHmvmrWH0mNXQy+axc9Zd
        do9NqzrZPDYvqff4vEkugC0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
        MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5x
        aV66Xl5qiZWhgYGRKVBhQnZG39UJzAW/+CseLLvE0sB4hreLkZNDQsBE4l3zIeYuRi4OIYHd
        jBL7765nh3A+MUp8WfGBFaRKSOAzo8TnQxYwHY1HX7FBFO1ilDj89RmU85JR4k7zDGaQKjYB
        XYkdi9vAEiICj5kkJp7fytjFyMHBKeAhsaq5BKRGWCBEYs7fp4wgNouAisSFrZ+ZQGxeAUuJ
        7dfmsUDYghInZz4Bs5kF5CW2v53DDHGFgsTPp8vArhMRcJK4O/klI0SNuMTLo0fAXpAQmMsh
        cWDGTagGF4muW19YIGxhiVfHt7BD2FISn9/tZQO5TUIgW6JnlzFEuEZi6bxjUOX2EgeuzGEB
        KWEW0JRYv0sfYhWfRO/vJ0wQnbwSHW1CENWqEs3vrkJ1SktM7O5mhbA9JF4vngsN3JuMEqvW
        TGabwKgwC8mXs5B8OQvJN7MQNi9gZFnFKJlaUJybnlpsWmCUl1oOj+/k/NxNjOAkq+W1g/Hh
        gw96hxiZOBgPMUpwMCuJ8Mp0/08U4k1JrKxKLcqPLyrNSS0+xGgKDPqJzFKiyfnANJ9XEm9o
        YmlgYmZmZmJpbGaoJM57On1DopBAemJJanZqakFqEUwfEwenVANTdNFbpXlJ7AeNXrJ2cV34
        sW/Sw9y3kTF3zTbeNr6pf2PK2RZfj0X/P0hNUDO68FHV33PXsiXue/KMna8IzFkZeNhkoZau
        2qdbfAo2NvbPgu9pa3GeKzc6s1N33sMbS24bX5J9XDwhXdF0074ah7Z5YcXJq19+cPe1LK57
        v/Eyp+yrSf9nVlwylBfkUGmv52APtvdhNq5+qCPZ15733qJR4arLXS+DNIv5z1sXhr0orr6Y
        5X7g8w+3r/77pL4GCxb3iro/mMbw4P1ujm09D/6y6T9W/2HGaRaW0/ruk038zzsfDnkmNa2y
        2dV3b/stngt613bOyy7MPewlusbA4W08c6SFT9FVwYhJD75yhP5UYinOSDTUYi4qTgQA2Nq+
        szsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXnfJHIYkg3lrNS3mHznHarH642NG
        i41vfzBZbHp8jdXi8q45bBafe48wWsw4v4/JYmFTC7tF694j7A6cHmvmrWH0mNXQy+axc9Zd
        do9NqzrZPDYvqff4vEkugC2KyyYlNSezLLVI3y6BK6Pv6gTmgl/8FQ+WXWJpYDzD28XIySEh
        YCLRePQVWxcjF4eQwA5GiVtXFrJCJKQlrm+cwA5hC0us/PecHaLoOaPEzKlbGEESbAK6EjsW
        t4F1iwi8ZpJ40LSUBaLqKqNE28cDQBkODk4BD4lVzSUgDcICQRKvnnSDTWURUJG4sPUzE4jN
        K2Apsf3aPBYIW1Di5MwnLCCtzAJ6Em0bwXYxC8hLbH87hxniIAWJn0+XgR0qIuAkcXfyS6ga
        cYmXR4+wT2AUmoVk0iyESbOQTJqFpGMBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
        TYzgiNLS2sG4Z9UHvUOMTByMhxglOJiVRHhluv8nCvGmJFZWpRblxxeV5qQWH2KU5mBREue9
        0HUyXkggPbEkNTs1tSC1CCbLxMEp1cA0a7Kb1TE55396VRVv/t7WXy/yzFljHttto1OqXP5G
        2e9fRRqte3Pm97ICdrnNL4KktNhu+N2e6zNXui6pX9OwT/vne28lQb33+2OEFHnmh0l7yU5m
        /dyYG7X725q6znXM/B6Vqe/dOuMPWZkFHEletPB6w84rQspTmW5mCq4V47comJ0ZManrVMLC
        iwlOttfaW06yqzLM+XP+er6teaUA12rf9MaHL46671DZz1D4K+zTZ0N2zvZm5Z3Pg3+47Z3r
        7prvnfqDZdNk0wo3m79vpWIj70vNOWMgOWFPJov28galz8sW1V2POjXf+ryGA3uZ+a7M4+eK
        J6VczK6TPa60PU4gP3ql3OTmA049fEosxRmJhlrMRcWJAGnFBDIXAwAA
X-CMS-MailID: 20220207041428epcas5p3661db168eb3582e93ac58a424cca0b42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220206135825epcas5p4c07136cf0a54eb4d6c8441cd6dbf14bc
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
        <CGME20220206135825epcas5p4c07136cf0a54eb4d6c8441cd6dbf14bc@epcas5p4.samsung.com>
        <20220206135807.211767-6-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Sunday, February 6, 2022 7:28 PM
>To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Rob Herring
><robh+dt@kernel.org>; Lukasz Luba <lukasz.luba@arm.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Dmitry Osipenko <digetx@gmail.com>; linux-
>kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
>pm@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org
>Subject: [PATCH v3 5/8] dt-bindings: memory: lpddr3: deprecate
>manufacturer ID
>
>The memory manufacturer should be described in vendor part of compatible,
>so there is no need to duplicate it in a separate property.
>Similarly is done in LPDDR2 bindings.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---
> .../bindings/memory-controllers/ddr/jedec,lpddr3.yaml         | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/devicetree/bindings/memory-
>controllers/ddr/jedec,lpddr3.yaml
>b/Documentation/devicetree/bindings/memory-
>controllers/ddr/jedec,lpddr3.yaml
>index d6787b5190ee..3bcba15098ea 100644
>--- a/Documentation/devicetree/bindings/memory-
>controllers/ddr/jedec,lpddr3.yaml
>+++ b/Documentation/devicetree/bindings/memory-
>controllers/ddr/jedec,lpd
>+++ dr3.yaml
>@@ -40,7 +40,9 @@ properties:
>   manufacturer-id:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     description: |
>-      Manufacturer ID value read from Mode Register 5.
>+      Manufacturer ID value read from Mode Register 5.  The property is
>+      deprecated, manufacturer should be derived from the compatible.
>+    deprecated: true
>

Shouldn't it be the other way? As DT describes hardware and MR5 does contain
the Manufacturer ID, 
so getting Manufacturer ID from MR5 makes aligned to hardware description.


>   revision-id:
>     $ref: /schemas/types.yaml#/definitions/uint32-array
>--
>2.32.0


