Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA1566A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiGELxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiGELw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:52:29 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C0217A83
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:52:28 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220705115226epoutp03d741918ffc7332e8767235dbbf837d8a~_7K5hoL850505305053epoutp03O
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:52:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220705115226epoutp03d741918ffc7332e8767235dbbf837d8a~_7K5hoL850505305053epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657021946;
        bh=n5X07+dvSt5HPtQNR62Z9LfSjI7D7S8+f+4AI0jIlwc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rrAepX45cB3OsgDgBJPv9thzt2coL+EY0LLOfnv+TzVaOMRl8sELKpBa8/r5u/yRh
         5pmPOwn+mUD7dhJfD0ms93rQM2cGTkOlRljwpgBBm4Lqde0uymgHUnY+ujvCjvjeWP
         CrQRAGLq63LPhyO0F/k61cCmNJzHxp1KxmVNSj5k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220705115225epcas5p14e15ab4d33f5f970f7396e1aea50938f~_7K40gMUP1357613576epcas5p1N;
        Tue,  5 Jul 2022 11:52:25 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LcgyZ69s9z4x9Q6; Tue,  5 Jul
        2022 11:52:22 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.00.09566.6F524C26; Tue,  5 Jul 2022 20:52:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220705114800epcas5p20ed5fbaa9d830f3f5838b4a244f05e18~_7HB7KDIu1536315363epcas5p2P;
        Tue,  5 Jul 2022 11:48:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220705114800epsmtrp2bbdafbe2f0a81aa04173a4c1c3ab6e2b~_7HB4siHe0967409674epsmtrp2Y;
        Tue,  5 Jul 2022 11:48:00 +0000 (GMT)
X-AuditID: b6c32a4a-ba3ff7000000255e-37-62c425f6950d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.E4.08905.0F424C26; Tue,  5 Jul 2022 20:48:00 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220705114757epsmtip2fb62d1413e8eaaefc5ac605fafdd8159~_7G_4XRl90746207462epsmtip2E;
        Tue,  5 Jul 2022 11:47:57 +0000 (GMT)
From:   "Smitha T Murthy" <smitha.t@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
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
        <linux-fsd@tesla.com>
In-Reply-To: <08787027-4978-d03e-0d91-d70bb8e98f82@linaro.org>
Subject: RE: [PATCH 15/20] media: s5p-mfc: DPB Count Independent of
 VIDIOC_REQBUF
