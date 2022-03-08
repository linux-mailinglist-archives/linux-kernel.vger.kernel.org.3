Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C7A4D1AEC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbiCHOq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiCHOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:46:26 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B304B851
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:45:29 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220308144524epoutp01855502b7f3b25bbc24820629aa600af0~abw8jG8f62840228402epoutp01S
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:45:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220308144524epoutp01855502b7f3b25bbc24820629aa600af0~abw8jG8f62840228402epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646750724;
        bh=lmHLPqNItLMb8jz79J20gYYp3YnXa2xox3wIzroio30=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MKJQhw8AAwL8xyfGrEbqzjsfUWIlEBDFBwKAn/tluAp0egwZu4fLzkHDYzrSTDLAv
         90/Lyyr+JnirIt862YbODzzq9l+jyJ66M5f96hqOvIosCJlhUl5xk+P2Pds6uTEgl/
         2/o6cmeoXnNer4g1AButnUO6LUxB25A8TGIC0As8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220308144523epcas5p4f815e30777cf24ba41fd196f94a08854~abw7rDnEy1721317213epcas5p4V;
        Tue,  8 Mar 2022 14:45:23 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KCdR31pr0z4x9Pp; Tue,  8 Mar
        2022 14:45:19 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.E2.06423.FFB67226; Tue,  8 Mar 2022 23:45:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220308144518epcas5p40e4bb33a1b47ea714475327333b20353~abw20XesJ0355303553epcas5p4T;
        Tue,  8 Mar 2022 14:45:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220308144518epsmtrp25ba627e2f31b50bc39a3cb62497cb0f3~abw2zhFyf0183701837epsmtrp2K;
        Tue,  8 Mar 2022 14:45:18 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-11-62276bff6b30
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.50.29871.EFB67226; Tue,  8 Mar 2022 23:45:18 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308144516epsmtip1f01b2ecd0903e8ccd4731dd51080c8d6~abw01ul4v0840308403epsmtip1O;
        Tue,  8 Mar 2022 14:45:16 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Mark Brown'" <broonie@kernel.org>,
        "'Lee Jones'" <lee.jones@linaro.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <andi@etezian.org>, <linux-spi@vger.kernel.org>,
        <linux-fsd@tesla.com>, "'Adithya K V'" <adithya.kv@samsung.com>
In-Reply-To: <YidosChLIwIAKDmG@sirena.org.uk>
Subject: RE: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
 compatible
