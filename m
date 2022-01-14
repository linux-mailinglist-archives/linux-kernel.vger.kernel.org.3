Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8048E6B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiANIif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:38:35 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:23775 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiANIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:38:31 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220114083828epoutp024d2ff6691509e4cad1827075ed531c29~KFkb1u9gN0931909319epoutp02g
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:38:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220114083828epoutp024d2ff6691509e4cad1827075ed531c29~KFkb1u9gN0931909319epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642149508;
        bh=Cur3k3PauERrmtbJjvVcmmykkWyBSqOEzneFlcppSiQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fDIzBD/sL0mG9dUyL1LBxkLW+BVw72tjSljgyCm/xmBA7p6JlbZdzNyOmgNpAGZDv
         hmfj4EEMeq/Ymyl/KPj7843TUgszIgd8/ZlAJKeRlxmCKZAGX08vfUhWse9Xr8SH86
         U9rQLC6sIfEH61ce/ZosRMxx6cli8xJsopEjGELw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220114083827epcas5p4d0a7eda942f2c4d90ccec6b5dafaaff7~KFkbT-Z-p1922119221epcas5p4U;
        Fri, 14 Jan 2022 08:38:27 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JZvp73rQmz4x9QJ; Fri, 14 Jan
        2022 08:38:23 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.9D.06423.F7631E16; Fri, 14 Jan 2022 17:38:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220114083822epcas5p38a563af3d5a7f69c8e9679730ad2afcf~KFkW7-Hky1707817078epcas5p3E;
        Fri, 14 Jan 2022 08:38:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220114083822epsmtrp2387b14fdd2e60ea5bef119a514cb1a40~KFkW7MsGl0182601826epsmtrp2g;
        Fri, 14 Jan 2022 08:38:22 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-49-61e1367fa364
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.7A.29871.E7631E16; Fri, 14 Jan 2022 17:38:22 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114083820epsmtip2e14daa3e6cc08874d42134b1db68b8bf~KFkU3C67R3017630176epsmtip2d;
        Fri, 14 Jan 2022 08:38:20 +0000 (GMT)
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
In-Reply-To: <65e6f034-278a-81fa-844d-10a1865a25a4@canonical.com>
Subject: RE: [PATCH 10/23] dt-bindings: pinctrl: samsung: Add compatible for
 Tesla FSD SoC
