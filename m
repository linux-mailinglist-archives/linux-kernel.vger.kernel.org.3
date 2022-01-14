Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A13C48E4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiANHLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:11:18 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:60173 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiANHLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:11:17 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220114071115epoutp04b373c279215354514da867d1810252a9~KEYSgZ8Go1725917259epoutp04P
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:11:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220114071115epoutp04b373c279215354514da867d1810252a9~KEYSgZ8Go1725917259epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642144275;
        bh=LC6YprnUGwTG73GzUsTbWJhxER5WLhPqM4gGRO5I4Hk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=XbKMcdA0rneDq0DeqmZvRwVOrlF/wmGg1mRAB9dE8wqrrKVpNt8KH+GS/ywfuazGq
         y93KigpGKVHei7E/f+TTOxZhan1W5tKafyhzSA4gUs9g05JBIs/yTV4DcDA2X/Fh5U
         4i3DVQ0srrVwydUwL9O137z2yoNjFiEfiNyyX46w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220114071114epcas5p30f7a0e54aff18365f7a0595f12f2debf~KEYSASTMv2875528755epcas5p3M;
        Fri, 14 Jan 2022 07:11:14 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JZssT3Pypz4x9QV; Fri, 14 Jan
        2022 07:11:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.CB.05590.70221E16; Fri, 14 Jan 2022 16:11:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220114071103epcas5p472f650dae4d0f7c76fa30411dc237dc7~KEYHQ7y4k2613026130epcas5p4E;
        Fri, 14 Jan 2022 07:11:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220114071103epsmtrp149cbc803b627459bf14be8d682100963~KEYHQBnGe0430204302epsmtrp1Y;
        Fri, 14 Jan 2022 07:11:03 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-e6-61e122077dfc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.22.29871.70221E16; Fri, 14 Jan 2022 16:11:03 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114071101epsmtip186c0c6980ba2b7062f14c37400b1eac6~KEYFKadpJ0140101401epsmtip1k;
        Fri, 14 Jan 2022 07:11:00 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>
