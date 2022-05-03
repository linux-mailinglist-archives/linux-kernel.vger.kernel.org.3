Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCC518126
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiECJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiECJlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:41:18 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FEB3204F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:37:45 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220503093743epoutp0300d7405c4eca8cbd60da9764cf069036~rjsSxe_wK0773207732epoutp03K
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:37:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220503093743epoutp0300d7405c4eca8cbd60da9764cf069036~rjsSxe_wK0773207732epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651570663;
        bh=eZPCA5Ld61CjuQcfpKdQrmY+FdOllgiJ6OejF1D7514=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=dhZAx9C0XSzZVEuHcp9Gs/Hkm0FNzvD3jpPzYCjMsaw0xth3MGi5LkW18avHZG8RB
         PdwF6hDQlcdrXD2klFioXw3CtIjMeDwFveyU20Mx/AcXAE0qe3vY6YExxvbBtUmcXF
         F2YWo0DT5+MTP3rtoQUDLlOiaPWLBmRDpa7iW7D8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220503093742epcas2p284bf0d52e1dbb7404ba5ca1ccf50c3d5~rjsR-cuhb0806408064epcas2p2w;
        Tue,  3 May 2022 09:37:42 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KsvyF0cjcz4x9Q1; Tue,  3 May
        2022 09:37:41 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.C6.10069.4E7F0726; Tue,  3 May 2022 18:37:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220503093740epcas2p327ab7c0718b4cd1effda87f106ceeebd~rjsPwTRTO1761517615epcas2p3S;
        Tue,  3 May 2022 09:37:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220503093740epsmtrp1fa65665fc1c16dae8f6b4711ac6b85aa~rjsPvfdIb2127221272epsmtrp1c;
        Tue,  3 May 2022 09:37:40 +0000 (GMT)
X-AuditID: b6c32a45-a79ff70000002755-22-6270f7e499f2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.DE.08853.4E7F0726; Tue,  3 May 2022 18:37:40 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220503093740epsmtip21eafc03609f612cdeef5581012b9e420~rjsPhIF2k2820728207epsmtip20;
        Tue,  3 May 2022 09:37:40 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220503092631.174713-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] arm64: dts: exynos: move XTCXO clock frequency to board
 in Exynos Auto v9