Date:   Fri, 14 Jan 2022 14:08:19 +0530
Message-ID: <07cf01d80922$16d7f760$4487e620$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgL8ryguAaBfAcEA6PFKowJzFa60ASXzfreqbN6UUA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmlm692cNEgym/xS3eL+thtJh/5Byr
        xca3P5gspvxZzmSx6fE1VouPPfdYLR6+Cre4vGsOm8WM8/uYLE5d/8xmsWjrF3aL1r1H2C0O
        v2lntXh8/Q+bA5/HmnlrGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/P
        m+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        bldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZ
        AhUmZGecnHCYsWCLbMXKfdNZGxjfSnYxcnJICJhIrO/sYe9i5OIQEtjNKHFh73w2COcTo8Tt
        xY2sEM43Ron22SeZYFo2zZ3CApHYyyjR/HseVNVLRonO5leMIFVsAroSOxa3gc0SEehklFj9
        /ScTiMMssIJJYv6pu0D9HBycAo4SzScdQBqEBWIktn29xw4SZhFQlbjQ7gYS5hWwlHj+bjob
        hC0ocXLmExYQm1lAW2LZwtfMEBcpSPx8uowVxBYRCJNY+OswO0SNuMTLo0fAnpMQeMEhsW/z
        CzaQ+RICLhJnDopD9ApLvDq+hR3ClpL4/G4vVEm2RM8uY4hwjcTSecdYIGx7iQNX5oAdzyyg
        KbF+lz7EJj6J3t9PmCA6eSU62oQgqlUlmt9dheqUlpjY3c0KYXtIHL3RzDaBUXEWkr9mIflr
        FpL7ZyEsW8DIsopRMrWgODc9tdi0wDAvtRwe3cn5uZsYwQlby3MH490HH/QOMTJxMB5ilOBg
        VhLh7S+6nyjEm5JYWZValB9fVJqTWnyI0RQY1hOZpUST84E5I68k3tDE0sDEzMzMxNLYzFBJ
        nPd0+oZEIYH0xJLU7NTUgtQimD4mDk6pBiax3qTZhvzRz3Psc9rSjvfM/ZbFFX/h9VwJqVgx
        t759+S/Zo7ddvM1R9GmCzHKfE0+7iqyzVKZdV705+c+sPWZlFXzzvpuYnC+c5qq3K3CZ6Ktk
        xad9bhvsJLed/bRkQQ7r/2u39B7FLX4Ud31bIrf1zLAOj48X9ygpTF395WHQai1R9e/Wwtv/
        1r1Z2bR4gpvPI2Ge9hstc3ZkOthe+iCy4civuqC5/6fcfCjRKmvrpniqyL3tXKSu41qvpn2b
        mmYFdm6czq8qfXnm1DK1siQpgyUPl7sskeX/kzx/a2vF/AfrOyauyXGUmLhXaNOEb9VfYzhe
        Bd9Y8/rc2cVCli1Gm7mKFl/Ou/Wx6HfhhB1vlFiKMxINtZiLihMBIOFSxmEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSvG6d2cNEg/mzdCzeL+thtJh/5Byr
        xca3P5gspvxZzmSx6fE1VouPPfdYLR6+Cre4vGsOm8WM8/uYLE5d/8xmsWjrF3aL1r1H2C0O
        v2lntXh8/Q+bA5/HmnlrGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/P
        m+QCOKO4bFJSczLLUov07RK4Mlomn2YsOCtTcfzVX9YGxhbJLkZODgkBE4lNc6ewdDFycQgJ
        7GaUWNBykhUiIS1xfeMEdghbWGLlv+fsEEXPGSV+bpvGDJJgE9CV2LG4jQ0kISLQzShxpWcm
        I4jDLLCFSaLzxRlmiJYbTBING/YxdTFycHAKOEo0n3QA6RYWiJI4/fYWWJhFQFXiQrsbSJhX
        wFLi+bvpbBC2oMTJmU9YQGxmAW2J3oetjDD2soWvmSGuU5D4+XQZ2NUiAmESC38dZoeoEZd4
        efQI+wRG4VlIRs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kR
        HLtamjsYt6/6oHeIkYmD8RCjBAezkghvf9H9RCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pO
        xgsJpCeWpGanphakFsFkmTg4pRqYinb9TN88OeD6ohti7U9mTpkf4Kz7e5VqIJf0/7bwM/JN
        KWoaJ+8eE7+9I6Q/Jdt5QuwXXZ/tx1f45pc4ZB8xmLBjn5lMgP6JnHTrhS28jTcvbPT42c26
        +utX97b+tfFpBkKFFS7Py3OaTtc5zV4h3zf/UbOZ4omsdwq8dd+vhiy4eXJXA1+7lHb4Ik31
        MAHVqC8iGyw/z076/CzD/p7Rrv2d/eKpxwwitq0qXOFQcOJoTaD2p4ObtbWYt8zddYvvx93H
        DPkGT6+77/URMT3Kp6btn/dKxsftPUNmu4plQZ/prsbV5049Ojul7/jLK+z7P3zwj9HisLH7
        Htbx0v+zgN2Eq0+EVmtOXpWcz1qnxFKckWioxVxUnAgAv3K7u0wDAAA=