Date:   Tue, 5 Jul 2022 17:17:56 +0530
Message-ID: <01e801d89065$13b14170$3b13c450$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJFyDoizuFNEw0PhIpG3eTqugJ4BwGCSryRAm8k6zYBoQnu5qxopXpQ
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjed057WtzKjojySTLXnI1sECktFDxMKdvs5Eyd6eISzJaMFTgC
        A9qmp+B0WSBcx0WROYwt5RJaULnpSqEoIMLKzSCLDEGnIAiOgdEgFDZlcWtp2fj3PM/7vHnf
        5/3ycVEPLcebm6DQ0GqFPInANrFafvZ9x3/FxxotrKgWkJPlLRhp+GsWIR8Yllhkd1MzhzSP
        lKLk+b7rbLLCOsQmLV0PWeRPf9irt7TjLHK2ohGQc7oJjOx4bDebpkfZ5NR8JPnrVT1GFl5u
        ZpMN1nEOWT12CyFrTH8jZFWzjUNmd1g5ZFaOFXnfi6ovrwdU67gRUGPGRZS6ohvnUIb2OYQy
        1eZh1P3RdoxqMqZR2T0vWNQpcy2gXmaUcah86xhGLZl2UDeWlzgy988T98TT8lhazacVMcrY
        BEVcGHHgcNTeqOAQochfFEruIvgKeTIdRkgPyvz3JSTZL0DwU+VJKXZJJmcYIkCyR61M0dD8
        eCWjCSNoVWySSqwSMPJkJkURJ1DQmvdEQmFgsN34VWK8resyUK289k3P98VYOjC8mg/cuBAX
        wzu2DCQfbOJ64G0AVl4rcJFFAI1VOhdZAbA6p5O93jJv+YfjLHQAuDr4O8tJZgEsuPgj4nBh
        uADOWw1sR8ET7wFw0jyFOgiK/4nCR50zmMPlhkvgtak81IG34IehwTjMcmAW/jY0pJ9fm8fD
        Q+HgxEPMiTfDAe3MmgfF34SWJ3rUuRMfPn9Uw3bqXnCux8pxYE98HyzIaV4LAfFhN7jSZ+E4
        G6SwprATceItcL7P7NK94dLTDsyJ4+CDpUzgxCpYlm52+cPh9RG9fQmufZgvvHQ1wCm/AUtu
        NCLOHdzhydUZl50HW8vXMQGrBvtdoyC8/aSZfRoQug3RdBui6TbE0f0/rRKwasF2WsUkx9FM
        sCpQQR/7781jlMkmsPZH/Pa3gqnJBUE3QLigG0AuSnjyan/oivbgxcqPn6DVyih1ShLNdINg
        +72LUe+tMUr7J1NookTiUKE4JCREHBoUIiK8ePtvm6I98Di5hk6kaRWtXu9DuG7e6UjpzuWw
        O8qPopLiv3QHw9TR7GkVc+DKya+zGxQDv2TjykLTOdO3w8KdJamS3R/MPzshvShDJ4svlARt
        vyA7Wz87cs5rxJgKdvGyRC1HSk7lf6E58rwgJ3e1nFc353NPb4t+JWM6d6FOlleWhurfGtqx
        nPayTDLAzvAt+LjqZu+QVKDNP7Q5D2M3eoTZjmaJIw6aP6u+uTdrqAj0F92VRYcvSHf4Hvpw
        6+7wiNe97m17fOxuZEPdqohZsJS2+R3vlQRPFL1oH/OTvrtwaVufT0RvW3tFpDgwM6AyKLdb
        gtzXnl78tP23wO/4MbVZ0wNnVE/HdYErlv4zZ5+NKj/ps2Vqm/QEi4mXi/xQNSP/F03Jm5Os
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdlhJXveDypEkg6bFyhYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVns
        fQ1UvOnxNVaLh6/CLS7vmsNm0bNhK6vF2iN32S2WXr/IZLFs0x8mi0Vbv7BbtO49wm7R0naE
        yUHcY828NYweO+4uYfS4vuQTs8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n3aD36i8Wjb8sq
        Ro9/TXPZPbqOXGfz+LxJzuPU18/sAXxRXDYpqTmZZalF+nYJXBlfDm5gLPjGU3G0YyJbA+Ni
        7i5GTg4JAROJV9v/s3cxcnEICexmlGg83ccCkZCQWPl7EiOELSyx8t9zdhBbSOApo8SZ2UYg
        NpuAnsSrI4tZQZpFBE4ySvSfaQFzmAW6WSQaX7UyQYx9wyhxaektsHZOATuJfQ87mUFsYYFA
        iYV7e8BWsAioSCxuWM4KYvMKWEqcufeIDcIWlDg58wnYScwC2hK9D1sZIWx5ie1v5zBDnKcg
        8fPpMlaIuLjEy6NHwHaJCLhJdLdtZZrAKDwLyahZSEbNQjJqFpL2BYwsqxglUwuKc9Nziw0L
        DPNSy/WKE3OLS/PS9ZLzczcxghOJluYOxu2rPugdYmTiYDzEKMHBrCTCu2rSwSQh3pTEyqrU
        ovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamELFSj9U1lUt0eEX/7J6
        6VLGN96a+055MXv3vltlpWjP7mk9q2eq94EFexao2Syb66vBc6HpcIlMX6Sn0RuxXN/jvEXT
        J38xf7r3103/m4lLZmywsilvfuFkeGaN/0U7Lr1VKovLFi2zuNK1SFPjxLH4D7qmv/1nL9XS
        WxcustJWOurF62VGDyUWL+34VqsosF64g+Xs1PWlXDd9k6Lsn2Zw929ZPPlJQ3/wzYMmB2sm
        bOFuO/o5O6bIU/mg2/XNfDeuOz70KDmXtjJdL/4yt+JkLamTlsqLjj19vCgibJ+ObcrUH2rL
        LBd/MVa+zTTRrG/qkcdVizT671xm4vvNcf9R83HprpBtfht7FyaqNiuxFGckGmoxFxUnAgCB
        qZaNkwMAAA==
X-CMS-MailID: 20220705114800epcas5p20ed5fbaa9d830f3f5838b4a244f05e18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125641epcas5p48fc3d48ad5e4a02879a1063da36c0063
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125641epcas5p48fc3d48ad5e4a02879a1063da36c0063@epcas5p4.samsung.com>
        <20220517125548.14746-16-smitha.t@samsung.com>
        <08787027-4978-d03e-0d91-d70bb8e98f82@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: Tuesday, May 17, 2022 7:30 PM
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
> pankaj.dubey@samsung.com; linux-fsd@tesla.com
> Subject: Re: [PATCH 15/20] media: s5p-mfc: DPB Count Independent of
> VIDIOC_REQBUF
> 
> On 17/05/2022 14:55, Smitha T Murthy wrote:
> > This patch allows allocation of DPB buffers based on MFC requirement
> > so codec buffers allocations has been moved after state
> > MFCINST_HEAD_PRODUCED.
> > And it is taken care that codec buffer allocation is performed in
> > process context from userspace IOCTL call.
> 
> Please wrap your commit messages according to Linux coding style:
> https://protect2.fireeye.com/v1/url?k=7a17dde8-1b9cc8cd-7a1656a7-
> 74fe485cbff6-4e2dc61728e47c8b&q=1&e=5c8a7957-5da6-466f-b2c7-
> b905451fd24c&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.18-
> rc4%2Fsource%2FDocumentation%2Fprocess%2Fsubmitting-
> patches.rst%23L586
> 
> 
> Best regards,
> Krzysztof

Ok I will change this.

Regards,
Smitha