Date:   Tue, 3 May 2022 18:37:40 +0900
Message-ID: <02a301d85ed1$6e942cd0$4bbc8670$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQM0AewJ+A1wrOc8leVM2OSm1bsp/wEgrbzdqkyYVfA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmhe6T7wVJBsf/mVo8mLeNzWL+kXOs
        Fn0vHjJb7H29ld1i0+NrrBaXd81hs5hxfh+TReveI+wOHB6bVnWyedy5tofNY/OSeo++LasY
        PT5vkgtgjcq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhg
        YGQKVJiQnfHt+XKmgsfsFa9W/2NvYDzJ1sXIySEhYCLxZcJUli5GLg4hgR2MEp277jFBOJ8Y
        JZrm7IbKfGOUWDCzgQWmZWXrIUaIxF5GiWd/QVo4gZwXjBKTXzmA2GwC+hIvO7axghSJCNxn
        kvj8dR4rSIJTwFXi5awfQA0cHMICCRKvF9qAhFkEVCQaT61iBrF5BSwlHjyDsQUlTs58AraY
        WUBeYvvbOcwQRyhI/Hy6DGykiICVxOJlV5khakQkZne2MYPslRCYyCFxbspdqEddJL5+/Qn1
        gbDEq+Nb2CFsKYmX/W1QdrHE0lmfmCCaGxglLm/7BdVsLDHrWTsjyNHMApoS63fpg5gSAsoS
        R25B3cYn0XH4LztEmFeio00IolFd4sD26VBbZSW653xmhSjxkOj5wj2BUXEWkidnIXlyFpJn
        ZiGsXcDIsopRLLWgODc9tdiowBAe18n5uZsYwYlUy3UH4+S3H/QOMTJxMB5ilOBgVhLhdV5a
        kCTEm5JYWZValB9fVJqTWnyI0RQY7BOZpUST84GpPK8k3tDE0sDEzMzQ3MjUwFxJnNcrZUOi
        kEB6YklqdmpqQWoRTB8TB6dUA1PPtKfLHmULCwt/+z1xuzqX1S3F3nTdLft3RsdtqHvYe0g2
        7JR/ru3RjyVzDkrvmi11RGa7iL/0gdxvb1mM1tlJsfovjlv3p/Ju0ddlpzaJn92d9dhrTZsQ
        p9YyMwVJjq8rzSp2ZfX8YJMLS0y74md8O9D7zTb1uxPNY0vFN2337tmxie/5h4Mmk7bUvhe/
        J7pgeWzatV/eEyXy37KzN35+m/3Qrorf8JYZs7pOzOmCR99L5wlNL/12dsofg6VrfWcb9q7u
        y3vwSz1QRfJkxOE6sUdPcier7D01x0pz7gRTud5o7m1fBHOKtiXtyZyeXX+4+4/S9FPMR2uP
        rxbp+LnmQ3tN5o7deXsdRb+XSj9UYinOSDTUYi4qTgQAKPiuNS0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvO6T7wVJBksWSFk8mLeNzWL+kXOs
        Fn0vHjJb7H29ld1i0+NrrBaXd81hs5hxfh+TReveI+wOHB6bVnWyedy5tofNY/OSeo++LasY
        PT5vkgtgjeKySUnNySxLLdK3S+DK+PZ8OVPBY/aKV6v/sTcwnmTrYuTkkBAwkVjZeoixi5GL
        Q0hgN6PEzgt7oBKyEs/e7WCHsIUl7rccYYUoesYo8ehGJ1gRm4C+xMuObWAJEYHHTBLN/z5B
        jZrGKLGyoYERpIpTwFXi5awfTCC2sECcxKlzq8DGsgioSDSeWsUMYvMKWEo8eAZjC0qcnPmE
        pYuRg4NZQE+ibSPYGGYBeYntb+cwQ1ykIPHz6TJWEFtEwEpi8bKrzBA1IhKzO9uYJzAKzUIy
        aRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw/Ghp7mDcvuqD
        3iFGJg7GQ4wSHMxKIrzOSwuShHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2a
        WpBaBJNl4uCUamCyvnNolaoMVxRTt4PWmv5DPXUBseUaU7naA9kqrh+w++f1zntHuiTHBfd9
        r3LUXI4+nDgp+9+Zg0/vc3xk0Mq8stPwfNz2LTHLilfNOfUmyev5l6n2SaLZ4kY/uDN/Z6+d
        sEgsnWNxgKWv0TLpC9ors8yfJvb7JF8Ila/5s34zS//2bZdjxWt6ey/orVvtfmKP+tR6Kc2f
        JcwVNj/cNu1hudbbtzjVMUJV3KvRLNnTyKfywOIjKjuercztWLploXOp6U7N77cmWmxdO+dW
        /5Qdq1YfeykdUChw6kNnNG+ox+QVC7/4ztP7FSUsJDtHxsxcXmPXl97fyyvuP3p62cROYIod
        6+ronVespE+03QlQYinOSDTUYi4qTgQAjnpmng4DAAA=
X-CMS-MailID: 20220503093740epcas2p327ab7c0718b4cd1effda87f106ceeebd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220503092638epcas2p368d663b2d309b1fe8ed68b8465c5ff69
References: <CGME20220503092638epcas2p368d663b2d309b1fe8ed68b8465c5ff69@epcas2p3.samsung.com>
        <20220503092631.174713-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, May 3, 2022 6:27 PM
> To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
<alim.akhtar@samsung.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Chanho Park <chanho61.park@samsung.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH] arm64: dts: exynos: move XTCXO clock frequency to board
> in Exynos Auto v9
> 
> The external oscillator - XTCXO - is an input to the SoC.  It is defined
> in the Exynos Auto v9 SoC DTSI, because all boards will provide it and
> clock controller bindings expect it, however the actual frequency of the
> clock should be determined by the board.

Thanks for the update.
Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