In-Reply-To: <176af0b0-a324-da39-2848-1c2e01cfadf5@canonical.com>
Subject: RE: [PATCH 12/23] dt-bindings: add vendor prefix for Tesla
Date:   Fri, 14 Jan 2022 12:40:59 +0530
Message-ID: <077f01d80915$e3dfd550$ab9f7ff0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgJsXLbZAgznHMEBqa4Uj6qEpzow
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmhi670sNEg4PvLSzeL+thtJh/5Byr
        xca3P5gspvxZzmSx6fE1VouPPfdYLR6+Cre4vGsOm8WM8/uYLE5d/8xmsWjrF3aL1r1H2C0O
        v2lntXh8/Q+bA5/HmnlrGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/P
        m+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        bldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZ
        AhUmZGc8vvyYseARR8W0zX+ZGxivsHcxcnJICJhIHDx2i7mLkYtDSGA3o8TSLzcYQRJCAp8Y
        JV4/VYJIfGOU+PNzMTNMR/ufqywQib2MEj/2PWOFcF4yStxeNYMJpIpNQFdix+I2NpCEiEAn
        o8Tq7z+ZQBxmgRVMEvNP3WUBqeIUcJT43rSJFcQWFnCWuDPxF1g3i4CqxL+Vm9lAbF4BS4ml
        y+4yQtiCEidnPgHrZRaQl9j+dg7UTQoSP58uA5sjIuAmcW5pJztEjbjEy6NHoD59wyExbykP
        hO0isebxe6i4sMSr41ugbCmJl/1tQDYHkJ0t0bPLGCJcI7F03jEWCNte4sCVOSwgJcwCmhLr
        d+lDbOKT6P39hAmik1eio00IolpVovndVahOaYmJ3d2sELaHxOxzvewTGBVnIflrFpK/ZiG5
        fxbCsgWMLKsYJVMLinPTU4tNC4zzUsvh8Z2cn7uJEZyytbx3MD568EHvECMTB+MhRgkOZiUR
        3v6i+4lCvCmJlVWpRfnxRaU5qcWHGE2BgT2RWUo0OR+YNfJK4g1NLA1MzMzMTCyNzQyVxHlP
        pW9IFBJITyxJzU5NLUgtgulj4uCUamDaoeGmeHBfJE9YuK/H6y1TXnpxTwxdI6y82v2drvE0
        f4Ut39W/lez8oPc42CXQjDGcb/Yt5od+ucXTUzxWTnjt7fWUmZHvSc0HpfQ1ZnvMDv368c8g
        XLT3qvBxvhmy2dkM8UuPpMYyycx7+735fYl/57ujy+1KdQsmr2275PE3Nru8Imon26SjUq/3
        Cl1i+vS0Lzf4mlym8YGm3Dsyb4tuXC80XXLYQfajE8tpR+m7/jZXT0sHis1qVJljMP+lVGx2
        8qPtHIeX2+SsnBLzvPFMz41Y7rY/mceKm+5kaG9vcjWfr8N6YNdLB8WFZxm1q0WYUhhW6vId
        +/Et/YRdF7+2Q8p/sa3LjtsFVBW/0FNiKc5INNRiLipOBAB5/9NVYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSnC670sNEg83z+CzeL+thtJh/5Byr
        xca3P5gspvxZzmSx6fE1VouPPfdYLR6+Cre4vGsOm8WM8/uYLE5d/8xmsWjrF3aL1r1H2C0O
        v2lntXh8/Q+bA5/HmnlrGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/P
        m+QCOKO4bFJSczLLUov07RK4Mh5ffsxY8IijYtrmv8wNjFfYuxg5OSQETCTa/1xl6WLk4hAS
        2M0osevMbqiEtMT1jROgbGGJlf+es0MUPWeUuPToIRNIgk1AV2LH4jY2kISIQDejxJWemYwg
        DrPAFiaJzhdnmCFavjJKfJg/mxmkhVPAUeJ70yZWEFtYwFnizsRfYKNYBFQl/q3czAZi8wpY
        SixddpcRwhaUODnzCQuIzSygLdH7sJURwpaX2P52DjPEfQoSP58uA5spIuAmcW5pJztEjbjE
        y6NH2CcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M
        4PjV0tzBuH3VB71DjEwcjIcYJTiYlUR4+4vuJwrxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1
        Ml5IID2xJDU7NbUgtQgmy8TBKdXAxPmG0e9mh+CsUvtTTSdsfFW2My8XC5v7ZXWw/zeOuQdf
        6Ozz4jP9+K7kcHbyD61PZTzpG/eLfOAKtXvFPeHhGsa77A5rbk8JXbz4b1vSGe/eQuat2/ML
        VXZy3mC4spVJvqD7z98t7H4TVn6d3Z6zbeFWHZbDGudPrL/PGJZ1R/DVo+cFySmGiW0iCbFr
        4ycvT/7jVDZJ8JKV3PXfTivkPKM6lry66ntI6H2GgOrhPX5+z8zrd7/5uoJBv9nz0hyW2zPq
        VnYLRTzeINK8S6z3j9rW/x8uS1vyvotbwhX2Ri2Nx4s1oSbv6Q+lN3N8suL+ThKRPbN03eFJ
        YVfmOOVNfeG+QY9xYcSsle0W26Iv2CqxFGckGmoxFxUnAgDBgEvATgMAAA==
X-CMS-MailID: 20220114071103epcas5p472f650dae4d0f7c76fa30411dc237dc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122404epcas5p4aa1c3ac09510eb55cce5fdd0791993a6
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122404epcas5p4aa1c3ac09510eb55cce5fdd0791993a6@epcas5p4.samsung.com>
        <20220113121143.22280-13-alim.akhtar@samsung.com>
        <176af0b0-a324-da39-2848-1c2e01cfadf5@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Thursday, January 13, 2022 6:28 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>Cc: soc@kernel.org; linux-clk@vger.kernel.org; devicetree@vger.kernel.org;
>olof@lixom.net; linus.walleij@linaro.org; catalin.marinas@arm.com;
>robh+dt@kernel.org; s.nawrocki@samsung.com; linux-samsung-
>soc@vger.kernel.org; pankaj.dubey@samsung.com; linux-fsd@tesla.com
>Subject: Re: [PATCH 12/23] dt-bindings: add vendor prefix for Tesla
>
>On 13/01/2022 13:11, Alim Akhtar wrote:
>> Add vendor prefix for the Tesla (https://www.tesla.com)
>>
>> Cc: linux-fsd@tesla.com
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>  1 file changed, 2 insertions(
>
>This should be the first patch in the series.
>
>Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
Thanks, will put this as first patch in this series
>
>Best regards,
>Krzysztof