Date:   Tue, 8 Mar 2022 20:15:15 +0530
Message-ID: <010901d832fb$212124f0$63636ed0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ0WBqQSnNME8An5DjgYUtJdqxg/AH0fdoJAkkbGC8BrsvLegHow/MEqz6biJA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmuu7/bPUkg/aPHBYHJrxitVj84zmT
        xdSHT9gs5h85x2qx8e0PJov7X48yWkz5s5zJYtPja6wWD1+FW1zeNYfNYsb5fUwWjR9vslss
        2vqF3aJ17xF2Bz6PWQ29bB7Xl3xi9ti0qpPN4861PWwem5fUe/RtWcXo8a9pLrvH501yARxR
        2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
        5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
        Gq+eYC24wFVx8adEA+Nbji5GTg4JAROJjT/vM3UxcnEICexmlLgyZScjSEJI4BOjxJ2OcIjE
        N0aJZVNvMMJ0PGu9zg6R2Mso0TThFVT7S0aJlRNOsIJUsQnoSuxY3MYGYosI+Esc3D2RBaSI
        WeAPk8Tihi1gCU6gokMXl4CNFRYIk5h59iwziM0ioCIxpWUDWJxXwFLixbp9zBC2oMTJmU9Y
        QGxmAXmJ7W/nMEOcpCDx8+kyVohlfhKHJvxlh6gRl3h59AjYqRICdzgkNredZ4VocJHo2vOK
        BcIWlnh1fAs7hC0l8fndXqDjOIDsbImeXcYQ4RqJpfOOQZXbSxy4MocFpIRZQFNi/S59iFV8
        Er2/nzBBdPJKdLQJQVSrSjS/uwrVKS0xsbsb6gAPiT17NzNOYFScheSxWUgem4XkgVkIyxYw
        sqxilEwtKM5NTy02LTDMSy2HR3dyfu4mRnCa1vLcwXj3wQe9Q4xMHIyHGCU4mJVEeO+fV0kS
        4k1JrKxKLcqPLyrNSS0+xGgKDO2JzFKiyfnATJFXEm9oYmlgYmZmZmJpbGaoJM57On1DopBA
        emJJanZqakFqEUwfEwenVANT7SmRq1d2zXl0RFbcMkZB9tGcVY+9A/Zoi5kvZNJSOedk4//l
        z94Sz9qmWz1zhc76bcuYkbH4DSf7DzsbY4cv4j52zDfE1uyQ+flc+lR4/tXV4s98PG/whTTv
        nL+t58XUJqP1k2etCP+a9rv44CmFNU0bVv2V+27c+7hs2dqPy1awrG1OvK2RlchYXGZ1LnlR
        xKMza5XX/zvML9vy1u+/6vEK5/9l7OFTl+4pDljo+EBj44zfiSVFvOt3ZSWzzvj2R8bGzdjZ
        jfnCBB1m5pg0sZX62p9TnjoFZPxLWH3+hUqgq8ZtxVdqXyUPTfxs0LAmN4FpHrfYneMFLRp5
        TkXNYQLdJ9j5T08NWXPNaaW4EktxRqKhFnNRcSIAHvOLaFwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSnO6/bPUkg2/n+S0OTHjFarH4x3Mm
        i6kPn7BZzD9yjtVi49sfTBb3vx5ltJjyZzmTxabH11gtHr4Kt7i8aw6bxYzz+5gsGj/eZLdY
        tPULu0Xr3iPsDnwesxp62TyuL/nE7LFpVSebx51re9g8Ni+p9+jbsorR41/TXHaPz5vkAjii
        uGxSUnMyy1KL9O0SuDIar55gLbjAVXHxp0QD41uOLkZODgkBE4lnrdfZuxi5OIQEdjNKLH46
        lQUiIS1xfeMEdghbWGLlv+dQRc8ZJX4/vQaWYBPQldixuI0NxBYR8Jf4+r+bFaSIWaCDWeLX
        jBdMEB3vGCU2zn8MNpYTqOPQxSWMILawQIjEzU3LwOIsAioSU1o2gMV5BSwlXqzbxwxhC0qc
        nPkEqIYDaKqeRNtGsBJmAXmJ7W/nMENcpyDx8+kyVogj/CQOTfjLDlEjLvHy6BH2CYzCs5BM
        moUwaRaSSbOQdCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcrVqaOxi3r/qg
        d4iRiYPxEKMEB7OSCO/98ypJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5N
        LUgtgskycXBKNTBVLpm7rm7VC6UP70UXbZN66te2mLeUrWcNz+5/utXahsGFhsI7ogVXOBsJ
        lG9NtTptUJudpsd4JEChsWnBcte9bUx3n8jnJs21EgkO65iQPGO/IIPBpgnva6Zo1mZNK1xR
        UtcwlYvn5pfQ6ptMnL82PXtx0+/7108rZjwRMd7Q+PXD7+bMP7ZXnzImGLO8Y8qxn54x62Lr
        f9bjd3nfn35gd2ai5M3CrbI5N+PK/r5JfChcsC2sY8Wuzh3lC1sn6SVcWlMuPFvbP+zLq8W7
        P1hZ34j70du3z5Vx6vGpjhYuDyODmutnP+5kzL0ru4rba6kx/w/19MwpVw5c2cyZ9evU3gzm
        O289TsnOvTvpZuBKJZbijERDLeai4kQAIZCyx0UDAAA=
X-CMS-MailID: 20220308144518epcas5p40e4bb33a1b47ea714475327333b20353
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681
References: <CGME20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681@epcas5p3.samsung.com>
        <20220308121640.27344-1-alim.akhtar@samsung.com>
        <YidY+ncMVhp7bBvh@sirena.org.uk> <Yidg64QGGzIbduQ2@google.com>
        <YidosChLIwIAKDmG@sirena.org.uk>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Tuesday, March 8, 2022 8:01 PM
>To: Lee Jones <lee.jones@linaro.org>
>Cc: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>devicetree@vger.kernel.org; linus.walleij@linaro.org; robh+dt@kernel.org;
>krzysztof.kozlowski@canonical.com; linux-samsung-soc@vger.kernel.org;
>pankaj.dubey@samsung.com; andi@etezian.org; linux-spi@vger.kernel.org;
>linux-fsd@tesla.com; Adithya K V <adithya.kv@samsung.com>
>Subject: Re: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
>compatible
>
>On Tue, Mar 08, 2022 at 01:58:03PM +0000, Lee Jones wrote:
>> On Tue, 08 Mar 2022, Mark Brown wrote:
>
>> > I either need a pull request for the MFD changes or to wait until
>> > those changes have come in via Linus' tree.
>
>> You mean this one:
>
>>   https://lore.kernel.org/all/YiYC7eYx2SpPILyl@google.com/
>
>>   spi: dt-bindings: samsung: Convert to dtschema
>
>> Or something else?
>
>There were changes adding the FSD SoC as well as DT stuff IIRC.

FSD SoC DT changes are already in -next.
I think this can go with MFD tree because of immutable
branch between MFD, SPI and DT due for the v5.18 merge windows.
I am not sure if there are better ways to handle this.

Regards,
Alim