X-CMS-MailID: 20220114083822epcas5p38a563af3d5a7f69c8e9679730ad2afcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122354epcas5p19e5cebe9e85e9ba1758fa0b9d7d1ef75
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122354epcas5p19e5cebe9e85e9ba1758fa0b9d7d1ef75@epcas5p1.samsung.com>
        <20220113121143.22280-11-alim.akhtar@samsung.com>
        <849c7772-0f7e-32ff-6ea6-c46aa6837bb4@canonical.com>
        <076101d80909$d5849060$808db120$@samsung.com>
        <65e6f034-278a-81fa-844d-10a1865a25a4@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Friday, January 14, 2022 1:20 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; linus.walleij=40linaro.org; catalin.marinas=40arm.com;
>robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.com
>Subject: Re: =5BPATCH 10/23=5D dt-bindings: pinctrl: samsung: Add compatib=
le for
>Tesla FSD SoC
>
>On 14/01/2022 06:44, Alim Akhtar wrote:
>>
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=
=5D
>>> Sent: Thursday, January 13, 2022 5:57 PM
>>> To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>>> kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>>> Cc: soc=40kernel.org; linux-clk=40vger.kernel.org;
>>> devicetree=40vger.kernel.org; olof=40lixom.net; linus.walleij=40linaro.=
org;
>>> catalin.marinas=40arm.com;
>>> robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>>> soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.co=
m
>>> Subject: Re: =5BPATCH 10/23=5D dt-bindings: pinctrl: samsung: Add
>>> compatible for Tesla FSD SoC
>>>
>>> On 13/01/2022 13:11, Alim Akhtar wrote:
>>>> Add compatible for Tesla Full Self-Driving SoC. The pinctrl hardware
>>>> IP is similar to what found on most of the exynos series of SoC, so
>>>> this new compatible is added in samsung pinctrl binding.
>>>>
>>>> Cc: linux-fsd=40tesla.com
>>>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt =7C 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>>>> b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>>>> index b8b475967ff9..ba972998a0e4 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>>>> =40=40 -24,6 +24,7 =40=40 Required Properties:
>>>>    - =22samsung,exynos7-pinctrl=22: for Exynos7 compatible pin-control=
ler.
>>>>    - =22samsung,exynos850-pinctrl=22: for Exynos850 compatible pin-con=
troller.
>>>>    - =22samsung,exynosautov9-pinctrl=22: for ExynosAutov9 compatible
>>>> pin-
>>> controller.
>>>> +  - =22tesla,fsd-pinctrl=22: for Tesla FSD SoC compatible pin-control=
ler.
>>>>
>>>
>>> Please rebase this on my latest Samsung pinctrl dtschema patches. You
>>> also need a tesla vendor prefix patch (separate).
>>>
>> Sure will rebase when sending v2, your latest patches are in Linux-next =
or
>still in your tree?
>
>The SPI (v3) and pinctrl (v2) dtschema patches are on mailing lists.
>They seem to be done, so after merge window they will make to linux-next. =
If
>you want earlier, grab them from mailing list or from
>branches:
>https://protect2.fireeye.com/v1/url?k=3D78372ba7-27ac12a5-7836a0e8-
>0cc47a31381a-987e4f8740569613&q=3D1&e=3D8e15033d-ca15-4f1f-b463-
>adce6ebe65ef&u=3Dhttps%3A%2F%2Fgithub.com%2Fkrzk%2Flinux%2Ftree%2F
>n%2Fdt-bindings-samsung-spi-schema-v3
>https://protect2.fireeye.com/v1/url?k=3D32fb0ddf-6d6034dd-32fa8690-
>0cc47a31381a-a7fe8cfb89319cf3&q=3D1&e=3D8e15033d-ca15-4f1f-b463-
>adce6ebe65ef&u=3Dhttps%3A%2F%2Fgithub.com%2Fkrzk%2Flinux%2Ftree%2F
>n%2Fdt-bindings-samsung-pinctrl-schema-v2
>
Thanks Krzysztof, will take them for addressing FSD comments.

>
>Best regards,
>Krzysztof

